//
//  Cip.swift
//  PagoEfectivoSDKSample
//
//  Created by gerardo on 16/10/17.
//  Copyright © 2017 Orbis. All rights reserved.
//

import Foundation

struct DataCip {
    var amountCip:Double!
    var numberCip:Int!
    var currencyCip:String!
    var dateExpiryCip:String!
    var transationCodeCip:String!

}

struct ResultSearchCip {
    var amountCip:Double!
    var numberCip:Int!
    var currencyCip:String!
    var dateExpiryCip:String!
    var transationCodeCip:String!
    var statusCip:Int!
    var statusNameCip:String!
    var dateCreationCip:String!
    var datePaymentCip:String!
    var dateRemovalCip:String!
}
