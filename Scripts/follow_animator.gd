class_name Follower
extends Animator


@export var path: Path

@export var speed: float = 64.0

var moving: bool = false
var path_target: int = 1


func _ready() -> void:
	if not target:
		push_warning("No target; Follower will not move anything")
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


func _physics_process(delta: float) -> void:
	if not moving:
		return
	var target_to_path_target: Vector2 = path.targets[path_target].position - target.position
	if target_to_path_target.length() > speed * delta:
		target.position += target_to_path_target.normalized() * speed * delta
	else:
		target.position = path.targets[path_target].position
		path_target += 1
	if path_target >= path.targets.size():
		moving = false


func animate() -> void:
	target.position = path.targets[0].position
	path_target = 1
	moving = true
