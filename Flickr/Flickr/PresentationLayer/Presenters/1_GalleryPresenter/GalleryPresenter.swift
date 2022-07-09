//
//  GalleryPresenter.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import UIKit

private extension Int {
    static let amountOfFirstLevelCache = 60
    static let numberOfCellWhenItNeedsToUpdate = 15
}


final class GalleryPresenter: IGalleryPresenter {
    
    private let paginatorHelper: IPaginatorHelper
    private let imageLoader: IImageLoader
    private let router: IMainGalleryRouter
    
    private var isUpdating = false
    
    private var photos = ThreadSafeArray<FlickrPhoto>()
    
    var countOfPhotos: Int {
        return photos.count
    }
    
    var title = "Flickr's Gallery"
    
    weak var viewController: IGalleryView?
    
    init(paginatorHelper: IPaginatorHelper,
         imageLoader: IImageLoader,
         router: IMainGalleryRouter) {
        self.paginatorHelper = paginatorHelper
        self.imageLoader = imageLoader
        self.router = router
    }
    
    func viewDidLoad() {
        guard !isUpdating else {
            return
        }
        
        isUpdating = true
        
        Task(priority: .high) {
            let flickrPhoto = await paginatorHelper.loadInitialData()
            
            fetchPhotosHandler(flickrPhoto)
            isUpdating = false
        }
    }
    
    func getCellViewModelFor(index: Int) -> ImageCellViewModel {
        
        getCellViewModelOn(index: index)
        
        
        
        guard index < countOfPhotos else {
            return .defaultImageCellViewModel
        }
        
        let photo = photos[index]
        
        guard let photo = photo else {
            return .defaultImageCellViewModel
        }
        
        if let image = photo.image {
            return ImageCellViewModel{ block in
                block(image)
            }
        }
        
        guard let url = URL(string: photo.photoUrl) else {
            return .defaultImageCellViewModel
        }
        
        let task = Task(priority: .high) { () -> UIImage in
            let image = await getImageFor(url: url)
            photos[index]?.image = image
            return image
        }
        
        let result = ImageCellViewModel { block in
            Task {
                let image = await task.value
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
        
        Task(priority: .high) {
            let flickrPhoto = await paginatorHelper.loadNextPage()
            
            fetchPhotosHandler(flickrPhoto)
            isUpdating = false
        }
    }
    
    private func fetchPhotosHandler(_ flickrResponse: PaginatorHelperResult) {
        
        switch flickrResponse {
        case let .success(fetchPhotosResult):
            updatePhotosModel(flickrPhoto: fetchPhotosResult)
        case let .failure(error):
            handleError(with: error)
        }

        Task { @MainActor in
            viewController?.updateData()
        }
    }
    
    private func getCellViewModelOn(index: Int) {
        Task(priority: .background) {
            if index > countOfPhotos - Int.numberOfCellWhenItNeedsToUpdate {
                clearImage(index: index)
                loadPhotos()
            }
        }
    }
    
    private func clearImage(index: Int) {
        Task(priority: .background) {
            (0..<countOfPhotos).forEach { i in
                if abs(i-index) > Int.amountOfFirstLevelCache/2,
                   photos[i]?.image != nil {
                    photos[i]?.image = nil
                }
            }
        }
    }
    
    private func updatePhotosModel(flickrPhoto: [FlickrPhoto]) {
        photos.append(contentsOf: flickrPhoto)
        let to = self.countOfPhotos
        let from = Swift.max(0, to - flickrPhoto.count)
        
        (0..<(to - from)).forEach { i in
            if let photo = photos[from + i],
               let url = URL(string: photo.photoUrl)  {
                Task(priority: .background) {
                    let image = await getImageFor(url: url)
                    photos[from + i]?.image = image
                }
            }
        }
    }
    
    private func getImageFor(url: URL) async -> (UIImage) {
        do {
            guard let image = try await imageLoader.image(from: url) else {
                throw ImageLoaderCustomErrors.emphtyImage
            }
            
            return image
        } catch {
            handleError(with: error)
            return UIImage()
        }
    }
    
    private func handleError(with error: Error) {
        /// Обработчик ошибки
    }
}


private struct Const {
    static let defaultBlock: GetImageblock = { block in
        block(UIImage())
    }
}

private extension ImageCellViewModel {
    static let defaultImageCellViewModel = ImageCellViewModel(getImageblock: Const.defaultBlock)
}
