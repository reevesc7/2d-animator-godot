class_name FollowAnimator
extends Animator


@export var path_targeter: Targeter


func _ready() -> void:
	_prop_targeted_ready()
	if not path_targeter:
		push_warning("No path Targeter.")
		queue_free()
		return


func animate() -> void:
	for target in targeter.targets:
		_make_follow_animation(target)


func _make_follow_animation(target: Prop) -> void:
	var tween : Tween = target. create_tween()
	var relative_pos: Vector2 = Vector2.ZERO
	if relative:
		relative_pos = path_targeter.targets[0].position - target.position
	for path_segment in path_targeter.targets.size() - 1:
		var segment_start: Vector2 = path_targeter.targets[path_segment].position - relative_pos
		var segment_end: Vector2 = path_targeter.targets[path_segment + 1].position - relative_pos
		tween = _make_translation(tween, target, segment_start, segment_end)
	
