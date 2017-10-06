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
        let newLabel = Help.addLbl(numberItems: contCips, text: "Cip", positionY: 120, positionx: 30, width: 37, height: 30)
        let newTextField = Help.addTextField(numberItems: contCips)
        view.addSubview(newLabel)
        view.addSubview(newTextField)
        arraytxtLbl.append(newTextField)
        contCips = contCips + 1
        positonYBtnSearch.constant = CGFloat(37 + 45 * contCips)
        if (contCips > 5){
            self.present(Help.simpleAlert(message: "Número máximo de Cips : 5", time: 1.5), animated: true, completion: nil)
            contCips = 5
        }
    }

    @IBAction func searchCips(_ sender: UIButton) {
        btnSearch.isEnabled = false
        for index in 0...contCips - 1 {
            let cip = arraytxtLbl[index].text
            arrayCips.append(cip!)
        }
        PagoEfectivoSDK.cip().search(arrayCips, responseHandler: { (status, resul, error) in
        if (error != nil) {
            self.present(Help.simpleAlert(message: "Error en \(error!.localizedDescription)", time: 3), animated: true, completion: nil)
            self.btnSearch.isEnabled = true
            self.arrayCips.removeAll()
            } else {
                if let dictionary = resul as? [String: Any] {
                    if let data = dictionary["data"] as? NSArray {
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
                    }
                }
                DispatchQueue.main.async{
                    self.performSegue(withIdentifier: Global.Segue.showResultSearch, sender: self)
                }
            }
        })
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
