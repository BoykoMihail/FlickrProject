//
//  ImageCell.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import UIKit

final class ImageCell: UITableViewCell {
    
    private let flickrImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage() // Может быть дефолтная картинка
        return imageView
    }()
    
    var lazyImage: UIImage? {
        didSet{
            guard let lazyImage = lazyImage else {
                return
            }
            
            DispatchQueue.main.async {
                self.flickrImageView.image = lazyImage
                self.lazyImage = nil
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
        setupConstraints()

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        flickrImageView.image = nil
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func clearImage() {
        flickrImageView.image = nil
    }
    
    private func setupViews() {
        contentView.addSubview(flickrImageView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            flickrImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            flickrImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            flickrImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            flickrImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
        ])
    }
}

