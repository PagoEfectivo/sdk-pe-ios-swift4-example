//
//  Help.swift
//  PagoEfectivoSDKSample
//
//  Created by gerardo on 16/10/17.
//  Copyright © 2017 Orbis. All rights reserved.
//

import Foundation


struct Help {
    
    static func StringToCurrency (value : UITextField) -> currency {
        switch value.text! {
        case "PEN":
            return .PEN
        case "USD":
            return .USD
        default:
            return .NONE
        }
    }

    static func StringToDocumenType (value : UITextField) -> documentType {
        switch value.text! {
        case "DNI":
            return .DNI
        case "PASS":
            return  .PASS
        case "LMI":
            return .LMI
        case "PAR":
            return .PAR
        default:
            return .NANE
        }
    }
    
    static func addLbl ( numberItems : Int, text : String, positionY: Int, positionX: Int, width: Int, height: Int) -> UILabel {
        
        let distanceY = positionY + numberItems * 45
        let lbl = UILabel()
        lbl.frame = CGRect(x: positionX, y: distanceY, width: width, height: height)
        lbl.text = text
        lbl.textColor = UIColor.black
        lbl.numberOfLines = 0
        lbl.textAlignment = .justified
        lbl.font=UIFont.systemFont(ofSize: 15)
        lbl.tag = 10 + numberItems
        return lbl
    }
    
    static func addTextField (numberItems: Int) -> UITextField {
        let distanceY = 120 + numberItems * 45
        let textField = UITextField()
        textField.frame = CGRect(x: 85, y: distanceY, width: 173, height: 30)
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        return textField
    }
    
    static func simpleAlert (message: String , time: Double ) -> UIAlertController {
    
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let delayTime = DispatchTime.now() + time
        DispatchQueue.main.asyncAfter(deadline: delayTime){
            alert.dismiss(animated: true, completion: nil)
        }
        return alert
    }
    
    static func customAlert (arrayErrorsForUser: [String], time: Double) -> UIAlertController {
        let alert = UIAlertController(title: "Error!", message: "", preferredStyle: .alert)
        let newView = UIView()
        var constant = CGFloat(80)
        if (arrayErrorsForUser.count > 1) {
            constant = CGFloat((75 - 5*(arrayErrorsForUser.count-1))*arrayErrorsForUser.count)
        }
        let height:NSLayoutConstraint = NSLayoutConstraint(item: alert.view, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: constant)
        alert.view.addConstraint(height)
        for (index,item) in arrayErrorsForUser.enumerated(){
            newView.addSubview(Help.addLbl(numberItems: index , text:item, positionY: 30, positionX: 8, width: 200, height: 60))
        }
        alert.view.addSubview(newView)
        let delayTime = DispatchTime.now() + time
        DispatchQueue.main.asyncAfter(deadline: delayTime){
            alert.dismiss(animated: true, completion: nil)
        }
        return alert
    }

    static func getFormatterEvent(dateString:String)->String{
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return self.newFormatFor(dateFormater.date(from: dateString)!)
        
    }

    static func newFormatFor(_ date:Date) -> String {
        let newDateFormat = DateFormatter()
        newDateFormat.dateFormat = "dd/MM/yyyy hh:mm a"
        newDateFormat.locale = Locale(identifier: "es_PE")
        return newDateFormat.string(from: date)
    }

    static func createRefresh ( view: UIView) -> UIActivityIndicatorView {
        
        let refresh : UIActivityIndicatorView = UIActivityIndicatorView()
        refresh.center = view.center
        refresh.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        refresh.hidesWhenStopped = true
        view.addSubview(refresh)
        return refresh
    }

    static func returnErrorFounded( error : Any) -> [String] {
        var arrayErrorsForUser: [String] = []
        guard let errorAux = error as? NSError else { return arrayErrorsForUser }
        guard let errorsFounded = errorAux.userInfo["errorsFounded"] as? NSArray else {
            return arrayErrorsForUser
        }
        errorsFounded.enumerated().forEach({ (index, item) in
            let object = item as? [String: Any]
            let messageForUser = "\(index+1). Campo \(object?["message"] as! String)"
            arrayErrorsForUser.append(messageForUser)
        })
        return arrayErrorsForUser
    }

    static func stringToTypeDate ( string: String) -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/mm/yyyy hh:mm" //Your date format
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        return dateFormatter.date(from: string)!
    }

    static func createRefresher ( view: UIView) -> UIActivityIndicatorView {
        
        let refresh : UIActivityIndicatorView = UIActivityIndicatorView()
        refresh.center = view.center
        refresh.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        refresh.hidesWhenStopped = true
        view.addSubview(refresh)
        return refresh
    }
}

