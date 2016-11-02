//
//  ViewController.swift
//  Ninja Gold
//
//  Created by Hans Ravnaas on 11/2/16.
//  Copyright © 2016 Hans Ravnaas. All rights reserved.
//

import UIKit

// Extend Int class so that it has a random method.
extension Int
{
    static func random(range: Range<Int>) -> Int
    {
        var offset = 0
        if range.lowerBound < 0
        {
            offset = Swift.abs(range.lowerBound)
        }
        let min = UInt32(range.lowerBound + offset)
        let max = UInt32(range.upperBound + offset)
        return Int(min + arc4random_uniform(max -  min)) - offset;
    }
}

class ViewController: UIViewController {
    var score = 0
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var farmLabel: UILabel!
    @IBOutlet weak var caveLabel: UILabel!
    @IBOutlet weak var houseLabel: UILabel!
    @IBOutlet weak var casinoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func buildingButtonPressed(_ sender: UIButton) {
        farmLabel.text = ""
        caveLabel.text = ""
        houseLabel.text = ""
        casinoLabel.text = ""
        
        let newGold = getGoldForBuilding(buildingType: sender.tag)
        let rewardText = "You earned \(newGold) golds"
        
        switch sender.tag {
        case 1:
            farmLabel.text = rewardText
        case 2:
            caveLabel.text = rewardText
        case 3:
            houseLabel.text = rewardText
        case 4:
            casinoLabel.text = rewardText
        default:
            casinoLabel.text = ""
        }
        
        score += newGold
        scoreLabel.text = "Score: " + String(score)
        
    }

    @IBAction func resetButtonPressed(_ sender: UIButton) {
        score = 0
        scoreLabel.text = "Score: " + String(score)
        farmLabel.text = ""
        caveLabel.text = ""
        houseLabel.text = ""
        casinoLabel.text = ""
    }
    
    func getGoldForBuilding(buildingType: Int) -> Int
    {
        switch buildingType {
        case 1:
            return Int.random(range: Range(10...20))
        case 2:
            return Int.random(range: Range(5...10))
        case 3:
            return Int.random(range: Range(2...5))
        case 4:
            return Int.random(range: Range(-50...50))
        default:
            return 0
        }
    }

}

