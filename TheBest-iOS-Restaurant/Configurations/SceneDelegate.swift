//
//  SceneDelegate.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 10/2/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let _ = (scene as? UIWindowScene) else { return }
        AppDelegate.standard.window = window
        
        if AuthServices.instance.isLogged {
            
            let mainStoryboard = UIStoryboard(name: "Main" , bundle: nil)
            let protectedPage = mainStoryboard.instantiateViewController(withIdentifier: "NavHome") as! UINavigationController
            window!.rootViewController = protectedPage
            window!.makeKeyAndVisible()
            
        }
        
    }

}

