//
//  CharacterListViewControllerAssembly.swift
//  MVVM&Combine
//
//  Created by User on 17.06.2023.
//

import Foundation
import UIKit

protocol ICharacterListViewControllerAssembly {
	func assembly(navigationController: UINavigationController?) -> UIViewController
}

final class CharacterListViewControllerAssembly: ICharacterListViewControllerAssembly {
	private let characterPageLoader: ICharacterPageLoader
	private let imageLoader: IImageLoader
	private let detailCharacterViewControllerAssembly: IDetailCharacterViewControllerAssembly

	init(
		characterPageLoader: ICharacterPageLoader,
		imageLoader: IImageLoader,
		detailCharacterViewControllerAssembly: IDetailCharacterViewControllerAssembly
	) {
		self.characterPageLoader = characterPageLoader
		self.imageLoader = imageLoader
		self.detailCharacterViewControllerAssembly = detailCharacterViewControllerAssembly
	}

	func assembly(navigationController: UINavigationController?) -> UIViewController {
		let router = CharacterListRouter(detailCharacterViewControllerAssembly: detailCharacterViewControllerAssembly)
		router.navigationCantroller = navigationController
		
		let viewModel = CharacterListViewModel(
			characterPageLoader: characterPageLoader,
			imageLoader: imageLoader,
			router: router
		)

		return CharacterListViewController(viewModel: viewModel)
	}
}
