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
    let currencyOptions = ["PEN","USD"]
    let documentTypeOptions = ["DNI","PASS","LMI","PAR","NAN"]
    var dataCip = DataCip()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPicker(value: currencyPicker)
        setupPicker(value: documentTypePicker)
    }

    func setupPicker (value : UIPickerView){
        value.delegate = self
        value.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        generateCip.isEnabled = true
        currency.inputView = currencyPicker
        userDocumentType.inputView = documentTypePicker
    }

    @IBAction func nextView(_ sender: UIButton) {
        generateCip.isEnabled = false
        request.currency = Help.StringToCurrency(value: currency)
        request.userEmail = userEmail.text
        request.transactionCode = transactionCode.text
        request.userName = userName.text
        request.userLastName = userLastName.text
        request.userUbigeo = userUbigeo.text
        request.userCodeCountry = userCountry.text
        request.userDocumentNumber = userDocumentNumber.text
        request.userPhone = userPhone.text
        request.userEmail = userEmail.text
        request.transactionCode = transactionCode.text
        request.additionalData = additionalData.text
        request.additionalData = additionalData.text
        request.paymentConcept = paymentConcep.text
        request.userCodeCountry = userCodeCountry.text
        request.userDocumentType = Help.StringToDocumenType(value: userDocumentType)
        if (amount.text != "") {
            request.amount = Double(amount.text!)!
        } else {
            request.amount = 0
        }
        PagoEfectivoSDK.cip().generate(request, responseHandler: { (status, result, error) in
            if (error != nil) {
                var arrayErrorsForUser = [String]()
                if let errors = (error as NSError?)?.userInfo{
                    if let arrayErrors = errors["errorsFounded"]! as? NSArray {
                        for index in 0...arrayErrors.count - 1 {
                            let object = arrayErrors[index] as? [String:Any]
                            let messageForUser = "\(index+1).\(object?["fieldName"] as! String ) is \(object?["message"] as! String)"
                            arrayErrorsForUser.append(messageForUser)
                        }
                    }
                }
                self.present(Help.customAlert(arrayErrorsForUser: arrayErrorsForUser, time: 2), animated: true, completion: nil)
                self.generateCip.isEnabled = true
            } else {
                if let dictionary = result as? [String: Any] {
                    if let data = dictionary["data"] as? [String: Any] {
                        for _ in data {
                            self.dataCip.numberCip = data["cip"] as! Int
                            self.dataCip.currencyCip = data["currency"] as! String
                            self.dataCip.transationCodeCip = data["transactionCode"] as! String
                            self.dataCip.amountCip = data["amount"] as! Double
                            self.dataCip.dateExpiryCip = data["dateExpiry"] as! String
                        }
                    }
                }
                DispatchQueue.main.async{
                    self.performSegue(withIdentifier: Global.Segue.showPasarela, sender: self)
                }
            }
        })
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == Global.Segue.showPasarela) {
            guard let nextView = segue.destination as? PaymentMethodTableViewController else {
                return
            }
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
        if pickerView == currencyPicker {
            return currencyOptions.count
        } else {
            return  documentTypeOptions.count
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == currencyPicker {
            return currencyOptions[row]
        } else {
            return  documentTypeOptions[row]
        }
    }
}
