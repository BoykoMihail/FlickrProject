//
//  IImageDetailView.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import UIKit

protocol IImageDetailView: AnyObject {
    
    func updateImage(with image: UIImage, width: CGFloat, height: CGFloat)
    func updateLabel(with string: String)
    
    var viewWidth: CGFloat { get }
}
