//
//  BattlefieldTransformerViewController.swift
//  TransformersAppSwift
//
//  Created by Anjali Pragati Dennis on 08/07/20.
//  Copyright © 2020 Anjali Pragati Dennis. All rights reserved.
//

import UIKit

class BattlefieldTransformerTableViewCell: UITableViewCell {
    @IBOutlet weak var autobotNameLabel: UILabel!
    @IBOutlet weak var decepticonNameLabel: UILabel!
    @IBOutlet weak var autobotTeamIcon: UIImageView!
    @IBOutlet weak var decepticonTeamIcon: UIImageView!
    @IBOutlet weak var autobotRatingLabel: UILabel!
    @IBOutlet weak var decepticonRatingLabel: UILabel!
    @IBOutlet weak var autobotStatsLabel: UILabel!
    @IBOutlet weak var decepticonStatsLabel: UILabel!
    @IBOutlet weak var autobotResultLabel: UILabel!
    @IBOutlet weak var decepticonResultLabel: UILabel!
    @IBOutlet weak var autobotRankLabel: UILabel!
    @IBOutlet weak var decepticonRankLabel: UILabel!
    
    
}

class BattlefieldTransformerViewController: UIViewController {
    @IBOutlet weak var startBattleButton: UIButton!
    @IBOutlet weak var battlefieldBannerLabel: UILabel!
    @IBOutlet weak var transformerBattleTableView: UITableView!
    
    var isSorted: Bool?
    var isBattleComplete: Bool?
    var isGameOVerByAnnihilation: Bool?
    var dataSource: BattlefieldTransformerTableViewDatasourceAndDelegate?
    var transformerDataModelArray: NSMutableArray = [TransformerDataModel()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = BattlefieldTransformerTableViewDatasourceAndDelegate()
        self.transformerBattleTableView.dataSource = self.dataSource
        self.transformerBattleTableView.delegate = self.dataSource
        self.isBattleComplete = false
        self.isGameOVerByAnnihilation = false
        self.dataSource?.isBattleComplete = self.isBattleComplete
        self.dataSource!.transformerDataModelArray = self.transformerDataModelArray
         if (self.transformerDataModelArray.count == 0) {
            self.startBattleButton.isUserInteractionEnabled = false;
         }
         else {
            self.startBattleButton.isHidden = self.isBattleComplete!;
             self.startBattleButton.isUserInteractionEnabled = true;
         }
        sortTransformers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if(!self.isSorted!) {
            sortTransformers()
        }
    }
    
