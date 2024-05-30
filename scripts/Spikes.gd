extends Node2D
@export var speed: int = 100
@export var amplitude: int = 50
var direction: int = 1
var start_position: Vector2

func _ready():
	start_position = position
 
func _process(delta):
	position.y += direction * speed * delta
	if abs(position.y - start_position.y) > amplitude:
		direction *= -1 
