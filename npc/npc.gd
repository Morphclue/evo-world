extends Node2D

onready var sprite: AnimatedSprite = $animatedSprite
onready var trigger: Area2D = $triggerZone
onready var button: Control = $button

func _ready() -> void:
	sprite.play()


func _on_triggerZone_player_entered(value) -> void:
	button.visible = value
