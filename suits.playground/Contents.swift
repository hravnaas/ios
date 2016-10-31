import UIKit

let suits = ["Clubs", "Diamonds", "Hearts", "Spades"]
let cards = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
var deckOfCards = [String: [Int]]()

for suit in suits
{
    deckOfCards[suit] = cards
}

// Testing
//deckOfCards["Clubs"]?.remove(at: 3)
print(deckOfCards)

//var dict: [String: Int] = [String: Int]()
//var myDict = ["test": 2]
//var result = myDict["test"]
//var result2 = myDict["test"]
//print(result2)
//
//if let unwrapped = result2
//{
//    print(unwrapped)
//}
////myDict.removeValue(forKey: "test")
//for (key, value) in myDict
//{
//    print("Key is \(key) and value is \(value)")
//}
//
//for x in myDict
//{
//    print(x)
//}
