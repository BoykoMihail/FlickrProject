//
//  FlickrPhoto.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import UIKit

struct FlickrPhoto: Decodable {
    let photoId: String
    let title: String
    let height: Int
    let width: Int
    let photoUrl: String

    enum CodingKeys: String, CodingKey {
        case photoId = "id"
        case title
        case height = "height_m"
        case width = "width_m"
        case photoUrl = "url_m"
    }

    init(photoId: String,
         title: String,
         height: Int,
         width: Int,
         photoUrl: String) {
        self.photoId = photoId
        self.title = title
        self.height = height
        self.width = width
        self.photoUrl = photoUrl
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        photoId = try container.decode(String.self, forKey: .photoId)
        title = try container.decode(String.self, forKey: .title)
        if let height = try? container.decode(Int.self, forKey: .height) {
            self.height = height
        } else {
            self.height = 0
        }
        if let width = try? container.decode(Int.self, forKey: .width) {
            self.width = width
        } else {
            self.width = 0
        }

        if let photoUrl = try? container.decode(String.self, forKey: .photoUrl) {
            self.photoUrl = photoUrl
        } else {
            self.photoUrl = ""
        }
    }
}

extension FlickrPhoto {
    var url: URL? {
        guard let url = URL(string: photoUrl) else {
            return nil
        }
        
        return url
    }
}

extension FlickrPhoto {
    static func getFlickrPhotoStub(photoId: String = "1",
                                   title: String = "image",
                                   height: Int = 200,
                                   width: Int = 100,
                                   photoUrl: String = .photoUrl,
                                   image: UIImage? = nil) -> FlickrPhoto {
        FlickrPhoto(photoId: photoId, title: title, height: height, width: width, photoUrl: photoUrl)
    }
}

private extension String {
    // swiftlint:disable line_length
    static let photoUrl = "https://www.wikihow.com/images_en/thumb/d/db/Get-the-URL-for-Pictures-Step-2-Version-6.jpg/v4-460px-Get-the-URL-for-Pictures-Step-2-Version-6.jpg.webp"
    // swiftlint:enable line_length
}
