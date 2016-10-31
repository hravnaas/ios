
import UIKit

// Simulates a coin tass
func tossCoin() -> String
{
    //print("Tossing a Coin!")
    let tossResult = Int(arc4random_uniform(2))
    return tossResult == 1 ? "Heads" : "Tails"
}

// Run a coin toss a given number of times
func tossMultipleCoins(numCoinToss: Int) -> Double
{
    var numHeads: Double = 0
    for _ in 1...numCoinToss
    {
        if tossCoin() == "Heads"
        {
            print("Heads")
            numHeads += 1;
        }
        else
        {
            print("Tails")
        }
    }
    
    return numHeads / Double(numCoinToss)
}

// Test code
//var coinTossResult: String = tossCoin()
//print(coinTossResult)

print(tossMultipleCoins(numCoinToss: 3))

