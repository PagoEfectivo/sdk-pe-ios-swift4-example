//
//  CipDetailTableViewCell.swift
//  PagoEfectivoSDKSample
//
//  Created by gerardo on 6/10/17.
//  Copyright © 2017 Orbis. All rights reserved.
//

import UIKit

class CipDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var numberCip: UILabel!
    @IBOutlet weak var transactionCodeCip: UILabel!
    @IBOutlet weak var amountCip: UILabel!
    @IBOutlet weak var currencyCip: UILabel!
    @IBOutlet weak var statusCip: UILabel!
    @IBOutlet weak var statusNameCip: UILabel!
    @IBOutlet weak var dateCreationCip: UILabel!
    @IBOutlet weak var dateExpiryCip: UILabel!
    @IBOutlet weak var datePaymentCip: UILabel!
    @IBOutlet weak var dateRemovalCip: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView(view: view)
        contentView.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 240/255.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupView( view : UIView) {
        view.layer.cornerRadius = 3.0
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 0.8
    }
}
