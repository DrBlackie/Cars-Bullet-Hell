extends PathFollow2D

var direction = 1
var progress_speed = 0.05

func _ready():
	progress_ratio = 0.0

func _process(delta):
	if progress_ratio == 0:
		direction = 1
	progress_ratio += progress_speed * direction * delta
	
