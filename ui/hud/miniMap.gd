extends MarginContainer

# reference: https://kidscancode.org/godot_recipes/ui/minimap/

export (NodePath) var player
var zoom: float = 1.5 setget _set_zoom

onready var grid: TextureRect = $gridContainer/grid
onready var player_marker: Sprite = $gridContainer/grid/playerMarker

var scaling: float = 0.5
var grid_scale: Vector2

func _ready() -> void:
	player_marker.scale *= scaling
	player_marker.position = grid.rect_size / 2
	
	grid_scale = grid.rect_size / (get_viewport_rect().size * zoom)


func _process(_delta) -> void:
	if !player:
		return
	player_marker.rotation = get_node(player).rotation + PI


func _set_zoom(value):
	zoom = clamp(value, Constants.MIN_GRID_ZOOM, Constants.MAX_GRID_ZOOM)
	grid_scale = grid.rect_size / (get_viewport_rect().size * zoom)


func _on_miniMap_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == BUTTON_WHEEL_UP:
			self.zoom += Constants.ZOOM_FACTOR
		if event.button_index == BUTTON_WHEEL_DOWN:
			self.zoom -= Constants.ZOOM_FACTOR
