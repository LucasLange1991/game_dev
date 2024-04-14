extends CharacterBody2D



const ACCELERATION = 8000
const FRICTION = 5000
const MAX_SPEED = 120

enum {IDLE, WALK}
var state = IDLE

@onready var animationTree = $AnimationTree
@onready var state_machine = animationTree["parameters/playback"]

var blend_position : Vector2 = Vector2.ZERO
var blend_pos_paths = [
	"parameters/idle/idle_bs2d/blend_position",
	"parameters/walk/walk_bs2d/blend_position"
]
var animTree_state_keys = [
	"idle",
	"walk"
]

func _physics_process(delta):
	move(delta)
	animate()
	toggle_player()

func move(delta):
	var input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if input_vector == Vector2.ZERO:
		state = IDLE
		apply_friction(FRICTION * delta)
	else:
		state = WALK
		apply_movement(input_vector * ACCELERATION * delta)
		blend_position = input_vector
	move_and_slide()


func apply_movement(amount) -> void:
	velocity += amount
	velocity = velocity.limit_length(MAX_SPEED)

func apply_friction(amount) -> void:
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
	else:
		velocity = Vector2.ZERO

func animate() -> void:
	state_machine.travel(animTree_state_keys[state])
	animationTree.set(blend_pos_paths[state], blend_position)
	######################################################################################
	
	
var blink_distance = 10
	
func blink():
	var blink_position = position + get_facing_direction() * blink_distance
	position = blink_position
		
func _process(delta):
	if Input.is_action_pressed("blink"):
		blink()
			
func get_facing_direction():
	#return Vector2(0, -1).rotated(rotation)
	var input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	return input_vector
	



func toggle_player():
	var player2 = $player2
	if Input.is_action_pressed("equip"):
		player2.visible = not player2.visible
	
