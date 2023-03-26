extends Control

var card: Card
var is_double: bool

@onready var texture_rect = $CardImage


func _ready():
	texture_rect.texture = load(card.get_sprite())
	if is_double:
		texture_rect.rotation = deg_to_rad(90)
		texture_rect.position.x = 125
