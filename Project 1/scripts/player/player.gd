extends CharacterBody2D

const SPEED = 100.0

@onready var sprite = $AnimatedSprite2D

@export var inventory: Inventory

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	var direction_horizontal = Input.get_axis("move_left", "move_right")
	var direction_vertical = Input.get_axis("move_up", "move_down")
	
	
	#Movement
	if direction_horizontal:
		velocity.x = direction_horizontal * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if direction_vertical:
		velocity.y = direction_vertical * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	#Animations
	if direction_horizontal == 0 && direction_vertical == 0:
		sprite.play("idle")
	
	if direction_horizontal > 0:
		sprite.play("move_right")
	elif direction_horizontal < 0:
		sprite.play("move_left")
	
	if direction_vertical < 0:
		sprite.play("move_up")

	move_and_slide()

# This adds a non-collider area around the player that helps other scripts to interact with the player
func _on_hurt_box_area_entered(area):
	if area.has_method("collect"):
		area.collect(inventory)
