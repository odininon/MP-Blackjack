extends "res://player.gd"


func _ready():
	super._ready()


func _process(delta):
	super._process(delta)


func get_dealt(card: Card, is_double: bool):
	cards.append(card)
	if cards.size() == 2:
		current_stack.add_unknown(card)
	else:
		current_stack.add_known(card, is_double)

	if is_current:
		if get_total() < 17:
			hitting.emit(self)
		elif get_total() > 21:
			show_full_hand()
			busted.emit(self)
		else:
			show_full_hand()
			standing.emit(self)


func _to_string():
	return "Dealer"


func show_full_hand():
	for i in card_stacks.get_children():
		i.free()
	current_stack = load("res://card_stack.tscn").instantiate()
	card_stacks.add_child(current_stack)

	for card in cards:
		current_stack.add_known(card, false)


func start_turn():
	super.start_turn()
	if get_total() < 17:
		hitting.emit(self)
	else:
		show_full_hand()
		standing.emit(self)
