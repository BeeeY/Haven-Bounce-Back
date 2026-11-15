extends Node2D

signal next
signal update_bounces


var level = 1
var already_called = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$hud.bounces = 1
	update_bounces.emit()
	
	$Level2.collision_enabled = false
	$Level3.collision_enabled = false
	$Level4.collision_enabled = false
	$Level5.collision_enabled = false
	$Level6.collision_enabled = false
	$Level7.collision_enabled = false
	$Level8.collision_enabled = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_hud_start_game() -> void:
	$Ball.set_physics_process(true)

func next_level(current_level, next_level, bounces_for_level):
	## changes level
	current_level.hide()
	current_level.collision_enabled = false
	next_level.show()
	next_level.collision_enabled = true
	## resets ball
	$Ball.velocity = Vector2.ZERO
	$Ball.follow_mouse = true
	$Ball.reset($Spawn.position,"arrow")
	## resets bounces
	$hud.bounces = bounces_for_level
	$Ball.bounces = bounces_for_level
	update_bounces.emit()

## calls for next level
func _on_finish_body_entered(body: Node2D) -> void:
	if body.is_in_group("ball"):
		level += 1
		next.emit()
		
		if level == 2:
			next_level($Level1, $Level2, 3)
		elif level == 3:
			next_level($Level2, $Level3, 5)
		elif level == 4:
			next_level($Level3, $Level4, 5)
		elif level == 5:
			next_level($Level4, $Level5, 7)
		elif level == 6:
			next_level($Level5, $Level6, 7)
		elif level == 7:
			next_level($Level6, $Level7, 8)
		elif level == 8:
			next_level($Level7, $Level8, 9)
		elif level == 9:
			next_level($Level8, $Level9, 10)
		elif level == 10:
			next_level($Level9, $Level10, 10)
