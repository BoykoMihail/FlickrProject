//
//  GalleryPresenter.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import UIKit

private extension Int {
    static let amountOfFirstLevelCash = 200
}

final class GalleryPresenter: IGalleryPresenter {
    
    private let flickrService: IFlickrService
    private let imageLoader: IImageLoader
    private let router: IMainGalleryRouter
    
    private var isUpdating = false
    private let concurrentQueue = DispatchQueue(label: "gallerypresenter.concurrent.queue", attributes: .concurrent)
    private let lock = NSLock()
    
    weak var viewController: IGalleryView?
    
    var photos: [FlickrPhoto] = []
    
    init(flickrService: IFlickrService,
         imageLoader: IImageLoader,
         router: IMainGalleryRouter) {
        self.flickrService = flickrService
        self.imageLoader = imageLoader
        self.router = router
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
                    
            self?.concurrentQueue.async {
                let to = self?.photos.count ?? 0
                let from = Swift.max(0, to - flickrPhoto.count)
                for i in from..<to {
                    self?.getImageFor(index: i) { _ in }
                }
            }
            
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
        imageLoader.downloadImage(from: url) { [weak self] error, image in
            
            if let error = error {
                self?.handleError(with: error)
                return
            }
            
            guard let image = image else {
                self?.handleError(with: ImageLoaderCustomErrors.emphtyImage)
                return
            }
            self?.lock.lock()
            self?.photos[index].image = image
            self?.lock.unlock()
            
            completion(image)
        }
    }
    
    func didTapCell(indexPath: Int) {
        lock.lock()
        let photo = photos[indexPath]
        lock.unlock()
        
        guard let image = photo.image else {
            return
        }
        
        let size = CGSize(width: photo.width, height: photo.height)
        let viewModel = DetailsViewModel(image: image,
                                         name: photo.title,
                                         size: size)
        router.moveToDetailsImageView(viewModel: viewModel)
    }
    
    func clearImage(index: Int) {
        concurrentQueue.async {
            for i in (0..<self.photos.count){
                if abs(i-index) > Int.amountOfFirstLevelCash/2, self.photos[i].image != nil {
                    self.lock.lock()
                    self.photos[i].image = nil
                    self.lock.unlock()
                }
            }
        }
    }
    
    private func handleError(with error: Error) {
        /// Обработчик ошибки
    }
}
