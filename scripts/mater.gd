extends Area2D

@onready  var Bullet_scene = preload("res://scenes/bullet.tscn")
@onready var mater_audio = $AudioStreamPlayer2D
@export var burst_count := 8
@export var burst_cooldown := 1.5
@export var burst_spacing := 0.05
@export var bullet_speed := 600
@export var player: CharacterBody2D
var on_screen = false

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	mater_audio.play()

func start_firing():
	while on_screen:
		await fire_burst()
		await get_tree().create_timer(burst_cooldown).timeout

func fire_burst():
	if player == null:
		return

	var dir = (player.global_position - global_position).normalized()

	for i in range(burst_count):
		fire_bullet(dir)
		await get_tree().create_timer(burst_spacing).timeout

func fire_bullet(dir: Vector2):
	var b = Bullet_scene.instantiate()
	get_tree().get_first_node_in_group("bullets").add_child(b)
	b.global_position = $Muzzle3.global_position
	b.direction = dir
	b.speed = bullet_speed


func _on_visible_on_screen_notifier_2d_screen_entered():
	on_screen = true
	start_firing()


func _on_visible_on_screen_notifier_2d_screen_exited():
	on_screen = false
	mater_audio.play()
