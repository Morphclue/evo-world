extends KinematicBody2D

const ACCELERATION: int = 500
const MAX_SPEED: int = 80
const sprites: Script = preload("res://player/sprites/sprites.gd")

var velocity = Vector2.ZERO

onready var ray = $RayCast2D
onready var hair_sprite = $SpriteLayer/Hair
onready var head_sprite= $SpriteLayer/Head
onready var body_sprite = $SpriteLayer/Body
onready var shoes_sprite = $SpriteLayer/Shoes
onready var accessory_sprite = $SpriteLayer/Accessory

var current_sprite = {
	"Hair" : 0,
	"Head" : 0,
	"Body" : 0,
	"Shoes": 0,
	"Accessory" : 0
}

func _ready():
	set_sprites()


func _physics_process(delta):
	_move(delta)


func set_sprites() -> void:
	current_sprite.Hair = current_sprite.Hair % sprites.hair.size()
	current_sprite.Head = 0
	current_sprite.Body = current_sprite.Body % sprites.body.size()
	current_sprite.Shoes = current_sprite.Shoes % sprites.shoes.size()
	current_sprite.Accessory = current_sprite.Accessory % sprites.accessory.size()
	
	hair_sprite.texture = sprites.hair[current_sprite.Hair]
	head_sprite.texture = sprites.head
	body_sprite.texture = sprites.body[current_sprite.Body]
	shoes_sprite.texture = sprites.shoes[current_sprite.Shoes]
	accessory_sprite.texture = sprites.accessory[current_sprite.Accessory]


func _move(delta: float) -> void:
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


func _look_in_direction(input: Vector2) -> void:
	var look_direction = atan2(-input.x, input.y)
	ray.rotation = look_direction
