//
//  CharacterLoader.swift
//  MVVM&Combine
//
//  Created by User on 16.06.2023.
//

import Foundation
import Combine

private extension String {
	static let characterURL = "https://rickandmortyapi.com/api/character/"
}

// MARK: - IProtocol

protocol ICharacterLoader: AnyObject {
	func load(characterIndex: Int) -> AnyPublisher<Character, Error>
}

final class CharacterLoader: ICharacterLoader {

	// MARK: - Properties

	private let httpTransport: IHTTPTransport

	// MARK: - Init

	init(httpTransport: IHTTPTransport) {
		self.httpTransport = httpTransport
	}

	// MARK: - Protocol implementation

	func load(characterIndex: Int) -> AnyPublisher<Character, Error> {
		httpTransport.load(
			stringUrl:  String.characterURL.appending(String(characterIndex)),
			responseType: Character.self
		)
	}
}
