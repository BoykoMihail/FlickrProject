//
//  IGalleryView.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import UIKit

@MainActor
protocol IGalleryView: AnyObject {
    func updateData()
}
