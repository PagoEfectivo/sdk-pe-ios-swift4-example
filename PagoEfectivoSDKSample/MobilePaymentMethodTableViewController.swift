//
//  AgentsTableViewController.swift
//  PagoEfectivoSDKSample
//
//  Created by gerardo on 16/10/17.
//  Copyright © 2017 Orbis. All rights reserved.
//

import UIKit
import WebKit

class MobilePaymentMethodTableViewController: UITableViewController {

    @IBOutlet weak var numberCip: UILabel!
    @IBOutlet weak var amountCip: UILabel!
    @IBOutlet weak var dateExpiryCip: UILabel!
    @IBOutlet weak var urlCip: UILabel!
    
    var webView: WKWebView!
    var dataCip = DataCip()

    override func viewDidLoad() {
        super.viewDidLoad()
        numberCip.text = String(dataCip.numberCip)
        amountCip.text = "$ \(String(dataCip.amountCip))"
        if (dataCip.currencyCip == "PEN") {
            amountCip.text = "S/.\(String(dataCip.amountCip))"
        }
        dateExpiryCip.text = Help.getFormatterEvent(dateString: dataCip.dateExpiryCip)
        urlCip.text = dataCip.cipUrl
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
            self.view.addSubview(webView)
            let url = URL(string: self.urlCip.text!)
            webView.load(URLRequest(url: url!))
            return
        }
        if(indexPath.row == 1) {
            performSegue(withIdentifier: Global.Segue.showSummary, sender: self)
        } else {
            self.present(Help.simpleAlert(message: "\(Global.Segue.showSummary) no disponible", time: 1.5), animated: true, completion: nil)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == Global.Segue.showSummary) {
            guard let nextView = segue.destination as? SummaryViewController else {
                return
            }
            nextView.dataCip = dataCip
        }
    }
}
