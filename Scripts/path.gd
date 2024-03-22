class_name Path
extends Node


@export var targeter: Targeter

@onready var path_visual := $Line2D as Line2D
@onready var length_report := $LengthReport as LengthReport


func _ready() -> void:
	if not targeter:
		push_warning("No targeter.")
	for target in targeter.targets:
		target.position_changed.connect(_on_target_changed)
	if path_visual:
		for target in targeter.targets:
			path_visual.add_point(target.position)
	if length_report:
		length_report.formula_changed.connect(_on_report_changed)
		length_report.update_length(targeter.targets)


func _on_target_changed(target: Prop) -> void:
	if path_visual:
		path_visual.points[targeter.targets.find(target)] = target.position
	if length_report:
		length_report.update_length(targeter.targets)


func _on_report_changed() -> void:
	length_report.update_length(targeter.targets)
