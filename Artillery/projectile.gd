extends RigidBody2D
class_name projectile
var tween:Tween
var gravity:float = Global.meter * 9.8
var force:float;
var angle:float;
var initialPosition:Vector2
var lastVelocity:float
var velocityBefCol:float
var collision:KinematicCollision2D
var highestPoint:float

func _ready() -> void:
	tween = get_tree().create_tween()
	highestPoint = 0
	linear_velocity.x = (force * cos(deg_to_rad(angle)))
	linear_velocity.y = - (force * sin(deg_to_rad(angle)))
	
	if (linear_velocity.length() >= 10 && !sleeping) :
		get_parent().camState(false)
		$Camera2D.set_enabled(true)
		tween.tween_property($Camera2D,"zoom",Vector2(remap(linear_velocity.length() / Global.meter,50, 0, .2, 1), remap(linear_velocity.length()/ Global.meter,50, 0, .2, 1)), 0.2)
	pass


func _physics_process(delta: float) -> void:
	if (linear_velocity.length() <= 10 && !sleeping) :
		set_sleeping(true)
		get_parent().camState(true)
		$Camera2D.set_enabled(false)
	if (get_global_position().y < highestPoint):
		highestPoint = get_global_position().y
	
	collision = move_and_collide(Vector2.ZERO)
	if (collision):
		velocityBefCol = lastVelocity
	
	$Camera2D.set_zoom($Camera2D.zoom.lerp(Vector2(remap(linear_velocity.length() / Global.meter,50, 0, .2, 1), remap(linear_velocity.length()/ Global.meter,50, 0, .2, 1)), .5 * delta)) #wtf
	linear_velocity.y += gravity * delta
	
	lastVelocity = linear_velocity.length()
	pass
