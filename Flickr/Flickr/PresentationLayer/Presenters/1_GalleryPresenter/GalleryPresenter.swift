//
//  GalleryPresenter.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import UIKit

private extension Int {
    static let amountOfFirstLevelCash = 40
    static let numberOfCellWhenItNeedsToUpdate = 5
}

final class GalleryPresenter: IGalleryPresenter {
    
    private let flickrService: IFlickrService
    private let imageLoader: IImageLoader
    private let router: IMainGalleryRouter
    
    private let concurrentQueue = DispatchQueue(label: "gallerypresenter.concurrent.queue", attributes: .concurrent)
    
    private var isUpdating = false
    
    private var photos = ThreadSafeArray<FlickrPhoto>()
    
    var countOfPhotos: Int {
        return photos.count
    }
    
    var title = "Flickr's Gallery"
    
    weak var viewController: IGalleryView?
    
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
    
    func getCellViewModelFor(index: Int) -> ImageCellViewModel {
        
        getCellViewModelOn(index: index)
        
        let defaultBlock: GetImageblock = { block in
            block(UIImage())
        }
        
        guard index < countOfPhotos else {
            return ImageCellViewModel(getImageblock: defaultBlock)
        }
        
        let photo = photos[index]
        
        guard let photo = photo else {
            return ImageCellViewModel(getImageblock: defaultBlock)
        }
        
        if let image = photo.image {
            return ImageCellViewModel{ block in
                block(image)
            }
        }
        
        guard let url = URL(string: photo.photoUrl) else {
            return ImageCellViewModel(getImageblock: defaultBlock)
        }
        
        let result = ImageCellViewModel { [weak self] block in
            self?.getImageFor(url: url) { image in
                self?.photos[index]?.image = image
                block(image)
            }
        }
        
        return result
    }
    
    func didTapCell(indexPath: Int) {
        let photo = photos[indexPath]
        
        guard let photo = photo else {
            return
        }
        
        router.moveToDetailsImageView(viewModel: photo)
    }
    
    func getCellHeight(index: Int, viewWidth: CGFloat) -> CGFloat {
        let photo = photos[index]
        
        guard let photo = photo else {
            return .zero
        }
        
        guard photo.width != 0 else {
            return .zero
        }
        
        let koef = CGFloat(photo.height)/CGFloat(photo.width)
        let currentHeight = koef*viewWidth
        
        return currentHeight
    }
    
    private func loadPhotos() {
        guard !isUpdating else {
            return
        }
        
        isUpdating = true
        flickrService.fetchPhotos { [weak self] error, flickrPhoto in
            self?.fetchPhotosHandler(flickrPhoto, error)
            self?.isUpdating = false
        }
    }
    
    private func fetchPhotosHandler(_ flickrPhoto: [FlickrPhoto]?, _ error: Error?) {
        if let error = error {
            handleError(with: error)
            return
        }
        
        guard let flickrPhoto = flickrPhoto else {
            handleError(with: FlickrServiceCustomErrors.ephtyData)
            return
        }
        
        updatePhotosModel(flickrPhoto: flickrPhoto)

        DispatchQueue.main.async {
            self.viewController?.updateData()
        }
    }
    
    private func getCellViewModelOn(index: Int) {
        concurrentQueue.async {
            if index > self.countOfPhotos - Int.numberOfCellWhenItNeedsToUpdate {
                self.clearImage(index: index)
                self.loadPhotos()
            }
        }
    }
    
    private func clearImage(index: Int) {
        DispatchQueue.concurrentPerform(iterations: countOfPhotos) { i in
            if abs(i-index) > Int.amountOfFirstLevelCash/2,
               self.photos[i]?.image != nil {
                self.photos[i]?.image = nil
            }
        }
    }
    
    private func updatePhotosModel(flickrPhoto: [FlickrPhoto]) {
        photos.append(contentsOf: flickrPhoto)
        let to = self.countOfPhotos
        let from = Swift.max(0, to - flickrPhoto.count)
        
        DispatchQueue.concurrentPerform(iterations: to - from) { i in
            if let photo = self.photos[from + i],
               let url = URL(string: photo.photoUrl)  {
                self.getImageFor(url: url) { _ in }
            }
        }
    }
    
    private func getImageFor(url: URL, completion: @escaping (UIImage) -> ()) {
        imageLoader.downloadImage(from: url) { [weak self] error, image in
            
            if let error = error {
                self?.handleError(with: error)
                return
            }
            
            guard let image = image else {
                self?.handleError(with: ImageLoaderCustomErrors.emphtyImage)
                return
            }
            
            completion(image)
        }
    }
    
    private func handleError(with error: Error) {
        /// Обработчик ошибки
    }
}
