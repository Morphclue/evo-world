extends Node2D

func _ready():
	pass


func _on_Button_pressed():
	Utils.switch_scene(self, Utils.world_scene)
