extends CanvasLayer

signal start_game
var level = 1
var bounces = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Level.hide()
	$Bounces.hide()
	$Thanks.hide()
	$ColorRect.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	$TitleBackground.hide()
	$Title.hide()
	$Title2.hide()
	$StartButton.hide()
	$Level.show()
	$Bounces.show()
	start_game.emit()


func _on_main_update_bounces() -> void:
	$Bounces.text = str(bounces)

func _on_main_next() -> void:
	level += 1
	$Level.text = "Level " + str(level)
	
## updates the bounces text
func _on_ball_bounced() -> void:
	bounces -= 1
	$Bounces.text = str(bounces)


func _on_main_game_over() -> void:
	$Level.hide()
	$Bounces.hide()
	$ColorRect.show()
	$Thanks.show()
