extends Control

@onready var container = $VBoxContainer

@export var known_card: Resource
@export var unknown_card: Resource


func add_known(card: Card, is_double: bool):
	var card_item = known_card.instantiate()
	card_item.card = card
	card_item.is_double = is_double
	container.add_child(card_item)


func add_unknown(_card: Card):
	var card_item = unknown_card.instantiate()
	container.add_child(card_item)
