extends Control

const Player = preload("res://player.gd")

var deck: Array[Card]

var current_player = 0
var number_of_players

@onready var dealer = $Dealer
@onready var card_shoe = $CardShoe
@onready var button = $Button

@export_range(1, 7) var number_of_decks = 1
@export_range(0, 100) var reshuffle_at_percentage = 10

@onready var reshuffle_at = number_of_decks * 52 * reshuffle_at_percentage / 100.0


func _ready():
	create_deck()
	var player_nodes = get_tree().get_nodes_in_group("players")
	number_of_players = player_nodes.size()

	for player in player_nodes:
		player.connect("hitting", Callable(self, "deal_card"))
		player.connect("standing", Callable(self, "standing"))
		player.connect("doubling_down", Callable(self, "doubling_down"))
		player.connect("busted", Callable(self, "busted"))

	deal_new_hand()


func create_deck():
	var cards: Array[Card] = []
	for i in range(number_of_decks):
		for suit in Global.CardSuit:
			for value in Global.CardValue:
				var card = Card.new()
				card.suit = Global.CardSuit[suit]
				card.value = Global.CardValue[value]
				cards.append(card)

	card_shoe.number_of_cards = cards.size()
	card_shoe.create()

	randomize()
	cards.shuffle()

	deck = cards


func deal_card(player: Player, is_double: bool = false):
	card_shoe.remove_first_card()

	var card = deck.pop_back()
	player.get_dealt(card, is_double)


func standing(player: Player):
	player.is_current = false

	if (current_player + 1) == number_of_players:
		hand_is_over()
		return

	current_player = (current_player + 1) % number_of_players

	var current_player_instance = get_tree().get_nodes_in_group("players")[current_player]
	current_player_instance.start_turn()


func doubling_down(player: Player):
	deal_card(player, true)
	standing(player)


func busted(player: Player):
	standing(player)


func deal_new_hand():
	if deck.size() <= reshuffle_at:
		create_deck()

	for i in range(2):
		for player in get_tree().get_nodes_in_group("players"):
			player.is_current = false
			deal_card(player)

	current_player = 0
	var current_player_instance = get_tree().get_nodes_in_group("players")[current_player]
	current_player_instance.start_turn()


func hand_is_over():
	button.visible = true


func new_hand():
	button.visible = false
	for player in get_tree().get_nodes_in_group("players"):
		player.reset_hand()
	deal_new_hand()


func _on_button_pressed():
	new_hand()
