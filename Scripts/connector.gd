extends Line2D


@export var path: Path


func _ready() -> void:
	if not path:
		path = get_node_or_null("Path")
		if not path:
			push_warning("CONNECTOR: No Path detectable; Connector will not display")
			queue_free()
			return
	for target in path.targets:
		add_point(target.position)
		target.position_changed.connect(_on_target_changed)


func _on_target_changed(target: Prop) -> void:
	points[path.targets.find(target)] = target.position
