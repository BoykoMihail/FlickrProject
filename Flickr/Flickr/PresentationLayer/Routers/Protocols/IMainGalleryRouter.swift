//
//  IMainGalleryRouter.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import UIKit

@MainActor
protocol IMainGalleryRouter {
    func moveToDetailsImageView(model: MainGalleryRouterModel)
}
