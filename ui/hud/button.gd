extends Control

onready var sprite: AnimatedSprite = $animatedSprite

func _ready():
	sprite.play()
