extends AcceptDialog

func _ready() -> void:
	dialog_text = "Apple x3\nMeat x2"
	call_deferred("popup")
