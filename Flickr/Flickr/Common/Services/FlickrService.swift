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
            onCompletion(FlickrServiceCustomErrors.thisIsLastPage, nil)
            return
        }
        let urlString: String = "https://api.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=\(Flickr.applicationKey)&extras=url_m&per_page=\(Flickr.perPage)&page=\(currentPage)&format=json&nojsoncallback=1"
        
        guard let url: NSURL = NSURL(string: urlString) else {
            onCompletion(FlickrServiceCustomErrors.wrongURL, nil)
            return
        }
        
        let searchTask = URLSession
            .shared
            .dataTask(with: url as URL) { [weak self] data, response, error -> Void in
                if error != nil {
                    onCompletion(error as NSError?, nil)
                    return
                }
                
                guard let data = data else {
                    onCompletion(FlickrServiceCustomErrors.ephtyData, nil)
                    return
                }
                
                guard let parsedResult = try? JSONDecoder().decode(FetchPhotosResult.self, from: data) else {
                    onCompletion(FlickrServiceCustomErrors.decodeError, nil)
                    return
                }
                            
                self?.currentPage+=1
                self?.amountOfPages = parsedResult.photos.pages
                onCompletion(nil, parsedResult.photos.photo)
        }
        searchTask.resume()
    }
}

