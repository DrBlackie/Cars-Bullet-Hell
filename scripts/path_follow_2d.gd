extends PathFollow2D

var speed = 100
var direction = 1

func _ready():
	progress_ratio = 0.0

func _process(delta):
	if progress_ratio == 0:
		direction = 1
	progress_ratio += 0.4 * direction * delta
	if progress_ratio == 1.0:
		direction = -1
