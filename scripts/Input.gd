extends Node2D

func get_move_vector() -> Vector2:
	var x = Input.get_axis("ui_left", "ui_right")
	var y = Input.get_axis("ui_up", "ui_down")
	return Vector2(x, y).normalized()

func _process(delta):
	var move_vector = get_move_vector()
	var first = get_child(0)
	if first && move_vector != Vector2.ZERO: 
		first.move(move_vector, delta) #Move only the first child from input, the rest will follow on their own
