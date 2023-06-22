//
//  DetailState+Event.swift
//  MVVM&Combine
//
//  Created by User on 18.06.2023.
//

import Foundation

enum DetailState {
	typealias Event = DetailEvent

	case idle
	case loading
	case loaded(DetailModel)
	case error(Error)
}

extension DetailState: IState {
	static func reduce(state: DetailState, event: DetailEvent) -> DetailState {
		switch state {
		case .idle:
			switch event {
			case .onAppear:
				return .loading
			default:
				return state
			}
		case .loading:
			switch event {
			case .onCharactersLoaded(let item):
				return .loaded(item)
			case .onFailedToLoadCharacters(let error):
				return .error(error)
			default:
				return state
			}

		case .loaded:
			return state
		case .error:
			return state
		}
	}

	static func initalState() -> DetailState {
		.idle
	}
}

enum DetailEvent: IEvent {
	case onAppear
	case onCharactersLoaded(DetailModel)
	case onFailedToLoadCharacters(Error)

	static func onAppear() -> DetailEvent {
		.onAppear
	}
}
