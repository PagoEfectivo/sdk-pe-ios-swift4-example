//
//  SearchCipViewController.swift
//  PagoEfectivoSDKSample
//
//  Created by gerardo on 12/10/17.
//  Copyright © 2017 Orbis. All rights reserved.
//

import UIKit
import PagoEfectivoSDK


class SearchCipViewController: UIViewController {

    @IBOutlet weak var positonYBtnSearch: NSLayoutConstraint!
    @IBOutlet weak var btnSearch: UIButton!
    var arrayCips = [String]()
    var arraytxtLbl = [UITextField]()
    var resulSearchCip : [ResultSearchCip] = []
    var contCips = 0
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        contCips = 0
        btnSearch.isEnabled = false
        arrayCips.removeAll()
        arraytxtLbl.removeAll()
        resulSearchCip.removeAll()
        for subview in view.subviews{
            if subview is UITextField{
                subview.removeFromSuperview()
            }
            if subview is UILabel {
                if subview.tag >= 10 {
                subview.removeFromSuperview()
                }
            }
        }
    }

    @IBAction func addCip(_ sender: UIButton) {
        btnSearch.isEnabled = true
        if (contCips <= 4) {
            let newLabel = Help.addLbl(numberItems: contCips, text: "Cip", positionY: 120, positionX: 30, width: 37, height: 30)
            let newTextField = Help.addTextField(numberItems: contCips)
            view.addSubview(newLabel)
            view.addSubview(newTextField)
            arraytxtLbl.append(newTextField)
            contCips = contCips + 1
            positonYBtnSearch.constant = CGFloat(37 + 45 * contCips)
        } else {
            self.present(Help.simpleAlert(message: "Número máximo de Cips : 5", time: 1.5), animated: true, completion: nil)
        }
    }

    @IBAction func searchCips(_ sender: UIButton) {
        let refresh = Help.createRefresh(view: self.view)
        refresh.startAnimating()
        btnSearch.isEnabled = false
        arraytxtLbl.enumerated().forEach ({ (index, item) in
            arrayCips.append(item.text!)
        })
        let response:serviceCallback = { (status, result, error) in
            if(error != nil ){
                DispatchQueue.main.async{
                    self.present(Help.customAlert(arrayErrorsForUser: ["\(error!.localizedDescription)"], time: 2), animated: true, completion: nil)
                    refresh.stopAnimating()
                    self.arrayCips.removeAll()
                    self.btnSearch.isEnabled = true
                }
            } else {
                guard let dictionary = result as? [String: Any] else { return }
                guard let data = dictionary["data"] as? NSArray else { return }
                for index in 0...data.count - 1 {
                    let object = data[index] as? [String:Any]
                    var resultSearchAux = ResultSearchCip()
                    resultSearchAux.numberCip = object?["cip"] as! Int
                    resultSearchAux.currencyCip = object?["currency"] as! String
                    resultSearchAux.transationCodeCip = object?["transactionCode"] as! String
                    resultSearchAux.amountCip = object?["amount"] as! Double
                    resultSearchAux.dateExpiryCip = object?["dateExpiry"] as! String
                    resultSearchAux.dateCreationCip = object?["dateCreation"] as! String
                    resultSearchAux.datePaymentCip = object?["datePayment"] as! String
                    resultSearchAux.dateRemovalCip = object?["dateRemoval"] as! String
                    resultSearchAux.statusCip = object?["status"] as! Int
                    resultSearchAux.statusNameCip = object?["statusName"] as! String
                    self.resulSearchCip.append(resultSearchAux)
                }
                DispatchQueue.main.async{
                    self.performSegue(withIdentifier: Global.Segue.showResultSearch, sender: self)
                    refresh.stopAnimating()
                }
            }
        }
        PagoEfectivoSDK.cip().search(arrayCips, responseHandler: response)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Global.Segue.showResultSearch {
            guard let nextView = segue.destination as? ResultSearchViewController else {
                return
            }
            nextView.resultSearch = resulSearchCip
        }
    }
}
