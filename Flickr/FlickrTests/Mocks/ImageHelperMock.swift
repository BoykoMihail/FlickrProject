//
//  ImageHelperMock.swift
//  FlickrTests
//
//  Created by Михаил Бойко on 10.07.2022.
//

@testable import Flickr
import UIKit

class ImageHelperMock: IImageHelper {
    var invokedUpdatePhotosModel = false
    var invokedUpdatePhotosModelCount = 0
    var invokedUpdatePhotosModelParameters: (flickrPhoto: [FlickrPhoto], Void)?
    var invokedUpdatePhotosModelParametersList = [(flickrPhoto: [FlickrPhoto], Void)]()

    func updatePhotosModel(flickrPhoto: [FlickrPhoto]) {
        invokedUpdatePhotosModel = true
        invokedUpdatePhotosModelCount += 1
        invokedUpdatePhotosModelParameters = (flickrPhoto, ())
        invokedUpdatePhotosModelParametersList.append((flickrPhoto, ()))
    }

    var invokedGetImageFor = false
    var invokedGetImageForCount = 0
    var invokedGetImageForParameters: (url: URL, Void)?
    var invokedGetImageForParametersList = [(url: URL, Void)]()
    var stubbedGetImageForResult: UIImage!
    var stubbedGetImageForError: RequestError?

    func getImageFor(url: URL) async throws -> (UIImage) {
        invokedGetImageFor = true
        invokedGetImageForCount += 1
        invokedGetImageForParameters = (url, ())
        invokedGetImageForParametersList.append((url, ()))
        if let error = stubbedGetImageForError {
            throw error
        }
        return stubbedGetImageForResult
    }
}
