extends Area2D

@onready  var Bullet_scene = preload("res://bullet.tscn")
@onready var rng = RandomNumberGenerator.new()
@export var bullet_angle = 0.0
@export var min_wait_time = 0.05
@export var angle_increment = 25
@export var player: Node2D
@export var burst_count := 8
@export var burst_cooldown := 1.5
@export var burst_spacing := 0.05 
@export var bullet_speed := 600

func _ready():
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
	b.global_position = $Muzzle2.global_position
	b.direction = dir
	b.speed = bullet_speed
	owner.add_child.call_deferred(b)
	

func shoot():
	#var bullet:Bullet = Bullet_scene.instantiate()
	#owner.add_child(bullet)
	#bullet.rotate_bullet(rng.randf_range(-45, 45))
	#bullet.global_transform = $Muzzle.global_transform
	var bullet:Bullet = Bullet_scene.instantiate()
	owner.add_child(bullet)
	bullet.rotate_bullet(bullet_angle)
	bullet_angle += angle_increment
	bullet.global_transform = $Muzzle.global_transform

func radial_homing_shoot():
	#var bullet:Bullet = Bullet_scene.instantiate()
	#owner.add_child(bullet)
	#bullet.rotate_bullet(rng.randf_range(-45, 45))
	#bullet.global_transform = $Muzzle.global_transform
	var bullet:Bullet = Bullet_scene.instantiate()
	owner.add_child(bullet)
	bullet.rotate_bullet(bullet_angle)
	bullet_angle += angle_increment
	bullet.global_transform = $Muzzle.global_transform

	# homing
	if rng.randf() < 0.02:
		var dir := (player.global_position - bullet.global_position).normalized()
		bullet.direction = dir

func _on_timer_timeout():
	#shoot()
	radial_homing_shoot()

#func _on_timer_2_timeout():
	#$Timer.wait_time = maxf(min_wait_time, $Timer.wait_time/2)
	# pass
