extends Label


@export var target: Prop


func _ready() -> void:
	target.position_changed.connect(_on_target_changed)


func _physics_process(_delta: float) -> void:
	if target.NOTIFICATION_TRANSFORM_CHANGED:
		text = str(target.scaled_position)


func _on_target_changed(_prop: Prop) -> void:
	_set_text(target.scaled_position)


func _set_text(position: Vector2) -> void:
	text = str(position)
