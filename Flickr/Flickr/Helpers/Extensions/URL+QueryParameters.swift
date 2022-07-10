//
//  URL+QueryParameters.swift
//  Flickr
//
//  Created by Михаил Бойко on 10.07.2022.
//

import Foundation

extension URL {
    var queryParameters: [String: String]? {
        let components = URLComponents(
            url: self,
            resolvingAgainstBaseURL: true
        )
        
        guard let components = components,
              let queryItems = components.queryItems else {
            return nil
        }
        
        return queryItems
            .reduce(into: [String: String]()) { result, item in
                result[item.name] = item.value
            }
    }
}
