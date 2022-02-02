//
//  SceneDelegate.swift
//  NP
//
//  Created by Рушан Киньягулов on 26.11.2021.
//

import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = TabBarController()
        window.windowScene = windowScene
        window.makeKeyAndVisible()
        self.window = window

        Auth.auth().addStateDidChangeListener { _, user in
            if user == nil {
                self.showAuthVC()
            }
        }
    }

        func showAuthVC() {
            let authVC = AuthorizationViewController()
            authVC.modalPresentationStyle = .fullScreen
            self.window?.rootViewController?.present(authVC, animated: false)
        }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}
