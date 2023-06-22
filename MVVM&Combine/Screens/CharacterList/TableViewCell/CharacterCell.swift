//
//  CharacterCell.swift
//  MVVM&Combine
//
//  Created by User on 16.06.2023.
//

import Foundation
import Combine
import UIKit

final class CharacterCell: UITableViewCell {

	private var cancellable: AnyCancellable?

	// MARK: - Subviews

	let nameView = UILabel()
	let raceView = UILabel()
	let genderView = UILabel()
	let avatarView = UIImageView()


	func configure(item: CharacterItem) {
		raceView.text = item.race
		genderView.text = item.gender
		nameView.text = item.name

		item.image {
			self.cancellable = $0
				.receive(on: DispatchQueue.main)
				.sink { self.avatarView.image = $0 }
		}
	}

	// MARK: - Lifecycle

	override func prepareForReuse() {
		super.prepareForReuse()
		cancellable = nil
		avatarView.image = nil
	}

	// MARK: - Init

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Private

	private func setup() {
		self.backgroundColor = .clear

		addSubview(nameView)
		addSubview(raceView)
		addSubview(genderView)
		addSubview(avatarView)
		nameView.font = UIFont.systemFont(ofSize: 25)
		nameView.numberOfLines = 1
		nameView.adjustsFontSizeToFitWidth = true

		setupLayout()
	}

	private func setupLayout() {
		avatarView.translatesAutoresizingMaskIntoConstraints = false
		nameView.translatesAutoresizingMaskIntoConstraints = false
		raceView.translatesAutoresizingMaskIntoConstraints = false
		genderView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			avatarView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
			avatarView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
			avatarView.heightAnchor.constraint(equalToConstant: 50),
			avatarView.widthAnchor.constraint(equalToConstant: 50),

			nameView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
			nameView.leftAnchor.constraint(equalTo: avatarView.rightAnchor, constant: 20),
			nameView.heightAnchor.constraint(equalToConstant: 25),
			nameView.rightAnchor.constraint(equalTo: self.rightAnchor),

			raceView.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 5),
			raceView.leftAnchor.constraint(equalTo: nameView.leftAnchor),
			raceView.heightAnchor.constraint(equalToConstant: 13),

			genderView.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 5),
			genderView.leftAnchor.constraint(equalTo: raceView.rightAnchor, constant: 5),
			genderView.heightAnchor.constraint(equalToConstant: 13)
		])
	}
}
