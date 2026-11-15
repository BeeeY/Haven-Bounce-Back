extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


@export var radius = 5

func _process(_delta):
	var mouse_pos = get_tree().get_mouse_position()
	var player_pos = $"..".transform.origin 
	var mouse_dir = (mouse_pos-player_pos).normalized()
	$".".transform.origin = player_pos + (mouse_dir * radius)
