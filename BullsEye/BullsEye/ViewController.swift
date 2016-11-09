//
//  ViewController.swift
//  BullsEye
//
//  Created by Hans Ravnaas on 11/8/16.
//  Copyright © 2016 Hans Ravnaas. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {

    var currentValue: Int = 0
	var initialValue: Int = 0
	var targetValue: Int = 0
	var totalScore: Int = 0
	var round: Int = 0
	@IBOutlet weak var slider: UISlider!
	@IBOutlet weak var targetValueLabel: UILabel!
	@IBOutlet weak var scoreLabel: UILabel!
	@IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad()
	{
        super.viewDidLoad()
		
		let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
		slider.setThumbImage(thumbImageNormal, for: .normal)
		
		let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
		slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
		
		let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
		let trackLeftImage = UIImage(named: "SliderTrackLeft")!
		let trackLeftResizable =
			trackLeftImage.resizableImage(withCapInsets: insets)
		slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
		
		let trackRightImage = UIImage(named: "SliderTrackRight")!
		let trackRightResizable =
			trackRightImage.resizableImage(withCapInsets: insets)
		slider.setMaximumTrackImage(trackRightResizable, for: .normal)
		
		initialValue = lroundf(slider.value)
		startOver()
		updateLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAlert()
    {
		let difference = abs(targetValue - currentValue)
		var points = 100 - difference

		// Construct message to user.
		var msg: String
		if points == 100
		{
			msg = "Dude, perfect!"
			points += 100 // Add bonus points
		}
		else if points >= 95
		{
			msg = "Sooooo close"
			if points == 99
			{
				points += 50 // Add bonus points
			}
		}
		else if points >= 90
		{
			msg = "Pretty good, keep at it"
		}
		else
		{
			msg = "Not bad, but put down the beer and try again."
		}
		
		totalScore += points
		
        let alert = UIAlertController(title: "\(points) points", message: "\(msg)", preferredStyle: UIAlertControllerStyle.alert)
		
		let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:
			{
				action in
					self.startNewRound()
					self.updateLabels()
			})
		
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(_ slider: UISlider)
    {
        //print("Value of slider is now: \(slider.value)")
        currentValue = lroundf(slider.value)
    }
	
	func startNewRound() -> Void
	{
		targetValue = 1 + Int(arc4random_uniform(100))
		currentValue = lroundf(slider.value)
		slider.value = Float(initialValue)
		round += 1
	}
	func updateLabels()
	{
		targetValueLabel.text = String(targetValue)
		scoreLabel.text = String(totalScore)
		roundLabel.text = String(round)
	}
	
	@IBAction func startOverButtonPressed(_ sender: UIButton)
	{
		startOver()
	}
	
	func startOver() -> Void
	{
		totalScore = 0
		round = 0
		
		startNewRound()
		updateLabels()
		
		let transition = CATransition()
		transition.type = kCATransitionFade
		transition.duration = 0
		transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
		view.layer.add(transition, forKey: nil)
	}
}



