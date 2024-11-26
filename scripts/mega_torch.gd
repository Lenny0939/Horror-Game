extends Area2D

var batteries = 0

func charge():
	batteries += 1
	$PointLight2D.energy = batteries / 10
