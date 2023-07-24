class_name MoveInfo
var dir: int = 0
var time: int = 0
var running: bool = false
var time_running: int = 0

static func make(preceding_move: MoveInfo, dir: int, running: bool = false) -> MoveInfo:
	var move = MoveInfo.new()
	move.dir = dir
	move.time = Time.get_ticks_msec()
	move.running = running
	if preceding_move:
		if running:
			move.time_running = preceding_move.time_running + (Time.get_ticks_msec() - preceding_move.time)
	return move
	
