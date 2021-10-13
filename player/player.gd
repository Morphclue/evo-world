extends KinematicBody2D

const ACCELERATION = 500
const MAX_SPEED = 80
const sprites = preload("res://player/sprites/sprites.gd")

var velocity = Vector2.ZERO

onready var ray = $RayCast2D
onready var hairSprite = $SpriteLayer/Hair
onready var headSprite = $SpriteLayer/Head
onready var bodySprite = $SpriteLayer/Body
onready var shoesSprite = $SpriteLayer/Shoes
onready var accessorySprite = $SpriteLayer/Accessory

var currentSprite = {
	"Hair" : 0,
	"Head" : 0,
	"Body" : 0,
	"Shoes": 0,
	"Accessory" : 0
}

func _ready():
	set_sprites()


func set_sprites():
	hairSprite.texture = sprites.hair[currentSprite.Hair % sprites.hair.size()]
	headSprite.texture = sprites.head
	bodySprite.texture = sprites.body[currentSprite.Body % sprites.body.size()]
	shoesSprite.texture = sprites.shoes[currentSprite.Shoes % sprites.shoes.size()]
	accessorySprite.texture = sprites.accessory[currentSprite.Accessory % sprites.accessory.size()]


func _physics_process(delta):
	_move(delta)


func _move(delta) -> void:
	var input = Vector2.ZERO
	if Input.is_action_pressed("right"):
		input.x += 1
	if Input.is_action_pressed("left"):
		input.x -= 1
	if Input.is_action_pressed("down"):
		input.y += 1
	if Input.is_action_pressed("up"):
		input.y -= 1
	input = input.normalized()
	
	if input != Vector2.ZERO:
		velocity = velocity.move_toward(input * MAX_SPEED, ACCELERATION * delta)
		_look_in_direction(input)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, ACCELERATION * delta)
	
	velocity = move_and_slide(velocity)


func _look_in_direction(input) -> void:
	var look_direction = atan2(-input.x, input.y)
	ray.rotation = look_direction
