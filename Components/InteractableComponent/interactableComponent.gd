extends Node
class_name InteractableComponent

signal on_interact

@export var is_one_shot: bool = false
var _has_interacted: bool = false

func interact(source: Node) -> void:
	if is_one_shot and _has_interacted:
		return

	_has_interacted = true
	on_interact.emit()

	# Optional: Print for debug
	print("Interaction triggered on: %s by %s" % [get_parent().name, source.name])