//
//  GalleryPresenter.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import UIKit

final class GalleryPresenter: IGalleryPresenter {
    
    private let flickrService: IFlickrService
    private var isUpdating = false
    
    private let concurrentQueue = DispatchQueue(label: "gallerypresenter.concurrent.queue", attributes: .concurrent)
    private let lock = NSLock()

    weak var viewController: IGalleryView?

    var photos: [FlickrPhoto] = []
    
    init(flickrService: IFlickrService) {
        self.flickrService = flickrService
    }
    
    func viewDidLoad() {
        loadPhotos()
    }
    
    func loadPhotos() {
        guard !isUpdating else {
            return
        }
        
        isUpdating = true
        
        flickrService.fetchPhotos { [weak self] error, flickrPhoto in
            
            if let error = error {
                self?.handleError(with: error)
                self?.isUpdating = false
                return
            }
            
            guard let flickrPhoto = flickrPhoto else {
                self?.handleError(with: FlickrServiceCustomErrors.ephtyData)
                self?.isUpdating = false
                return
            }
            
            self?.lock.lock()
            self?.photos.append(contentsOf: flickrPhoto)
            self?.lock.unlock()
            
            self?.isUpdating = false

            DispatchQueue.main.async {
                self?.viewController?.updateData()
            }
        }
    }
    
    func getImageFor(index: Int, completion: @escaping (UIImage) -> ()) {
        guard (0...photos.count).contains(index) else {
            completion(UIImage())
            return
        }
        
        lock.lock()
        let photo = photos[index]
        lock.unlock()
        
        if let image = photo.image {
            completion(image)
            return
        }
        
        guard let url = URL(string: photo.photoUrl) else {
            completion(UIImage())
            return
        }

        completion(UIImage())
    }
    
    func didTapCell(indexPath: Int) { }
    
    private func handleError(with error: Error) {
        /// Обработчик ошибки
    }
}

