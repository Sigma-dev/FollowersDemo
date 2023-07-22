class_name MoveInfo
var dir: int = 0
var time: int = 0

static func make(dir: int) -> MoveInfo:
	var move = MoveInfo.new()
	move.dir = dir
	move.time = Time.get_ticks_msec()
	return move
	
