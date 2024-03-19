extends Button


@export var target: Prop

var down: bool = false


func _ready() -> void:
	if not target:
		push_warning("DRAGBUTTON: No target; shutting off DragButton functionality")
		return
	self.button_down.connect(_on_down)
	self.button_up.connect(_on_up)


func _unhandled_input(event: InputEvent) -> void:
	if down and event is InputEventMouseMotion:
		target.position += (event as InputEventMouseMotion).relative


func _on_down() -> void:
	down = true


func _on_up() -> void:
	down = false
