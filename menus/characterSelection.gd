extends Control

onready var vBoxContainer = $centerContainer/vBoxContainer
onready var player = $player
const sprites = ['Hair', 'Head', 'Body', 'Shoes', 'Accessory']

const leftArrow = preload("res://menus/sprites/arrowl.png")
const rightArrow = preload("res://menus/sprites/arrow.png")
const font = preload("res://menus/NESCyrillic.tres")


func _ready():
	_initUI()


func _initUI() -> void:
	for sprite in sprites:
		var hBox = HBoxContainer.new()
		var leftButton = Button.new()
		var name = Label.new()
		var number = Label.new()
		var rightButton = Button.new()
		
		hBox.alignment = HALIGN_CENTER
		
		name.text = sprite
		number.text = '1'
		name.add_font_override("font", font)
		number.add_font_override("font", font)
		
		leftButton.icon = leftArrow
		rightButton.icon = rightArrow
		leftButton.set("custom_styles/normal", StyleBoxEmpty.new())
		rightButton.set("custom_styles/normal", StyleBoxEmpty.new())
		leftButton.set("custom_styles/hover", StyleBoxEmpty.new())
		rightButton.set("custom_styles/hover", StyleBoxEmpty.new())
		leftButton.set("custom_styles/focus", StyleBoxEmpty.new())
		rightButton.set("custom_styles/focus", StyleBoxEmpty.new())
		
		leftButton.connect("pressed", self, "_on_button_pressed", [name, number, -1])
		rightButton.connect("pressed", self, "_on_button_pressed", [name, number, 1])
		
		hBox.add_child(leftButton)
		hBox.add_child(name)
		hBox.add_child(number)
		hBox.add_child(rightButton)
		vBoxContainer.add_child(hBox)
	
	var acceptButton = Button.new()
	acceptButton.add_font_override("font", font)
	acceptButton.text = 'Accept'
	acceptButton.set("custom_styles/normal", StyleBoxEmpty.new())
	acceptButton.set("custom_styles/hover", StyleBoxEmpty.new())
	acceptButton.set("custom_styles/focus", StyleBoxEmpty.new())
	
	vBoxContainer.add_child(acceptButton)


func _on_button_pressed(_name: Label, _number: Label, _value: int) -> void:
	player.currentSprite[_name.text] += _value
	player.set_sprites()
	_number.text = str(player.currentSprite[_name.text] + 1)
