//
//  ViewController.swift
//  MonkeyPitch
//
//  Created by Hans Ravnaas on 11/4/16.
//  Copyright © 2016 Hans Ravnaas. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIGestureRecognizerDelegate
{
    var chompPlayer:AVAudioPlayer? = nil
    var hehePlayer:AVAudioPlayer? = nil
    
    @IBOutlet var monkeyPan: UIPanGestureRecognizer!
    @IBOutlet var bananaPan: UIPanGestureRecognizer!
    
    func loadSound(filename:NSString) throws -> AVAudioPlayer
    {
        let url = Bundle.main.url(forResource: filename as String, withExtension: "caf")
        //let player = AVAudioPlayer(contentsOf: url, error: &error)
        let player = try AVAudioPlayer(contentsOf: url!)
        player.prepareToPlay()
        return player
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //1
        let filteredSubviews = self.view.subviews.filter(
            {
                $0.isKind(of: UIImageView.self)
            })
        // 2
        for view in filteredSubviews
        {
            // 3
            // Reason for #selector syntax, see...
            // http://stackoverflow.com/questions/36211030/whats-the-advantage-of-selector-update-in-swift-2-3
            let recognizer = UITapGestureRecognizer(target: self, action:#selector(handleTap(recognizer:)))
            // 4

            recognizer.delegate = self
            view.addGestureRecognizer(recognizer)
            
            //TODO: Add a custom gesture recognizer too
            recognizer.require(toFail: monkeyPan)
            recognizer.require(toFail: bananaPan)
            
            let recognizer2 = TickleGestureRecognizer(target: self, action:#selector(handleTickle(recognizer:)))
            recognizer2.delegate = self
            view.addGestureRecognizer(recognizer2)
        }
        do
        {
        self.chompPlayer = try self.loadSound(filename: "chomp")
        }
        catch
        {
            print (error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Optional function for UIGestureRecognizerDelegate protocol
    func gestureRecognizer(_: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith shouldRecognizeSimultaneouslyWithGestureRecognizer:UIGestureRecognizer) -> Bool {
        return true
    }

    @IBAction func handlePan(recognizer:UIPanGestureRecognizer)
    {
        //comment for panning
        //uncomment for tickling
        return;
        
        let translation = recognizer.translation(in: self.view)
        // recognizer.view is the monkey or banana image
        if let view = recognizer.view
        {
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        
        // Deal with touch velocity
        if recognizer.state == UIGestureRecognizerState.ended
        {
            // 1
            let velocity = recognizer.velocity(in: self.view)
            let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
            let slideMultiplier = magnitude / 200
            print("magnitude: \(magnitude), slideMultiplier: \(slideMultiplier)")
            
            // 2
            let slideFactor = 0.1 * slideMultiplier     //Increase for more of a slide
            // 3
            var finalPoint = CGPoint(x:recognizer.view!.center.x + (velocity.x * slideFactor),
                                     y:recognizer.view!.center.y + (velocity.y * slideFactor))
            // 4
            finalPoint.x = min(max(finalPoint.x, 0), self.view.bounds.size.width)
            finalPoint.y = min(max(finalPoint.y, 0), self.view.bounds.size.height)
            
            // 5
            UIView.animate(
                            withDuration: Double(slideFactor * 2),
                            delay: 0,
                            // 6
                            options: UIViewAnimationOptions.curveEaseOut,
                            animations: { recognizer.view!.center = finalPoint },
                            completion: nil
                          )
        }
    }
    
    @IBAction func handlePinch(recognizer : UIPinchGestureRecognizer)
    {
        if let view = recognizer.view {
            view.transform = view.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
            recognizer.scale = 1
        }
    }
    
    @IBAction func handleRotate(recognizer : UIRotationGestureRecognizer)
    {
        if let view = recognizer.view {
            view.transform = view.transform.rotated(by: recognizer.rotation)
            recognizer.rotation = 0
        }
    }
    
    func handleTap(recognizer: UITapGestureRecognizer)
    {
        self.chompPlayer?.play()
    }
    
    func handleTickle(recognizer:TickleGestureRecognizer)
    {
        self.hehePlayer?.play()
    }
}

