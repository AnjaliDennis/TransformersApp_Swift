//
//  TransformerViewController.swift
//  TransformersAppSwift
//
//  Created by Anjali Pragati Dennis on 06/07/20.
//  Copyright © 2020 Anjali Pragati Dennis. All rights reserved.
//

import UIKit

class TransformerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var ratingValueLabel: UILabel!
    @IBOutlet weak var teamIconImagView: UIImageView!
    @IBOutlet weak var deleteTransformerButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var teamValueSegmentedControl: UISegmentedControl!
    @IBOutlet weak var strengthLabel: UILabel!
    @IBOutlet weak var strengthSlider: UISlider!
    @IBOutlet weak var intelligenceLabel: UILabel!
    @IBOutlet weak var intelligenceSlider: UISlider!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var speedSlider: UISlider!
    @IBOutlet weak var enduranceLabel: UILabel!
    @IBOutlet weak var enduranceSlider: UISlider!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var rankSlider: UISlider!
    @IBOutlet weak var courageLabel: UILabel!
    @IBOutlet weak var courageSlider: UISlider!
    @IBOutlet weak var firepowerLabel: UILabel!
    @IBOutlet weak var firepowerSlider: UISlider!
    @IBOutlet weak var skillLabel: UILabel!
    @IBOutlet weak var skillSlider: UISlider!
    @IBOutlet weak var editTransformerButton: UIButton!
}

class TransformerViewController: UIViewController,UICollectionViewDataSource,UITextFieldDelegate {
    
    @IBOutlet weak var autobotCollectionView: UICollectionView!
    var transformerDataModelArray: NSMutableArray = [TransformerDataModel()]
    //var transformerDataModelArray: NSMutableArray = [TransformerDataModel]()
    var currentIndexPath: IndexPath?
    var isCellEditing: Bool?
    var isRefreshed: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getAuthenticationToken()
        self.transformerDataModelArray = NSMutableArray()
        self.isCellEditing = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (UserDefaults.standard.bool(forKey: CONSTANT_REFRESH)) {
            UserDefaults.standard.set(false, forKey: CONSTANT_REFRESH)
            refreshTransformerList([])
        }
        
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.transformerDataModelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TransformerCollectionViewCellReuseIdentifier", for: indexPath) as! TransformerCollectionViewCell
        let transformerDataModel: TransformerDataModel = self.transformerDataModelArray.object(at: indexPath.row) as! TransformerDataModel
        
