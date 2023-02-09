extends Area2D

onready var anim = $"Door Animation"
onready var block = $"Door Body/Door Body Collider"
onready var collider = $"Door Collider"
onready var is_open: bool = false

func _ready():
	pass

signal changeScene

func _on_Door_body_entered(body):
	if body.name == "Player":
		print("It's player")
		change_State()
	print("collide")
	

func change_State():
	is_open = not is_open
	if is_open:
		anim.play("Open")
	else:
		anim.play_backwards("Open")

func _on_Door_Animation_animation_finished(anim_name):
	if is_open :
		print("is open")
		emit_signal("changeScene")
		
	
	
	
