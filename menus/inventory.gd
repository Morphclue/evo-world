extends Control

const PANEL_MIN_SIZE_X: int = 95
const PANEL_MIN_SIZE_Y: int = 20
const INVENTORY_SIZE: int = 10

const font: DynamicFont = preload("res://menus/NESCyrillic.tres")
onready var grid_container: GridContainer = $vBox/control/gridContainer
onready var description: Label = $vBox/hBox/panelContainer/description

var items: Array = []
var select_position: int = 0 setget _set_select_position
signal hover_changed

func _ready():
	_load_items()
	_load_dummy_items()
	_load_ui()
	_init_signals()
	_select_hover()


func _process(_delta):
	_handle_input()


func _init_signals():
	var error_code = self.connect("hover_changed", self, "_select_hover")
	if error_code != OK:
		print("Failed to connect hover_changed")


func _set_select_position(value):
	select_position = value
	emit_signal("hover_changed")


func _handle_input():
	if Input.is_action_just_pressed("ui_down"):
		self.select_position = (select_position + 1)  % INVENTORY_SIZE
	if Input.is_action_just_pressed("ui_up"):
		self.select_position = (select_position - 1)  % INVENTORY_SIZE


func _select_hover():
	var position = abs(select_position)
	var label: Label = grid_container.get_child(position).get_child(0)
	
	for child in grid_container.get_children():
		child.get_child(0).add_color_override("font_color", Color(1,1,1,1))
	label.add_color_override("font_color", Color(1,1,0,1))
	description.text = items[select_position].description


func _load_items() -> void:
	items = PlayerVariables.item_list.duplicate()


func _load_dummy_items() -> void:
	var apple: Item = Item.new("Apple", "Delicious! (Adds +20 food)")
	items.append(apple)
	
	for i in range(INVENTORY_SIZE - 1):
		var item_name = "Item " + str(i + 1)
		var desc = "Desc: " + str(i + 1)
		var item: Item = Item.new(item_name, desc)
		items.append(item)


func _load_ui() -> void:
	for item in items:
		var panel_container: PanelContainer = PanelContainer.new()
		panel_container.rect_min_size = Vector2(PANEL_MIN_SIZE_X, PANEL_MIN_SIZE_Y)
		
		var label: Label = Label.new()
		var unique_font = font.duplicate()
		unique_font.size = 8
		label.add_font_override("font", unique_font)
		label.text = item.item_name
		label.align = Label.ALIGN_CENTER
		
		panel_container.add_child(label)
		grid_container.add_child(panel_container)


func _on_back_pressed():
	var parent: Node = get_parent()
	queue_free()
	parent.remove_child(self)
