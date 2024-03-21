class_name Follower
extends Animator


@export var path: Path

@export var speed: float = 64.0


func _ready() -> void:
	if not targets:
		push_warning("No targets; Follower will not move anything")
		queue_free()
		return
	if not path:
		path = get_node_or_null("Path") as Path
		if not path:
			push_warning("No Path detectable; Follower will not move target")
			queue_free()
			return
	if trigger:
		trigger.button_down.connect(_on_triggered)


func animate() -> void:
	for target in targets:
		var tween: Tween = target.create_tween()
		for path_segment in path.targets.size() - 1:
			var segment_start: Vector2 = path.targets[path_segment].position
			var segment_end: Vector2 = path.targets[path_segment + 1].position
			var segment_length: float = (segment_end - segment_start).length()
			tween.tween_property(target, "position", segment_end, segment_length / speed).from(segment_start)
