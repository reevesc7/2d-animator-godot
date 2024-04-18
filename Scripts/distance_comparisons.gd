extends Node2D


@onready var endpt_mover := $ToPointAnimator as Animator


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("play_1"):
		endpt_mover.animate()
