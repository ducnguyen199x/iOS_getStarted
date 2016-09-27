//Similar to enum and struct in C (in term of usage)

enum Rank: Int {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
    func simpleDescription() -> String {
        switch self {
        case .ace:
            return "ace"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}
let jack = Rank.jack
let jackRawValue = jack.rawValue
Rank.two.simpleDescription() //default
Rank.ace.simpleDescription() // case .ace

//function that compares two Rank values by comparing their raw values
func compareRank(rank1: Rank, rank2: Rank) -> Int{
    if(rank1.rawValue > rank2.rawValue){
        return 1
    }
    else if(rank1.rawValue < rank2.rawValue){
        return 2
    }
    else{
        return 0
    }
}

compareRank(rank1: Rank.ace, rank2: Rank.king)

//make an instance of an enumeration from a raw value. (init?rawValue:)

if let convertedRank = Rank(rawValue: 3) {
    let threeDescription = convertedRank.simpleDescription()
}
//---
enum Suit: Int {
    case spades, hearts, diamonds, clubs
    func simpleDescription() -> String {
        switch self {
        case .spades:
            return "spades"
        case .hearts:
            return "hearts"
        case .diamonds:
            return "diamonds"
        case .clubs:
            return "clubs"
        }
    }
    
    func color() -> String {
        switch self {
        case .spades, .clubs:
            return "black"
        case .diamonds, .hearts:
            return "red"
        }
    }
}
    
let hearts = Suit.hearts
let heartsDescription = hearts.simpleDescription()
let heartsColor = hearts.color()


//Structure
//structures are always copied when they are passed around in your code, but classes are passed by reference.
struct Card {
    var rank: Rank
    var suit: Suit
//    init(rank: Rank, suit: Suit) {
//        self.rank = rank
//        self.suit = suit
//    }
    func simpleDescription() -> String {
        return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
    }
    
    func createDeck() -> [Card] {
        var deck = [Card]()
        var n = 1
        while let rank = Rank(rawValue: n){
            var m = 1
            while let suit = Suit(rawValue: m){
                deck.append(Card(rank: rank, suit: suit))
                m += 1
            }
            n += 1
        }
        return deck
    }
}
let threeOfSpades = Card(rank: .three, suit: .spades)
let threeOfSpadesDescription = threeOfSpades.simpleDescription()
let deck = threeOfSpades.createDeck()


//instance of an enumeration case
enum ServerResponse {
    case result(String, String)//instance can have different value
    case failure(String)
    case rain(Bool)
}

let success = ServerResponse.result("6:00 am", "8:09 pm")
let failure = ServerResponse.failure("Out of cheese.")
let rain = ServerResponse.rain(true)

switch rain {
case let .result(sunrise, sunset):
    print("Sunrise is at \(sunrise) and sunset is at \(sunset).")
case let .failure(message):
    print("Failure...  \(message)")
case let .rain(message):
    print("Rain today: \(message)")
}

