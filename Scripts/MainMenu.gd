extends CanvasLayer

func _on_Start_pressed():
	GlobalData.reset_data()
	PlayerStats.health = 5
	get_tree().change_scene("res://Scenes/FirstLevel.tscn")
	


func _on_Load_pressed():
	GlobalData.load_data(GlobalData.player_file_path)
	PlayerStats.health = GlobalData.current_data["Player_health"]
	if (GlobalData.current_data["Level"] == 1):
		get_tree().change_scene("res://Scenes/FirstLevel.tscn")
	if (GlobalData.current_data["Level"] == 2):
		get_tree().change_scene("res://Scenes/DemoLevel.tscn")
	if (GlobalData.current_data["Level"] == 3):
		get_tree().change_scene("res://Scenes/ThirdLevel.tscn")


func _on_Level_pressed():
	get_tree().change_scene("res://Scenes/LevelMenu.tscn")
