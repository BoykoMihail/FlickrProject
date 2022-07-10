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

private struct Const {
    static let defaultBlock: GetImageblock = { block in
        let task = Task {
            UIImage()
        }
        block(task)
    }
}

private extension ImageCellViewModel {
    static let defaultImageCellViewModel = ImageCellViewModel(getImageblock: Const.defaultBlock)
}

final class GalleryPresenter: IGalleryPresenter {
    private let paginatorHelper: IPaginatorHelper
    private let imageHelper: IImageHelper
    private let router: IMainGalleryRouter

    private var isUpdating = false

    private var photos = ThreadSafeArray<FlickrPhoto>()

    var countOfPhotos: Int {
        return photos.count
    }

    var title = "Flickr's Gallery"

    weak var viewController: IGalleryView?

    init(paginatorHelper: IPaginatorHelper,
         imageHelper: IImageHelper,
         router: IMainGalleryRouter) {
        self.paginatorHelper = paginatorHelper
        self.imageHelper = imageHelper
        self.router = router
    }

    func viewDidLoad() async {
        guard !isUpdating else {
            return
        }

        isUpdating = true

        do {
            let flickrPhoto = try await paginatorHelper.loadInitialData()
            fetchPhotosHandler(flickrPhoto)
            isUpdating = false
        } catch {
            handleError(with: error)
        }
    }

    func getCellViewModelFor(index: Int) -> ImageCellViewModel {
        Task {
            await getCellViewModelOn(index: index)
        }
        
        guard index < countOfPhotos else {
            return .defaultImageCellViewModel
        }

        let photo = photos[index]

        guard let photo = photo else {
            return .defaultImageCellViewModel
        }

        guard let url = photo.url else {
            return .defaultImageCellViewModel
        }

        let task = Task { () -> UIImage in
            return await getImageFor(url: url)
        }

        let result = ImageCellViewModel { block in
            Task {
                block(task)
            }
        }

        return result
    }

    func didTapCell(indexPath: Int) {
        let photoModel = photos[indexPath]

        guard let photoModel = photoModel else {
            return
        }

        let size = CGSize(width: photoModel.width, height: photoModel.height)
        
        if let url = photoModel.url {
            Task {
                let image = await getImageFor(url: url)
                let model = MainGalleryRouterModel(size: size, title: photoModel.title, image: image)
                await router.moveToDetailsImageView(model: model)
            }
        }
    }

    func getCellHeight(index: Int, viewWidth: CGFloat) -> CGFloat {
        let photo = photos[index]

        guard let photo = photo else {
            return .zero
        }

        guard photo.width != 0 else {
            return .zero
        }

        let koef = CGFloat(photo.height) / CGFloat(photo.width)
        let currentHeight = koef * viewWidth

        return currentHeight
    }

    private func loadPhotos() async {
        guard !isUpdating else {
            return
        }

        isUpdating = true

        do {
            let flickrPhoto = try await paginatorHelper.loadNextPage()
            
            fetchPhotosHandler(flickrPhoto)
            isUpdating = false
        } catch {
            handleError(with: error)
        }
    }

    private func fetchPhotosHandler(_ flickrResponse: PaginatorHelperResult) {
        updatePhotosModel(flickrPhoto: flickrResponse)

        Task { @MainActor in
            viewController?.updateData()
        }
    }

    private func getCellViewModelOn(index: Int) async {
        if index > countOfPhotos - Int.numberOfCellWhenItNeedsToUpdate {
            await loadPhotos()
        }
    }

    private func updatePhotosModel(flickrPhoto: [FlickrPhoto]) {
        photos.append(contentsOf: flickrPhoto)
        imageHelper.updatePhotosModel(flickrPhoto: flickrPhoto)
    }

    private func getImageFor(url: URL) async -> (UIImage) {
        do {
            return try await imageHelper.getImageFor(url: url)
        } catch {
            handleError(with: error)
            return UIImage()
        }
    }

    private func handleError(with error: Error) {
        // Обработчик ошибки
    }
}
