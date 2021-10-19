extends AcceptDialog

const font: DynamicFont = preload("res://menus/NESCyrillic.tres")

func _ready():
	dialog_text = "Apple x3\nMeat x2"
	call_deferred("popup")
