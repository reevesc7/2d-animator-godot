extends Node2D


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("play_1"):
		($AngleReport as AngleReport).terminal = $MoveTargeter/MovingProp as Prop
