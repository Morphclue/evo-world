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
const font: DynamicFont = preload("res://ui/fonts/NESCyrillic.tres")

func _ready():
	_initUI()


func _initUI() -> void:
	for sprite in sprites:
		var h_box = HBoxContainer.new()
		var left_button = Button.new()
		var name = Label.new()
		var number = Label.new()
		var right_button = Button.new()
		
		h_box.alignment = HALIGN_CENTER
		
		name.text = sprite
		number.text = '1'
		name.add_font_override("font", font)
		number.add_font_override("font", font)
		
		left_button.icon = left_arrow
		right_button.icon = right_arrow
		left_button.set("custom_styles/normal", StyleBoxEmpty.new())
		right_button.set("custom_styles/normal", StyleBoxEmpty.new())
		left_button.set("custom_styles/hover", StyleBoxEmpty.new())
		right_button.set("custom_styles/hover", StyleBoxEmpty.new())
		left_button.set("custom_styles/focus", StyleBoxEmpty.new())
		right_button.set("custom_styles/focus", StyleBoxEmpty.new())
		
		left_button.connect("pressed", self, "_on_button_pressed", [name, number, -1])
		right_button.connect("pressed", self, "_on_button_pressed", [name, number, 1])
		
		h_box.add_child(left_button)
		h_box.add_child(name)
		h_box.add_child(number)
		h_box.add_child(right_button)
		v_box.add_child(h_box)
	
	var accept_button = Button.new()
	accept_button.add_font_override("font", font)
	accept_button.text = 'Accept'
	accept_button.set("custom_styles/normal", StyleBoxEmpty.new())
	accept_button.set("custom_styles/hover", StyleBoxEmpty.new())
	accept_button.set("custom_styles/focus", StyleBoxEmpty.new())
	accept_button.connect("pressed", self, "_accept_button_pressed")
	
	v_box.add_child(accept_button)


func _accept_button_pressed() -> void:
	Utils.switch_scene(self, world_scene)


func _on_button_pressed(_name: Label, _number: Label, _value: int) -> void:
	player.current_sprite[_name.text] += _value
	player.set_sprites()
	_number.text = str(player.current_sprite[_name.text] + 1)
