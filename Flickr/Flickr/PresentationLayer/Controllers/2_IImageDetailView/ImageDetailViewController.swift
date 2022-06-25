//
//  ImageDetailViewController.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import UIKit

class ImageDetailViewController: BaseViewController {
    
    private lazy var detailImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var presenter: IImageDetailViewPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
    }
    
    override func addSubViews() {
        super.addSubViews()
        
        view.addSubview(detailImage)
    }
    
    // MARK: - Setting Constraints
    
    override func setupConstraints() {
        super.setupConstraints()
        
        let safeArea = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            detailImage.topAnchor.constraint(equalTo: safeArea.topAnchor),
            detailImage.widthAnchor.constraint(equalTo: safeArea.widthAnchor),
            detailImage.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            detailImage.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }
}

extension ImageDetailViewController: IImageDetailView {
    
    func updateImage(with image: UIImage, size: CGSize) {
        detailImage.image = image

        let koef = size.height/size.width
        let currentHeight = koef*self.view.bounds.width

        let newSize = CGSize(width: view.bounds.width, height: currentHeight)

        detailImage.frame.size = newSize
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            detailImage.widthAnchor.constraint(equalTo: safeArea.widthAnchor),
            detailImage.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            detailImage.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            detailImage.heightAnchor.constraint(equalToConstant: newSize.height)
        ])
    }
    
    func updateLabel(with string: String) {
        title = string
    }
}

