extends KinematicBody2D

export (int) var speed = 100
export (bool) var debug_mode = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func debug(msg):
	if debug_mode:
		print("Right Pad: " + msg)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2()
	if Input.is_action_pressed("right_up"):
		velocity.y -= 1
	if Input.is_action_pressed("right_down"):
		velocity.y += 1
	
	debug(velocity)
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed * delta
		debug("Normalized: " + str(velocity))
	
	var _ret = move_and_collide(velocity)


func _on_HUD_start_game():
	position.y = 300
