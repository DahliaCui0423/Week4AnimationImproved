extends CanvasLayer



func _on_Back_pressed():
	GlobalData.save_data(GlobalData.player_file_path)
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