    func sortTransformers() {
        self.dataSource?.sortedAutobotsDataModelArray = NSMutableArray()
        self.dataSource?.sortedDecepticonsDataModelArray = NSMutableArray()
        if (self.dataSource!.transformerDataModelArray.count != 0) {
            
            
            let sortedMainArray = self.dataSource?.transformerDataModelArray.sortedArray(){
                (transformer1:Any, transformer2:Any) -> ComparisonResult in
                
                if (((transformer1 as! TransformerDataModel).rank! as NSString).intValue > ((transformer2 as! TransformerDataModel).rank! as NSString).intValue) {
                    return ComparisonResult.orderedAscending
                }
                if (((transformer1 as! TransformerDataModel).rank! as NSString).intValue < ((transformer2 as! TransformerDataModel).rank! as NSString).intValue) {
                    return ComparisonResult.orderedDescending
                }
                return ComparisonResult.orderedSame
            }
            for transformerDataModelItem in sortedMainArray! {
                ((transformerDataModelItem as! TransformerDataModel).team == CONSTANT_TEAM_AUTOBOT_STRING) ?  self.dataSource?.sortedAutobotsDataModelArray.add(transformerDataModelItem) : self.dataSource?.sortedDecepticonsDataModelArray.add(transformerDataModelItem)
            }
            self.isSorted = true
            self.transformerBattleTableView.reloadData()
        }
    }
    @IBAction func startTransformerBattle(_ sender: Any) {
        var totalBattles = 0
        let annihilatorAutobotName = CONSTANT_AUTOBOT_ANNIHILATOR_NAME_STRING
        let annihilatorDecepticonName = CONSTANT_DECEPTICON_ANNIHILATOR_NAME_STRING
        if (self.dataSource!.sortedAutobotsDataModelArray.count >= self.dataSource!.sortedDecepticonsDataModelArray.count) {
            totalBattles = (self.dataSource?.sortedDecepticonsDataModelArray.count)!
        }
        else {
            totalBattles = (self.dataSource?.sortedAutobotsDataModelArray.count)!
        }
        var battlesWonByAutobots = 0;
        var battleWonByDecepticons = 0;
        for i in 0...totalBattles-1 {
            var autobotTransformerDataModel = TransformerDataModel()
            var decepticonTransformerDataModel = TransformerDataModel()
            autobotTransformerDataModel = self.dataSource?.sortedAutobotsDataModelArray.object(at: i) as! TransformerDataModel
            decepticonTransformerDataModel = self.dataSource?.sortedDecepticonsDataModelArray.object(at: i) as! TransformerDataModel
            //rules of battle
            let isAutobotAnnihilator: Bool = ((autobotTransformerDataModel.name?.lowercased() == annihilatorAutobotName) || (autobotTransformerDataModel.name?.lowercased() == annihilatorDecepticonName))
            let isDecepticonAnnihilator: Bool = ((decepticonTransformerDataModel.name?.lowercased() == annihilatorAutobotName) || (decepticonTransformerDataModel.name?.lowercased() == annihilatorDecepticonName))
            if (isAutobotAnnihilator && isDecepticonAnnihilator) {
                //opponents are a combination of optimus prime and predaking-> results in annihilation
                setDataForGameOverByAnnihilation(battleCount: totalBattles)
                break;
            }
            else if (isDecepticonAnnihilator) {
                //decepticon victor
                updateBattleResult(autobotTransformerModel: autobotTransformerDataModel, decepticonTransformerModel: decepticonTransformerDataModel, winnerSpecifier: CONSTANT_TEAM_DECEPTICON_STRING as NSString, index: i)
                battleWonByDecepticons += 1;
                continue;
            }
            else if (isAutobotAnnihilator) {
                //autobot victor
                updateBattleResult(autobotTransformerModel: autobotTransformerDataModel, decepticonTransformerModel: decepticonTransformerDataModel, winnerSpecifier: CONSTANT_TEAM_AUTOBOT_STRING as NSString, index: i)
                battlesWonByAutobots += 1
                continue
            }
            if (((autobotTransformerDataModel.courage! as NSString).integerValue > (decepticonTransformerDataModel.courage! as NSString).integerValue) && ((autobotTransformerDataModel.strength! as NSString).integerValue > (decepticonTransformerDataModel.strength! as NSString).integerValue)) {
                
                if(((autobotTransformerDataModel.courage! as NSString).integerValue -  (decepticonTransformerDataModel.courage! as NSString).integerValue >= 4) && ((autobotTransformerDataModel.strength! as NSString).integerValue -  (decepticonTransformerDataModel.strength! as NSString).integerValue >= 3)) {
                    updateBattleResult(autobotTransformerModel: autobotTransformerDataModel, decepticonTransformerModel: decepticonTransformerDataModel, winnerSpecifier: CONSTANT_TEAM_AUTOBOT_STRING as NSString, index: i)
                    battlesWonByAutobots += 1
                    continue
                }
            }
            else if (((decepticonTransformerDataModel.courage! as NSString).integerValue > (autobotTransformerDataModel.courage! as NSString).integerValue) && ((decepticonTransformerDataModel.strength! as NSString).integerValue > (autobotTransformerDataModel.strength! as NSString).integerValue)) {
                
                if(((decepticonTransformerDataModel.courage! as NSString).integerValue -  (autobotTransformerDataModel.courage! as NSString).integerValue >= 4) && ((decepticonTransformerDataModel.strength! as NSString).integerValue -  (autobotTransformerDataModel.strength! as NSString).integerValue >= 3)) {
                    updateBattleResult(autobotTransformerModel: autobotTransformerDataModel, decepticonTransformerModel: decepticonTransformerDataModel, winnerSpecifier: CONSTANT_TEAM_DECEPTICON_STRING as NSString, index: i)
                    battleWonByDecepticons += 1
                    continue
                }
            }
            if (((autobotTransformerDataModel.skill! as NSString).integerValue > (decepticonTransformerDataModel.skill! as NSString).integerValue) && ((autobotTransformerDataModel.skill! as NSString).integerValue - (decepticonTransformerDataModel.skill! as NSString).integerValue >= 3)) {
                updateBattleResult(autobotTransformerModel: autobotTransformerDataModel, decepticonTransformerModel: decepticonTransformerDataModel, winnerSpecifier: CONSTANT_TEAM_AUTOBOT_STRING as NSString, index: i)
                battlesWonByAutobots += 1
                continue
            }
            else if (((decepticonTransformerDataModel.skill! as NSString).integerValue > (autobotTransformerDataModel.skill! as NSString).integerValue) && ((decepticonTransformerDataModel.skill! as NSString).integerValue - (autobotTransformerDataModel.skill! as NSString).integerValue >= 3)) {
                updateBattleResult(autobotTransformerModel: autobotTransformerDataModel, decepticonTransformerModel: decepticonTransformerDataModel, winnerSpecifier: CONSTANT_TEAM_DECEPTICON_STRING as NSString, index: i)
                battleWonByDecepticons += 1
                continue
            }
            
            if ((autobotTransformerDataModel.rating! as NSString).integerValue > (decepticonTransformerDataModel.rating! as NSString).integerValue) {
                updateBattleResult(autobotTransformerModel: autobotTransformerDataModel, decepticonTransformerModel: decepticonTransformerDataModel, winnerSpecifier: CONSTANT_TEAM_AUTOBOT_STRING as NSString, index: i)
                battlesWonByAutobots += 1
                continue
            }
            else if ((decepticonTransformerDataModel.rating! as NSString).integerValue > (autobotTransformerDataModel.rating! as NSString).integerValue) {
                updateBattleResult(autobotTransformerModel: autobotTransformerDataModel, decepticonTransformerModel: decepticonTransformerDataModel, winnerSpecifier: CONSTANT_TEAM_DECEPTICON_STRING as NSString, index: i)
                battleWonByDecepticons += 1
                continue
            }
            
            if ((autobotTransformerDataModel.rating! as NSString).integerValue == (decepticonTransformerDataModel.rating! as NSString).integerValue) {
                autobotTransformerDataModel.battleOutcome = CONSTANT_DESTROYED_STRING;
                decepticonTransformerDataModel.battleOutcome = CONSTANT_DESTROYED_STRING;
                self.dataSource?.sortedAutobotsDataModelArray.replaceObject(at: i, with: autobotTransformerDataModel)
                self.dataSource?.sortedDecepticonsDataModelArray.replaceObject(at: i, with: decepticonTransformerDataModel)
                continue
            }
        }
        
        self.isBattleComplete = true
        self.dataSource!.isBattleComplete = true
        self.startBattleButton.isHidden = self.isBattleComplete!
        //NSLog(@"a: %d b: %d", battlesWonByAutobots, battleWonByDecepticons);
        if (totalBattles == 0) {
            self.battlefieldBannerLabel.text = CONSTANT_BATTLE_INSUFFICIENT_STRING;
        }
        else {
            if (self.isGameOVerByAnnihilation!) {
                self.battlefieldBannerLabel.text = CONSTANT_GAMEOVER_STRING;
            }
            else {
                if (battlesWonByAutobots == battleWonByDecepticons) {
                    self.battlefieldBannerLabel.text = CONSTANT_BATTLE_TIE_STRING;
                }
                else {
                    if (battlesWonByAutobots > battleWonByDecepticons) {
                        self.battlefieldBannerLabel.text = CONSTANT_BATTLE_AUTOBOTS_STRING;
                    }
                    else {
                        self.battlefieldBannerLabel.text = CONSTANT_BATTLE_DECEPTICONS_STRING;
                    }
                }
            }
        }
        self.transformerBattleTableView.reloadData()
    }
    
