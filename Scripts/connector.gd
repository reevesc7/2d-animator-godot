class_name Connector
extends Line2D


signal points_changed()

@export var targets: Array[Prop]


func _ready() -> void:
	for target in targets:
		add_point(target.position)
		target.position_changed.connect(_on_points_changed)


#func _physics_process(_delta: float) -> void:
	#for target in targets.size():
		#if targets[target].NOTIFICATION_TRANSFORM_CHANGED:
			#points[target] = targets[target].position
			#points_changed.emit()


func _on_points_changed() -> void:
	for target in targets.size():
		if targets[target].NOTIFICATION_TRANSFORM_CHANGED:
			points[target] = targets[target].position
			points_changed.emit()
