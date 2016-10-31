import UIKit

struct Card
{
    //Give the Card struct a property "value" which will hold the value of the card (A, 2, 3, 4, 5, 6, 7, 8, 9, 10, J, Q, K).
    var value: String
    
    //Give the Card a property "Suit" which will hold the suit of the card (Clubs, Spades, Hearts, Diamonds)
    var suit: String
    
    //Give the Card a property "numerical_value" which will hold the numerical value of the card 1-13
    var numerical_value: Int
}

class Deck
{
    //When initializing the deck make sure that it has the 52 unique cards in its "cards" property
    var cards: [Card]
    let suits = ["Clubs", "Spades", "Hearts", "Diamonds"]
    let values = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
    
    init()
    {
        self.cards = []
        self.reset()
    }
    
    //Give the Deck a deal method that selects the "top-most" card, removes it, and returns it
    func deal() -> Card
    {
        let topCard = self.cards.removeLast()
        return topCard
    }
    
    //Give the Deck a reset method that resets the cards property to the contain the original 52 cards
    func reset()
    {
        for s in suits
        {
            for v in 0...values.count - 1
            {
                self.cards.append(Card(value: values[v], suit: s, numerical_value: v))
            }
        }
    }
    
    //Give the Deck a shuffle method that randomly reorders the deck's cards
    func shuffle()
    {
        let NUM_SHUFFLES = 100
        let cardsInDeck = self.cards.count
        
        for _ in 1...NUM_SHUFFLES
        {
            // Get two random numbers
            let randomNum1 = Int(arc4random_uniform(UInt32(cardsInDeck)))
            let randomNum2 = Int(arc4random_uniform(UInt32(cardsInDeck)))
            
            // Swap array values for those two array locations
            let temp = self.cards[randomNum1]
            self.cards[randomNum1] = self.cards[randomNum2]
            self.cards[randomNum2] = temp
        }
    }
}

class Player
{
    //Give the Player class a name property
    var name: String
    
    //Give the Player a hand property of type [Card]
    var hand: [Card]
    
    init(name: String)
    {
        self.name = name
        self.hand = []
    }
    
    //Give the Player a draw method of type (Deck) -> Card which draws a card from a deck, adds it to the players hand, and returns it
    //Note how we are passing the Deck by reference here since it is a class.
    func draw(deck: Deck) -> Card
    {
        let dealtCard = deck.deal()
        self.hand.append(dealtCard)
        return dealtCard
    }
    
    //Give the Player a discard method of type (Card) -> Bool which discards the Card specified and returns True if the Card existed and
    // was successfully removed or False if the Card was not in the player's hand.
    func discard(card: Card) -> Bool
    {
        for c in self.hand
        {
            if c.numerical_value == card.numerical_value && c.suit == card.suit
            {
                return true
            }
        }
        return false
    }
}

////// Run code ///////
var myDeck = Deck()
var player1 = Player(name: "Hans")
var newCard = player1.draw(deck: myDeck)
//print(newCard)

