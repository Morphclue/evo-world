extends Control

onready var sprite: AnimatedSprite = $animatedSprite

func _ready() -> void:
	sprite.play()
