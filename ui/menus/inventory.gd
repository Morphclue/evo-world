extends Control

const font: DynamicFont = preload("res://ui/fonts/NESCyrillic.tres")
onready var grid_container: GridContainer = $vBox/control/gridContainer
onready var description: Label = $vBox/hBox/panelContainer/description

var items: Array = []
var right_side: bool = false
var select_position: int = 0 setget _set_select_position
signal hover_changed

func _ready() -> void:
	_load_items()
	_load_dummy_items()
	_load_ui()
	_init_signals()
	_select_hover()


func _process(_delta) -> void:
	_handle_input()


func _init_signals() -> void:
	var error_code = self.connect("hover_changed", self, "_select_hover")
	if error_code != OK:
		print("Failed to connect hover_changed")


func _set_select_position(value) -> void:
	select_position = value
	emit_signal("hover_changed")


func _handle_input() -> void:
	if Input.is_action_just_pressed("ui_down"):
		#warning-ignore:integer_division
		self.select_position = (select_position + 1)  % (Constants.INVENTORY_SIZE / 2)
	if Input.is_action_just_pressed("ui_up"):
		#warning-ignore:integer_division
		self.select_position = (select_position - 1)  % (Constants.INVENTORY_SIZE / 2)
	if Input.is_action_just_pressed("ui_right") or Input.is_action_just_pressed("ui_left"):
		right_side = !right_side
		emit_signal("hover_changed")


func _select_hover() -> void:
	var position: int = int(abs(select_position) * 2)
	if right_side:
		position += 1
	var label: Label = grid_container.get_child(position).get_child(0)
	
	for child in grid_container.get_children():
		child.get_child(0).add_color_override("font_color", Constants.WHITE)
	label.add_color_override("font_color", Constants.YELLOW)
	description.text = items[select_position].description


func _load_items() -> void:
	items = PlayerVariables.item_list.duplicate()


func _load_dummy_items() -> void:
	var apple: Item = Item.new("Apple", "Delicious! (Adds +20 food)")
	items.append(apple)
	
	for i in range(Constants.INVENTORY_SIZE - 1):
		var item_name: String = "Item " + str(i + 1)
		var desc: String = "Desc: " + str(i + 1)
		var item: Item = Item.new(item_name, desc)
		items.append(item)


func _load_ui() -> void:
	var unique_font: DynamicFont = font.duplicate()
	unique_font.size = 8
	description.add_font_override("font", unique_font)
	
	for item in items:
		var panel_container: PanelContainer = PanelContainer.new()
		panel_container.rect_min_size = Vector2(
			Constants.PANEL_MIN_SIZE_X, 
			Constants.PANEL_MIN_SIZE_Y
		)
		
		var label: Label = Label.new()
		label.add_font_override("font", unique_font)
		label.text = item.item_name
		label.align = Label.ALIGN_CENTER
		
		panel_container.add_child(label)
		grid_container.add_child(panel_container)


func _on_back_pressed() -> void:
	var parent: Node = get_parent()
	queue_free()
	parent.remove_child(self)
