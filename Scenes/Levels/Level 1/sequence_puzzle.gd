extends Node
class_name SequencePuzzle

# Export the interactables so we can assign them in Editor via drag-and-drop
# This avoids fragile string paths like get_node("Candle1")
@export var sequence_nodes: Array[Candle]
@export var door_to_open: Node2D # Generic Node2D, could be a door scene
@export var next_level_scene: PackedScene # Drag the Level 2 scene here (uses UID automatically)

var current_index: int = 0

func _ready() -> void:
	# Connect signals dynamically
	for candle in sequence_nodes:
		candle.lit.connect(_on_candle_lit.bind(candle))

func _on_candle_lit(candle: Candle) -> void:
	# Check if the lit candle matches the expected one in the array
	if candle == sequence_nodes[current_index]:
		current_index += 1
		
		if current_index >= sequence_nodes.size():
			_solve_puzzle()
	else:
		_fail_puzzle()

func _fail_puzzle() -> void:
	print("Wrong order! Resetting...")
	current_index = 0
	# Reset visuals here (omitted for brevity)

func _solve_puzzle() -> void:
	print("Puzzle Solved! Door Opening.")
	if door_to_open:
		door_to_open.queue_free() # Or play an animation
	
	# In a real scenario, this would likely trigger an Area2D transition, 
	# but for prototype, we can change scene after a delay:
	get_tree().create_timer(1.0).timeout.connect(func():
		get_tree().change_scene_to_packed(next_level_scene)
	)
