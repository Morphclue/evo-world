extends Node

class_name Quest

var description: String
var is_main_quest: bool

func _init(_description: String, _is_main_quest: bool):
	self.description = description
	self.is_main_quest = is_main_quest
