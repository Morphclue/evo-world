extends Node

class_name Quest

var title: String
var description: String

func _init(_title: String, _description: String) -> void:
	self.title = _title
	self.description = _description
