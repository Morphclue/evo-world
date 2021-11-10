extends Control

export var card_name: String
export var card_description: String
export var mana_points: int
onready var card_name_label: Label = $VBoxContainer/HBoxContainer/cardName
onready var card_name_description: Label = $VBoxContainer/description
onready var mana_label: Label = $VBoxContainer/HBoxContainer/mana

func _ready():
	card_name_label.text = card_name
	card_name_description.text = card_description
	mana_label.text = str(mana_points)
