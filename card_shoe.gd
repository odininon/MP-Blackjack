extends Node2D

var number_of_cards = 52 * 4

@export var card_back: Resource


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func create():
	for i in range(number_of_cards):
		var card = card_back.instantiate()
		card.position.x -= i * 1
		add_child(card)


func remove_first_card():
	var children = get_children()
	children[children.size() - 1].free()
