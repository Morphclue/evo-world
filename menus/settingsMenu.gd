extends Control

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_parent().add_child(load("res://menus/mainMenu.tscn").instance())
		queue_free()
