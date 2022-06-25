//
//  GalleryPresenter.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import UIKit

final class GalleryPresenter: IGalleryPresenter {
    
    weak var viewController: IGalleryView?
    
    func viewDidLoad() {
        loadPhotos()
    }
    
    func loadPhotos() { }
    
    func getImageFor(index: Int, completion: @escaping (UIImage) -> ()) {
        completion(UIImage())
    }
    
    func didTapCell(indexPath: Int) { }
    
    private func handleError(with error: Error) {
        /// Обработчик ошибки
    }
}

