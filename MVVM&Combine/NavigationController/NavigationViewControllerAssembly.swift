//
//  NavigationViewControllerAssembly.swift
//  MVVM&Combine
//
//  Created by User on 17.06.2023.
//

import Foundation
import UIKit

final class NavigationViewControllerAssembly {

	// MARK: - Protocol implementation

	static func assembly() -> UINavigationController {
		let navigationController = UINavigationController()
		navigationController.navigationBar.backgroundColor = .clear
		navigationController.navigationBar.prefersLargeTitles = true
		return navigationController
	}
}
