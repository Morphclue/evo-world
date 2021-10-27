extends Node2D

onready var sprite: AnimatedSprite = $animatedSprite
onready var trigger: Area2D = $triggerZone
onready var button: Control = $button

const minimap_icon = Constants.QUEST_ICON

func _ready() -> void:
	sprite.play()
	_init_signals()


func _init_signals() -> void:
	var error_code = EventBus.connect("confirm_button_pressed", self, "_start_dialogue")
	if error_code != OK:
		print("Failed to connect confirm_button_pressed")


func _start_dialogue(target):
	if self != target:
		return
	EventBus.emit_signal("start_dialogue", "train")


func _on_triggerZone_player_entered(value: bool) -> void:
	button.visible = value
