extends CharacterBody2D

@export var speed = 200
var bounces = 0
var mouse_position
var follow_mouse = true

func start():
	pass
	
# This function is called automatically when the game starts.
func _ready():
	pass

func _physics_process(delta):
	
	if follow_mouse == true:
		mouse_position = get_global_mouse_position()
		look_at(mouse_position)
		rotation = clampf(rotation, deg_to_rad(-90), deg_to_rad(90))
	
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		bounces -= 1
			
	if Input.is_action_just_pressed("click"):
		follow_mouse = false
		
