extends KinematicBody2D

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var HitBoxCollision = $HitBoxPivot/SwordHitBox/CollisionShape2D
onready var hurtbox = $HurtBox

enum {
	MOVE,
	ATTACK,
	DASH
}

var state = MOVE
var velocity = Vector2.ZERO
export var max_speed = 150
export var dash_speed = 175
var dash_vector = Vector2.DOWN
var stats = PlayerStats

func _ready():
	stats.connect("die", self, "player_die")
	animationTree.active = true
	HitBoxCollision.disabled = true

func _physics_process(delta):
	match state:
		MOVE:
			state_move(delta)
		ATTACK:
			state_attack(delta)
		DASH:
			state_dash(delta)

# I did the assignemnt wrong. I thought the player need to control the character.
func state_move(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		dash_vector = input_vector
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationTree.set("parameters/Dash/blend_position", input_vector)
		animationState.travel("Run")
		velocity = input_vector * max_speed
	else:
		animationState.travel("Idle")
		velocity = Vector2.ZERO
	
	move()
	
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
		
	if Input.is_action_just_pressed("dash"):
		state = DASH
	
	GlobalData.current_data["Player_position_x"] = global_position.x
	GlobalData.current_data["Player_position_y"] = global_position.y

func state_attack(delta):
	velocity = Vector2.ZERO
	animationState.travel("Attack")

	
func state_dash(delta):
	velocity = dash_vector * dash_speed
	animationState.travel("Dash")
	move()

func move():
	velocity = move_and_slide(velocity)
	
func attack_animation_finished():
	state = MOVE
	
func dash_animation_finished():
	velocity = Vector2.ZERO
	state = MOVE

func _on_HurtBox_area_entered(area):
	stats.health -= 1
	hurtbox.start_invincibility(0.5)
	hurtbox.create_hit_effect()
	print(stats.health)
	
func player_die():
	queue_free()
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
