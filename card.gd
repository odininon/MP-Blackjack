class_name Card

var suit: Global.CardSuit
var value: Global.CardValue


func get_sprite():
	var suit_string = Global.card_suit_to_string(suit)
	var value_string = Global.card_value_to_string(value)

	return "res://assets/cards/%s_of_%s.png" % [value_string, suit_string]


func _to_string():
	return "suit: %s - value: %s" % [suit, value]
