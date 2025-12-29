extends Area2D

class_name Bullet

var speed = 200
var direction = Vector2.DOWN

func _physics_process(delta):
	translate(direction * speed * delta)

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_body_entered(body):
	body.hit()

func rotate_bullet(degrees):
	direction = direction.rotated(deg_to_rad(degrees))
