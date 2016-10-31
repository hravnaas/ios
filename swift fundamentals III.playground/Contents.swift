import UIKit
let MAX_ITEMS: UInt32 = 255
let NUM_SHUFFLES = 100

var arr = [Int]()
for i in 1...MAX_ITEMS
{
    arr.append(Int(i))
}

for i in 1...NUM_SHUFFLES
{
    // Get two random numbers
    let randomNum1 = Int(arc4random_uniform(MAX_ITEMS))
    let randomNum2 = Int(arc4random_uniform(MAX_ITEMS))

    // Swap array values for those two array locations
    let temp = arr[randomNum1]
    arr[randomNum1] = arr[randomNum2]
    arr[randomNum2] = temp
}

for i in 1...NUM_SHUFFLES
{
    if(arr[i] == 42)
    {
        print("Found 42 at location \(i)")
        arr.remove(at: i)
    }
}

// print result
print(arr)
