class_name ToPointAnimator
extends Animator


@export var point: Vector2


func animate() -> void:
	for target in targeter.targets:
		var tween = target.create_tween()
		var end_point: Vector2 = point
		if relative:
			end_point += target.position
		tween = _make_translation(tween, target, target.position, end_point)
