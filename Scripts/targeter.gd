class_name Targeter
extends Node


signal target_changed(target: Prop)

@export var targets: Array[Prop]
@export var targets_parents: Array[Node]


func _ready() -> void:
	if targets_parents:
		for parent in targets_parents:
			_add_child_props(parent)
	_add_child_props(self)
	#if not targets:
		#push_warning("No targets.")
		#queue_free()
		#return
	for target in targets:
		target.position_changed.connect(_on_target_changed)


func _add_child_props(parent: Node) -> void:
	for node in parent.get_children():
		if node is Prop and node not in targets:
			targets.append(node)


func add_targets(new_targets: Array[Prop]) -> void:
	targets.append_array(new_targets)
	for target in new_targets:
		target.position_changed.connect(_on_target_changed)


func _on_target_changed(target: Prop) -> void:
	target_changed.emit(target)
