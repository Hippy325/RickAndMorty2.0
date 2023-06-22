//
//  CharacterListFeedback.swift
//  MVVM&Combine
//
//  Created by User on 17.06.2023.
//

import Foundation
import Combine

struct Feedback<State: IState> {
	let run: (AnyPublisher<State, Never>) -> AnyPublisher<State.Event, Never>
}

extension Feedback {
	init<Effect: Publisher>(effects: @escaping (State) -> Effect) where Effect.Output == State.Event, Effect.Failure == Never {
		self.run = { state -> AnyPublisher<State.Event, Never> in
			state
				.map { effects($0) }
				.switchToLatest()
				.eraseToAnyPublisher()
		}
	}
}
