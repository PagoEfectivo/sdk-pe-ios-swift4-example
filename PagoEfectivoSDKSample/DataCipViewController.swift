//
//  DataCipViewController.swift
//  PagoEfectivoSDKSample
//
//  Created by gerardo on 12/10/17.
//  Copyright © 2017 Orbis. All rights reserved.
//

import UIKit
import PagoEfectivoSDK
class DataCipViewController: UIViewController {

    let request = CipRequest()
    @IBOutlet weak var generateCip: UIButton!
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var currency: UITextField!
    @IBOutlet weak var transactionCode: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var dateExpiry: UITextField!
    @IBOutlet weak var additionalData: UITextField!
    @IBOutlet weak var paymentConcep: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userLastName: UITextField!
    @IBOutlet weak var userUbigeo: UITextField!
    @IBOutlet weak var userCountry: UITextField!
    @IBOutlet weak var userDocumentType: UITextField!
    @IBOutlet weak var userDocumentNumber: UITextField!
    @IBOutlet weak var userPhone: UITextField!
    @IBOutlet weak var userCodeCountry: UITextField!
    @IBOutlet weak var adminEmail: UITextField!
    let currencyPicker = UIPickerView()
    let documentTypePicker = UIPickerView()
    let currencyOptions = ["","PEN","USD"]
    let documentTypeOptions = ["","DNI","PASS","LMI","PAR","NAN"]
    var dataCip = DataCip()
    let datePicker = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPicker(value: currencyPicker)
        setupPicker(value: documentTypePicker)
        setupDataPicker(value: datePicker)
    }

    func setupPicker (value : UIPickerView){
        value.delegate = self
        value.dataSource = self
    }
    func setupDataPicker ( value: UIDatePicker) {
        value.frame = CGRect(x: 0, y: 50, width: self.view.frame.width, height: 200)
        value.timeZone = NSTimeZone.local
        value.backgroundColor = UIColor.white
        value.layer.cornerRadius = 5.0
        value.layer.shadowOpacity = 0.5
        value.addTarget(self, action: #selector(changeDate), for: .valueChanged)
    }

    override func viewWillAppear(_ animated: Bool) {
        generateCip.isEnabled = true
        currency.inputView = currencyPicker
        userDocumentType.inputView = documentTypePicker
        dateExpiry.inputView = datePicker
    }
    
    @objc func changeDate () {
        let myDateFormatter: DateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
        dateExpiry.text = myDateFormatter.string(from: datePicker.date)
        request.dateExpiry = datePicker.date
    }

    @IBAction func nextView(_ sender: UIButton) {
        generateCip.isEnabled = false
        let refresh = Help.createRefresh(view: self.view)
        refresh.startAnimating()
        request.currency = Help.StringToCurrency(value: currency)
        request.userName = userName.text
        request.amount = 0
        if (!(amount.text?.isEmpty)!) {
            request.amount = Double(amount.text!)!
        }
        request.transactionCode = transactionCode.text
        request.additionalData = additionalData.text
        request.paymentConcept = paymentConcep.text
        request.userEmail = userEmail.text
        request.userName = userName.text
        request.userLastName = userLastName.text
        request.userUbigeo = userUbigeo.text
        request.userCountry = userCountry.text
        request.userDocumentType = Help.StringToDocumenType(value: userDocumentType)
        request.userDocumentNumber = userDocumentNumber.text
        request.userPhone = userPhone.text
        request.userCodeCountry = userCodeCountry.text
        request.adminEmail = adminEmail.text
        let response:serviceCallback = { (status, result, error) in
            if(error != nil ){
                DispatchQueue.main.async{
                    self.present(Help.customAlert(arrayErrorsForUser: Help.returnErrorFounded(error: error!), time: 2), animated: true, completion: nil)
                    self.generateCip.isEnabled = true
                    refresh.stopAnimating()
                }
            } else {
                guard let dictionary = result as? [String: Any] else { return }
                guard let data = dictionary["data"] as? [String: Any] else { return }
                for _ in data {
                    self.dataCip.numberCip = data["cip"] as! Int
                    self.dataCip.currencyCip = data["currency"] as! String
                    self.dataCip.transationCodeCip = data["transactionCode"] as! String
                    self.dataCip.amountCip = data["amount"] as! Double
                    self.dataCip.dateExpiryCip = data["dateExpiry"] as! String
                }
                DispatchQueue.main.async{
                    self.performSegue(withIdentifier: Global.Segue.showPasarela, sender: self)
                    refresh.stopAnimating()
                }
            }
        }
        PagoEfectivoSDK.cip().generate(request, responseHandler: response)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == Global.Segue.showPasarela) {
            guard let nextView = segue.destination as? PaymentMethodTableViewController else { return }
            nextView.dataCip = dataCip
        }
    }
}

extension DataCipViewController : UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == currencyPicker {
            currency.text = currencyOptions[row]
        } else {
            userDocumentType.text = documentTypeOptions[row]
        }
    }
}

extension DataCipViewController : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var numbersRows = documentTypeOptions.count
        if pickerView == currencyPicker {
            numbersRows = currencyOptions.count
        }
        return numbersRows
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var title = documentTypeOptions[row]
        if pickerView == currencyPicker {
            title = currencyOptions[row]
        }
        return title
    }
}