    func setDataForGameOverByAnnihilation (battleCount: Int) {
        self.isGameOVerByAnnihilation = true
        for i in 0...battleCount-1 {
            var updatedAutobotDataModel = TransformerDataModel()
            updatedAutobotDataModel = self.dataSource?.sortedAutobotsDataModelArray.object(at: i) as! TransformerDataModel
            updatedAutobotDataModel.battleOutcome = CONSTANT_DESTROYED_STRING
            self.dataSource?.sortedAutobotsDataModelArray.replaceObject(at: i, with: updatedAutobotDataModel)
            
            var updatedDecepticonDataModel = TransformerDataModel()
            updatedDecepticonDataModel = self.dataSource?.sortedDecepticonsDataModelArray.object(at: i) as! TransformerDataModel
            updatedDecepticonDataModel.battleOutcome = CONSTANT_DESTROYED_STRING
            self.dataSource?.sortedDecepticonsDataModelArray.replaceObject(at: i, with: updatedDecepticonDataModel)
        }
        if (self.dataSource!.sortedAutobotsDataModelArray.count == battleCount && self.dataSource!.sortedDecepticonsDataModelArray.count > battleCount) {
            for i in battleCount...self.dataSource!.sortedDecepticonsDataModelArray.count-1 {
                var updatedDecepticonDataModel = TransformerDataModel()
                updatedDecepticonDataModel = self.dataSource?.sortedDecepticonsDataModelArray.object(at: i) as! TransformerDataModel
                updatedDecepticonDataModel.battleOutcome = CONSTANT_DESTROYED_STRING;
                self.dataSource?.sortedDecepticonsDataModelArray.replaceObject(at: i, with: updatedDecepticonDataModel)
            }
        }
        else if (self.dataSource!.sortedDecepticonsDataModelArray.count == battleCount && self.dataSource!.sortedAutobotsDataModelArray.count > battleCount){
            for i in battleCount...self.dataSource!.sortedAutobotsDataModelArray.count-1 {
                var updatedAutobotDataModel = TransformerDataModel()
                updatedAutobotDataModel = self.dataSource?.sortedAutobotsDataModelArray.object(at: i) as! TransformerDataModel
                updatedAutobotDataModel.battleOutcome = CONSTANT_DESTROYED_STRING;
                self.dataSource?.sortedAutobotsDataModelArray.replaceObject(at: i, with: updatedAutobotDataModel)
            }
        }
        
    }
    
