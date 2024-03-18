extends CanvasLayer


@onready var tree = get_tree()
@onready var resume_button := $MarginContainer/BoxContainer/Resume as Button
@onready var quit_button := $MarginContainer/BoxContainer/Quit as Button


func _ready() -> void:
	visible = false
	resume_button.pressed.connect(_on_resume_pressed)
	quit_button.pressed.connect(_on_quit_pressed)


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		tree.paused = !tree.paused
		if tree.paused:
			visible = true
		else:
			visible = false


func _on_resume_pressed() -> void:
	tree.paused = false
	visible = false


func _on_quit_pressed() -> void:
	tree.quit()
