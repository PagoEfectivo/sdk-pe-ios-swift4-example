//
//  SummaryViewController.swift
//  PagoEfectivoSDKSample
//
//  Created by gerardo on 16/10/17.
//  Copyright © 2017 Orbis. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController {

    @IBOutlet weak var generalSummary: UILabel!
    @IBOutlet weak var summaruNumberCip: UILabel!
    var dataCip = DataCip()
    override func viewDidLoad() {
        super.viewDidLoad()
        generalSummary.text = "Paga $ \(String(dataCip.amountCip)) en BCP para reservar tu compra"
        if (dataCip.currencyCip == "PEN") {
            generalSummary.text = "Paga S/.\(String(dataCip.amountCip)) en BCP para reservar tu compra"
        }
        summaruNumberCip.text = "3. Díctale al cajero este código CIP : \(String(dataCip.numberCip))"
    }

}
