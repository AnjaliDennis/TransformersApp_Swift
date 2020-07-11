//
//  TransformerNetworkAPITests.swift
//  TransformersAppSwiftTests
//
//  Created by Anjali Pragati Dennis on 11/07/20.
//  Copyright © 2020 Anjali Pragati Dennis. All rights reserved.
//

import XCTest
@testable import TransformersAppSwift

class TransformerNetworkAPITests: XCTestCase {
    var transformerId = ""
    let transformerNetworkAPI = TransformerNetworkAPI()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    
        //setting up data for delete and update test cases
        testCreateTransformer()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        transformerId = ""
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetTokenWithCompletionHandler() {
       // let url = URL(string: "https://transformers-api.firebaseapp.com/allspark")
        //let description = "GET \(String(describing: url))"
        let expectationForRequest = expectation(description: "GET https://transformers-api.firebaseapp.com/allspark")
        transformerNetworkAPI.getToken { (result:ResultType) in
            switch result
            {
            case .Success( _):
                let jwtCreds = self.transformerNetworkAPI.retrieveJwt()
                XCTAssertNotNil(jwtCreds, "Error in retreiving token")
                expectationForRequest.fulfill()
                break
            case .Error(let e):
                XCTAssertNotNil(e, "Expected error is not nil")
                expectationForRequest.fulfill()
            }
        }
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testCreateTransformer () {
        let expectationForRequest = expectation(description: "POST https://transformers-api.firebaseapp.com/transformers")
        transformerNetworkAPI.createTransformer(requestBody: createTransformer()) { (result:ResultType) in
            switch result
            {
            case .Success(let rst):
                let transformerCreated = rst as! TransformerDataModel
                self.transformerId = transformerCreated.id!
                XCTAssertNotNil(transformerCreated, "Created Transformer is nil")
                XCTAssertNotNil(transformerCreated.id, "Created Transformer id is nil")
                expectationForRequest.fulfill()
                break
            case .Error(let e):
                XCTAssertNotNil(e, "Expected error is not nil")
                expectationForRequest.fulfill()
            }
        }
        waitForExpectations(timeout: 15.0, handler: nil)
    }
    
    func testGetTransformerListWithCompletionHandler() {
        let expectationForRequest = expectation(description: "GET https://transformers-api.firebaseapp.com/transformers")
        transformerNetworkAPI.getTransformerList { (result:ResultType) in
            switch result
            {
            case .Success(let rst):
                let transformerCreated = ((rst as! TransformerDataModelArray).transformers! as NSArray)
                XCTAssertEqual(transformerCreated.count, 1, "Count for list of transformers is incorrect")
                XCTAssertEqual((transformerCreated.firstObject as! TransformerDataModel).id, self.transformerId, "List Transformer id is incorrect")
                expectationForRequest.fulfill()
                break
            case .Error(let e):
                XCTAssertNotNil(e, "Expected error is not nil")
                expectationForRequest.fulfill()
            }
        }
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testUpdateTransformer() {
        let expectationForRequest = expectation(description: "PUT https://transformers-api.firebaseapp.com/transformers")
        let updatedTransformer = createTransformer()
        updatedTransformer.name = "Bumblebee"
        transformerNetworkAPI.updateTransformer(updateRequestBody: updatedTransformer) { (result:ResultType) in
            switch result
            {
            case .Success(let rst):
                let transformerUpdated = rst as! TransformerDataModel
                XCTAssertNotNil(transformerUpdated, "Updated transformer is nil")
                XCTAssertEqual(transformerUpdated.name, "Bumblebee", "Transformer updation is not successful")
                XCTAssertEqual(transformerUpdated.id, self.transformerId, "Transformer updation is not successful")
                expectationForRequest.fulfill()
                break
            case .Error(let e):
                XCTAssertNotNil(e, "Expected error is not nil")
                expectationForRequest.fulfill()
            }
        }
        waitForExpectations(timeout: 20.0, handler: nil)
    }
    
    func testDeleteTransformer() {
        let expectationForRequest = expectation(description: "DELETE https://transformers-api.firebaseapp.com/transformers")
        transformerNetworkAPI.deleteTransformer(transformerId: self.transformerId as NSString) { (result:ResultType) in
            switch result
            {
            case .Success(let rst):
                XCTAssertEqual(rst as! String, "Success", "Transformer deletion is not successful")
                expectationForRequest.fulfill()
                break
            case .Error(let e):
                XCTAssertNotNil(e, "Expected error is not nil")
            }
        }
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func createTransformer() -> TransformerDataModel {
        let autobotTransformer = TransformerDataModel()
        autobotTransformer.id = "-LLbrUN3dQkeejt9vTZc"
        autobotTransformer.name = "Optimus Prime"
        autobotTransformer.strength = "10"
        autobotTransformer.intelligence = "10"
        autobotTransformer.speed = "4"
        autobotTransformer.endurance = "8"
        autobotTransformer.rank = "10"
        autobotTransformer.courage = "9"
        autobotTransformer.firepower = "10"
        autobotTransformer.skill = "9"
        autobotTransformer.team = "A"
        autobotTransformer.team_icon = "https://tfwiki.net/mediawiki/images2/archive/f/fe/20110410191732%21Symbol_autobot_reg.png"
        autobotTransformer.rating = "42"
        return autobotTransformer
    }

}
