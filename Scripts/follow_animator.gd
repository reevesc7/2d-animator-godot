class_name FollowAnimator
extends Animator


@export var path: Path

@export var speed: float = 64.0
@export var relative_positions: bool = false:
	set(value):
		relative_positions = value
		_update_animation_maker()

var _animation_maker: AnimationMaker


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
	_update_animation_maker()


func _update_animation_maker() -> void:
	if relative_positions:
		_animation_maker = RelativeMaker.new()
	else:
		_animation_maker = AbsoluteMaker.new()


func animate() -> void:
	for target in targets:
		_animation_maker.make_animation(target, path, speed)


class AnimationMaker:
	func make_animation(_target: Prop, _path: Path, _speed: float) -> void:
		push_error("UNIMPLEMENTED: AnimationMaker.make_animation")


class AbsoluteMaker extends AnimationMaker:
	func make_animation(target: Prop, path: Path, speed: float) -> void:
		var tween: Tween = target.create_tween()
		for path_segment in path.targets.size() - 1:
			var segment_start: Vector2 = path.targets[path_segment].position
			var segment_end: Vector2 = path.targets[path_segment + 1].position
			var segment_length: float = (segment_end - segment_start).length()
			tween.tween_property(target, "position", segment_end, segment_length / speed).from(segment_start)


class RelativeMaker extends AnimationMaker:
	func make_animation(target: Prop, path: Path, speed: float) -> void:
		var tween: Tween = target.create_tween()
		for path_segment in path.targets.size() - 1:
			var segment_start: Vector2 = path.targets[path_segment].position
			var segment_end: Vector2 = path.targets[path_segment + 1].position
			var segment_length: float = (segment_end - segment_start).length()
			tween.tween_property(target, "position", segment_end - segment_start, segment_length / speed).as_relative()
