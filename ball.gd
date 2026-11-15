extends CharacterBody2D

signal start_over

@export var speed = 400
var bounces = 0
var mouse_position
var follow_mouse = true

# This function is called automatically when the game starts.
func _ready():
	set_physics_process(false)
	$BallSprite.animation = "arrow"

func _physics_process(delta):
	
	if follow_mouse == true:
		mouse_position = get_global_mouse_position()
		look_at(mouse_position)
		rotation = clampf(rotation, deg_to_rad(-90), deg_to_rad(90))
	elif follow_mouse == false:
		rotation = velocity.angle()
		
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		bounces -= 1
			
	if Input.is_action_just_pressed("click"):
		follow_mouse = false
		$BallSprite.animation = "ball"
		velocity = Vector2.from_angle(rotation) * speed
		
	if bounces < 0:
		start_over.emit()
	
func spawn(pos):
	position = pos
