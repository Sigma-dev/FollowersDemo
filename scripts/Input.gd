extends Node2D

func get_move_vector():
	var x = Input.get_axis("ui_left", "ui_right")
	var y = Input.get_axis("ui_up", "ui_down")
	return Vector2(x, y).normalized()

func _process(delta):
	var move_vector = get_move_vector()
	var first = get_child(0)
	if first:
		first.move(move_vector, delta)
	pass
