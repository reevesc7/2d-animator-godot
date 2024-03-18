extends Label


@export var connector: Connector


func _ready() -> void:
	connector.points_changed.connect(_on_connector_changed)


func _on_connector_changed() -> void:
	if connector.points.size() > 1:
		var total_length: float = 0.0
		for point in range(1, connector.points.size()):
			total_length += connector.points[point - 1].distance_to(connector.points[point])
		text = str(snappedf(total_length, 0.001))
