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
    
    override func setupAccessibility() {
        super.setupAccessibility()
        view.accessibilityIdentifier = "ImageDetailViewController"
    }
}

extension ImageDetailViewController: IImageDetailView {
    
    var viewWidth: CGFloat {
        view.bounds.width
    }
    
    func updateImage(with image: UIImage, width: CGFloat, height: CGFloat) {
        detailImage.image = image

        

        detailImage.frame.size = CGSize(width: width, height: height)
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            detailImage.widthAnchor.constraint(equalTo: safeArea.widthAnchor),
            detailImage.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            detailImage.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            detailImage.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    func updateLabel(with string: String) {
        title = string
    }
}
