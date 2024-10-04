extends RigidBody2D
class_name projectile

var gravity = Global.meter * 9.8
var force:float;
var angle:float;
var startTime
var initialPosition
var lastVelocity
var velocityBefCol
var collision
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print(get_global_position())
	startTime = Time.get_unix_time_from_system()
	linear_velocity.x = force * cos(deg_to_rad(angle))
	linear_velocity.y = - (force * sin(deg_to_rad(angle)))
	initialPosition = get_global_position()
	#print(linear_velocity.x)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	collision = move_and_collide(linear_velocity * delta)
	if (collision):
		velocityBefCol = lastVelocity
	linear_velocity.y += gravity * delta
	
	lastVelocity = linear_velocity.length()
	pass


func _on_body_entered(body: Node) -> void:
	pass # Replace with function body.
