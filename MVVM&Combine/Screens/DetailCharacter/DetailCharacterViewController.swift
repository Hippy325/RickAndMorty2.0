//
//  DetailCharacterViewController.swift
//  MVVM&Combine
//
//  Created by User on 18.06.2023.
//

import Foundation
import Combine
import UIKit

final class DetailCharacterViewController: BaseViewController<DetailState, DetailCharacterViewModel> {

	// MARK: - Subviews

	private struct Subviews {
		let raceView = UILabel()
		let statusView = UILabel()
		let genderView = UILabel()
		let locationView = UILabel()
		let countEpisodeView = UILabel()
		let avatarView = UIImageView()
	}

	// MARK: - Properties
	private var store = Set<AnyCancellable>()
	private let subviews = Subviews()
	private let stackView = UIStackView()
	private let titleView = TitleView()

	// MARK: - Lifecycle

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

	}

	override func viewDidLoad() {
		view.backgroundColor = UIColor(named: "DetailBackgraundColor")
		setup()

		navigationItem.titleView = titleView

		viewModel.$state
			.sink { self.reloadData(state: $0) }
			.store(in: &store)
	}

	// MARK: - Private

	private func setup() {
		navigationController?.navigationBar.tintColor = UIColor(named: "NavigatinBarButtonColor")

		view.addSubview(stackView)
		stackView.axis = .vertical
		setupSubviews()
		setupLayout()
	}

	private func setupSubviews() {
		view.addSubview(subviews.avatarView)
		subviews.avatarView.translatesAutoresizingMaskIntoConstraints = false
		stackView.addArrangedSubview(subviews.raceView)
		stackView.addArrangedSubview(subviews.genderView)
		stackView.addArrangedSubview(subviews.statusView)
		stackView.addArrangedSubview(subviews.locationView)
		stackView.addArrangedSubview(subviews.countEpisodeView)

		subviews.raceView.font = UIFont.systemFont(ofSize: 20)
		subviews.genderView.font = UIFont.systemFont(ofSize: 20)
		subviews.statusView.font = UIFont.systemFont(ofSize: 20)
		subviews.countEpisodeView.font = UIFont.systemFont(ofSize: 20)
		subviews.locationView.font = UIFont.systemFont(ofSize: 20)
	}

	private func setupLayout() {
		stackView.translatesAutoresizingMaskIntoConstraints = false
		subviews.avatarView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			subviews.avatarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			subviews.avatarView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
			subviews.avatarView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),

			stackView.topAnchor.constraint(equalTo: subviews.avatarView.bottomAnchor, constant: 15),
			stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
			stackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 15),
			stackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -15)
		])
	}
}

extension DetailCharacterViewController {
	func reloadData(state: DetailState) {
		guard case .loaded(let model) = state else { return }

		titleView.setup(title: model.name)
		subviews.raceView.text = "race: " + model.race
		subviews.genderView.text = "gender: " + model.gender
		subviews.statusView.text = "status: " + model.status
		subviews.locationView.text = "location: " + model.location
		subviews.countEpisodeView.text = "episodes: " + model.countEpisode
		model.image
			.sink { self.subviews.avatarView.image = $0 }
			.store(in: &store)
	}
}

