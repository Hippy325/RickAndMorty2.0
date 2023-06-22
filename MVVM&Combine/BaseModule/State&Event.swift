//
//  State&Event.swift
//  MVVM&Combine
//
//  Created by User on 19.06.2023.
//

import Foundation

protocol IState {
	associatedtype Event: IEvent

	static func initalState() -> Self
	static func reduce(state: Self, event: Event) -> Self
}

protocol IEvent {
	static func onAppear() -> Self
}
