extends KinematicBody2D

const sprites: Script = preload("res://player/sprites/sprites.gd")

var velocity: Vector2 = Vector2.ZERO

onready var ray: RayCast2D = $RayCast2D
onready var hair_sprite: Sprite = $SpriteLayer/Hair
onready var head_sprite: Sprite = $SpriteLayer/Head
onready var body_sprite: Sprite = $SpriteLayer/Body
onready var shoes_sprite: Sprite = $SpriteLayer/Shoes
onready var accessory_sprite: Sprite = $SpriteLayer/Accessory

var current_sprite: Dictionary = {
	Constants.HAIR : 0,
	Constants.HEAD : 0,
	Constants.BODY : 0,
	Constants.SHOES : 0,
	Constants.ACCESSORY : 0,
}

func _ready() -> void:
	if PlayerVariables.current_sprite:
		current_sprite = PlayerVariables.current_sprite
	set_sprites()


func _physics_process(delta: float) -> void:
	_move(delta)
	_handle_colliding()


func set_sprites() -> void:
	current_sprite.Hair = Utils.positive_mod(current_sprite.Hair, sprites.hair.size())
	current_sprite.Head = Utils.positive_mod(current_sprite.Head, sprites.head.size())
	current_sprite.Body = Utils.positive_mod(current_sprite.Body, sprites.body.size())
	current_sprite.Shoes = Utils.positive_mod(current_sprite.Shoes, sprites.shoes.size())
	current_sprite.Accessory = Utils.positive_mod(current_sprite.Accessory, sprites.accessory.size())
	
	hair_sprite.texture = sprites.hair[current_sprite.Hair]
	head_sprite.texture = sprites.head[current_sprite.Head]
	body_sprite.texture = sprites.body[current_sprite.Body]
	shoes_sprite.texture = sprites.shoes[current_sprite.Shoes]
	accessory_sprite.texture = sprites.accessory[current_sprite.Accessory]
	PlayerVariables.current_sprite = current_sprite


func _move(delta: float) -> void:
	var input: Vector2 = Vector2.ZERO
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
		velocity = velocity.move_toward(input * Constants.MAX_SPEED, Constants.ACCELERATION * delta)
		_look_in_direction(input)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, Constants.ACCELERATION * delta)
	
	velocity = move_and_slide(velocity)


func _handle_colliding() -> void:
	if !Input.is_action_just_pressed("confirm"):
		return
		
	if !ray.is_colliding():
		return
	
	var target = ray.get_collider().get_parent()
	EventBus.emit_signal("confirm_button_pressed", target)


func _look_in_direction(input: Vector2) -> void:
	var look_direction: float = -atan2(input.x, input.y)
	ray.rotation = look_direction
