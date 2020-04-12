extends Node2D

signal scored
signal won

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (int) var max_score = 5

var left_pad_score = 0
var right_pad_score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	reset_assets()


func reset_assets():
	left_pad_score = 0
	right_pad_score = 0
	$ball.hide()
	$left_pad.hide()
	$right_pad.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_HUD_start_game():
	$HUD.show_score(left_pad_score, right_pad_score)
	$HUD.show_timed_message("Starting game!")
	$ball.show()
	$left_pad.show()
	$right_pad.show()


func _on_right_bound_body_entered(_body):
	left_pad_score += 1
	$HUD.show_score(left_pad_score, right_pad_score)
	if left_pad_score == max_score:
		emit_signal("won")
		$HUD.show_timed_message("Left WON!!!")
		reset_assets()
	else:
		emit_signal("scored")


func _on_left_bound_body_entered(_body):
	right_pad_score += 1
	$HUD.show_score(left_pad_score, right_pad_score)
	if right_pad_score == max_score:
		emit_signal("won")
		$HUD.show_timed_message("Right WON!!!")
		reset_assets()
	else:
		emit_signal("scored")

