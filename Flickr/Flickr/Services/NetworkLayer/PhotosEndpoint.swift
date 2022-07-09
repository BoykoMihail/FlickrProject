//
//  PhotosEndpoint.swift
//  Flickr
//
//  Created by m.a.boyko on 09.07.2022.
//

import Foundation

private struct Flickr {
    static let applicationKey = "7dcd9f647984abea7985f22f66d1b4dd"
    static let applicationSecret = "19b81c5acc3c570c"
}

enum PhotosEndpoint {
    case getRecent(perPage: Int, page: Int)
}

extension PhotosEndpoint: Endpoint {
    
    var path: String {
        switch self {
        case .getRecent:
            return "services/rest"
        }
    }
    
    var queryItems: [String : String]? {
        switch self {
        case let .getRecent(perPage, page):
            return [
                "method":"flickr.photos.getRecent",
                "api_key":Flickr.applicationKey,
                "extras":"url_m",
                "per_page":"\(perPage)",
                "page":"\(page)",
                "format":"json",
                "nojsoncallback":"1",
            ]
        }
    }

    var header: [String: String]? {
        switch self {
        case .getRecent:
            return nil
        }
    }
    
    var body: [String: String]? {
        switch self {
        case .getRecent:
            return nil
        }
    }
    

    var method: Method {
        switch self {
        case .getRecent:
            return .get
        }
    }
}
