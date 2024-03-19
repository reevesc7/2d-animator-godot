class_name Path
extends Node


@export var targets: Array[Prop]

@onready var path_visual := $Line2D as Line2D
@onready var length_report := $LengthReport as LengthReport


func _ready() -> void:
	if not targets:
		push_warning("NO_TARGET: Path._ready()")
	for target in targets:
		target.position_changed.connect(_on_target_changed)
	if path_visual:
		for target in targets:
			path_visual.add_point(target.position)
	if length_report:
		length_report.formula_changed.connect(_on_report_changed)
		length_report.update_length(targets)


func _on_target_changed(target: Prop) -> void:
	if path_visual:
		path_visual.points[targets.find(target)] = target.position
	if length_report:
		length_report.update_length(targets)


func _on_report_changed() -> void:
	length_report.update_length(targets)
