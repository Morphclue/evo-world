extends Control

const world_scene = preload("res://world.tscn")
const settings_scene = preload("res://menus/settingsMenu.tscn")

onready var start = $centerContainer/container/options/start
onready var settings = $centerContainer/container/options/settings
onready var exit = $centerContainer/container/options/exit

var options
var current_selection = 0

func _ready():
	options = [start, settings, exit]
	start.add_color_override("font_color", Color(1,1,0,1))


func _process(_delta):
	if Input.is_action_just_pressed("ui_down"):
		_hover(1)
	elif Input.is_action_just_pressed("ui_up"):
		_hover(-1)
	elif Input.is_action_just_pressed("ui_accept"):
		_select()


func _select() -> void:
	if current_selection == 0:
		_switch_scene(world_scene)
	elif current_selection == 1:
		_switch_scene(settings_scene)
	elif current_selection == 2:
		get_tree().quit()


func _switch_scene(scene):
	get_parent().add_child(scene.instance())
	queue_free()


func _hover(value: int) -> void:
	current_selection += value
	current_selection = current_selection % 3 
	
	for option in options:
		option.add_color_override("font_color", Color(1,1,1,1))
	
	options[current_selection].add_color_override("font_color", Color(1,1,0,1))
	pass
