//
//  CharacterListViewController.swift
//  MVVM&Combine
//
//  Created by User on 15.06.2023.
//

import UIKit
import Combine

class CharacterListViewController: BaseViewController<ListState, CharacterListViewModel> {

	// MARK: - Properties

	private var store = Set<AnyCancellable>()
	private let characterTableView = UITableView()
	private let imageView = UIImageView()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		setup()

		viewModel.$state
			.sink { _ in self.characterTableView.reloadData() }
			.store(in: &store)
	}

	private func setup() {
		navigationItem.backButtonTitle = "back"
		view.addSubview(imageView)
		view.addSubview(characterTableView)
		title = "Rick && Morty"
		navigationItem.largeTitleDisplayMode = .automatic
		characterTableView.contentInsetAdjustmentBehavior = .always
		imageView.image = UIImage(named: "rick")

		setupLayout()
		characterTableView.backgroundColor = .clear
		characterTableView.register(CharacterCell.self, forCellReuseIdentifier: "CharacterCell")
		characterTableView.register(LoaderCell.self, forCellReuseIdentifier: "LoaderCell")
		characterTableView.dataSource = self
		characterTableView.delegate = self
	}

	private func setupLayout() {
		imageView.translatesAutoresizingMaskIntoConstraints = false
		characterTableView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			imageView.leftAnchor.constraint(equalTo: view.leftAnchor),
			imageView.rightAnchor.constraint(equalTo: view.rightAnchor),

			characterTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			characterTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			characterTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
			characterTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
		])
	}
}

extension CharacterListViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.models.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		switch viewModel.models[indexPath.row] {

		case .character(characterItem: let item):
			guard let characterCell = tableView.dequeueReusableCell(
					withIdentifier: "CharacterCell",
					for: indexPath
				) as? CharacterCell
			else { return UITableViewCell() }
			characterCell.configure(item: item)

			return characterCell

		case .loader:
			guard let loaderCell = tableView.dequeueReusableCell(
					withIdentifier: "LoaderCell",
					for: indexPath
				) as? LoaderCell
			else { return UITableViewCell() }
			loaderCell.startAnimation()
			return loaderCell
		}
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		viewModel.send(.onSelectCharacter(indexPath.row))
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 60
	}

	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
			if tableView.visibleCells.contains(cell) {
				guard cell as? LoaderCell != nil else { return }
				self.viewModel.send(.onAppear)
			}
		}
	}
}

