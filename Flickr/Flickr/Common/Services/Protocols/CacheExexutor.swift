//
//  CacheExexutor.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import Foundation

typealias CacheExexutorResponse = ([URL]?) -> Void

protocol CacheExexutor {
    func warmUpCache(onCompletion: @escaping CacheExexutorResponse)
}
