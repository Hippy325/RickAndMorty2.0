//
//  CharactersModel.swift
//  MVVM&Combine
//
//  Created by User on 16.06.2023.
//

import Foundation

struct Location: Decodable {
	var name: String
}

struct Character: Decodable {
	var id: Int
	var name: String
	var species: String
	var gender: String
	var status: String
	var location: Location
	var episode: [String]

	var image: URL?
}

struct CharacterResponse: Decodable {

	struct ListInfo: Decodable {
		var count: Int
		var pages: Int
		var next: URL?
	}

	var info: ListInfo
	var results: [Character]
}
