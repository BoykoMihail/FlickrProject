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

private extension Int {
    static let numberOfCellWhenItNeedsToUpdate = 5
}

class GalleryController: BaseViewController, IGalleryView {
    
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
        
        title = "Flickr's Gallery"
        presenter?.viewDidLoad()
        
    }
    // MARK: - Setting Views
    
    override func addSubViews() {
        super.addSubViews()
        view.addSubview(tableView)
    }
    
    // MARK: - Setting Constraints
    
    override func setupConstraints() {
        super.setupConstraints()
        
        let safeArea = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.widthAnchor.constraint(equalTo: safeArea.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: safeArea.heightAnchor),
        ])
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
        
        let photo = presenter.photos[indexPath.row]
        guard photo.width != 0 else {
            return .zero
        }
        
        let koef = CGFloat(photo.height)/CGFloat(photo.width)
        let currentHeight = koef*self.view.bounds.width
        
        return currentHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let presenter = presenter else {
            return .zero
        }
        
        return presenter.photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: .tableViewCellIdentifier, for: indexPath) as? ImageCell,
              let presenter = presenter else {
            return UITableViewCell()
        }

        cell.clearImage()
        presenter.getImageFor(index: indexPath.row) {
            cell.lazyImage = $0
        }
        
        cell.accessibilityIdentifier = String.tableViewCellIdentifier + "_\(indexPath.row)"
        if indexPath.row > presenter.photos.count - Int.numberOfCellWhenItNeedsToUpdate {
            DispatchQueue.global(qos: .background).async {
                presenter.clearImage(index: indexPath.row)
            }
            
            DispatchQueue.global(qos: .userInteractive).async {
                self.presenter?.loadPhotos()
            }
        }
        
        return cell
    }
}
