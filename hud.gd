extends CanvasLayer

signal start_game
var level = 1
var bounces = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Level.hide()
	$LevelFinish.hide()
	$LevelFinishBg.hide()
	$Bounces.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	$TitleBackground.hide()
	$ColorRect.hide()
	$Title.hide()
	$StartButton.hide()
	$Level.show()
	$Bounces.show()
	start_game.emit()


func _on_main_update_bounces() -> void:
	$Bounces.text = str(bounces)

func _on_main_next() -> void:
	level += 1
	$LevelFinish.show()
	$LevelFinishBg.show()
	$Level.text = "Level " + str(level)
	await get_tree().create_timer(1.0).timeout
	$LevelFinish.hide()
	$LevelFinishBg.hide()

## updates the bounces text
func _on_ball_bounced() -> void:
	bounces -= 1
	$Bounces.text = str(bounces)
