class_name PathVisual
extends Line2D


@export var targeter: Targeter:
	set(value):
		if targeter:
			targeter.target_changed.disconnect(_on_target_changed)
		targeter = value
		if targeter:
			targeter.target_changed.connect(_on_target_changed)
			_update_targeter()


func _update_targeter() -> void:
	clear_points()
	if not targeter.is_node_ready():
		await targeter.ready
	for target in targeter.targets:
		add_point(target.position)


func _on_target_changed(target: Prop) -> void:
	points[targeter.targets.find(target)] = target.position
