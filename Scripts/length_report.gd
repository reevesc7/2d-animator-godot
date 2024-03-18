extends Label


@export var targets: Array[Prop]

var segment_lengths: Array[float]


func _ready() -> void:
	for target in targets:
		target.position_changed.connect(_on_target_changed)
	_init_lengths()
	_set_text(_sum_lengths(segment_lengths))


func _init_lengths() -> void:
	segment_lengths = []
	if targets.size() > 1:
		for target in range(1, targets.size()):
			segment_lengths.append(targets[target - 1].scaled_position.distance_to(targets[target].scaled_position))


func _on_target_changed(target: Prop) -> void:
	var index: int = targets.find(target)
	if index > 0:
		segment_lengths[index - 1] = targets[index - 1].scaled_position.distance_to(targets[index].scaled_position)
	if index < targets.size() - 1:
		segment_lengths[index] = targets[index].scaled_position.distance_to(targets[index + 1].scaled_position)
	_set_text(_sum_lengths(segment_lengths))


func _sum_lengths(lengths: Array[float]) -> float:
	var sum: float = 0.0
	for length in lengths:
		sum += length
	return sum


func _set_text(length: float) -> void:
	text = str(snappedf(length, 0.001))
