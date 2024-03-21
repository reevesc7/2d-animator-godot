class_name Animator
extends Node


@export var targets: Array[Prop]
@export var trigger: BaseButton


func _ready() -> void:
	if trigger:
		trigger.button_down.connect(_on_triggered)


func _on_triggered() -> void:
	animate()


func animate() -> void:
	push_error("UINIMPLEMENTED: Animator.animate()")
