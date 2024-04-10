class_name LengthReport
extends Report


enum DistanceFormula {CHEBYSHEV, EUCLIDEAN, MANHATTAN}

@export var targeter: Targeter:
	set(value):
		if targeter:
			targeter.target_changed.disconnect(_on_target_changed)
		targeter = value
		if targeter:
			targeter.target_changed.connect(_on_target_changed)
			_update_targeter()

@export var distance_formula: DistanceFormula = DistanceFormula.EUCLIDEAN:
	set(value):
		distance_formula = value
		_update_distance_calc()

var points: Array[Vector2] = []
var _distance_calc: DistanceCalc


func _update_targeter() -> void:
	if not targeter.is_node_ready():
		await targeter.ready
	_init_points()
	_update_distance_calc()


func _update_distance_calc() -> void:
	if distance_formula == DistanceFormula.CHEBYSHEV:
		_distance_calc = ChebyshevCalc.new()
	elif distance_formula == DistanceFormula.EUCLIDEAN:
		_distance_calc = EuclideanCalc.new()
	elif distance_formula == DistanceFormula.MANHATTAN:
		_distance_calc = ManhattanCalc.new()
	_update_length()


func _init_points() -> void:
	points = []
	for target in targeter.targets:
		points.append(target.scaled_position)


func _on_target_changed(target: Prop) -> void:
	points[targeter.targets.find(target)] = target.scaled_position
	_update_length()


func _update_length() -> void:
	var total_length: float = 0.0
	for index in points.size() - 1:
		total_length += _distance_calc.calc(points[index], points[index + 1])
	text = str(snappedf(total_length, 0.001))


class DistanceCalc:
	func calc(_point1: Vector2, _point2: Vector2) -> float:
		push_error("UNIMPLEMENTED: DistanceCalc.calc")
		return 0.0


class ChebyshevCalc extends DistanceCalc:
	func calc(point1: Vector2, point2: Vector2) -> float:
		return maxf(absf(point1.x - point2.x), absf(point1.y - point2.y))


class EuclideanCalc extends DistanceCalc:
	func calc(point1: Vector2, point2: Vector2) -> float:
		return point1.distance_to(point2)


class ManhattanCalc extends DistanceCalc:
	func calc(point1: Vector2, point2: Vector2) -> float:
		return absf(point1.x - point2.x) + absf(point1.y - point2.y)
