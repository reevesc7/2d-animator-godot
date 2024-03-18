extends Line2D


@export var targets: Array[Prop]


func _ready() -> void:
	for target in targets:
		add_point(target.position)
		target.position_changed.connect(_on_target_changed)


func _on_target_changed(target: Prop) -> void:
	points[targets.find(target)] = target.position
