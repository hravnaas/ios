//
//  ViewController.swift
//  TTT
//
//  Created by Hans Ravnaas on 11/2/16.
//  Copyright © 2016 Hans Ravnaas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    
    // 0 = blue, 1 = red
    // For now, blue always starts.
    var currentColor = 0
    
    // Board is initialized with -1 which means square has not been clicked.
    var board: [[Int]] = [[-1, -1, -1], [-1, -1, -1], [-1, -1, -1]]
    
    // Initialize/reset the board. Using during game.
    func initBoard() -> Void
    {
        // Ugly, but works.
        button1.backgroundColor = UIColor.lightGray
        button2.backgroundColor = UIColor.lightGray
        button3.backgroundColor = UIColor.lightGray
        button4.backgroundColor = UIColor.lightGray
        button5.backgroundColor = UIColor.lightGray
        button6.backgroundColor = UIColor.lightGray
        button7.backgroundColor = UIColor.lightGray
        button8.backgroundColor = UIColor.lightGray
        button9.backgroundColor = UIColor.lightGray

        winnerLabel.isHidden = true
        
        for row in 0...board.count - 1
        {
            for col in 0...board[row].count - 1
            {
                board[row][col] = -1
            }
        }
    }
    
    // Prints the values of the board. Only used for debugging.
    func printBoard() -> Void
    {
        for row in 0...board.count - 1
        {
            print("Row \(row)")
            for col in 0...board[row].count - 1
            {
                print("\t\(board[row][col])")
            }
        }
    }
    
    // Colors a square on the board.
    func setSquare(color: Int, tag: Int) -> Void
    {
        // First translate tag to x and y coordinates
        // TODO: Do better boundary checking.
        let tagString = String(tag)
        let x = Int(String(tagString[tagString.startIndex]))! - 1
        let y = Int(String(tagString[tagString.index(before: tagString.endIndex)]))! - 1
        
        board[y][x] = color
    }
    
    // Checks if player with passed in color is a winner.
    func isWinner(color: Int) -> Bool
    {
        // Check all rows first
        for row in 0...board.count - 1
        {
            var threeInRow = true
            for col in 0...board[row].count - 1
            {
                if board[row][col] != color
                {
                    threeInRow = false
                }
            }
            if threeInRow
            {
                return true
            }
        }
        
        // Check columns next
        for col in 0...2
        {
            var threeInRow = true
            for row in 0...2
            {
                if board[row][col] != color
                {
                    threeInRow = false
                }
            }
            if threeInRow
            {
                return true
            }
        }
        
        // Check first diagonal
        if (board[0][0] == color) && board[1][1] == color && board[2][2] == color
        {
            return true
        }
        
        // Check second diagonal
        if (board[2][0] == color) && board[1][1] == color && board[0][2] == color
        {
            return true
        }
        
        // Passed in color is not a winner
        return false
    }
    
    @IBOutlet weak var winnerLabel: UILabel!
    
    @IBAction func squareButtonClicked(_ sender: UIButton) {
        // Flip color of square and mark as selected.
        sender.backgroundColor = (currentColor == 0 ? UIColor.blue : UIColor.red)
        setSquare(color: currentColor, tag: sender.tag)
        
        // Check if there is a winner
        if isWinner(color: currentColor)
        {
            winnerLabel.text = "Winner is \(currentColor == 0 ? "blue" : "red")!"
            winnerLabel.isHidden = false
        }
        
        // Switch active player
        currentColor = (currentColor == 0 ? 1 : 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBoard()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func resetButtonPressed(_ sender: UIButton) {
       initBoard()
    }
}

