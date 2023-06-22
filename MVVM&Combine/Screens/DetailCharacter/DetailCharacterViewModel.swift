//
//  DetailCharacterViewModel.swift
//  MVVM&Combine
//
//  Created by User on 18.06.2023.
//

import Foundation
import Combine

protocol IDetailCharacterViewModel {
	var state: DetailState { get }
}

final class DetailCharacterViewModel: BaseViewModel<DetailState>, IDetailCharacterViewModel {
	private let imageLoader: IImageLoader
	private let characterLoader: ICharacterLoader
	private let characterIndex: Int

	init(
		characterIndex: Int,
		imageLoader: IImageLoader,
		characterLoader: ICharacterLoader
	) {
		self.characterIndex = characterIndex
		self.imageLoader = imageLoader
		self.characterLoader = characterLoader

		super.init()
		system(feedbacks: [whenLoading()])
	}
}

private extension DetailCharacterViewModel {
	func whenLoading() -> Feedback<DetailState> {
		Feedback { (state: DetailState) -> AnyPublisher<DetailEvent, Never> in
			guard case .loading = state else { return Empty().eraseToAnyPublisher() }

			return self.characterLoader.load(characterIndex: self.characterIndex)
				.receive(on: DispatchQueue.main)
				.map { DetailEvent.onCharactersLoaded(self.transformCharacter(from: $0)) }
				.catch { Just(DetailEvent.onFailedToLoadCharacters($0)).eraseToAnyPublisher()}
				.eraseToAnyPublisher()
		}
	}

	func transformCharacter(from character: Character) -> DetailModel {
		DetailModel(
			name: character.name,
			race: character.species,
			gender: character.gender,
			status: character.status,
			location: character.location.name,
			countEpisode: String(character.episode.count),
			image: imageLoader.loadImage(from: character.image)
				.replaceError(with: nil)
				.eraseToAnyPublisher()
		)
	}
}
