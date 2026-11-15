extends Node2D

signal next
signal update_bounces
signal game_over

var level = 1
var already_called = false
var bounces_for_level

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$hud.bounces = 1
	$Ball.bounces = 1
	update_bounces.emit()
	
	$Level2.collision_enabled = false
	$Level3.collision_enabled = false
	$Level4.collision_enabled = false
	$Level5.collision_enabled = false


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
			next_level($Level1, $Level2, 4)
			$ColorRect.color = ('#D8BFD8')
		elif level == 3:
			next_level($Level2, $Level3, 3)
			$ColorRect.color = ("#FFCBA4")
		elif level == 4:
			next_level($Level3, $Level4, 3)
			$ColorRect.color = ("#9BB7E8")
		elif level == 5:
			next_level($Level4, $Level5, 1)
			$ColorRect.color = ("#F7CAC9")
		elif level == 6:
			game_over.emit()


func _on_ball_start_over() -> void:
		## resets ball
	$Ball.velocity = Vector2.ZERO
	$Ball.follow_mouse = true
	$Ball.reset($Spawn.position,"arrow")
	## resets bounces
	if level == 1:
		bounces_for_level = 1
	elif level == 2:
		bounces_for_level = 4
	elif level == 3:
		bounces_for_level = 3
	elif level == 4:
		bounces_for_level = 3
	elif level == 5:
		bounces_for_level = 1
	$hud.bounces = bounces_for_level
	$Ball.bounces = bounces_for_level
	update_bounces.emit()
	
func _on_area_2d_body_entered(body: Node2D) -> void:
		if body.is_in_group("ball"):
			_on_ball_start_over()
func _on_area_2d_2_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
		if body.is_in_group("ball"):
			_on_ball_start_over()
func _on_area_2d_3_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
		if body.is_in_group("ball"):
			_on_ball_start_over()
func _on_area_2d_4_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
		if body.is_in_group("ball"):
			_on_ball_start_over()


func _on_ball_bounced() -> void:
	$AudioStreamPlayer2.play()
