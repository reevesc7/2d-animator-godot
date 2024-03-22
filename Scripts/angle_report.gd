class_name AngleReport
extends Label


@export var vertex: Prop:
	set(value):
		if vertex:
			vertex.position_changed.disconnect(_on_point_moved)
		vertex = value
		if vertex:
			vertex.position_changed.connect(_on_point_moved)
			_on_point_changed()
@export var initial: Prop:
	set(value):
		if initial:
			initial.position_changed.disconnect(_on_point_moved)
		initial = value
		if initial:
			initial.position_changed.connect(_on_point_moved)
			_on_point_changed()
@export var terminal: Prop:
	set(value):
		if terminal:
			terminal.position_changed.disconnect(_on_point_moved)
		terminal = value
		if terminal:
			terminal.position_changed.connect(_on_point_moved)
			_on_point_changed()



func _ready() -> void:
	if not vertex or not initial or not terminal:
		push_warning("Point(s) missing; angle will be 0")
		text = "0"


func _on_point_changed() -> void:
	if vertex and initial and terminal:
		_update_targets()


func _on_point_moved(_prop: Prop) -> void:
	_update_targets()


func _update_targets() -> void:
	var initial_rel_position: Vector2 = initial.scaled_position - vertex.scaled_position
	var terminal_rel_position: Vector2 = terminal.scaled_position - vertex.scaled_position
	_set_text(initial_rel_position.angle_to(terminal_rel_position))


func _set_text(angle: float) -> void:
	text = str(snappedf(rad_to_deg(angle), 0.001))
