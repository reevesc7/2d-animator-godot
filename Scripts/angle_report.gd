extends Label


@export var vertex: Prop
@export var initial: Prop
@export var terminal: Prop



func _ready() -> void:
	vertex.position_changed.connect(_on_point_changed)
	initial.position_changed.connect(_on_point_changed)
	terminal.position_changed.connect(_on_point_changed)
	_on_point_changed()


#func _physics_process(_delta: float) -> void:
	#if vertex.NOTIFICATION_TRANSFORM_CHANGED or initial.NOTIFICATION_TRANSFORM_CHANGED or terminal.NOTIFICATION_TRANSFORM_CHANGED:
		#var initial_rel_position: Vector2 = initial.position - vertex.position
		#var terminal_rel_position: Vector2 = terminal.position - vertex.position
		#text = str(snappedf(rad_to_deg(initial_rel_position.angle_to(terminal_rel_position)), 0.001))


func _on_point_changed() -> void:
	var initial_rel_position: Vector2 = initial.position - vertex.position
	var terminal_rel_position: Vector2 = terminal.position - vertex.position
	text = str(snappedf(rad_to_deg(initial_rel_position.angle_to(terminal_rel_position)), 0.001))
