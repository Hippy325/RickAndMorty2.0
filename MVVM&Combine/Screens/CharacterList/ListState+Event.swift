//
//  State+Event.swift
//  MVVM&Combine
//
//  Created by User on 17.06.2023.
//

import Foundation

enum ListState: IState {
	typealias Event = ListEvent
	case idle
	case loading
	case loaded([CharacterListItem])
	case error(Error)
}

extension ListState {
	static func reduce(state: ListState, event: ListEvent) -> ListState {
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
			case .onCharactersLoaded(let items):
				return .loaded(items)
			case .onFailedToLoadCharacters(let error):
				return .error(error)
			default:
				return state
			}

		case .loaded:
			switch event {
			case .onAppear:
				return .loading
			default:
				return state
			}
		case .error:
			return state
		}
	}

	static func initalState() -> ListState {
		.idle
	}
}

enum ListEvent {
	case onAppear
	case onSelectCharacter(Int)
	case onCharactersLoaded([CharacterListItem])
	case onFailedToLoadCharacters(Error)
}

extension ListEvent: IEvent {
	static func onAppear() -> ListEvent {
		.onAppear
	}
}
