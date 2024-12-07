extends Node2D

var rng = RandomNumberGenerator.new()
const height = 70
const width = 70
const properties = 5
const max_chance = 1000
const base_ratio = 0.65
const max_rooms = 150
var rooms = 0
var rooms_built = 0
var layout = []

var room_scene = preload("res://scenes/room.tscn")
var door_scene = load("res://scenes/door.tscn")
var invisible_door_scene = preload("res://scenes/invisible_door.tscn")
var battery_scene = preload("res://scenes/battery.tscn")

func _ready():
	# initialises array
	for x in range(width):
		layout.append([])
		layout[x]=[]
		for y in range(height):
			layout[x].append([])
			for z in range(properties):
				layout[x][y].append([])
				layout[x][y][z]=0

	# creates initial room
	layout[width / 2][height / 2] = [1, 1, 1, 1, 1]
	generate_rooms()
	show_rooms()
	build_rooms()
	play_animation()

func generate_rooms():
	var i
	var j
	var created_room = false
	while not created_room:
		j = 0
		created_room = false
		for x in layout:
			i = 0
			if j >= width - 1: continue
			for y in layout:
				if i >= height - 1: continue
				if(layout[i][j][0] == 1):
					# if there is a door and if there is not already a room there
					if(layout[i][j][2] == 1 && layout[i + 1][j][0] == 0):
						created_room = true
						create_room(i + 1, j)
						
					if(layout[i][j][3] == 1 && layout[i][j + 1][0] == 0):
						created_room = true
						create_room(i , j + 1)
						
					if(layout[i][j][1] == 1 && layout[i][j - 1][0] == 0):
						created_room = true
						create_room(i, j - 1)
						
					if(layout[i][j][4] == 1 && layout[i - 1][j][0] == 0):
						created_room = true
						create_room(i - 1, j)

				i += 1
			j += 1
	
func create_room(x, y):
	rooms += 1
	layout[x][y][0] = 1
	var i = 0
	while i < properties - 1:
		i += 1

		if(rng.randi_range(0, max_chance) < max_chance * base_ratio and rooms < max_rooms and not (i == 1 && y >= height - 1 or (i == 2 and x >= width - 1) or (i == 3 && y < 1) or (i == 4 && x < 1 ))):
			layout[x][y][i] = 1

func show_rooms():
	var i 
	var j
	var demo_string = ''
	j = 0
	for x in layout:
		i = 0
		for y in layout:
			if(layout[i][j][0] == 1): demo_string = demo_string + '#'
			else: demo_string = demo_string + '.'

			i += 1
		j += 1
		print(demo_string)
		demo_string = ''
		
func build_rooms():
	var i = 0
	var j = 0
	
	for x in layout:
		j = 0
		for y in layout[i]:
			if(layout[i][j][0]):
				var room = room_scene.instantiate()
				add_child(room)
				rooms_built += 1
				room.position.x = i * 320 - width * 160
				room.position.y = j * 180 - height * 90
				var north_door
				if(layout[i][j][1]): north_door = door_scene.instantiate()
				else: north_door = invisible_door_scene.instantiate()
				add_child(north_door)
				north_door.position.x = i * 320 - width * 160
				north_door.position.y = j * 180 - 80 - height * 90
				
				var east_door
				if(layout[i][j][2]): east_door = door_scene.instantiate()
				else: east_door = invisible_door_scene.instantiate()
				add_child(east_door)
				east_door.position.x = i * 320 + 160 - width * 160
				east_door.position.y = j * 180 - 20 - height * 90
				if(rng.randi_range(0, 10) < max(i, j)):
					var battery = battery_scene.instantiate()
					add_child(battery)
					battery.position.x = i * 320 - width * 160 + rng.randi_range(-90, 90)
					battery.position.y = j * 180 - height * 90 + rng.randi_range(-40, 160)
			j += 1
		i += 1
		
func is_full():
	var i = 0
	var j = 0
	for x in layout:
		i = 0
		for y in layout:
			var l = 0
			while l < 4:
				l += 1
				if((layout[i][j][1] and not layout[i][j - 1][0]) or (layout[i][j][2] and not layout[i][j + 1][0]) or (layout[i][j][3] and not layout[i + 1][j][0]) or (layout[i][j][4] and not layout[i - 1][j][0])):
					return false
			i += 1
		j += 1
	return true

func play_animation():
	var timer := Timer.new()
	timer.autostart = true
	timer.wait_time = 3.0
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)

func _on_timer_timeout():
	$Dad.animation = "die"
