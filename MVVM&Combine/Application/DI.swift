//
//  DI.swift
//  MVVM&Combine
//
//  Created by User on 17.06.2023.
//

import Foundation
import UIKit

final class DI {

	// MARK: - Common
	lazy private var httpTransport: IHTTPTransport = HTTPTransport(session: session, decoder: decoder)
	lazy private var decoder: JSONDecoder = .init()
	lazy private var session: URLSession = .shared

	lazy private var characterPageLoader: ICharacterPageLoader = CharacterPageLoader(httpTransport: httpTransport)
	lazy private var imageLoader: IImageLoader = ImageLoaderPublisher(httpTransport: httpTransport)
	lazy private var characterLoader: ICharacterLoader = CharacterLoader(httpTransport: httpTransport)

	// MARK: - Navigation

	var navigationController: UINavigationController {
		let navigationController = NavigationViewControllerAssembly.assembly()
		navigationController.viewControllers = [
			characterListViewControllerAssembly.assembly(navigationController: navigationController)
		]
		return navigationController
	}

	// MARK: - Screens

	private var characterListViewControllerAssembly: ICharacterListViewControllerAssembly {
		CharacterListViewControllerAssembly(
			characterPageLoader: characterPageLoader,
			imageLoader: imageLoader,
			detailCharacterViewControllerAssembly: detailCharacterViewControllerAssembly
		)
	}

	private var detailCharacterViewControllerAssembly: IDetailCharacterViewControllerAssembly {
		DetailCharacterViewControllerAssembly(imageLoader: imageLoader, characterLoader: characterLoader)
	}
}