        cell.nameTextField.text = transformerDataModel.name;
        cell.nameTextField.delegate = self;
        cell.teamValueSegmentedControl.selectedSegmentIndex = (transformerDataModel.team == CONSTANT_AUTOBOT_STRING) ? 0 : 1
        cell.strengthSlider.value = (transformerDataModel.strength! as NSString).floatValue
        cell.strengthLabel.text = CONSTANT_STRENGTH_STRING+transformerDataModel.strength!
        cell.intelligenceSlider.value = (transformerDataModel.intelligence! as NSString).floatValue
        cell.intelligenceLabel.text = CONSTANT_INTELLIGENCE_STRING+transformerDataModel.intelligence!
        cell.speedSlider.value = (transformerDataModel.speed! as NSString).floatValue
        cell.speedLabel.text = CONSTANT_SPEED_STRING+transformerDataModel.speed!
        cell.enduranceSlider.value = (transformerDataModel.endurance! as NSString).floatValue
        cell.enduranceLabel.text = CONSTANT_ENDURANCE_STRING+transformerDataModel.endurance!
        cell.rankSlider.value = (transformerDataModel.rank! as NSString).floatValue
        cell.rankLabel.text = CONSTANT_RANK_STRING+transformerDataModel.rank!;
        cell.courageSlider.value = (transformerDataModel.courage! as NSString).floatValue
        cell.courageLabel.text = CONSTANT_COURAGE_STRING+transformerDataModel.courage!
        cell.firepowerSlider.value = (transformerDataModel.firepower! as NSString).floatValue
        cell.firepowerLabel.text = CONSTANT_FIREPOWER_STRING+transformerDataModel.firepower!
        cell.skillSlider.value = (transformerDataModel.skill! as NSString).floatValue
        cell.skillLabel.text = CONSTANT_SKILL_STRING+transformerDataModel.skill!
        cell.ratingValueLabel.text = transformerDataModel.rating;
        let imageData = NSData(contentsOf: URL(string: transformerDataModel.team_icon!)!)
        cell.teamIconImagView.image = UIImage(data: imageData! as Data)
        cell.backgroundColor = (transformerDataModel.team == CONSTANT_AUTOBOT_STRING) ?  UIColor.init(named: "AutobotColor") : UIColor.init(named: "DecepticonColor")
        cell.deleteTransformerButton.tag = indexPath.row;
        cell.deleteTransformerButton.addTarget(self, action: #selector(collectionViewCellDeleteButtonPressed(sender:)), for: .touchUpInside)
        cell.editTransformerButton.tag = indexPath.row;
        cell.editTransformerButton.addTarget(self, action: #selector(collectionViewCellEditButtonPressed(sender:)), for: .touchUpInside)
        self.currentIndexPath = indexPath;
        cell.strengthSlider.addTarget(self, action: #selector(sliderValueChange(sender:)), for: .touchUpInside)
        cell.intelligenceSlider.addTarget(self, action: #selector(sliderValueChange(sender:)), for: .touchUpInside)
        cell.speedSlider.addTarget(self, action: #selector(sliderValueChange(sender:)), for: .touchUpInside)
        cell.enduranceSlider.addTarget(self, action: #selector(sliderValueChange(sender:)), for: .touchUpInside)
        cell.rankSlider.addTarget(self, action: #selector(sliderValueChange(sender:)), for: .touchUpInside)
        cell.courageSlider.addTarget(self, action: #selector(sliderValueChange(sender:)), for: .touchUpInside)
        cell.firepowerSlider.addTarget(self, action: #selector(sliderValueChange(sender:)), for: .touchUpInside)
        cell.skillSlider.addTarget(self, action: #selector(sliderValueChange(sender:)), for: .touchUpInside)
        cell.nameTextField.isUserInteractionEnabled = false;
        cell.teamValueSegmentedControl.isUserInteractionEnabled = false;
        cell.strengthSlider.isUserInteractionEnabled = false;
        cell.intelligenceSlider.isUserInteractionEnabled = false;
        cell.speedSlider.isUserInteractionEnabled = false;
        cell.enduranceSlider.isUserInteractionEnabled = false;
        cell.rankSlider.isUserInteractionEnabled = false;
        cell.courageSlider.isUserInteractionEnabled = false;
        cell.firepowerSlider.isUserInteractionEnabled = false;
        cell.skillSlider.isUserInteractionEnabled = false;
        
        return cell
    }
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    // MARK: - Web service call
    func getAuthenticationToken () {
        TransformerNetworkAPI().getToken(completion: { (result:ResultType) in
            switch result
            {
            case .Success(let rst):
                print("successful in vc %@", rst)
                if (UserDefaults.standard.bool(forKey: CONSTANT_REFRESH)) {
                    self.refreshTransformerList([])
                }
                
            case .Error(let e):
                print("Error", e)
                let alert = UIAlertController(title: "TransformerApp", message: e.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: false, completion: nil)
            }
        })
    }
    
    
    @objc func collectionViewCellDeleteButtonPressed(sender: UIButton){
        print("Delete button press")
    }
    @objc func collectionViewCellEditButtonPressed(sender: UIButton){
        print("Edit button press")
        self.currentIndexPath = IndexPath(row: sender.tag, section: 0)
        let selectedCell: TransformerCollectionViewCell = self.autobotCollectionView.cellForItem(at: self.currentIndexPath!) as! TransformerCollectionViewCell
        self.isCellEditing = !self.isCellEditing!
        selectedCell.nameTextField.isUserInteractionEnabled = self.isCellEditing!
        selectedCell.teamValueSegmentedControl.isUserInteractionEnabled = self.isCellEditing!
        selectedCell.strengthSlider.isUserInteractionEnabled = self.isCellEditing!
        selectedCell.intelligenceSlider.isUserInteractionEnabled = self.isCellEditing!
        selectedCell.speedSlider.isUserInteractionEnabled = self.isCellEditing!
        selectedCell.enduranceSlider.isUserInteractionEnabled = self.isCellEditing!
        selectedCell.rankSlider.isUserInteractionEnabled = self.isCellEditing!
        selectedCell.courageSlider.isUserInteractionEnabled = self.isCellEditing!
        selectedCell.firepowerSlider.isUserInteractionEnabled = self.isCellEditing!
        selectedCell.skillSlider.isUserInteractionEnabled = self.isCellEditing!
        selectedCell.editTransformerButton.setTitle(((self.isCellEditing!) ? CONSTANT_SAVE_BUTTON : CONSTANT_EDIT_BUTTON_OK), for: .normal)
        self.autobotCollectionView.isScrollEnabled = !self.isCellEditing!
        if(!self.isCellEditing!) {
            //changes are to be saved/updated
            var uneditedTransformerDataModel = TransformerDataModel()
            var updatedTransformerDataModel = TransformerDataModel()
            uneditedTransformerDataModel = self.transformerDataModelArray.object(at: self.currentIndexPath!.row) as! TransformerDataModel
            updatedTransformerDataModel.id = uneditedTransformerDataModel.id
            updatedTransformerDataModel.name = selectedCell.nameTextField.text
            updatedTransformerDataModel.strength = "\(Int(selectedCell.strengthSlider.value))"
            updatedTransformerDataModel.intelligence = "\(Int(selectedCell.intelligenceSlider.value))"
            updatedTransformerDataModel.speed = "\(Int(selectedCell.speedSlider.value))"
            updatedTransformerDataModel.endurance = "\(Int(selectedCell.enduranceSlider.value))"
            updatedTransformerDataModel.rank = "\(Int(selectedCell.rankSlider.value))"
            updatedTransformerDataModel.courage = "\(Int(selectedCell.courageSlider.value))"
            updatedTransformerDataModel.firepower = "\(Int(selectedCell.firepowerSlider.value))"
            updatedTransformerDataModel.skill = "\(Int(selectedCell.skillSlider.value))"
            updatedTransformerDataModel.team = (selectedCell.teamValueSegmentedControl.selectedSegmentIndex == 0) ? CONSTANT_TEAM_AUTOBOT_STRING : CONSTANT_TEAM_DECEPTICON_STRING
            updatedTransformerDataModel.team_icon = ""
            let overallRating = (updatedTransformerDataModel.strength! as NSString).integerValue + (updatedTransformerDataModel.intelligence! as NSString).integerValue + (updatedTransformerDataModel.speed! as NSString).integerValue + (updatedTransformerDataModel.endurance! as NSString).integerValue + (updatedTransformerDataModel.firepower! as NSString).integerValue
            selectedCell.ratingValueLabel.text = "\(overallRating)"
            updatedTransformerDataModel.rating = ""
            
            TransformerNetworkAPI().updateTransformer(updateRequestBody: updatedTransformerDataModel, completion: { (result:ResultType) in
                switch result
                {
                case .Success(let rst):
                    print("successful in updation- vc %@", rst)
                    self.transformerDataModelArray.replaceObject(at: self.currentIndexPath!.row, with: rst as! TransformerDataModel)
                    DispatchQueue.main.async{
                        self.autobotCollectionView.reloadData()
                        let alert = UIAlertController(title: CONSTANT_ALERT_SUCCESS_TITLE_STRING, message: CONSTANT_ALERT_UPDATE_SUCCESS_MESSAGE_STRING, preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: false, completion: nil)
                    }
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
    @objc func sliderValueChange(sender: UISlider){
        print("Slider action")
        let selectedCell: TransformerCollectionViewCell = self.autobotCollectionView.cellForItem(at: self.currentIndexPath!) as! TransformerCollectionViewCell
         
         switch (sender.tag) {
             case 0:
                selectedCell.strengthLabel.text = CONSTANT_STRENGTH_STRING+"\(Int(sender.value))"
                 break;
                 
             case 1:
                 selectedCell.intelligenceLabel.text = CONSTANT_INTELLIGENCE_STRING+"\(Int(sender.value))"
                 break;
                 
             case 2:
                 selectedCell.speedLabel.text = CONSTANT_SPEED_STRING+"\(Int(sender.value))"
                 break;
                 
             case 3:
                 selectedCell.enduranceLabel.text = CONSTANT_ENDURANCE_STRING+"\(Int(sender.value))"
                 break;
                 
             case 4:
                 selectedCell.rankLabel.text = CONSTANT_RANK_STRING+"\(Int(sender.value))"
                 break;
                 
             case 5:
                 selectedCell.courageLabel.text = CONSTANT_COURAGE_STRING+"\(Int(sender.value))"
                 break;
                 
             case 6:
                 selectedCell.firepowerLabel.text = CONSTANT_FIREPOWER_STRING+"\(Int(sender.value))"
                 break;
                 
             case 7:
                 selectedCell.skillLabel.text = CONSTANT_SKILL_STRING+"\(Int(sender.value))"
                 break;
                 
             default:
                 break;
         }
         
    }
    
    @IBAction func refreshTransformerList(_ sender: Any) {
        TransformerNetworkAPI().getTransformerList(completion: { (result:ResultType) in
            switch result
            {
            case .Success(let rst):
                print("successful in vc %@", rst)
                if (((rst as! TransformerDataModelArray).transformers! as NSArray).count != 0 ) {
                    if let tempArray: [TransformerDataModel] = ((rst as! TransformerDataModelArray).transformers! as [TransformerDataModel]) {
                        self.transformerDataModelArray.removeAllObjects()
                        self.transformerDataModelArray.addObjects(from: tempArray)
                        DispatchQueue.main.async{
                            self.autobotCollectionView.reloadData()
                        }
                    }
                    
                }
                
            case .Error(let e):
                print("Error", e)
                let alert = UIAlertController(title: "TransformerApp", message: e.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: false, completion: nil)
            }
        })
    }
    
    @IBAction func createButtonSelected(_ sender: Any) {
        self.performSegue(withIdentifier: "segueToCreateTransformerScreen", sender: sender)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueToBattlefieldScreen") {
            //            let destVC = segue.destination as! BattlefieldTransformerViewController
            //            destVC.transformerDataModelArray = self.transformerDataModelArray
        }
    }
    
    
}

