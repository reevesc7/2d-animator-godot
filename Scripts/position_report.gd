extends Label


@export var target: Prop:
	set(value):
		if target:
			target.position_changed.disconnect(_on_target_moved)
		target = value
		if target:
			target.position_changed.connect(_on_target_moved)


func _on_target_moved(_prop: Prop) -> void:
	_set_text()


func _set_text() -> void:
	text = str(target.scaled_position)
