import UIKit

// 1.
for i in 1...255
{
    //print(i)
}
print("\n")

// 2.
for i in 1...100
{
    if (i % 3 == 0 || i % 5 == 0) && !(i % 3 == 0 && i % 5 == 0)
    {
        //print(i)
    }
}
print("\n")

// 3.
for i in 1...100
{
    if (i % 3 == 0 && i % 5 == 0)
    {
        print("\(i): FizzBuzz")
    }
    else if i % 3 == 0
    {
        print("\(i): Fizz")
    }
    else if i % 5 == 0
    {
        print("\(i): Buzz")
    }
}

var myArr: [String] = [String]()
myArr.append("test")
myArr.append("more")
print(myArr[0...1])
print("\(myArr[0...1])")
//myArr.remove(at: 1)
myArr.insert("testing", at:0);



