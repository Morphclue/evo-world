extends Node

class_name Item

var item_name: String
var description: String

func _init(_item_name: String, _description: String) -> void:
	self.item_name = _item_name
	self.description = _description
