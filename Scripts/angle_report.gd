extends Label


@export var vertex: Prop
@export var initial: Prop
@export var terminal: Prop



func _ready() -> void:
	if not vertex or not initial or not terminal:
		push_warning("ANGLEREPORT: point(s) missing; angle will be 0")
		text = "0"
	vertex.position_changed.connect(_on_point_changed)
	initial.position_changed.connect(_on_point_changed)
	terminal.position_changed.connect(_on_point_changed)
	_update_targets()


func _on_point_changed(_prop: Prop) -> void:
	_update_targets()


func _update_targets() -> void:
	var initial_rel_position: Vector2 = initial.scaled_position - vertex.scaled_position
	var terminal_rel_position: Vector2 = terminal.scaled_position - vertex.scaled_position
	_set_text(initial_rel_position.angle_to(terminal_rel_position))


func _set_text(angle: float) -> void:
	text = str(snappedf(rad_to_deg(angle), 0.001))
