extends Area2D

@onready  var Bullet_scene = preload("res://bullet.tscn")
@onready var rng = RandomNumberGenerator.new()
@export var bullet_angle = 0.0
@export var min_wait_time = 0.05
@export var angle_increment = 25
@export var player: Node2D

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
	get_tree().get_first_node_in_group("bullets").add_child(bullet)
	bullet.rotate_bullet(bullet_angle)
	bullet_angle += angle_increment
	bullet.global_transform = $Muzzle.global_transform

	# homing
	if rng.randf() < 0.01:
		var dir := (player.global_position - bullet.global_position).normalized()
		bullet.direction = dir

func _on_timer_timeout():
	#shoot()
	radial_homing_shoot()

#func _on_timer_2_timeout():
	#$Timer.wait_time = maxf(min_wait_time, $Timer.wait_time/2)
	# pass
