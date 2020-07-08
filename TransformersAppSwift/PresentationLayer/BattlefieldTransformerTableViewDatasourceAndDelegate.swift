//
//  BattlefieldTransformerTableViewDatasourceAndDelegate.swift
//  TransformersAppSwift
//
//  Created by Anjali Pragati Dennis on 08/07/20.
//  Copyright © 2020 Anjali Pragati Dennis. All rights reserved.
//

import UIKit

class BattlefieldTransformerTableViewDatasourceAndDelegate: NSObject, UITableViewDataSource, UITableViewDelegate {
    var transformerDataModelArray: NSMutableArray = [TransformerDataModel()]
    var sortedAutobotsDataModelArray: NSMutableArray = [TransformerDataModel()]
    var sortedDecepticonsDataModelArray: NSMutableArray = [TransformerDataModel()]
    var isBattleComplete: Bool?
  
     // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.sortedAutobotsDataModelArray.count > self.sortedDecepticonsDataModelArray.count) {
            return self.sortedAutobotsDataModelArray.count;
        }
        else {
            return self.sortedDecepticonsDataModelArray.count;
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 275
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "BattlefieldTransformerTableViewCellReuseIdentifier"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! BattlefieldTransformerTableViewCell
        let imageUrlDecepticon = URL(string: CONSTANT_URL_DECEPTICON_TEAMICON)
        let imageDataDecepticon = NSData(contentsOf: imageUrlDecepticon!)
        let placeholerImageDecepticon = UIImage(data: imageDataDecepticon! as Data)
        let imageUrlAutobot = URL(string: CONSTANT_URL_AUTOBOT_TEAMICON)
        let imageDataAutobot = NSData(contentsOf: imageUrlAutobot!)
        let placeholerImageAutobot = UIImage(data: imageDataAutobot! as Data)
        if (self.sortedAutobotsDataModelArray.count <= indexPath.row) {
            cell.autobotNameLabel.text = CONSTANT_UNAVAILABLE_STRING
            cell.autobotRatingLabel.text = CONSTANT_RATING_UNAVAILABLE_STRING
            cell.autobotStatsLabel.text = CONSTANT_STATS_UNAVAILABLE_STRING
            cell.autobotRankLabel.text = CONSTANT_RANK_UNAVAILABLE_STRING
            cell.autobotResultLabel.text = self.isBattleComplete! ? CONSTANT_BATTLE_MISSED_STRING : CONSTANT_COMMENCE_BATTLE_STRING
            cell.autobotTeamIcon.image = placeholerImageAutobot
        }
        else  {
            let autobotDataModel: TransformerDataModel = self.sortedAutobotsDataModelArray.object(at: indexPath.row) as! TransformerDataModel
            cell.autobotNameLabel.text = autobotDataModel.name
            let imageUrlAutobot = URL(string: autobotDataModel.team_icon!)
            let imageDataAutobot = NSData(contentsOf: imageUrlAutobot!)
            cell.autobotTeamIcon.image = UIImage(data: imageDataAutobot! as Data)
            cell.autobotRatingLabel.text = CONSTANT_RATING_STRING+autobotDataModel.rating!
            let statsString = "\(autobotDataModel.strength!), \(autobotDataModel.intelligence!), \(autobotDataModel.speed!), \(autobotDataModel.endurance!), \(autobotDataModel.rank!), \(autobotDataModel.courage!), \(autobotDataModel.firepower!), \(autobotDataModel.skill!)"
            cell.autobotStatsLabel.text = CONSTANT_STATS_STRING+statsString
            cell.autobotRankLabel.text = CONSTANT_RANK_STRING+autobotDataModel.rank!
            if (self.isBattleComplete!) {
                if (autobotDataModel.battleOutcome != nil) {
                    cell.autobotResultLabel.text = autobotDataModel.battleOutcome
                }
                else {
                    cell.autobotResultLabel.text = CONSTANT_SURVIVOR_STRING
                }
            }
            else {
                cell.autobotResultLabel.text = CONSTANT_COMMENCE_BATTLE_STRING
            }
        }
        if (self.sortedDecepticonsDataModelArray.count <= indexPath.row) {
            cell.decepticonNameLabel.text = CONSTANT_UNAVAILABLE_STRING
            cell.decepticonRatingLabel.text = CONSTANT_RATING_UNAVAILABLE_STRING
            cell.decepticonStatsLabel.text = CONSTANT_STATS_UNAVAILABLE_STRING
            cell.decepticonRankLabel.text = CONSTANT_RANK_UNAVAILABLE_STRING
            cell.decepticonResultLabel.text = self.isBattleComplete! ? CONSTANT_BATTLE_MISSED_STRING : CONSTANT_COMMENCE_BATTLE_STRING
            cell.decepticonTeamIcon.image = placeholerImageDecepticon
        }
        else {
            let decepticonDataModel: TransformerDataModel = self.sortedDecepticonsDataModelArray.object(at: indexPath.row) as! TransformerDataModel
            cell.decepticonNameLabel.text = decepticonDataModel.name;
            let imageUrlDecepticon = URL(string: decepticonDataModel.team_icon!)
            let imageDataDecepticon = NSData(contentsOf: imageUrlDecepticon!)
            cell.decepticonTeamIcon.image = UIImage(data: imageDataDecepticon! as Data)
            cell.decepticonRatingLabel.text = CONSTANT_RATING_STRING+decepticonDataModel.rating!
            let statsString = "\(decepticonDataModel.strength!), \(decepticonDataModel.intelligence!), \(decepticonDataModel.speed!), \(decepticonDataModel.endurance!), \(decepticonDataModel.rank!), \(decepticonDataModel.courage!), \(decepticonDataModel.firepower!), \(decepticonDataModel.skill!)"
            
            cell.decepticonStatsLabel.text = CONSTANT_STATS_STRING+statsString
            cell.decepticonRankLabel.text = CONSTANT_RANK_STRING+decepticonDataModel.rank!
            if (self.isBattleComplete!) {
                if (decepticonDataModel.battleOutcome != nil) {
                    cell.decepticonResultLabel.text = decepticonDataModel.battleOutcome;
                }
                else {
                    cell.decepticonResultLabel.text = CONSTANT_SURVIVOR_STRING;
                }
            }
            else {
                cell.decepticonResultLabel.text = CONSTANT_COMMENCE_BATTLE_STRING;
            }
        }
        
        return cell;
    }

}
