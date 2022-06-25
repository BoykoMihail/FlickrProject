//
//  GalleryPresenter.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import UIKit

final class GalleryPresenter: IGalleryPresenter {
    
    private let flickrService: IFlickrService
    
    weak var viewController: IGalleryView?
    
    init(flickrService: IFlickrService) {
        self.flickrService = flickrService
    }
    
    func viewDidLoad() {
        loadPhotos()
    }
    
    func loadPhotos() {
        flickrService.fetchPhotos { error, data in
            debugPrint("//// data = ", data?.count)
        }
    }
    
    func getImageFor(index: Int, completion: @escaping (UIImage) -> ()) {
        completion(UIImage())
    }
    
    func didTapCell(indexPath: Int) { }
    
    private func handleError(with error: Error) {
        /// Обработчик ошибки
    }
}

