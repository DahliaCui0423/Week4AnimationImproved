extends Node2D

export(int) var max_health = 1
var health = max_health setget set_health

signal die
signal health_changed(value)
signal max_health_changed(value)

func set_max_health(value):
	max_health = value
	self.health = min(health, max_health)
	emit_signal("max_health_changed", max_health)

func set_health(value):
	health = value
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("die")

func _ready():
	self.health = max_health