    func updateBattleResult (autobotTransformerModel: TransformerDataModel, decepticonTransformerModel: TransformerDataModel, winnerSpecifier: NSString, index: Int) {
        let differentiator = (winnerSpecifier as String == CONSTANT_TEAM_AUTOBOT_STRING) ? 0 : 1
        switch (differentiator) {
        case 0:
            //autobot->won decepticon->lost
            autobotTransformerModel.battleOutcome = CONSTANT_WINNER_STRING;
            decepticonTransformerModel.battleOutcome = CONSTANT_LOSER_STRING;
            self.dataSource?.sortedAutobotsDataModelArray.replaceObject(at: index, with: autobotTransformerModel)
            self.dataSource?.sortedDecepticonsDataModelArray.replaceObject(at: index, with: decepticonTransformerModel)
            break;
            
        case 1:
            //autobot->lost decepticon->won
            autobotTransformerModel.battleOutcome = CONSTANT_LOSER_STRING;
            decepticonTransformerModel.battleOutcome = CONSTANT_WINNER_STRING;
            self.dataSource?.sortedAutobotsDataModelArray.replaceObject(at: index, with: autobotTransformerModel)
            self.dataSource?.sortedDecepticonsDataModelArray.replaceObject(at: index, with: decepticonTransformerModel)
            break;
            
        default:
            break;
        }
    }
}

