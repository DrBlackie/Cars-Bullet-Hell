extends CharacterBody2D

@export var speed := 300
@export var focus_speed := 160
@onready var animated_sprite = $AnimatedSprite2D
@onready var audio = $AudioStreamPlayer

var screen_size: Vector2
var focus := false
var alive = true

func _ready():
	screen_size = get_viewport_rect().size

func _process(_delta):
	var dir = Input.get_vector("left", "right", "up", "down")
	velocity = dir * (focus_speed if focus else speed)
	move_and_slide()

	var character_size = Vector2(25, 60)
	global_position.x = clamp(global_position.x, character_size.x / 2, screen_size.x - character_size.x / 2)
	global_position.y = clamp(global_position.y, character_size.y / 2, screen_size.y - character_size.y / 2)
	
	if alive:
		if Input.is_action_just_pressed("focus"):
			focus = !focus
			animated_sprite.visible = true
			animated_sprite.play()
		if !focus:
			animated_sprite.visible = false
			$AnimatedSprite2D.visible = false
	else: 
		pass

func hit():
	audio.play()
	$spongebob_popsicle.process_mode = Node.PROCESS_MODE_DISABLED 
	$spongebob_popsicle.visible = false
	$AnimatedSprite2D.visible = false
	$CollisionShape2D.set_deferred("disabled", true)
	alive = false
	
