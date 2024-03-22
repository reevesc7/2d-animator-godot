class_name Connector
extends PropTargeted


enum ConnectionsType {DENSE, MST}

@export var clear_trigger: BaseButton:
	set(value):
		if clear_trigger:
			clear_trigger.button_down.disconnect(_on_clear_triggered)
		clear_trigger = value
		clear_trigger.button_down.connect(_on_clear_triggered)

@export var connections_type: ConnectionsType = ConnectionsType.DENSE:
	set(value):
		connections_type = value
		_update_connections_type()
@export var path_visuals: bool = true

var _connection_maker: ConnectionMaker


func _ready() -> void:
	_prop_targeted_ready()
	_update_connections_type()


func _update_connections_type() -> void:
	if connections_type == ConnectionsType.DENSE:
		_connection_maker = DenseMaker.new()
	elif connections_type == ConnectionsType.MST:
		_connection_maker = MSTMaker.new()


func _on_triggered() -> void:
	make_connections()


func make_connections() -> void:
	clear_connections()
	var connections: Array[Array] = _connection_maker.make_connections(targeter.targets)
	for connection in connections:
		_make_connection([connection[0], connection[1]])


func clear_connections() -> void:
	for child in get_children():
		child.queue_free()


func _make_connection(targets: Array[Prop]) -> void:
	var new_targeter: Targeter = Globals.TargeterScene.instantiate() as Targeter
	add_child(new_targeter)
	new_targeter.add_targets(targets)
	if path_visuals:
		var new_path_visual: PathVisual = Globals.PathVisualScene.instantiate() as PathVisual
		add_child(new_path_visual)
		new_path_visual.targeter = new_targeter


func _on_clear_triggered() -> void:
	clear_connections()


class ConnectionMaker:
	func make_connections(_targets: Array[Prop]) -> Array[Array]:
		push_error("UNIMPLEMENTED: ConnectionMaker.make_connections()")
		return []
	
	func make_connection(parent: Connector, start: Prop, end: Prop) -> void:
		var targeter: Targeter = Globals.TargeterScene.instantiate() as Targeter
		parent.add_child(targeter)
		targeter.add_targets([start, end])
		var path_visual: PathVisual = Globals.PathVisualScene.instantiate() as PathVisual
		parent.add_child(path_visual)
		path_visual.set_targeter(targeter)


class DenseMaker extends ConnectionMaker:
	func make_connections(targets: Array[Prop]) -> Array[Array]:
		var connections: Array[Array] = []
		for index_start in targets.size() - 1:
			for target_index in range(index_start + 1, targets.size()):
				connections.append([targets[index_start], targets[target_index]])
		return connections


class MSTMaker extends ConnectionMaker:
	func make_connections(_targets: Array[Prop]) -> Array[Array]:
		pass
		return []
