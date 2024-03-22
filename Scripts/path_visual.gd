class_name PathVisual
extends Line2D


@export var targeter: Targeter:
	set(value):
		targeter = value
		_update_targeter()


#func _ready() -> void:
	#_update_targeter()


func _update_targeter() -> void:
	if not targeter:
		return
	targeter.ready.connect(_on_targeter_ready)
	targeter.target_changed.connect(_on_target_changed)
	clear_points()
	for target in targeter.targets:
		add_point(target.position)


func _on_targeter_ready() -> void:
	clear_points()
	for target in targeter.targets:
		add_point(target.position)


func set_targeter(new_targeter: Targeter) -> void:
	targeter = new_targeter
	targeter.target_changed.connect(_on_target_changed)
	_on_targeter_ready()


func _on_target_changed(target: Prop) -> void:
	points[targeter.targets.find(target)] = target.position
