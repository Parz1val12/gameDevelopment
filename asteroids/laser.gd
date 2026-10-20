extends Area2D

var speed = 600.0
var direction = Vector2.ZERO

func _ready():
	# Make the laser face the direction it's travelling
	rotation = direction.angle()

func _process(delta):
	position += direction * speed * delta

# Delete laser when it goes off screen
func _on_screen_exited():
	queue_free()
