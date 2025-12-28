extends Area2D

class_name Bullet

var speed = 200
var direction = Vector2.DOWN
var target: Node2D

func _ready():
	target = get_parent().get_node("Player")

func _physics_process(delta):
	var target_dir = (target.global_position - global_position).normalized()
	translate(target_dir * speed * delta)

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_body_entered(body):
	body.hit()

func rotate_bullet(degrees):
	direction = direction.rotated(deg_to_rad(degrees))
