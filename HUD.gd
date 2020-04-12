extends CanvasLayer


signal start_game

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func show_score(left_score, right_score):
	var score_string = str(left_score) + "    |    " + str(right_score)
	$score_label.text = score_string

func show_timed_message(msg):
	$message_label.text = msg
	$message_label.show()
	$message_timer.start()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_message_timer_timeout():
	$message_label.hide()


func _on_start_button_pressed():
	$start_button.hide()
	$controls.hide()
	emit_signal("start_game")


func _on_Node2D_won():
	$start_button.text = "Restart"
	$start_button.show()
	$controls.show()
