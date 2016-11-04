//
//  ViewController.swift
//  Tipster
//
//  Created by Hans Ravnaas on 11/3/16.
//  Copyright © 2016 Hans Ravnaas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let tipIncrementPercent: Int = 5
    var currentPrice: Double = 0.00
    var currentPriceString = ""
    var currentLowTipPercent: Int = 10
    var currentGroupSize: Int = 1
    
    // Meal price
    @IBOutlet weak var priceLabel: UILabel!
    
    // Low tip labels
    @IBOutlet weak var lowPercentLabel: UILabel!
    @IBOutlet weak var mediumPercentLabel: UILabel!
    @IBOutlet weak var highPercentLabel: UILabel!
    
    // Medium tip labels
    @IBOutlet weak var lowTipLabel: UILabel!
    @IBOutlet weak var mediumTipLabel: UILabel!
    @IBOutlet weak var highTipLabel: UILabel!
    
    // High tip labels
    @IBOutlet weak var lowTotalLabel: UILabel!
    @IBOutlet weak var mediumTotalLabel: UILabel!
    @IBOutlet weak var highTotalLabel: UILabel!
    
    // Group size
    @IBOutlet weak var groupSizeLabel: UILabel!
    
    // Updates the labels with new calculated values
    func updateCalcFromAmount(price: Int, lowTipPercent: Int, groupSize: Int) -> Void
    {
        if price == 10 // c was clicked
        {
            print("C was clicked")
            currentPriceString = ""
            reset()
            return
        }
    
        var newChar: String = ""
        if (price == 11)
        {
            newChar = currentPriceString.contains(".") ? "" : "."
        }
        else if currentPriceString == "0" && (price >= 0 || price <= 9)
        {
            currentPriceString = ""
            newChar = String(price)
        }
        else if price >= 0 // -1 means price was not changed.
        {
            newChar = String(price)
        }
        
        currentPriceString = "\(currentPriceString)\(newChar)"
        currentPrice = Double(currentPriceString)!
        priceLabel.text = currentPriceString
        print("Current price is now \(currentPrice)")
        
        // Update group size
        currentGroupSize = Int(groupSize)
        groupSizeLabel.text = "Group Size: \(String(currentGroupSize))"
        
        // Set tip header column names
        currentLowTipPercent = lowTipPercent
        lowPercentLabel.text = "\(currentLowTipPercent)%"
        mediumPercentLabel.text = "\(currentLowTipPercent + tipIncrementPercent)%"
        highPercentLabel.text = "\(currentLowTipPercent + (tipIncrementPercent * 2))%"
        
        // Set tip amount column values
        let lowTip = getTip(price: currentPrice, tip: currentLowTipPercent, groupSize: currentGroupSize)
        lowTipLabel.text = String(format: "%.2f", lowTip)
        
        let mediumTip = getTip(price: currentPrice, tip: currentLowTipPercent + tipIncrementPercent, groupSize: currentGroupSize)
        mediumTipLabel.text = String(format: "%.2f", mediumTip)
        
        let highTip = getTip(price: currentPrice, tip: currentLowTipPercent + (2 * tipIncrementPercent), groupSize: currentGroupSize)
        highTipLabel.text = String(format: "%.2f", highTip)
        
        // Set total column values
        let pricePerPerson = currentPrice / Double(currentGroupSize)
        lowTotalLabel.text = String(format: "%.2f", pricePerPerson + lowTip)
        mediumTotalLabel.text = String(format: "%.2f", pricePerPerson + mediumTip)
        highTotalLabel.text = String(format: "%.2f", pricePerPerson + highTip)
    }
    
    func getTip(price: Double, tip: Int, groupSize: Int) -> Double
    {
        if price == 0
        {
            return 0
        }
        
        return ((Double(tip) * price) / 100) / Double(groupSize)
    }
    
    @IBAction func amountButtonPressed(_ sender: UIButton) {
        print(sender.tag)
        updateCalcFromAmount(price: sender.tag, lowTipPercent: currentLowTipPercent, groupSize: currentGroupSize)
    }
    
    @IBAction func tipSliderMoved(_ sender: UISlider) {
        print("Tip slider moved. Current value: \(sender.value)")
        updateCalcFromAmount(price: -1, lowTipPercent: Int(sender.value), groupSize: currentGroupSize)
    }
    @IBAction func groupSizeSliderMoved(_ sender: UISlider) {
        print("Group slider moved. Current value: \(sender.value)")
        updateCalcFromAmount(price: -1, lowTipPercent: currentLowTipPercent, groupSize: Int(sender.value))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reset()
    }
    
    func reset() -> Void
    {
        updateCalcFromAmount(price: 0, lowTipPercent: 10, groupSize: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

