class_name ResetAnimator
extends Animator


@export var speed: float = 64.0
@export var instant: bool = true:
	set(value):
		instant = value
		_update_animation_maker()

var _animation_maker: AnimationMaker


func _ready():
	if not targets:
		push_warning("No targets; Follower will not move anything")
		queue_free()
		return
	if trigger:
		trigger.button_down.connect(_on_triggered)
	_update_animation_maker()


func _update_animation_maker() -> void:
	if instant:
		_animation_maker = InstantMaker.new()
	else:
		_animation_maker = TimedMaker.new()


func animate() -> void:
	for target in targets:
		_animation_maker.make_animation(target, speed)


class AnimationMaker:
	func make_animation(_target: Prop, _speed: float) -> void:
		push_error("UNIMPLEMENTED: AnimationMaker.make_animation")


class InstantMaker extends AnimationMaker:
	func make_animation(target: Prop, _speed: float) -> void:
		target.position = target.editor_position


class TimedMaker extends AnimationMaker:
	func make_animation(target: Prop, speed: float) -> void:
		var tween: Tween = target.create_tween()
		var length: float = (target.editor_position - target.position).length()
		tween.tween_property(target, "position", target.editor_position, length / speed).from(target.position)
