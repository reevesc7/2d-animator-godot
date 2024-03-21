class_name FollowAnimator
extends Animator


@export var path: Path


func _ready() -> void:
	if not targets:
		push_warning("No targets; nothing to animate")
		queue_free()
		return
	if not path:
		path = get_node_or_null("Path") as Path
		if not path:
			push_warning("No Path; targets will not be animated")
			queue_free()
			return
	if trigger:
		trigger.button_down.connect(_on_triggered)


func animate() -> void:
	for target in targets:
		var tween: Tween = target.create_tween()
		var relative_pos: Vector2 = Vector2.ZERO
		if relative and path.targets.size() > 0:
			relative_pos = path.targets[0].position - target.position
		for path_segment in path.targets.size() - 1:
			var segment_start: Vector2 = path.targets[path_segment].position - relative_pos
			var segment_end: Vector2 = path.targets[path_segment + 1].position - relative_pos
			tween = _make_translation(tween, target, segment_start, segment_end)
