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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
        setupConstraints()

    }
    
    override func prepareForReuse() {
        flickrImageView.image = nil
        super.prepareForReuse()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure(with viewModel: ImageCellViewModel) {
        viewModel.getImageFromUrl { image in
            Task { @MainActor in
                self.flickrImageView.image = image
            }
        }
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
