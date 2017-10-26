//
//  PaymentMethodTableViewController.swift
//  PagoEfectivoSDKSample
//
//  Created by gerardo on 16/10/17.
//  Copyright © 2017 Orbis. All rights reserved.
//

import UIKit

class PaymentMethodTableViewController: UITableViewController {

    var dataCip = DataCip()
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: Global.Segue.showMobileOptions, sender: self)
        case 1:
            performSegue(withIdentifier: Global.Segue.showAgentsOptions, sender: self)
        default:
            self.present(Help.simpleAlert(message: "Opción no válida", time: 1.5), animated: true, completion: nil)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == Global.Segue.showMobileOptions) {
            guard let nextView = segue.destination as? MobilePaymentMethodTableViewController else {
                return
            }
            nextView.dataCip = dataCip
        } else {
            guard let nextView = segue.destination as? AgentsPaymentMethodTableViewController else {
                return
            }
            nextView.dataCip = dataCip
        }
    }

}
