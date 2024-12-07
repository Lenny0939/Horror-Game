extends CharacterBody2D

const max_battery = 600
var speed = 150  # speed in pixels/sec
var batteries = 3
var battery = 600
var direction_facing: Vector2
@onready var torch = get_node("torch")
@onready var mega_torch = %MegaTorch
@onready var sprite = $AnimatedSprite2D
@onready var monster = $"../Monster"
@onready var torch_area = $torch/Area2D
@onready var footsteps = $Footsteps
@onready var battery_bar = $"../CanvasLayer/Battery Bar"

func _physics_process(delta):
	$"../CanvasLayer/Batteries Label".text = str(batteries)
	battery_bar.value = battery

	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed * delta * 60
	if not direction.is_zero_approx():
		direction_facing = direction
		if not footsteps.playing: footsteps.play()
		match direction.normalized():
			Vector2(1, 0):
				sprite.animation = "runs"
				sprite.flip_h = 0
			Vector2(-1, 0):
				sprite.animation = "runs"
				sprite.flip_h = 1
			Vector2(0, 1):
				sprite.animation = "runf"
			Vector2(0, -1):
				sprite.animation = "runb"
			_:
				sprite.animation = "runs"
	else:
		sprite.animation = "idle"
		footsteps.stop()
		
	if(Input.is_action_just_pressed("use_battery") && batteries > 0):
		batteries -= 1
		if($Area2D.overlaps_area(mega_torch)):
			mega_torch.charge()
		else:
			battery = max_battery

	if(Input.is_action_pressed("light") && battery > 0):
		light()
	else:
		torch.enabled = false
		$torch/Area2D/CollisionPolygon2D.disabled = true
	
	get_node("torch").rotation_degrees = rad_to_deg(direction_facing.angle())
	if torch_area.overlaps_area(monster):
		monster.discover()
	if $Area2D.overlaps_body(monster):
		monster.player_die()
	
	move_and_slide()
	
func collect_battery():
	batteries += 1

func light():
	torch.enabled = true
	$torch/Area2D/CollisionPolygon2D.disabled = false
	battery -=1
