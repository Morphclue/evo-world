extends Control

var cards: Array
var current_selection: int = 0

func _ready():
	for card in get_children():
		cards.append(card)


func _process(_delta: float) -> void:
	_handle_input()
	_raise_card()


func _handle_input() -> void:
	if Input.is_action_just_pressed("left"):
		self.current_selection -= 1
	if Input.is_action_just_pressed("right"):
		self.current_selection += 1


func _raise_card() -> void:
	_reset_margins()
	cards[current_selection % cards.size()].rect_position.y = 162


func _reset_margins() -> void:
	for card in cards: 
		card.rect_position.y = 172

