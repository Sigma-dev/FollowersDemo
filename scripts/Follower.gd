extends Sprite2D
@export var speed = 150
@export var move_dist = 30

func move(dir: Vector2, delta: float):
	global_position += dir * speed * delta
	_set_sprite(dir)

func _process(delta):
	var index = get_index()
	if index == 0: 
		return
	var next = get_parent().get_child(index - 1)
	var dist_to_next = global_position.distance_to(next.global_position)
	if dist_to_next > move_dist:
		var dir_to_next = global_position.direction_to(next.global_position)
		move(dir_to_next, delta)
	pass
	
func _set_sprite(dir: Vector2):
	var dir_frames = [[0, 3, 6], [20, 40, 24], [45, 39, 42]]
	var x_i = 1
	var y_i = 1
	if dir.x < 0:
		x_i = 0
	if dir.x > 0:
		x_i = 2
	if dir.y < 0:
		y_i = 0
	if dir.y > 0:
		y_i = 2
	frame = dir_frames[y_i][x_i]
