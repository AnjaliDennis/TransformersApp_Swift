//
//  CreateTransformerViewController.swift
//  TransformersAppSwift
//
//  Created by Anjali Pragati Dennis on 07/07/20.
//  Copyright © 2020 Anjali Pragati Dennis. All rights reserved.
//

import UIKit

class CreateTransformerViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var transformerNameTextField: UITextField!
    @IBOutlet weak var transformerTeamType: UISegmentedControl!
    @IBOutlet weak var strengthLabel: UILabel!
    @IBOutlet weak var intelligenceLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var enduranceLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var courageLabel: UILabel!
    @IBOutlet weak var firepowerLabel: UILabel!
    @IBOutlet weak var skillLabel: UILabel!
    @IBOutlet weak var createTransformerButton: UIButton!
    @IBOutlet weak var strengthSlider: UISlider!
    @IBOutlet weak var intelligenceSlider: UISlider!
    @IBOutlet weak var speedSlider: UISlider!
    @IBOutlet weak var enduranceSlider: UISlider!
    @IBOutlet weak var rankSlider: UISlider!
    @IBOutlet weak var courageSlider: UISlider!
    @IBOutlet weak var firepowerSlider: UISlider!
    @IBOutlet weak var skillSlider: UISlider!
    
    var createdTransformerDataModel: TransformerDataModel?
    var requestBodyDataModel: TransformerDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func sliderValueChange(_ sender: UISlider) {
        switch (sender.tag) {
        case 0:
            self.strengthLabel.text = "\(Int(sender.value))"
            break;
            
        case 1:
            self.intelligenceLabel.text = "\(Int(sender.value))"
            break;
            
        case 2:
            self.speedLabel.text = "\(Int(sender.value))"
            break;
            
        case 3:
            self.enduranceLabel.text = "\(Int(sender.value))"
            break;
            
        case 4:
            self.rankLabel.text = "\(Int(sender.value))"
            break;
            
        case 5:
            self.courageLabel.text = "\(Int(sender.value))"
            break;
            
        case 6:
            self.firepowerLabel.text = "\(Int(sender.value))"
            break;
            
        case 7:
            self.skillLabel.text = "\(Int(sender.value))"
            break;
            
        default:
            break;
        }
    }
    
    @IBAction func createTransformer(_ sender: Any) {
        if ((self.transformerNameTextField.text!).count != 0) {
            let teamValue = (self.transformerTeamType.selectedSegmentIndex == 0) ? CONSTANT_TEAM_AUTOBOT_STRING : CONSTANT_TEAM_DECEPTICON_STRING
            self.requestBodyDataModel = self.instantiateTransformerForRequest(transformerId: "", name: self.transformerNameTextField!.text! as NSString, strength: self.strengthLabel!.text! as NSString, intelligence: self.intelligenceLabel!.text! as NSString, speed: self.speedLabel!.text! as NSString, endurance: self.enduranceLabel!.text! as NSString, rank: self.rankLabel!.text! as NSString, courage: self.courageLabel!.text! as NSString, firepower: self.firepowerLabel!.text! as NSString, skill: self.skillLabel!.text! as NSString, team: teamValue as NSString, teamIcon: "")
            
            TransformerNetworkAPI().createTransformer(requestBody: self.requestBodyDataModel!, completion: { (result:ResultType) in
                switch result
                {
                case .Success(let rst):
                    print("successful in create vc %@", rst)
                    break
                case .Error(let e):
                    print("Error", e)
                    let alert = UIAlertController(title: "TransformerApp", message: e.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: false, completion: nil)
                }
                
            })
            
            
            
        }
    }
    
    func instantiateTransformerForRequest (transformerId:NSString, name:NSString, strength:NSString, intelligence:NSString, speed:NSString, endurance:NSString, rank:NSString, courage:NSString, firepower:NSString, skill:NSString, team:NSString, teamIcon:NSString ) -> TransformerDataModel {
        self.requestBodyDataModel = TransformerDataModel()
        self.requestBodyDataModel?.id = transformerId as String
        self.requestBodyDataModel?.name = name as String
        self.requestBodyDataModel?.strength = strength as String
        self.requestBodyDataModel?.intelligence = intelligence as String
        self.requestBodyDataModel?.speed = speed as String
        self.requestBodyDataModel?.endurance = endurance as String
        self.requestBodyDataModel?.rank = rank as String
        self.requestBodyDataModel?.courage = courage as String
        self.requestBodyDataModel?.firepower = firepower as String
        self.requestBodyDataModel?.skill = skill as String
        self.requestBodyDataModel?.team = team as String
        self.requestBodyDataModel?.team_icon = teamIcon as String
        
        return self.requestBodyDataModel!
    }
    
    
}
