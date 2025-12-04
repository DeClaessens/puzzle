extends CharacterBody2D
class_name Player

@export var move_speed: float = 120.0
@export var interaction_ray: RayCast2D

# Strict typing is mandatory
func _physics_process(_delta: float) -> void:
	handle_movement()
	handle_interaction()

func handle_movement() -> void:
	var input_dir: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	velocity = input_dir * move_speed

	if input_dir != Vector2.ZERO:
		# Update RayCast to face movement direction for interaction
		interaction_ray.target_position = input_dir.normalized() * 32.0 # Assuming 32px grid

	move_and_slide()

func handle_interaction() -> void:
	if Input.is_action_just_pressed("ui_accept"):
		if interaction_ray.is_colliding():
			var collider: Object = interaction_ray.get_collider()
			# Attempt to find the InteractableComponent on the object
			if collider is Node:
				# We assume the collider is the physics body, we look for the component
				var interactable: InteractableComponent = collider.get_node_or_null("InteractableComponent")
				if interactable:
					interactable.interact(self)
