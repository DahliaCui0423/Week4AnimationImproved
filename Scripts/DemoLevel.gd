extends Node2D

onready var player = $YSort/Player
onready var startPoint = $YSort/StartingPoint

func _ready():
	if (GlobalData.current_data["new_level"] == true):
		player.position = startPoint.position
	else:
		player.global_position.x = GlobalData.current_data["Player_position_x"]
		player.global_position.y = GlobalData.current_data["Player_position_y"]
	GlobalData.current_data["Level"] = 2
	GlobalData.current_data["new_level"] = false


func _on_Door_changeScene():
	GlobalData.current_data["new_level"] = true
	get_tree().change_scene("res://Scenes/ThirdLevel.tscn")


func _on_Restart_pressed():
	GlobalData.reset_data()
	PlayerStats.health = 5
	get_tree().change_scene("res://Scenes/DemoLevel.tscn")
