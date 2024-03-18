class_name Prop
extends Node2D


signal position_changed()


func _enter_tree() -> void:
	set_notify_transform(true)


func _notification(what: int) -> void:
	if what == NOTIFICATION_TRANSFORM_CHANGED:
		position_changed.emit()
