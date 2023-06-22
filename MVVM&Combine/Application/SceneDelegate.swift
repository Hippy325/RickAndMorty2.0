//
//  SceneDelegate.swift
//  MVVM&Combine
//
//  Created by User on 15.06.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?
	let di = DI()

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let scene = (scene as? UIWindowScene) else { return }

		window = UIWindow(windowScene: scene)
		window?.makeKeyAndVisible()


		window?.rootViewController = di.navigationController
	}
}

