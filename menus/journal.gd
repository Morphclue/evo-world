extends Control

var quests: Array = []
onready var item_list: ItemList = $vBox/itemList
onready var description: Label = $vBox/hBox/panelContainer/description
onready var back: Button = $vBox/hBox/back

func _ready():
	_load_quests()
	_load_ui()


func _load_quests():
	quests = PlayerVariables.quest_list


func _load_ui():
	pass
