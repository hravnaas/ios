//: Playground - noun: a place where people can play

import UIKit

let type: String = "Rectangle"
let description: String = "A quadrilateral with four right angles"
var width: Int = 5
var height: Double = 10.5
var area: Double = Double(width) * height
height+=1
width+=1
area = Double(width) * height
// Note how you can "interpolate" variables into Strings using the following syntax
print("The shape is a \(type) or \(description) with an area of \(area)")

let numberOfChampionships = 5
let name = "Kobe"
print("My favorite player is \(name) and he has \(numberOfChampionships) rings")
print("His jersey number is \(8 * 3)")

let myArray: Array = ["test"]

print("Max of int = \(Int32.max)")
print("Max of int = \(Int32.min)")

for i in 1...5
{
    print(i)
}

for i in 1..<5
{
    print(i)
}

var i: Int = 0
while i < 6
{
    print(i)
    i+=1
}
