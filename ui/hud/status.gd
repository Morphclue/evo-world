extends Control

onready var hunger_bar = $hBox/progressBars/hunger
onready var toilet_bar = $hBox/progressBars/toilet
onready var mood_bar = $hBox/progressBars/mood
onready var respect_bar = $hBox/progressBars/respect

func _ready() -> void:
	_connect_signals()


func _connect_signals() -> void:
	Utils.signal_error_code(
		EventBus.connect("status_changed", self, "_on_status_changed"),
		"status_changed"
	)


func _on_status_changed(status: Dictionary) -> void:
	hunger_bar.value = status.hunger
	toilet_bar.value = status.toilet
	mood_bar.value = status.mood
	respect_bar.value = status.respect
