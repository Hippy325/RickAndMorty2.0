//
//  CharacterListViewModel.swift
//  MVVM&Combine
//
//  Created by User on 16.06.2023.
//

import Foundation
import Combine

protocol ICharacterListViewModel {
	var models: [CharacterListItem] { get }
}

final class CharacterListViewModel: BaseViewModel<ListState>, ICharacterListViewModel {

	var models: [CharacterListItem] = []

	private let characterPageLoader: ICharacterPageLoader
	private let imageLoader: IImageLoader
	private let router: ICharacterListRouter

	init(
		characterPageLoader: ICharacterPageLoader,
		imageLoader: IImageLoader,
		router: ICharacterListRouter
	) {
		self.characterPageLoader = characterPageLoader
		self.imageLoader = imageLoader
		self.router = router

		super.init()
		system(feedbacks: [whenLoading()]) { (event) in
			if case .onSelectCharacter(let index) = event { router.pushToDetailCharacter(id: index) }
		}
	}
}

private extension CharacterListViewModel {
	func whenLoading() -> Feedback<ListState> {
		Feedback { (state: ListState) -> AnyPublisher<ListEvent, Never> in
			guard case .loading = state else { return Empty().eraseToAnyPublisher() }

			return self.characterPageLoader.loadNextPage()
				.receive(on: DispatchQueue.main)
				.map { $0.map { self.transformCharacter(from: $0) } }
				.map { characters -> ListEvent in
					if self.models.count != 0 {
						self.models.removeLast()
					}
					characters.forEach { self.models.append(.character(characterItem: $0)) }
					if !self.characterPageLoader.isFinished {
						self.models.append(.loader)
					}
					return ListEvent.onCharactersLoaded(self.models)
				}
				.catch { Just(ListEvent.onFailedToLoadCharacters($0)).eraseToAnyPublisher()}
				.eraseToAnyPublisher()
		}
	}

	private func transformCharacter(from character: Character) -> CharacterItem {
		CharacterItem(
			id: character.id,
			name: character.name,
			race: character.species,
			gender: character.gender
		) { imageSetter in
			imageSetter(
				self.imageLoader.loadImage(from: character.image)
					.replaceError(with: nil)
					.eraseToAnyPublisher()
			)
		}
	}
}
