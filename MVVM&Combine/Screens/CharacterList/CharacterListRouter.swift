//
//  CharacterListRouter.swift
//  MVVM&Combine
//
//  Created by User on 18.06.2023.
//

import Foundation
import UIKit

protocol ICharacterListRouter {
	var navigationCantroller: UINavigationController? { get set }

	func pushToDetailCharacter(id: Int)
}

final class CharacterListRouter: ICharacterListRouter {

	// MARK: - Properties

	private let detailCharacterViewControllerAssembly: IDetailCharacterViewControllerAssembly
	weak var navigationCantroller: UINavigationController?

	// MARK: - Init

	init(
		detailCharacterViewControllerAssembly: IDetailCharacterViewControllerAssembly
	) {
		self.detailCharacterViewControllerAssembly = detailCharacterViewControllerAssembly
	}

	// MARK: - Protocol implementation

	func pushToDetailCharacter(id: Int) {
		navigationCantroller?.pushViewController(
			detailCharacterViewControllerAssembly.assembly(index: id + 1), animated: true
		)
	}
}
