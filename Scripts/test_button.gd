extends Button


func _ready() -> void:
	self.button_down.connect(_on_pressed)


func _on_pressed() -> void:
	print("pressed")
