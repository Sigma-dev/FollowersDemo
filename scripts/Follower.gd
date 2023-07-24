extends Sprite2D
@export var speed = 150 #Move speed of the follower
@export var min_spacing = 30 #Spacing from the preceding follower
@export var run_spacing = 50 #Spacing from the preceding follower
var last_move : MoveInfo = null #Last move of the follower, used to determine if Idle and store their direction

#Called to make the follower move
func move(dir: Vector2, delta: float, running: bool = false) -> void:
	var move_speed = speed
	if running:
		move_speed *= 1.5
	global_position += dir * move_speed * delta
	var dir_index: int = _get_dir_index(dir)
	last_move = MoveInfo.make(last_move ,dir_index, running)

func _process(delta: float) -> void:
	if get_index() != 0: #No follow logic if the follower is the first
		_follow_preceding_follower(delta)
	if last_move:
		var idle: bool = Time.get_ticks_msec() - last_move.time > 50 #Is idle if the last move was more than 50 milliseconds ago
		var running: bool = last_move.time_running > 150 #Is running if started running more than 150 millis ago
		_set_sprite(last_move.dir, idle, running)
	else:
		_set_sprite(6, true)

func _follow_preceding_follower(delta: float) -> void:
	var preceding = get_parent().get_child(get_index() - 1) #Get sibling node that is one spot higher in hierarchy
	var dist_to_preceding = global_position.distance_to(preceding.global_position) #Get distance to preceding node
	if dist_to_preceding > min_spacing: #If preceding node is not too close
		var dir_to_preceding = global_position.direction_to(preceding.global_position) #Get direction to preceding node
		move(dir_to_preceding, delta, dist_to_preceding > run_spacing) #Move towards preceding node

#Sets the sprite correctly depending on the given direction index
func _set_sprite(dir_index: int, idle: bool = false, running: bool = false) -> void:
	var walk_dir_frames = [40, 0, 3, 6, 24, 42, 39, 45, 20] #The texture frames corresponding to the different directions
	var idle_dir_frames = [41, 1, 4, 7, 25, 43, 40, 46, 19] #The idle texture frames corresponding to the different directions
	var run_dir_frames =  [42, 2, 5, 8, 26, 44, 41, 48, 18] #The running texture frames corresponding to the different directions
	var frames = walk_dir_frames
	if idle:
		frames = idle_dir_frames
	if running:
		frames = run_dir_frames
	frame = frames[dir_index]# Choose which frame to use

#Returns the direction as an index from 0 to 8, mapped as such
# 1 2 3
# 8 0 4
# 7 6 5
func _get_dir_index(v: Vector2) -> int:
	var dirs = [
		[1,2,3],
		[8,0,4],
		[7,6,5]
	]
	return dirs[Math.sign(v.y) + 1][Math.sign(v.x) + 1]
