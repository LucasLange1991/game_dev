extends Sprite2D


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	

func _process(delta):
	if Input.is_action_pressed("ui_right"):
		$/root/world/CharacterBody2D/Sprite2D.texture = load("res://skele_equip.png").duplicate()

