extends Control

const world_scene = preload("res://world.tscn")

onready var start = $background/centerContainer/container/options/start
onready var settings = $background/centerContainer/container/options/settings
onready var exit = $background/centerContainer/container/options/exit

var options
var current_selection = 0

func _ready():
	options = [start, settings, exit]
	start.add_color_override("font_color", Color(1,1,0,1))


func _process(delta):
	if Input.is_action_just_pressed("ui_down") and current_selection < 2:
		current_selection += 1
		_hover(current_selection)
	elif Input.is_action_just_pressed("ui_up") and current_selection > 0:
		current_selection -= 1
		_hover(current_selection)
	elif Input.is_action_just_pressed("ui_accept"):
		_select(current_selection)


func _select(_current_selection: int) -> void:
	if current_selection == 0:
		get_parent().add_child(world_scene.instance())
		queue_free()
	elif _current_selection == 1:
		print("TODO OPTIONS")
	elif _current_selection == 2:
		get_tree().quit()


func _hover(_current_selection: int) -> void:
	for option in options:
		option.add_color_override("font_color", Color(1,1,1,1))
	
	options[_current_selection].add_color_override("font_color", Color(1,1,0,1))
	pass
