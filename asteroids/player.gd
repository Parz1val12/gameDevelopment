extends Area2D

var max_speed = 300.0
var acceleration = 800.0
var friction = 400.0
var velocity = Vector2.ZERO

# Preload your laser scene (make sure the path matches where you saved laser.tscn)
const LASER_SCENE = preload("res://laser.tscn")

func _process(delta):
	look_at(get_global_mouse_position())
	
	var input_vector = Vector2.ZERO
	if Input.is_key_pressed(KEY_D):
		input_vector.x += 1
	if Input.is_key_pressed(KEY_A):
		input_vector.x -= 1
	if Input.is_key_pressed(KEY_S):
		input_vector.y += 1
	if Input.is_key_pressed(KEY_W):
		input_vector.y -= 1
		
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * max_speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		
	position += velocity * delta
	screen_wrap()

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		shoot()

func shoot():
	var laser = LASER_SCENE.instantiate()
	# Set the laser's starting position to the player's position
	laser.position = global_position
	# Set its direction based on where the player is facing (toward the mouse)
	laser.direction = Vector2.RIGHT.rotated(rotation)
	# Add the laser to the main game world (the parent of the player)
	get_parent().add_child(laser)

func screen_wrap():
	var screen_size = get_viewport_rect().size
	if position.x < 0:
		position.x = screen_size.x
	elif position.x > screen_size.x:
		position.x = 0
		
	if position.y < 0:
		position.y = screen_size.y
	elif position.y > screen_size.y:
		position.y = 0
