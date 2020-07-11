//
//  TransformerViewControllerTests.swift
//  TransformersAppSwift
//
//  Created by Anjali Pragati Dennis on 09/07/20.
//  Copyright © 2020 Anjali Pragati Dennis. All rights reserved.
//

import XCTest
@testable import TransformersAppSwift

class TransformerViewControllerTests: XCTestCase {
    var viewController : TransformerViewController!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = (storyboard.instantiateViewController(identifier: "transformerViewController") as! TransformerViewController)
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
        let subviews = viewController.view.subviews
        XCTAssertTrue(subviews.contains(viewController.autobotCollectionView), "View does not have a collection view subview")
        XCTAssertNotNil(viewController.autobotCollectionView, "CollectionView not initiated")
        XCTAssertTrue(viewController.conforms(to:UICollectionViewDataSource.self), "View does not conform")
        XCTAssertNotNil(viewController.autobotCollectionView.dataSource, "Collection view datasource cannot be nil")
        XCTAssertTrue(viewController.responds(to: (#selector(viewController.collectionView(_:numberOfItemsInSection:)))), "Collection view not compliant")
        XCTAssertTrue(viewController.responds(to: (#selector(viewController.collectionView(_:cellForItemAt:)))), "Collection view not compliant")
    }
    
    func testCollectionView ()  {
        let _ = viewController.view
        viewController.transformerDataModelArray = NSMutableArray()
        
        viewController.transformerDataModelArray.addObjects(from: self.createDataSourceArray() as! [TransformerDataModel])
        
        viewController.autobotCollectionView.reloadData()
    
        let indexPath = NSIndexPath(item: 0, section: 0)
        let cell = viewController.collectionView(viewController.autobotCollectionView, cellForItemAt: indexPath as IndexPath) as! TransformerCollectionViewCell

        XCTAssertEqual(viewController.autobotCollectionView.numberOfItems(inSection: 0), 2, "Item count not equal to array count")
        XCTAssertTrue(cell.editTransformerButton.isUserInteractionEnabled, "Edit button is not enabled")
        XCTAssertTrue(cell.deleteTransformerButton.isUserInteractionEnabled, "Delete button is not enabled")
        XCTAssertEqual(cell.nameTextField.text, "Optimus Prime", "Name value mismatch")
        XCTAssertEqual(cell.strengthLabel.text, "Strength: 10", "Strength value mismatch")
        XCTAssertEqual(cell.intelligenceLabel.text, "Intelligence: 10", "Intelligence value mismatch")
        XCTAssertEqual(cell.speedLabel.text, "Speed: 4", "Speed value mismatch")
        XCTAssertEqual(cell.enduranceLabel.text, "Endurance: 8", "Endurance value mismatch")
        XCTAssertEqual(cell.rankLabel.text, "Rank: 10", "Rank value mismatch")
        XCTAssertEqual(cell.courageLabel.text, "Courage: 9" , "Courage value mismatch")
        XCTAssertEqual(cell.firepowerLabel.text, "Firepower: 10", "Firepower value mismatch")
        XCTAssertEqual(cell.skillLabel.text, "Skill: 9", "Skill value mismatch")
    }
    
    func testBattlefieldReadiness () {
         let _ = viewController.view
         viewController.transformerDataModelArray = NSMutableArray()
        XCTAssertFalse(viewController.battlefieldReadiness(), "Battle readiness is not correct when no transformers are added")
        viewController.transformerDataModelArray.addObjects(from: self.createDataSourceArray() as! [TransformerDataModel])
        XCTAssertTrue(viewController.battlefieldReadiness(), "Battle readiness is not corect")
     }
    
    func createDataSourceArray() -> NSMutableArray {
        let autobotTransformer = TransformerDataModel()
        let decepticonTransformer = TransformerDataModel()
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
        
        decepticonTransformer.id = "-LLbrUN3dQkeejt9vTZc"
        decepticonTransformer.name = "Predaking"
        decepticonTransformer.strength = "10"
        decepticonTransformer.intelligence = "10"
        decepticonTransformer.speed = "4"
        decepticonTransformer.endurance = "8"
        decepticonTransformer.rank = "10"
        decepticonTransformer.courage = "9"
        decepticonTransformer.firepower = "10"
        decepticonTransformer.skill = "9"
        decepticonTransformer.team = "D"
        decepticonTransformer.team_icon = "https://tfwiki.net/mediawiki/images2/archive/f/fe/20110410191732%21Symbol_autobot_reg.png"
        autobotTransformer.rating = "42"
        
        let tempArray: NSMutableArray = NSMutableArray()
        tempArray.add(autobotTransformer)
        tempArray.add(decepticonTransformer)
        
        return tempArray;
    }
}
