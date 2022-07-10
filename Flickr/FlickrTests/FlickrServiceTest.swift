//
//  FlickrServiceTest.swift
//  FlickrTests
//
//  Created by Михаил Бойко on 10.07.2022.
//

@testable import Flickr
import XCTest

private extension String {
    // swiftlint:disable line_length
    static let photoUrl = "https://api.flickr.com/services/rest?page=1&extras=url_m&per_page=1&format=json&method=flickr.photos.getRecent&api_key=7dcd9f647984abea7985f22f66d1b4dd&nojsoncallback=1"
    // swiftlint:enable line_length
}

class FlickrServiceTest: XCTestCase {
    private var flickrService: FlickrService!
    
    private var urlSessionProtocolMock: URLSessionProtocolMock!

    override func setUp() {
        super.setUp()
        urlSessionProtocolMock = URLSessionProtocolMock()
        flickrService = FlickrService(urlSession: urlSessionProtocolMock)
    }

    override func tearDown() {
        super.tearDown()

        urlSessionProtocolMock = nil
        flickrService = nil
    }

    func testFetchPhotos() async throws {
        // given
        let url = URL(fileURLWithPath: .photoUrl)
        let expectedHost = "api.flickr.com"
        let expectedPath = "/services/rest"
        let expectedQueryParameters = [
            "format": "json",
            "page": "1",
            "api_key": "7dcd9f647984abea7985f22f66d1b4dd",
            "method": "flickr.photos.getRecent",
            "nojsoncallback": "1",
            "extras": "url_m",
            "per_page": "1"
        ]
        let responce = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        let data = try JSONEncoder().encode(FetchPhotosResult.getFlickrPhotoStub())
        urlSessionProtocolMock.stubbedDataResult = (data, responce ?? URLResponse())
        // when
        
        _ = try await flickrService.fetchPhotos(perPage: 1, page: 1)
        // then
        
        guard let url = urlSessionProtocolMock.invokedDataParameters?.request.url else {
            XCTFail("Не передался URL")
            return
        }
        
        XCTAssertEqual(url.host, expectedHost)
        XCTAssertEqual(url.path, expectedPath)
        XCTAssertEqual(url.queryParameters, expectedQueryParameters)
    }
    
    func testFetchPhotosModels() async throws {
        // given
        let url = URL(fileURLWithPath: .photoUrl)
        let responce = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        let expectedCountPhoto = 12
        
        let data = try JSONEncoder().encode(FetchPhotosResult.getFlickrPhotoStub(countOfPhotos: expectedCountPhoto))
        urlSessionProtocolMock.stubbedDataResult = (data, responce ?? URLResponse())
        // when
        
        let model = try await flickrService.fetchPhotos(perPage: 1, page: 1)
        // then
        
        XCTAssertEqual(model.photos.photo.count, expectedCountPhoto)
    }
    
    func testFetchPhotosServerError() async throws {
        // given
        let url = URL(fileURLWithPath: .photoUrl)
        let responce = HTTPURLResponse(
            url: url,
            statusCode: 400,
            httpVersion: nil,
            headerFields: nil
        )
        let expectedCountPhoto = 12
        
        let data = try JSONEncoder().encode(FetchPhotosResult.getFlickrPhotoStub(countOfPhotos: expectedCountPhoto))
        urlSessionProtocolMock.stubbedDataResult = (data, responce ?? URLResponse())
        // when
        do {
            _ = try await flickrService.fetchPhotos(perPage: 1, page: 1)
            // then
            
            XCTFail("Не вылетела ошибка")
        } catch {
            XCTAssertTrue(error is RequestError)
            
            switch error as? RequestError {
            case .unexpectedStatusCode:
                break
            default:
                XCTFail("Не правильный тип ошиьбки")
            }
        }
    }
    
    func testFetchPhotosParserError() async throws {
        // given
        let url = URL(fileURLWithPath: .photoUrl)
        let responce = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        let data = Data()
        urlSessionProtocolMock.stubbedDataResult = (data, responce ?? URLResponse())
        // when
        do {
            _ = try await flickrService.fetchPhotos(perPage: 1, page: 1)
            // then
            
            XCTFail("Не вылетела ошибка")
        } catch {
            XCTAssertTrue(error is RequestError)
            
            switch error as? RequestError {
            case .decodeError:
                break
            default:
                XCTFail("Не правильный тип ошиьбки")
            }
        }
    }
    
    func testFetchPhotosNoResponseError() async throws {
        // given
        let responce = URLResponse()
        
        let data = Data()
        urlSessionProtocolMock.stubbedDataResult = (data, responce)
        // when
        do {
            _ = try await flickrService.fetchPhotos(perPage: 1, page: 1)
            // then
            
            XCTFail("Не вылетела ошибка")
        } catch {
            XCTAssertTrue(error is RequestError)
            
            switch error as? RequestError {
            case .noResponseError:
                break
            default:
                XCTFail("Не правильный тип ошиьбки")
            }
        }
    }
}
