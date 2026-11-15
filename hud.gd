extends CanvasLayer

signal start_game
signal level_finish

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	start_game.emit()


func _on_finish_body_entered(body: Node2D) -> void:
	if body.is_in_group("ball"):
		level_finish.emit()
