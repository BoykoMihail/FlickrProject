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

    let app = XCUIApplication()
    
    private let screenName = "GalleryController"
    
    override func setUpWithError() throws {
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
        
//        step(named: "Свайпаем вниз и проверяем наличие ячейки с номером 1") {
//            table.swipeUp()
//            XCTAssert(table.cells[String.tableViewCellIdentifier + "_4"].exists)
//        }
//
//        step(named: "Тапаем по ячейке с номером 4") {
//            table.cells[String.tableViewCellIdentifier + "_4"].tap()
//        }
        
//        step(named: "Проверяем, что открылся именно ImageDetailViewController") {
//            XCTAssert(app.descendants(matching: .any)["ImageDetailViewController"].exists)
//        }
        
//        step(named: "Проверяем title у экрана ImageDetailViewController") {
//            XCTAssert(app.navigationBars["title 4"].exists)
//        }
        
//        step(named: "Проверяем наличие кнопки назад на экране ImageDetailViewController") {
//            XCTAssert(app.navigationBars.buttons["Flickr's Gallery"].exists)
//        }
        
//        step(named: "Тап по кнопке назад на экране ImageDetailViewController") {
//            app.navigationBars.buttons["Flickr's Gallery"].tap()
//        }
//
//        step(named: "Свайпаем вниз и проверяем наличие ячейки с номером 0") {
//            table.swipeDown()
//            XCTAssert(table.cells[String.tableViewCellIdentifier + "_0"].exists)
//        }
       
//        step(named: "Тапаем по ячейке с номером 0") {
//            table.cells[String.tableViewCellIdentifier + "_0"].tap()
//        }
//        
//        step(named: "Проверяем, что открылся именно ImageDetailViewController") {
//            XCTAssert(app.descendants(matching: .any)["ImageDetailViewController"].exists)
//        }
//        
//        step(named: "Проверяем title у экрана ImageDetailViewController") {
//            XCTAssert(app.navigationBars["title 0"].exists)
//        }
    }
    
    private func step(named name: String, activity: () -> Void) {
        XCTContext.runActivity(named: "\(screenName): \(name)") { _ in
            activity()
        }
    }
}
