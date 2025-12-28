extends Area2D

@onready  var Bullet_scene = preload("res://bullet.tscn")
@onready var rng = RandomNumberGenerator.new()
@export var bullet_angle = 0.0
@export var min_wait_time = 0.05
@export var angle_increment = 25

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
	
func shoot1():
	var bullet:Bullet = Bullet_scene.instantiate()
	owner.add_child(bullet)
	#bullet.rotate_bullet(bullet_angle)
	#bullet_angle += angle_increment
	bullet.global_transform = $Muzzle2.global_transform 

func _on_timer_timeout():
	#shoot()
	shoot1()

func _on_timer_2_timeout():
	#$Timer.wait_time = maxf(min_wait_time, $Timer.wait_time/2)
	pass
