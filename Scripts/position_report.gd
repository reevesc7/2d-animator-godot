extends Label


@export var target: Prop


func _ready() -> void:
	target.position_changed.connect(_on_target_changed)


func _on_target_changed(_prop: Prop) -> void:
	_set_text()


func _set_text() -> void:
	text = str(target.scaled_position)
