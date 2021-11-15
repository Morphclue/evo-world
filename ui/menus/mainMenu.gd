extends Control

const char_selection_scene: PackedScene = preload("res://ui/menus/characterSelection.tscn")
const settings_scene: PackedScene = preload("res://ui/menus/settingsMenu.tscn")

onready var start: Label = $centerContainer/container/options/start
onready var settings: Label = $centerContainer/container/options/settings
onready var exit: Label = $centerContainer/container/options/exit

var options: Array = []
var current_selection: int = 0

func _ready() -> void:
	options = [start, settings, exit]
	start.add_color_override("font_color", Constants.YELLOW)


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_down"):
		_hover(1)
	elif Input.is_action_just_pressed("ui_up"):
		_hover(-1)
	elif Input.is_action_just_pressed("ui_accept"):
		_select()


func _select() -> void:
	if current_selection == 0:
		Utils.switch_scene(self, char_selection_scene)
	elif current_selection == 1:
		Utils.switch_scene(self, settings_scene)
	elif current_selection == 2:
		get_tree().quit()


func _hover(value: int) -> void:
	current_selection += value
	if current_selection < 0:
		current_selection += 3
	current_selection = current_selection % 3 
	
	for option in options:
		option.add_color_override("font_color", Constants.WHITE)
	
	options[current_selection].add_color_override("font_color", Constants.YELLOW)
