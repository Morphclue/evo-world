extends Node


func switch_scene(parent, scene):
	get_parent().add_child(scene.instance())
	parent.queue_free()


func remove_children(parent, ignore = []):
	for n in parent.get_children():
		if n in ignore:
			continue
		parent.remove_child(n)
		n.queue_free()
