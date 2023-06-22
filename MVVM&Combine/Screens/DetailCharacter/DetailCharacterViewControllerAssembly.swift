//
//  DetailCharacterViewControllerAssembly.swift
//  MVVM&Combine
//
//  Created by User on 18.06.2023.
//

import Foundation
import UIKit

protocol IDetailCharacterViewControllerAssembly {
	func assembly(index: Int) -> UIViewController
}

final class DetailCharacterViewControllerAssembly: IDetailCharacterViewControllerAssembly {

	// MARK: - Properties

	private let imageLoader: IImageLoader
	private let characterLoader: ICharacterLoader

	// MARK: - Init

	init(imageLoader: IImageLoader, characterLoader: ICharacterLoader) {
		self.imageLoader = imageLoader
		self.characterLoader = characterLoader
	}

	// MARK: - Protocol implementation

	func assembly(index: Int) -> UIViewController {
		let viewModel = DetailCharacterViewModel(
			characterIndex: index,
			imageLoader: imageLoader,
			characterLoader: characterLoader
		)
		let detailCharacter = DetailCharacterViewController(viewModel: viewModel)
		return detailCharacter
	}
}
