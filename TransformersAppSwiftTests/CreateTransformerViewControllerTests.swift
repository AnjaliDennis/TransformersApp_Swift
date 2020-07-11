//
//  CreateTransformerViewControllerTests.swift
//  TransformersAppSwiftTests
//
//  Created by Anjali Pragati Dennis on 10/07/20.
//  Copyright © 2020 Anjali Pragati Dennis. All rights reserved.
//

import XCTest
@testable import TransformersAppSwift

class CreateTransformerViewControllerTests: XCTestCase {
    var viewController : CreateTransformerViewController!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = (storyboard.instantiateViewController(identifier: "createTransformerViewController") as! CreateTransformerViewController)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewController = nil;
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testviewLoad () {
        let _ = viewController.view
        XCTAssertNotNil(viewController, "View controller not initiated properly")
        XCTAssertNotNil(viewController.view, "View not initiated properly")
        XCTAssert(viewController.createTransformerButton.isEnabled, "Create button is not enabled")
        XCTAssert(viewController.firepowerSlider.isEnabled, "Firepower slider is not enabled")
        XCTAssert(viewController.transformerTeamType.isEnabled, "Team selector is not enabled")
        XCTAssert(viewController.transformerNameTextField.isEnabled, "Name textfield is not enabled")
    }

}
