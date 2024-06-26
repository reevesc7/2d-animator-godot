class_name Animator
extends PropTargeted


@export var speed: float = 64.0
@export var relative: bool = false


func _on_triggered() -> void:
	animate()


func animate() -> void:
	push_error("UNIMPLEMENTED: Animator.animate()")


func _make_translation(tween: Tween, target: Prop, start: Vector2, end: Vector2) -> Tween:
	if speed > 0.0:
		var length: float = (end - start).length()
		tween.tween_property(target, "position", end, length / speed).from(start)
	else:
		tween.tween_property(target, "position", end, 0.0).from(start)
	return tween
