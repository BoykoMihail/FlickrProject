//
//  GalleryController.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import UIKit

private extension String {
    static let tableViewCellIdentifier = "ImageCell"
}

final class GalleryController: BaseViewController, IGalleryView {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ImageCell.self, forCellReuseIdentifier: .tableViewCellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    var presenter: IGalleryPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = presenter?.title
        
        Task {
            await presenter?.viewDidLoad()
        }
    }
    // MARK: - Setting Views

    override func addSubViews() {
        super.addSubViews()
        view.addSubview(tableView)
    }

    // MARK: - Setting Constraints

    override func setupConstraints() {
        super.setupConstraints()

        if let view = view {
            NSLayoutConstraint.activate([
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.topAnchor.constraint(equalTo: view.topAnchor),
                tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
                tableView.heightAnchor.constraint(equalTo: view.heightAnchor)
            ])
        }
    }

    override func setupAccessibility() {
        super.setupAccessibility()
        view.accessibilityIdentifier = "GalleryController"
        tableView.accessibilityIdentifier = "GalleryController_tableView"
    }

    func updateData() {
        tableView.reloadData()
    }
}

extension GalleryController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didTapCell(indexPath: indexPath.row)
    }
}

extension GalleryController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let presenter = presenter else {
            return .zero
        }

        return presenter.getCellHeight(index: indexPath.row,
                                       viewWidth: view.bounds.width)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let presenter = presenter else {
            return .zero
        }

        return presenter.countOfPhotos
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: .tableViewCellIdentifier,
                                 for: indexPath) as? ImageCell,
              let presenter = presenter else {
            return UITableViewCell()
        }

        let viewModel = presenter.getCellViewModelFor(index: indexPath.row)
        cell.configure(with: viewModel)

        cell.accessibilityIdentifier = String.tableViewCellIdentifier + "_\(indexPath.row)"

        return cell
    }
}
