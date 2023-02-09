extends CanvasLayer


func _on_Lv1_pressed():
	GlobalData.reset_data()
	PlayerStats.health = 5
	get_tree().change_scene("res://Scenes/FirstLevel.tscn")


func _on_Lv2_pressed():
	GlobalData.reset_data()
	PlayerStats.health = 5
	get_tree().change_scene("res://Scenes/DemoLevel.tscn")


func _on_Lv3_pressed():
	GlobalData.reset_data()
	PlayerStats.health = 5
	get_tree().change_scene("res://Scenes/ThirdLevel.tscn")


func _on_Back_pressed():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
