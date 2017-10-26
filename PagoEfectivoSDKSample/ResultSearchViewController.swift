//
//  ResultSearchViewController.swift
//  PagoEfectivoSDKSample
//
//  Created by gerardo on 6/10/17.
//  Copyright © 2017 Orbis. All rights reserved.
//

import UIKit

class ResultSearchViewController: UIViewController {

    var resultSearch = [ResultSearchCip]()
    @IBOutlet weak var detailCipTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable(table: detailCipTable)
    }

    func setupTable (table : UITableView) {
        table.dataSource = self
        table.delegate = self
        table.register(UINib(nibName: Global.NibName.CipDetailTableViewCell, bundle: nil), forCellReuseIdentifier: Global.NibIdentifier.CipDetailTableViewCell)
    }
}

extension ResultSearchViewController : UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 316
    }
}

extension ResultSearchViewController : UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultSearch.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = Bundle.main.loadNibNamed(Global.NibName.CipDetailTableViewCell, owner: self, options: nil)?.first as? CipDetailTableViewCell else {
            fatalError("Error loading \(Global.NibName.CipDetailTableViewCell)")
        }
        cell.numberCip.text = String(resultSearch[indexPath.row].numberCip)
        cell.transactionCodeCip.text = resultSearch[indexPath.row].transationCodeCip
        cell.amountCip.text = String(resultSearch[indexPath.row].amountCip)
        cell.currencyCip.text = resultSearch[indexPath.row].currencyCip
        cell.statusCip.text = String(resultSearch[indexPath.row].statusCip)
        cell.statusNameCip.text = resultSearch[indexPath.row].statusNameCip
        cell.dateCreationCip.text = Help.getFormatterEvent(dateString: resultSearch[indexPath.row].dateCreationCip)
        cell.dateExpiryCip.text = Help.getFormatterEvent(dateString: resultSearch[indexPath.row].dateExpiryCip)
        cell.datePaymentCip.text = Help.getFormatterEvent(dateString: resultSearch[indexPath.row].datePaymentCip)
        cell.dateRemovalCip.text = Help.getFormatterEvent(dateString: resultSearch[indexPath.row].dateRemovalCip)
        return cell
    }
}
