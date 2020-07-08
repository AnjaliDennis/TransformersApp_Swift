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
}

