//
//  IGalleryPresenter.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import UIKit

protocol IGalleryPresenter {
    
    func viewDidLoad()
    func loadPhotos()
    func getImageFor(index: Int, completion: @escaping (UIImage) -> ())
    func didTapCell(indexPath: Int)
}

