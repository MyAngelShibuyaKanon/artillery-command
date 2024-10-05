extends RigidBody2D
class_name projectile

var gravity = Global.meter * 9.8
var force:float;
var angle:float;
var initialPosition
var lastVelocity
var velocityBefCol
var collision
var highestPoint

func _ready() -> void:
	
	highestPoint = 0
	linear_velocity.x = (force * cos(deg_to_rad(angle)))
	linear_velocity.y = - (force * sin(deg_to_rad(angle)))
	
	if (linear_velocity.length() >= 10 && !sleeping) :
		$Camera2D.set_enabled(true)
	pass


func _physics_process(delta: float) -> void:
	if (linear_velocity.length() <= 10 && !sleeping) :
		set_sleeping(true)
		$Camera2D.set_enabled(false)
	if (get_global_position().y < highestPoint):
		highestPoint = get_global_position().y
	
	collision = move_and_collide(Vector2.ZERO)
	if (collision):
		velocityBefCol = lastVelocity
	
	linear_velocity.y += gravity * delta
	
	lastVelocity = linear_velocity.length()
	pass
