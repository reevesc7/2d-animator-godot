class_name Offsetter
extends Node


enum Direction {LEFT, RIGHT, UP, DOWN}

@export var report: Report:
	set(value):
		if report:
			report.value_updated.disconnect(_on_value_updated)
		report = value
		if report:
			report.value_updated.connect(_on_value_updated)
			_on_report_changed()
@export var targeter: Targeter:
	set(value):
		if targeter:
			for target in targeter.targets:
				target.position = target.editor_position
		targeter = value
		if targeter:
			_move_targets()
@export var scale: float = 1.0:
	set(value):
		scale = value
		_move_targets()
@export var direction: Direction = Direction.RIGHT:
	set(value):
		direction = value
		_move_targets()


func _on_report_changed() -> void:
	_move_targets()


func _on_value_updated() -> void:
	_move_targets()


func _move_targets() -> void:
	if not report or not targeter:
		return
	if not report.is_node_ready():
		await report.ready
	if not targeter.is_node_ready():
		await targeter.ready
	var scaled_offset_vector: Vector2 = Globals.SpaceScale * _get_offset_vector(scale * report.value)
	for target in targeter.targets:
		target.position = target.editor_position + scaled_offset_vector


func _get_offset_vector(offset: float) -> Vector2:
	if direction == Direction.LEFT:
		return offset * Vector2.LEFT
	elif direction == Direction.RIGHT:
		return offset * Vector2.RIGHT
	elif direction == Direction.UP:
		return offset * Vector2.UP
	elif direction == Direction.DOWN:
		return offset * Vector2.DOWN
	else:
		return Vector2.ZERO
