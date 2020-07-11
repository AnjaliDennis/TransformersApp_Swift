//
//  TransformersAppSwiftUITests.swift
//  TransformersAppSwiftUITests
//
//  Created by Anjali Pragati Dennis on 06/07/20.
//  Copyright © 2020 Anjali Pragati Dennis. All rights reserved.
//

import XCTest

class TransformersAppSwiftUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        XCUIApplication().launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testScreens() {
        let app = XCUIApplication()
        XCTAssertTrue(app.buttons["Refresh"].exists,"Refresh button is missing")
        XCTAssertTrue(app.buttons["Create New"].exists,"Create New button is missing")
        XCTAssertTrue(app.buttons["Battlefield"].exists,"Battlefield button is missing")
        
        app.buttons["Create New"].tap()
        //create
        let createButton = app.buttons["Create"]
        XCTAssertTrue(createButton.exists,"Create button is missing")
        
        let navnTextField = app.textFields["nameTextField"]
        navnTextField.tap()
        navnTextField.typeText("Optimus Prime")
        navnTextField.typeText("\n")
        app/*@START_MENU_TOKEN@*/.buttons["Autobot"]/*[[".segmentedControls.buttons[\"Autobot\"]",".buttons[\"Autobot\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        createButton.tap()
        let okButton = app.alerts["Success"].scrollViews.otherElements.buttons["OK"]
        okButton.tap()
        
        navnTextField.tap()
        navnTextField.typeText("Predaking")
        navnTextField.typeText("\n")
        app.buttons["Decepticon"].tap()
        createButton.tap()
        okButton.tap()
                
        app.navigationBars["Create Transformer"].buttons["Back"].tap()
        
        //update
        let collectionViewsQuery = app.collectionViews
        let cell = collectionViewsQuery.children(matching: .cell).element(boundBy: 0)
        cell.buttons["Edit"].tap()
        collectionViewsQuery.cells.otherElements.containing(.button, identifier:"Save").children(matching: .textField).element.tap()
        app.collectionViews/*@START_MENU_TOKEN@*/.buttons["Save"]/*[[".cells.buttons[\"Save\"]",".buttons[\"Save\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        okButton.tap()
        cell.otherElements.containing(.staticText, identifier:"Name:").children(matching: .textField).element.tap()
        //battlefield
        app.buttons["Battlefield"].tap()
        app.buttons["Start Battle"].tap()
        app.staticTexts["Game over by Annihilation"].tap()
        
        app.navigationBars["TransformersAppSwift.BattlefieldTransformerView"].buttons["Back"].tap()
        
        //delete
        app.collectionViews.children(matching: .cell).element(boundBy: 0).buttons["Delete"].tap()
        app.alerts["Success"].scrollViews.otherElements.buttons["OK"].tap()
        app.buttons["Battlefield"].tap()
        app.alerts["TransformersApp"].scrollViews.otherElements.buttons["OK"].tap()
        
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
