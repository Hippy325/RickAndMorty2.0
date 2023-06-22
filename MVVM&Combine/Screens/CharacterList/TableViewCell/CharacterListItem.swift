//
//  CharacterListItem.swift
//  MVVM&Combine
//
//  Created by User on 16.06.2023.
//

import Foundation
import Combine
import UIKit

enum CharacterListItem: Hashable {
	case character(characterItem: CharacterItem)
	case loader
}

struct CharacterItem: Hashable {

	// MARK: - Properties

	let id: Int
	let name: String
	let race: String
	let gender: String

	let image: (_ imageSetter: @escaping (AnyPublisher<UIImage?, Never>) -> Void) -> Void

	// MARK: - Hashable

	static func == (lhs: CharacterItem, rhs: CharacterItem) -> Bool {
		lhs.id == rhs.id
			&& lhs.name == rhs.name
			&& lhs.race == rhs.race
			&& lhs.gender == rhs.gender
	}

	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
		hasher.combine(name)
		hasher.combine(race)
		hasher.combine(gender)
	}
}

