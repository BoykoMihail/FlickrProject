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
    var image: UIImage?
    
    enum CodingKeys: String, CodingKey {
        case photoId = "id"
        case title
        case height = "height_m"
        case width = "width_m"
        case photoUrl = "url_m"
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


