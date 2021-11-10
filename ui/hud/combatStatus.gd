extends Control

onready var health_bar: ProgressBar = $hBox/progressBars/health
onready var mana_bar: ProgressBar = $hBox/progressBars/mana

func _ready() -> void:
	_connect_signals()


func _connect_signals() -> void:
	Utils.signal_error_code(
		EventBus.connect("combat_status_changed", self, "_on_combat_status_changed"),
		"combat_status_changed"
	)


func _on_combat_status_changed(status: Dictionary):
	health_bar.value = status.health
	mana_bar.value = status.mana
	health_bar.get_child(0).text = str(int(status.health)) + "/" +  str(health_bar.max_value)
	mana_bar.get_child(0).text = str(int(status.mana)) + "/" + str(mana_bar.max_value)
	
