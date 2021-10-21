extends Control

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		Utils.switch_scene(self, load("res://ui/menus/mainMenu.tscn"))
