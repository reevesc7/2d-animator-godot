class_name ResetAnimator
extends Animator


func animate() -> void:
	for target in targeter.targets:
		var tween = target.create_tween()
		tween = _make_translation(tween, target, target.position, target.editor_position)
