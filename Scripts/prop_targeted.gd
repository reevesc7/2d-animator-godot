class_name PropTargeted
extends Node


@export var targeter: Targeter
@export var trigger: BaseButton


func _ready():
	_prop_targeted_ready()


func _prop_targeted_ready() -> void:
	if not targeter:
		push_warning("No targeter.")
		queue_free()
		return
	if trigger:
		trigger.button_down.connect(_on_triggered)


func _on_triggered() -> void:
	push_error("UNIMPLEMENTED: PropTargeted._on_triggered()")
