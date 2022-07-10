//
//  GalleryControllerUITest.swift
//  FlickrUITests
//
//  Created by Михаил Бойко on 27.06.2022.
//

import XCTest

private extension String {
    static let tableViewCellIdentifier = "ImageCell"
}

class GalleryControllerUITest: XCTestCase {
    private let app = XCUIApplication()

    private let screenName = "GalleryController"

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        continueAfterFailure = false
        app.launchArguments.append("Testing")

        app.launch()
    }

    func testNavigationBarTitle() throws {
        step(named: "Проверяем, что открылся именно \(screenName)") {
            XCTAssert(app.descendants(matching: .any)[screenName].exists)
        }

        step(named: "Проверяем title") {
            XCTAssert(app.navigationBars["Flickr's Gallery"].exists)
        }

        let table = app.tables["GalleryController_tableView"]
        step(named: "Проверяем наличие tableView") {
            XCTAssert(table.exists)
        }
    }

    private func step(named name: String, activity: () -> Void) {
        XCTContext.runActivity(named: "\(screenName): \(name)") { _ in
            activity()
        }
    }
}
