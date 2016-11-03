import UIKit

var s: String = String(33)
//print(s)
//print(Int(String(s[s.startIndex]))! - 1)
//print(Int(String(s[s.index(before: s.endIndex)]))! - 1)


var board: [[Int]] = [[-1, -1, -1], [-1, -1, -1], [-1, -1, -1]]

func initBoard() -> Void
{
    for row in 0...board.count - 1
    {
        for col in 0...board[row].count - 1
        {
            board[row][col] = -1
        }
    }
}

initBoard()

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

func setSquare(color: Int, tag: Int) -> Void
{
    // First translate tag to x and y coordinates
    // TODO: Do better boundary checking.
    let tagString = String(tag)
    let x = Int(String(tagString[tagString.startIndex]))! - 1
    let y = Int(String(tagString[tagString.index(before: tagString.endIndex)]))! - 1
    
    board[y][x] = color
}

// Check if player with passed in color is a winner
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

//setSquare(color: 1, tag: 11)
//setSquare(color: 1, tag: 12)
//setSquare(color: 1, tag: 13)

//setSquare(color: 1, tag: 13)
//setSquare(color: 1, tag: 23)
//setSquare(color: 1, tag: 33)

//setSquare(color: 1, tag: 11)
//setSquare(color: 1, tag: 22)
//setSquare(color: 1, tag: 33)

setSquare(color: 1, tag: 13)
setSquare(color: 1, tag: 22)
setSquare(color: 1, tag: 31)


printBoard()

print(isWinner(color: 1))
//print(isWinner(color: 0))
