extends Node

var player_file_path = "user://player_data.json"

var default_data = {
	"new_level" : true,
	"Player_health" : 5,
	"Player_position_x" : 0,
	"player_position_y" : 0,
	"Level": 0
}

var current_data = default_data.duplicate(true)

func reset_data():
	current_data.clear()
	current_data = default_data.duplicate(true)

func save_data(path: String):
	var file = File.new()
	file.open(path, File.WRITE)
	file.store_line(to_json(current_data))
	file.close()
	print("saved!")
	print(current_data)

func load_data(path: String):
	var file = File.new()
	file.open(path, File.READ)
	var data_json = JSON.parse(file.get_as_text())
	file.close()
	current_data = data_json.result
	print("load...")
	print(current_data)
