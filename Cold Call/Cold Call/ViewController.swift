//
//  ViewController.swift
//  Cold Call
//
//  Created by Hans Ravnaas on 11/2/16.
//  Copyright © 2016 Hans Ravnaas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    var randNum = 0
    let names = [
        "Hans",
        "Doyle",
        "Malcolm",
        "Angus",
        "Linda"
        ]
    
    @IBAction func coldCallPressed(_ sender: UIButton) {
        let prevRandNum = randNum
        while prevRandNum == randNum
        {
            randNum = Int(arc4random_uniform(5))
        }
        
        // Determine number color
        let randColorNum = Int(arc4random_uniform(5) + 1)
        print(randColorNum)
        switch randColorNum {
        case 1, 2:
            numberLabel.textColor = UIColor.red
        case 3, 4:
            numberLabel.textColor = UIColor.orange
        case 5:
            numberLabel.textColor = UIColor.green
        default:
            numberLabel.textColor = UIColor.blue
        }
        
        nameLabel.text = names[randNum]
        numberLabel.text = String(randColorNum)
        numberLabel.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameLabel.text = "Ready?"
        numberLabel.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

