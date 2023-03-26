extends Control

var is_current = false

signal hitting
signal standing
signal splitting
signal doubling_down
signal busted

@onready var card_stacks = $CardStacks
@onready var buttons = $Buttons

var cards: Array[Card] = []
var current_stack

func _to_string():
	return "Player"

func _ready():
	reset_hand()
	buttons.visible = false

func _process(_delta):
	buttons.visible = is_current

func get_dealt(card: Card, is_double: bool):
	cards.append(card)
	current_stack.add_known(card, is_double)
	
	if get_total() > 21:
		busted.emit(self)

func start_turn():
	is_current = true

func reset_hand():
	cards = []
	for i in card_stacks.get_children():
		i.free()
	current_stack = load("res://card_stack.tscn").instantiate()
	card_stacks.add_child(current_stack)

func get_total():
	var includes_ace = false
	var total = 0
	
	for card in cards:
		total += Global.get_numerical_value(card)
		if card.value == Global.CardValue.Ace:
			includes_ace = true
	
	if includes_ace:
		if total + 11 > 21:
			total += 1
		else:
			total += 11

	return total

func _on_hit_button_pressed():
	hitting.emit(self)

func _on_stand_button_pressed():
	standing.emit(self)

func _on_double_button_pressed():
	doubling_down.emit(self)

func _on_split_button_pressed():
	splitting.emit(self)
