extends Label


@export var target: Prop


func _physics_process(_delta: float) -> void:
	if target.NOTIFICATION_TRANSFORM_CHANGED:
		text = str(target.position)
