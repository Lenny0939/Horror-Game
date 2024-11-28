extends CharacterBody2D

const max_battery = 600
var speed = 200  # speed in pixels/sec
var batteries = 20
var battery = 600
var direction_facing: Vector2
@onready var torch = get_node("torch")
@onready var mega_torch = %MegaTorch
@onready var area = $Area2D

func _physics_process(delta):
	$"../CanvasLayer/Battery Label".text = str(battery)
	$"../CanvasLayer/Batteries Label".text = str(batteries)
	$"../CanvasLayer/Audio Label".text = str(AudioServer.get_bus_peak_volume_left_db(0, 0))

	if (AudioServer.get_bus_peak_volume_left_db(1, 0) > -10 ):
		$"../Monster/AudioStreamPlayer2D".play()
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed * delta * 60
	if not direction.is_zero_approx():
		direction_facing = direction
	
	if(Input.is_action_just_pressed("use_battery") && batteries > 0):
		batteries -= 1
		if($Area2D.overlaps_area(mega_torch)):
			mega_torch.charge()
		else:
			battery = max_battery
	
	if(Input.is_action_pressed("light") && battery > 0):
		$torch.enabled = true
		battery -=1
	else:
		$torch.enabled = false
	
	get_node("torch").rotation_degrees = rad_to_deg(direction_facing.angle())
	move_and_slide()
	
func collect_battery():
	batteries += 1
