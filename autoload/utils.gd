extends Node


func switch_scene(parent, scene):
	get_parent().add_child(scene.instance())
	parent.queue_free()
