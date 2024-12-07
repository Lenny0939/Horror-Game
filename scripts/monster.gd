extends CharacterBody2D

@onready var player = $"../Player"
@onready var light = $Light
@onready var sprite = $Sprite2D
@onready var roar = $Roar
@onready var lenny_roar = $"Lenny Roar"
@onready var laugh = $Laugh
@onready var rng = RandomNumberGenerator.new()

var direction

var enraged = false
var discovered = false
var target_position
var speed = 40.0
var player_position
var player_distance
var end = false
var enemy_dead = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not end:
		target_position = (player.position - position).normalized()
		player_position = player.position
		player_distance = position.distance_to(player_position)
		if not discovered: speed = player_distance / 6
		else: speed = 40
		velocity = target_position * 50 * delta * 60
	
		if position.distance_to(player.position) < 100 and not discovered:
			jumpscare()
			discovered = true
		
		if position.distance_to(player.position) > 300:
			unjumpscare()
			discovered = false
		
		if not discovered and position.distance_to(player.position) > 1000:
			pass
			# teleport near the player
		direction = round(target_position)
	
		match direction:
			Vector2(0, 1):
				sprite.animation = "runf"
			Vector2(0, -1):
				sprite.animation = "runb"
			Vector2(1, 0):
				sprite.animation = "runs"
				sprite.flip_h = 0
			Vector2(-1, 0):
				sprite.animation = "runs"
				sprite.flip_h = 1
			_:
				sprite.animation = "runs"
	
		move_and_slide()

func _ready() -> void:
	position.x = rng.randi_range(0, 3600)
	position.y = rng.randi_range(0, 3600)
	

func discover():
	if not discovered:
		discovered = true
		jumpscare()
		
func jumpscare():
	pass
	#TODO
	light.enabled = true
	roar.play()

func unjumpscare():
	light.enabled = false

func monster_die():
	sprite.animation = "die"
	enemy_dead = true
	end = true
	var timer := Timer.new()
	timer.autostart = true
	timer.wait_time = 3.0
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)

func player_die():
	if not end:
		sprite.animation = "kill"
		lenny_roar.play()
		end = true
		$"../Player/AnimatedSprite2D".visible = false
		var timer := Timer.new()
		timer.autostart = true
		timer.wait_time = 3.0
		timer.timeout.connect(_on_timer_timeout)
		add_child(timer)

func _on_timer_timeout():
	if enemy_dead: get_tree().change_scene_to_file("res://credits.tscn")
	else: get_tree().change_scene_to_file("res://scenes/gameover.tscn")
