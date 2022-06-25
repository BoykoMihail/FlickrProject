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

class GalleryController: UIViewController, IGalleryView {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ImageCell.self, forCellReuseIdentifier: .tableViewCellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Flickr's Gallery"
        addSubViews()
        setupConstraints()
    }
    // MARK: - Setting Views
    
    func addSubViews() {
        view.addSubview(tableView)
    }
    
    // MARK: - Setting Constraints
    
    func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.widthAnchor.constraint(equalTo: safeArea.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: safeArea.heightAnchor),
        ])
    }
    
    func updateData() {
        tableView.reloadData()
    }
}


extension GalleryController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { }
}

extension GalleryController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: .tableViewCellIdentifier, for: indexPath) as? ImageCell else {
            return UITableViewCell()
        }

        cell.clearImage()
        
        cell.backgroundColor = .blue
        
        return cell
    }
}