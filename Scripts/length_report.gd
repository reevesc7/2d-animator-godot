extends Label


@export var path: Path

var segment_lengths: Array[float]


func _ready() -> void:
	if not path:
		path = get_node_or_null("Path")
		if not path:
			push_warning("LENGTHREPORT: No Path detectable; length will be 0")
			text = "0"
			return
	for target in path.targets:
		target.position_changed.connect(_on_target_changed)
	_init_lengths()


func _init_lengths() -> void:
	segment_lengths = []
	if path.targets.size() > 1:
		for target in range(1, path.targets.size()):
			segment_lengths.append(path.targets[target - 1].scaled_position.distance_to(path.targets[target].scaled_position))


func _on_target_changed(target: Prop) -> void:
	var index: int = path.targets.find(target)
	if index > 0:
		segment_lengths[index - 1] = path.targets[index - 1].scaled_position.distance_to(path.targets[index].scaled_position)
	if index < path.targets.size() - 1:
		segment_lengths[index] = path.targets[index].scaled_position.distance_to(path.targets[index + 1].scaled_position)
	_set_text()


func _sum_lengths(lengths: Array[float]) -> float:
	var sum: float = 0.0
	for length in lengths:
		sum += length
	return sum


func _set_text() -> void:
	text = str(snappedf(_sum_lengths(segment_lengths), 0.001))
