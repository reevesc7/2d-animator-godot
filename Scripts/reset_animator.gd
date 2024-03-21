class_name ResetAnimator
extends Animator


@export var speed: float = 0.0


func _ready():
	if not targets:
		push_warning("No targets; Follower will not move anything")
		queue_free()
		return
	if trigger:
		trigger.button_down.connect(_on_triggered)


func animate() -> void:
	for target in targets:
		var tween = target.create_tween()
		tween = _make_translation(tween, target, target.position, target.editor_position, speed)
