class_name LengthReport
extends Label


signal formula_changed()

enum DistanceFormula {CHEBYSHEV, EUCLIDEAN, MANHATTAN}

@export var distance_formula: DistanceFormula = DistanceFormula.EUCLIDEAN:
	set(value):
		distance_formula = value
		_update_distance_calc()
		formula_changed.emit()

var _distance_calc: DistanceCalc


func _ready() -> void:
	_update_distance_calc()


func _update_distance_calc() -> void:
	if distance_formula == DistanceFormula.CHEBYSHEV:
		_distance_calc = ChebyshevCalc.new()
	elif distance_formula == DistanceFormula.EUCLIDEAN:
		_distance_calc = EuclideanCalc.new()
	elif distance_formula == DistanceFormula.MANHATTAN:
		_distance_calc = ManhattanCalc.new()


func update_length(targets: Array[Prop]) -> void:
	var total_length: float = 0.0
	for target in targets.size() - 1:
		total_length += _distance_calc.calc(targets[target].position, targets[target + 1].position)
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
