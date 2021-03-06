extends Control

onready var v_box: VBoxContainer = $centerContainer/vBoxContainer
onready var player: Node2D = $player
const sprites: Array = [
	Constants.HAIR,
	Constants.HEAD,
	Constants.BODY,
	Constants.SHOES,
	Constants.ACCESSORY,
]

const world_scene: PackedScene = preload("res://world.tscn")
const left_arrow: StreamTexture = preload("res://ui/menus/sprites/arrowl.png")
const right_arrow: StreamTexture = preload("res://ui/menus/sprites/arrow.png")

var current_selection: int = 1 setget _set_selection

func _ready() -> void:
	_initUI()
	_hover()


func _process(_delta: float) -> void:
	_handle_input()


func _handle_input() -> void:
	if Input.is_action_just_pressed("ui_up"):
		self.current_selection -= 1
	if Input.is_action_just_pressed("ui_down"):
		self.current_selection += 1
	if Input.is_action_just_pressed("ui_left"):
		_simulate_button_press(-1)
	if Input.is_action_just_pressed("ui_right"):
		_simulate_button_press(1)
	if Input.is_action_just_pressed("ui_accept"):
		_accept_button_pressed()


func _simulate_button_press(value: int) -> void:
	var option: Label = v_box.get_child(current_selection).get_child(1)
	var number: Label = v_box.get_child(current_selection).get_child(2)
	_on_button_pressed(option, number, value)


func _set_selection(value: int) -> void:
	current_selection = value
	current_selection = int(clamp(current_selection, 1, sprites.size() + 1))
	_hover()


func _initUI() -> void:
	for sprite in sprites:
		var h_box: HBoxContainer = HBoxContainer.new()
		var left_button: Button = Button.new()
		var option: Label = Label.new()
		var number: Label = Label.new()
		var right_button: Button = Button.new()
		
		h_box.alignment = HALIGN_CENTER
		
		option.text = sprite
		number.text = '1'
		
		left_button.icon = left_arrow
		right_button.icon = right_arrow
		left_button.set("custom_styles/normal", StyleBoxEmpty.new())
		right_button.set("custom_styles/normal", StyleBoxEmpty.new())
		left_button.set("custom_styles/hover", StyleBoxEmpty.new())
		right_button.set("custom_styles/hover", StyleBoxEmpty.new())
		left_button.set("custom_styles/focus", StyleBoxEmpty.new())
		right_button.set("custom_styles/focus", StyleBoxEmpty.new())
		
		var _err1: int = left_button.connect(
			"pressed",
			self,
			"_on_button_pressed",
			[option, number, -1]
		)
		var _err2: int =  right_button.connect(
			"pressed",
			self,
			"_on_button_pressed",
			[option, number, 1]
		)
		
		h_box.add_child(left_button)
		h_box.add_child(option)
		h_box.add_child(number)
		h_box.add_child(right_button)
		v_box.add_child(h_box)
	
	var accept_button: Button = Button.new()
	accept_button.text = 'Accept'
	accept_button.set("custom_styles/normal", StyleBoxEmpty.new())
	accept_button.set("custom_styles/hover", StyleBoxEmpty.new())
	accept_button.set("custom_styles/focus", StyleBoxEmpty.new())
	var _err: int = accept_button.connect("pressed", self, "_accept_button_pressed")
	
	v_box.add_child(accept_button)


func _hover() -> void:
	_clear_hover()
	
	if current_selection == sprites.size() + 1:
		v_box.get_child(current_selection).modulate = Constants.YELLOW
		return
	
	var option: Label = v_box.get_child(current_selection).get_child(1)
	var number: Label = v_box.get_child(current_selection).get_child(2)
	
	option.add_color_override("font_color", Constants.YELLOW)
	number.add_color_override("font_color", Constants.YELLOW)


func _clear_hover() -> void:
	for count in range(1, v_box.get_children().size() - 1):
		var option: Label = v_box.get_child(count).get_child(1)
		var number: Label = v_box.get_child(count).get_child(2)
		option.add_color_override("font_color", Constants.WHITE)
		number.add_color_override("font_color", Constants.WHITE)
	v_box.get_child(sprites.size() + 1).modulate = Constants.WHITE


func _accept_button_pressed() -> void:
	Utils.switch_scene(self, world_scene)


func _on_button_pressed(option: Label, number: Label, value: int) -> void:
	player.current_sprite[option.text] += value
	player.set_sprites()
	number.text = str(player.current_sprite[option.text] + 1)
