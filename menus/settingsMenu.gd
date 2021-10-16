extends Control


func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		Utils.switch_scene(self, load("res://menus/mainMenu.tscn"))
