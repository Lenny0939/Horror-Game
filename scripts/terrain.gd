extends Node2D

var rng = RandomNumberGenerator.new()
const height = 70
const width = 70
const properties = 5
const max_chance = 1000
const base_ratio = 0.6
const max_rooms = 80
var rooms = 0
var rooms_built = 0
var layout = []

var room_scene = preload("res://scenes/room.tscn")
var door_scene = load("res://scenes/door.tscn")


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
	build_rooms()

func generate_rooms():
	var i
	var j
	var created_room
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
			if(layout[i][j][1]):
				var door = door_scene.instantiate()
				add_child(door)
				door.position.x = i * 320 - width * 160
				door.position.y = j * 180 - 90 - height * 90
			if(layout[i][j][2]):
				var door = door_scene.instantiate()
				add_child(door)
				door.position.x = i * 320 + 160 - width * 160
				door.position.y = j * 180 - height * 90
			if(layout[i][j][3]):
				var door = door_scene.instantiate()
				add_child(door)
				door.position.x = i * 320# - width * 160
				door.position.y = j * 180 + 90# - height * 90
			if(layout[i][j][4]):
				var door = door_scene.instantiate()
				add_child(door)
				door.position.x = i * 320 - 160# - width * 160
				door.position.y = j * 180# - height * 90
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
