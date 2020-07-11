//
//  BattlefieldTransformerViewControllerTests.swift
//  TransformersAppSwiftTests
//
//  Created by Anjali Pragati Dennis on 10/07/20.
//  Copyright © 2020 Anjali Pragati Dennis. All rights reserved.
//

import XCTest
@testable import TransformersAppSwift

class BattlefieldTransformerViewControllerTests: XCTestCase {
    var viewController : BattlefieldTransformerViewController!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = (storyboard.instantiateViewController(identifier: "battlefieldViewController") as! BattlefieldTransformerViewController)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewController = nil;
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

    func testviewLoad () {
        viewController.transformerDataModelArray = createDataSourceArray()
        let _ = viewController.view

        XCTAssertNotNil(viewController, "View controller not initiated properly")
        XCTAssertNotNil(viewController.view, "View not initiated properly")
        XCTAssert(viewController.startBattleButton.isEnabled, "Start battle button is not enabled")
        XCTAssertNotNil(viewController!.battlefieldBannerLabel, "Banner text is nil")
        
        let subviews = viewController.view.subviews
        XCTAssertTrue(subviews.contains(viewController.transformerBattleTableView), "View does not have a tableview subview")
        XCTAssertNotNil(viewController.transformerBattleTableView, "Tableview not initiated")
        XCTAssertTrue(viewController.dataSource!.conforms(to:UITableViewDataSource.self), "View does not conform")
        XCTAssertNotNil(viewController.transformerBattleTableView.dataSource, "Tableview datasource is nil")
        XCTAssertNotNil(viewController.transformerBattleTableView.delegate, "Tableview delegate is nil")
        
        XCTAssertTrue((viewController.dataSource?.responds(to: (#selector(viewController.transformerBattleTableView.dataSource?.tableView(_:numberOfRowsInSection:)))))!, "Tableview not compliant")
        
        XCTAssert((viewController.dataSource?.responds(to: (#selector(viewController.transformerBattleTableView.dataSource?.tableView(_:cellForRowAt:)))))!, "Tableview not compliant")
    }
    
    func testTableView()  {
        viewController.transformerDataModelArray = createDataSourceArray()
        let _ = viewController.view
        viewController.transformerBattleTableView.reloadData()
        
        let indexPath = NSIndexPath(item: 0, section: 0)
        let cell = viewController.dataSource?.tableView(viewController.transformerBattleTableView, cellForRowAt: indexPath as IndexPath) as! BattlefieldTransformerTableViewCell

        XCTAssertEqual(viewController.transformerBattleTableView.numberOfRows(inSection: 0), 1, "Row count not equal to array count")
        XCTAssertNotNil(cell.autobotNameLabel, "Autobot name label is nil")
        XCTAssertNotNil(cell.decepticonNameLabel, "Decepticon name label is nil")
        XCTAssertNotNil(cell.autobotTeamIcon, "Autobot team icon is nil")
        XCTAssertNotNil(cell.decepticonTeamIcon, "Decepticon team icon is nil")
        XCTAssertNotNil(cell.autobotRatingLabel, "Autobot rating label is nil")
        XCTAssertNotNil(cell.decepticonRatingLabel, "Decepticon rating label is nil")
        XCTAssertNotNil(cell.autobotStatsLabel, "Autobot stats label is nil")
        XCTAssertNotNil(cell.decepticonStatsLabel, "Decepticon stats label is nil")
        XCTAssertNotNil(cell.autobotRankLabel, "Autobot rank is nil")
        XCTAssertNotNil(cell.decepticonRankLabel, "Decepticon rank is nil")
        XCTAssertEqual(cell.autobotNameLabel.text, "Optimus Prime", "Autobot name value is incorrect")
        XCTAssertEqual(cell.decepticonNameLabel.text, "Predaking", "Decepticon name value is incorrect")
    }
    
    func testSortTransformers() {
        viewController.transformerDataModelArray = createDataSourceArray()
        let autobotTransformer = TransformerDataModel()
        autobotTransformer.id = "-LLbrUN3dQkeejt9vTZc"
        autobotTransformer.name = "Bumblebee"
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
        viewController.transformerDataModelArray.add(autobotTransformer)
        
        let _ = viewController.view
        viewController.sortTransformers()
        XCTAssertEqual(viewController.dataSource?.sortedAutobotsDataModelArray.count, 2, "Sorted autobot array count is incorrect")
        XCTAssertEqual(viewController.dataSource?.sortedDecepticonsDataModelArray.count, 1, "Sorted decepticon array count is incorrect")
        XCTAssertEqual((viewController.dataSource?.sortedAutobotsDataModelArray.firstObject as! TransformerDataModel).rank, "10", "Sorted autobot rank is incorrect")
        XCTAssertEqual((viewController.dataSource?.sortedDecepticonsDataModelArray.firstObject as! TransformerDataModel).rank, "10", "Sorted decepticon rank is incorrect")
        XCTAssert(viewController.isSorted!, "Sorting boolean is incorrect")
    }
    
    func startTransformerBattle() {
        viewController.transformerDataModelArray = createDataSourceArray()
        let _ = viewController.view
        
        viewController.startTransformerBattle([])
        
        XCTAssert(viewController.isBattleComplete!, "Battle completion boolean is incorrect")
        XCTAssert(viewController.isGameOVerByAnnihilation!, "Annihilation boolean is incorrect")
        XCTAssertEqual(viewController.battlefieldBannerLabel.text, CONSTANT_GAMEOVER_STRING, "Battlefield banner text is incorrect")

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
        autobotTransformer.rank = "7"
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
        decepticonTransformer.rating = "42"
        
        let tempArray: NSMutableArray = NSMutableArray()
        tempArray.add(autobotTransformer)
        tempArray.add(decepticonTransformer)
        
        return tempArray;
    }

}
