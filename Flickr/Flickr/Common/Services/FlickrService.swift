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
        let uiTesting = ProcessInfo.processInfo.arguments.contains("Testing")
        
        guard !uiTesting else {
            let photos = [
                FlickrPhoto.getFlickrPhotoStub(photoId: "0",
                                               title: "title 0"),
                FlickrPhoto.getFlickrPhotoStub(photoId: "1",
                                               title: "title 1"),
                FlickrPhoto.getFlickrPhotoStub(photoId: "2",
                                               title: "title 2"),
                FlickrPhoto.getFlickrPhotoStub(photoId: "3",
                                               title: "title 3"),
                FlickrPhoto.getFlickrPhotoStub(photoId: "4",
                                               title: "title 4"),
                FlickrPhoto.getFlickrPhotoStub(photoId: "5",
                                               title: "title 5"),
                FlickrPhoto.getFlickrPhotoStub(photoId: "6",
                                               title: "title 6")
            ]
                                               
            onCompletion(nil, photos)
            return
                                               
        }
        
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

extension FlickrService: CacheExexutor {
    
    func warmUpCache(onCompletion: @escaping CacheExexutorResponse) {
        let urlString: String = "https://api.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=\(Flickr.applicationKey)&extras=url_m&per_page=200&page=\(currentPage)&format=json&nojsoncallback=1"
        
        guard let url: NSURL = NSURL(string: urlString) else {
            onCompletion(nil)
            return
        }
        
        let searchTask = URLSession
            .shared
            .dataTask(with: url as URL) { data, response, error -> Void in
            
                if error != nil {
                    onCompletion(nil)
                    return
                }
                
                guard let data = data else {
                    onCompletion(nil)
                    return
                }
                
                guard let parsedResult = try? JSONDecoder().decode(FetchPhotosResult.self, from: data) else {
                    onCompletion(nil)
                    return
                }
                            
                let urls: [URL] = parsedResult.photos.photo.compactMap {
                    guard let url = URL(string: $0.photoUrl) else {
                        return nil
                    }
                    
                    return url
                }
                onCompletion(urls)
        }
        searchTask.resume()
    }
}
