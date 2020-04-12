extends KinematicBody2D


export (bool) var debug_mode = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var direction = Vector2(0, 0)
var RAND_ANGLE = 0.2
var START_POS = Vector2(512, 300)
var is_start = false
var DIR_ANGLE = PI / 3
var DEFAULT_SPEED = 200
var speed = DEFAULT_SPEED

func debug(msg):
	if debug_mode:
		print("Ball: " + msg)

func reset():
	position = Vector2(START_POS)
	direction = Vector2(0, 0)
	speed = DEFAULT_SPEED

func start():
	var polar_coord = Vector2(1, rand_range(-DIR_ANGLE, DIR_ANGLE))
	if randi() % 2 == 1:
		polar_coord.y += PI
	direction = Vector2(polar2cartesian(polar_coord.x, polar_coord.y))

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if not is_start:
		return
	
	var velocity = speed * direction
	var _ret = move_and_slide(velocity)
	if get_slide_count() > 0:
		debug("Slid count")
		var collision = get_slide_collision(0)
		if collision != null:
			debug("collided!")
			direction = direction.bounce(collision.normal)
			#print(direction)
			# Randomize the direction a tiny bit
			var polar_direction = cartesian2polar(direction.x, direction.y)
			debug("Before: " + str(polar_direction))
			polar_direction.y = polar_direction.y + \
									rand_range(-RAND_ANGLE, RAND_ANGLE)
			debug("After: " + str(polar_direction))
			direction = polar2cartesian(polar_direction.x, polar_direction.y)
			# Increase speed after each collision
			speed *= 1.1
	#debug("Speed " + str(velocity))


func _on_HUD_start_game():
	reset()
	is_start = true
	$Timer.start()


func _on_Timer_timeout():
	start()


func _on_Node2D_scored():
	reset()
	$Timer.start()


func _on_Node2D_won():
	reset()
	hide()
