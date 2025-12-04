extends StaticBody2D # Or Node2D, depending on your root
class_name Candle

# We define a signal that the Level Logic cares about
signal lit

# We get a reference to the internal component
# NOTE: Ensure the node name matches exactly in the Scene Tree
@onready var interactable: InteractableComponent = $InteractableComponent
@onready var sprite: Sprite2D = $Sprite2D # Reference to your visual

var is_lit: bool = false

func _ready() -> void:
	# Connect the child component's signal to a local function
	interactable.on_interact.connect(_on_interacted)

func _on_interacted() -> void:
	if is_lit: return
	
	is_lit = true
	
	# Visual Feedback (The Candle handles its own look)
	sprite.modulate = Color(1.2, 1.2, 1.2) # Make it glow slightly
	
	# "Signal Up": Tell the Level Logic we are done
	lit.emit()