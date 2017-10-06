//
//  AppDelegate.swift
//  PagoEfectivoSDKSample
//
//  Created by gerardo on 6/10/17.
//  Copyright © 2017 Orbis. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import PagoEfectivoSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.sharedManager().enable = true
        PagoEfectivoSDK.config("Nfybo8h0yN7CFN1ycX+XaG99pj/y3Vt25urt1LXM" , accessKey: "AKIPJP77AHN2DKVIJCCA", serviceId: 5)
        UINavigationBar.appearance().barTintColor = UIColor.yellow
        UINavigationBar.appearance().tintColor = UIColor.black
        return true
    }
}

