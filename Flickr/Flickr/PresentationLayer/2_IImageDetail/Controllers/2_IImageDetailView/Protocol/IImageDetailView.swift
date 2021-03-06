//
//  IImageDetailView.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import UIKit

@MainActor
protocol IImageDetailView: AnyObject {
    func updateImage(with image: UIImage, size: CGSize)
    func updateLabel(with string: String)

    var viewWidth: CGFloat { get }
}
