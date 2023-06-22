//
//  BaseViewModel.swift
//  MVVM&Combine
//
//  Created by User on 19.06.2023.
//

import Foundation
import Combine

class BaseViewModel<S: IState>: ObservableObject {
	@Published private(set) var state = S.initalState()
	private var store = Set<AnyCancellable>()
	private let input = PassthroughSubject<S.Event, Never>()

	func send(_ event: S.Event) {
		input.send(event)
	}

	private func userInput(specialEvent: ((_ event: S.Event) -> Void)?) -> Feedback<S> {
		Feedback { (_) -> AnyPublisher<S.Event, Never> in
			self.input
				.map { (event) -> S.Event in
					specialEvent?(event)
					return event
				}
				.eraseToAnyPublisher()
		}
	}

	func system(
		feedbacks: [Feedback<S>],
		specialEvent: ((_ event: S.Event) -> Void)? = nil
	) {
		let publisherState = CurrentValueSubject<S, Never>(state)
		let feedbackWithInput = feedbacks + [userInput(specialEvent: specialEvent)]

		let events = feedbackWithInput.map { $0.run(publisherState.eraseToAnyPublisher()) }

		Deferred {
			Publishers.MergeMany(events)
				.receive(on: DispatchQueue.main)
				.scan(self.state, S.reduce)
				.handleEvents(receiveOutput: publisherState.send)
				.prepend(self.state)
				.eraseToAnyPublisher()
		}
		.eraseToAnyPublisher()
		.assign(to: \.state, on: self)
		.store(in: &store)
	}
}
