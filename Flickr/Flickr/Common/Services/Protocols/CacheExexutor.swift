//
//  CacheExexutor.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import Foundation

typealias CacheExexutorResponse = [URL]?

protocol CacheExexutor {
    func warmUpCache(perPage: Int, page: Int) async -> CacheExexutorResponse
}
