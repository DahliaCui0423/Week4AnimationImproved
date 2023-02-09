extends KinematicBody2D

onready var stats = $Stats
onready var playerDetection = $PlayerDetection
onready var hurtbox = $HurtBox
onready var sprite  = $AnimatedSprite
onready var collision = $HitBox/CollisionShape2D
const EnemyDeathEffect = preload("res://DeathEffect.tscn")

export var max_speed = 50

enum {
	IDLE,
	WANDER, # don't have time to do the wandering.
	CHASE
}

var velocity = Vector2.ZERO
var state = IDLE

func _physics_process(delta):
	match state:
		IDLE:
			seek_player()
		WANDER:
			pass
		CHASE:
			var player = playerDetection.player
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				velocity = direction * max_speed
			else:
				state = IDLE
			sprite.flip_h = velocity.x < 0
	velocity = move_and_slide(velocity)
		
func seek_player():
	if playerDetection.can_see_player():
		state = CHASE

func _on_HurtBox_area_entered(area):
	stats.health -= area.damage
	hurtbox.create_hit_effect()

func _on_Stats_die():
	print("die");
	queue_free()
	var enemyDeathEffect = EnemyDeathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.scale.x = 0.1
	enemyDeathEffect.scale.y = 0.1
	enemyDeathEffect.global_position = global_position
