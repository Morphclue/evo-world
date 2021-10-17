extends Control

var quests: Array = []

func _ready():
	_load_quests()
	pass


func _load_quests():
	quests = PlayerVariables.quest_list
