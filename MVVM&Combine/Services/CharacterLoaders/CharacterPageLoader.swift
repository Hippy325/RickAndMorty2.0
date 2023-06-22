//
//  CharacterPageLoader.swift
//  MVVM&Combine
//
//  Created by User on 16.06.2023.
//

import Foundation
import Combine

private extension String {
	static let characterUrl = "https://rickandmortyapi.com/api/character"
}

protocol ICharacterPageLoader: AnyObject {
	var isFinished: Bool { get }

	func loadNextPage() -> AnyPublisher<[Character], Error>
}

final class CharacterPageLoader: ICharacterPageLoader {
	// MARK: - Properties

	private let httpTransport: IHTTPTransport
	private var nextPageUrl: URL? = URL(string: .characterUrl)
	private var cancellables = Set<AnyCancellable>()

	// MARK: - Protocol properties

	let dataPublisher = PassthroughSubject<[Character], Error>()
	var isFinished: Bool = false

	// MARK: - Init

	init(httpTransport: IHTTPTransport) {
		self.httpTransport = httpTransport
	}

	// MARK: - Protocol implementation

	func loadNextPage() -> AnyPublisher<[Character], Error> {
		guard !isFinished else { return Empty().eraseToAnyPublisher() }

		guard let url = nextPageUrl else { return Empty().eraseToAnyPublisher() }

		return httpTransport.load(url: url, responseType: CharacterResponse.self)
			.map { response -> [Character] in
				self.nextPageUrl = response.info.next
				self.isFinished = response.info.next == nil
				return response.results
			}
			.eraseToAnyPublisher()
	}
}
