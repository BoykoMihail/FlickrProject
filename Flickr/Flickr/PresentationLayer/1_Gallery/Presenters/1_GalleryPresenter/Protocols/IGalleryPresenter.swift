//
//  IGalleryPresenter.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import UIKit

protocol IGalleryPresenter {
    func viewDidLoad() async
    func didTapCell(indexPath: Int)
    func getCellHeight(index: Int, viewWidth: CGFloat) -> CGFloat
    func getCellViewModelFor(index: Int) -> ImageCellViewModel

    var title: String { get }
    var countOfPhotos: Int { get }
}
