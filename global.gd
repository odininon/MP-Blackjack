extends Node

enum CardSuit {
	Spade,
	Clubs,
	Diamonds,
	Hearts,
}

enum CardValue {
	Ace,
	Two,
	Three,
	Four,
	Five,
	Six,
	Seven,
	Eight,
	Nine,
	Ten,
	Jack,
	Queen,
	King,
}


func card_suit_to_string(suit: CardSuit):
	match suit:
		CardSuit.Spade:
			return "spades"
		CardSuit.Clubs:
			return "clubs"
		CardSuit.Diamonds:
			return "diamonds"
		CardSuit.Hearts:
			return "hearts"


func card_value_to_string(value: CardValue):
	match value:
		CardValue.Ace:
			return "ace"
		CardValue.Two:
			return "2"
		CardValue.Three:
			return "3"
		CardValue.Four:
			return "4"
		CardValue.Five:
			return "5"
		CardValue.Six:
			return "6"
		CardValue.Seven:
			return "7"
		CardValue.Eight:
			return "8"
		CardValue.Nine:
			return "9"
		CardValue.Ten:
			return "10"
		CardValue.Jack:
			return "jack"
		CardValue.Queen:
			return "queen"
		CardValue.King:
			return "king"

func get_numerical_value(card: Card):
	match card.value:
		CardValue.Ace:
			return 0
		CardValue.Two:
			return 2
		CardValue.Three:
			return 3
		CardValue.Four:
			return 4
		CardValue.Five:
			return 5
		CardValue.Six:
			return 6
		CardValue.Seven:
			return 7
		CardValue.Eight:
			return 8
		CardValue.Nine:
			return 9
		CardValue.Ten:
			return 10
		CardValue.Jack:
			return 10
		CardValue.Queen:
			return 10
		CardValue.King:
			return 10
