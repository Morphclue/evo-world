extends MarginContainer

# reference: https://kidscancode.org/godot_recipes/ui/minimap/

export (NodePath) var player
var zoom: float = 1.5 setget _set_zoom

onready var grid: TextureRect = $gridContainer/grid
onready var player_marker: Sprite = $gridContainer/grid/playerMarker
onready var quest_marker: Sprite = $gridContainer/grid/questMarker
onready var enemy_marker: Sprite = $gridContainer/grid/enemyMarker
onready var icons: Dictionary = {
	"quest": quest_marker,
	"enemy": enemy_marker,
}

var markers: Dictionary = {}
var sprite_scaling = 0.5
var grid_scale: Vector2

func _ready() -> void:
	player_marker.position = grid.rect_size / 2
	grid_scale = grid.rect_size / (get_viewport_rect().size * zoom)
	_init_markers()


func _process(_delta) -> void:
	if !player:
		return
	player_marker.rotation = get_node(player).rotation + PI
	_set_markers_position()


func _init_markers() -> void:
	var map_objects = get_tree().get_nodes_in_group("minimap_objects")
	for item in map_objects:
		var new_marker = icons[item.minimap_icon].duplicate()
		grid.add_child(new_marker)
		new_marker.show()
		markers[item] = new_marker


func _set_markers_position() -> void:
	for item in markers:
		var obj_pos = (item.position - get_node(player).get_parent().position) 
		obj_pos = obj_pos * grid_scale + grid.rect_size  / 2
		obj_pos.x = clamp(obj_pos.x, 0, grid.rect_size.x)
		obj_pos.y = clamp(obj_pos.y, 0, grid.rect_size.y)
		if grid.get_rect().has_point(obj_pos + grid.rect_position):
			markers[item].scale = Vector2(sprite_scaling, sprite_scaling)
		else: 
			markers[item].scale = Vector2(sprite_scaling / 2, sprite_scaling / 2)
		markers[item].position = obj_pos


func _set_zoom(value: float) -> void:
	zoom = clamp(value, Constants.MIN_GRID_ZOOM, Constants.MAX_GRID_ZOOM)
	grid_scale = grid.rect_size / (get_viewport_rect().size * zoom)


func _on_miniMap_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == BUTTON_WHEEL_UP:
			self.zoom += Constants.ZOOM_FACTOR
		if event.button_index == BUTTON_WHEEL_DOWN:
			self.zoom -= Constants.ZOOM_FACTOR
