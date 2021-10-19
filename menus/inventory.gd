extends Control

const PANEL_MIN_SIZE_X: int = 95
const PANEL_MIN_SIZE_Y: int = 20

const font: DynamicFont = preload("res://menus/NESCyrillic.tres")

onready var grid_container = $vBox/control/gridContainer

var items: Array = []

func _ready():
	_load_items()
	_load_dummy_items()
	_load_ui()


func _load_items() -> void:
	items = PlayerVariables.item_list.duplicate()


func _load_dummy_items() -> void:
	for i in range(10):
		var item_name = "Item " + str(i + 1)
		var desc = "Desc: " + str(i)
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
