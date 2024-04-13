extends CharacterBody2D

@export var max_speed = 300
@export var acceleration = 1500
@export var friction = 1200

@onready var axis = Vector2.ZERO


func _physics_process(delta):
	pass
	
	
func get_input_axis():
	axis.x = int(Input.is_action_just_pressed("move_right")) -
