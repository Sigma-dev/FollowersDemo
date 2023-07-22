class_name Math

#Compares to floats with some margin
static func cmp(a: float, b: float, epsilon: float = 0.1) -> bool:
	return abs(a - b) < epsilon

#Gets the sign of a float with some margin near 0
static func sign(a: float, epsilon: float = 0.1) -> int:
	if abs(a - 0) < epsilon:
		return 0
	if a < 0:
		return -1
	return 1
