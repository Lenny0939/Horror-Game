extends Area2D

@onready var monster = $"../Monster"
@onready var laser = $Area2D
@onready var laser_sprite = $AnimatedSprite2D
@onready var laser_light = $AnimatedSprite2D/PointLight2D
@onready var laser_hitbox = $AnimatedSprite2D/Area2D/CollisionShape2D
@onready var laser_area = $AnimatedSprite2D/Area2D
@onready var player = $"../Player"
const batteries_needed = 10

var batteries = 0

func charge():
	batteries += 1
	if batteries >= batteries_needed: shoot()
		
func shoot():
	laser_sprite.visible = true
	laser_hitbox.disabled = false
	
func _process(delta) -> void:
	if(laser_area.overlaps_body(monster)):
		monster.monster_die()
