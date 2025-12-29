extends Area2D

@onready  var Bullet_scene = preload("res://bullet.tscn")
@export var burst_count := 8
@export var burst_cooldown := 1.5
@export var burst_spacing := 0.05
@export var bullet_speed := 600
@export var player: CharacterBody2D

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	print(player)
	start_firing()

func start_firing():
	while true:
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
