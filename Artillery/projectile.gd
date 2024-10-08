extends RigidBody2D
class_name projectile
var tween:Tween
var gravity:float = Global.meter * 9.8
var force:float;
var angle:float;
var initialPosition:Vector2
var lastVelocity:Vector2
var velocityBefCol:Vector2
var collision:KinematicCollision2D
var highestPoint:float
var ifImpact:bool = false
var startTime

func _ready() -> void:
	tween = get_tree().create_tween()
	highestPoint = - (get_global_position().y - 1080 )
	linear_velocity.x = (force * cos(deg_to_rad(angle)))
	linear_velocity.y = - (force * sin(deg_to_rad(angle)))
	$CanvasLayer/InitVel.text = "Initial Velocity: " + str(snapped(linear_velocity.x / Global.meter, 0.01)) + "m/s" + ", " + str(- snapped(linear_velocity.y / Global.meter, 0.01)) + "m/s"
	startTime = Time.get_unix_time_from_system()
	if (linear_velocity.length() >= 10 && !sleeping) :
		get_parent().camState(false)
		$Camera2D.set_enabled(true)
		tween.tween_property($Camera2D,"zoom",Vector2(remap(linear_velocity.length() / Global.meter,50, 0, .2, 1), remap(linear_velocity.length()/ Global.meter,50, 0, .2, 1)), 0.2)
	pass


func _physics_process(delta: float) -> void:
	$CanvasLayer/CurVel.text = "Current Velocity: " + str(snapped(linear_velocity.x / Global.meter, 0.01)) + "m/s" + ", " + str(- snapped(linear_velocity.y / Global.meter, 0.01)) + "m/s"
	if (linear_velocity.length() <= 10 && !sleeping):
		if $Timer.is_stopped():
			$Timer.start(1)
		
	if (- (get_global_position().y - 1080 ) > highestPoint):
		highestPoint = (- (get_global_position().y - 1080 ))
		$CanvasLayer/highestPoint.text = "Highest Point: " + str((highestPoint) / Global.meter)
		
	
	collision = move_and_collide(Vector2.ZERO)
	if (collision):
		velocityBefCol = lastVelocity
		if (!ifImpact):
			ifImpact = true
			$CanvasLayer/FinalVel.text = "Final Velocity: " + str(snapped(velocityBefCol.x / Global.meter, 0.01)) + "m/s" + ", " + str(- snapped(velocityBefCol.y / Global.meter, 0.01)) + "m/s"
			$CanvasLayer/totalTime.text = "Travel Time: " + str(snapped(Time.get_unix_time_from_system() - startTime, 0.01)) + " seconds"
			$CanvasLayer/impactPos.text = "ImpactPos: " + str(Vector2(get_global_position().x / Global.meter, get_global_position().y / Global.meter))
		
	
	$Camera2D.set_zoom($Camera2D.zoom.lerp(Vector2(remap(linear_velocity.length() / Global.meter,50, 0, .2, 1), remap(linear_velocity.length()/ Global.meter,50, 0, .2, 1)), .5 * delta)) #wtf
	linear_velocity.y += gravity * delta
	
	lastVelocity = linear_velocity
	pass


func _on_timer_timeout() -> void:
	get_parent().camState(true)
	$Camera2D.set_enabled(false)
	queue_free()
