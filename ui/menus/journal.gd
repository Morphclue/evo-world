extends Control

var quests: Array = []
onready var item_list: ItemList = $vBox/itemList
onready var description: Label = $vBox/hBox/panelContainer/description
onready var back: Button = $vBox/hBox/back

func _ready() -> void:
	_load_quests()
	_load_dummy_quests()
	_load_ui()


func _load_quests() -> void:
	quests = PlayerVariables.quest_list.duplicate()


func _load_dummy_quests() -> void:
	for i in range(10):
		var title: String = "Quest " + str(i + 1)
		var desc: String = "Desc: " + str(i + 1)
		var quest: Quest = Quest.new(title, desc)
		quests.append(quest)


func _load_ui() -> void:
	if !quests.size():
		return
	
	for quest in quests: 
		item_list.add_item(quest.title)
	
	for i in range(item_list.get_item_count()):
		item_list.set_item_tooltip_enabled(i, false)
	
	_on_itemList_item_selected(0)
	item_list.select(0)
	item_list.grab_focus()


func _on_itemList_item_selected(index) -> void:
	description.text = quests[index].description


func _on_back_pressed() -> void:
	EventBus.emit_signal("back_button_pressed")
