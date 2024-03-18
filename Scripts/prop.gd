class_name Prop
extends Node2D


signal position_changed(prop: Prop)

var scaled_position: Vector2


func _ready() -> void:
	set_notify_transform(true)
	_set_scaled_position()


func _notification(what: int) -> void:
	if what == NOTIFICATION_TRANSFORM_CHANGED: 
		_set_scaled_position()
		position_changed.emit(self)


func _set_scaled_position() -> void:
	scaled_position = (position / Globals.SpaceScale).round()


func set_position_from_scaled(scaled: Vector2) -> void:
	position = scaled * Globals.SpaceScale
