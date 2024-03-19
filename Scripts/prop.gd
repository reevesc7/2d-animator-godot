class_name Prop
extends Node2D


signal position_changed(prop: Prop)

var scaled_position: Vector2
var _last_position: Vector2


func _ready() -> void:
	set_notify_transform(true)
	_set_scaled_position()


func _physics_process(_delta: float) -> void:
	if _last_position != position:
		_set_scaled_position()
		position_changed.emit(self)
		_last_position = position


func _set_scaled_position() -> void:
	scaled_position = (position / Globals.SpaceScale).round()


func set_position_from_scaled(scaled: Vector2) -> void:
	position = scaled * Globals.SpaceScale
