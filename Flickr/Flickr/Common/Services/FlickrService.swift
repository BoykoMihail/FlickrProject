//
//  FlickrService.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import Foundation

private struct Flickr {
    static let applicationKey = "7dcd9f647984abea7985f22f66d1b4dd"
    static let applicationSecret = "19b81c5acc3c570c"
    
    static let perPage = 30
}

class FlickrService: IFlickrService {
    
    private var currentPage = 1
    private var amountOfPages = 1
    
    func fetchPhotos(onCompletion: @escaping FlickrResponse) {
        if currentPage > amountOfPages {
            onCompletion(nil, nil)
            return
        }
        let urlString: String = "https://api.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=\(Flickr.applicationKey)&extras=url_m&per_page=\(Flickr.perPage)&page=\(currentPage)&format=json&nojsoncallback=1"
        
        guard let url: NSURL = NSURL(string: urlString) else {
            onCompletion(nil, nil)
            return
        }
        
        let searchTask = URLSession
            .shared
            .dataTask(with: url as URL) { data, response, error -> Void in
                onCompletion(nil, nil)
        }
        searchTask.resume()
    }
}

