//
//  FlickrPhoto+Stubs.swift
//  FlickrTests
//
//  Created by Михаил Бойко on 26.06.2022.
//

@testable import Flickr
import UIKit

extension FlickrPhoto {
    static func getFlickrPhotoStub(photoId: String = "1",
                                   title: String = "image",
                                   height: Int = 200,
                                   width: Int = 100,
                                   photoUrl: String = "url",
                                   image: UIImage? = nil) -> FlickrPhoto {
        FlickrPhoto(photoId: photoId, title: title, height: height, width: width, photoUrl: photoUrl)
    }
}
