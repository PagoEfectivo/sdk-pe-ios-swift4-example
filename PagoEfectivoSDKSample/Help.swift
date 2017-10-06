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
            return PEN
        default:
            return USD
        }
    }
    
    static func StringToDocumenType (value : UITextField) -> documentType {
        switch value.text! {
        case "DNI":
            return DNI
        case "PASS":
            return  PASS
        case "LMI":
            return LMI
        case "NANE":
            return NANE
        default:
            return PAR
        }
    }
    
    static func addLbl ( numberItems : Int, text : String, positionY: Int, positionx: Int, width: Int, height: Int) -> UILabel {
        
        let distanceY = positionY + numberItems * 45
        let distanceX = positionx  // ancho 173
        let lbl = UILabel()
        lbl.frame = CGRect(x: distanceX, y: distanceY, width: width, height: height)
        lbl.text = text
        lbl.textColor = UIColor.black
        lbl.numberOfLines = 2
        lbl.textAlignment = .justified
        lbl.font=UIFont.systemFont(ofSize: 15)
        lbl.tag = 10 + numberItems
        return lbl
    }
    
    static func addTextField (numberItems: Int) -> UITextField {
        let distanceY = 120 + numberItems * 45
        let distanceX = 85  // ancho 173
        let textField = UITextField()
        textField.frame = CGRect(x: distanceX, y: distanceY, width: 173, height: 30)
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        return textField
    }
    
    static func simpleAlert (message: String , time: Double ) -> UIAlertController {
    
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let when = DispatchTime.now() + time
        DispatchQueue.main.asyncAfter(deadline: when){
            alert.dismiss(animated: true, completion: nil)
        }
        return alert
    }
    
    static func customAlert (arrayErrorsForUser: [String], time: Double) -> UIAlertController {
        let alert = UIAlertController(title: "Error!", message: "", preferredStyle: .alert)
        let newView = UIView()
        let height:NSLayoutConstraint = NSLayoutConstraint(item: alert.view, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: CGFloat(75*arrayErrorsForUser.count))
        alert.view.addConstraint(height)
        for index in 0...arrayErrorsForUser.count - 1{
            newView.addSubview(Help.addLbl(numberItems: index, text:arrayErrorsForUser[index], positionY: 50, positionx: 8, width: 200, height: 60))
        }
        alert.view.addSubview(newView)
        let when = DispatchTime.now() + time
        DispatchQueue.main.asyncAfter(deadline: when){
            alert.dismiss(animated: true, completion: nil)
        }
        alert.view.removeFromSuperview()
        return alert
    }
    
    static func stringToDate (date: String) -> String {

        let stringDate = date
        let year = self.substring(string: stringDate, with: 0..<4)
        let month = self.substring(string: stringDate, with: 5..<7)
        let day = self.substring(string: stringDate, with: 8..<10)
        let hour = self.substring(string: stringDate, with: 11..<13)
        let min = self.substring(string: stringDate, with: 14..<16)
        let sec = self.substring(string: stringDate, with: 17..<19)
        return "\(day)/\(month)/\(year)  \(hour):\(min):\(sec)"
    }
    
    static func substring( string :String, with r: Range<Int>) -> String {
        let startIndex = string.index(string.startIndex, offsetBy: r.lowerBound)
        let endIndex = string.index(string.startIndex, offsetBy: r.upperBound)
        return String(string[startIndex..<endIndex])
    }
}

