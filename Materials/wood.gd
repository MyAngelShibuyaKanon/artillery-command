class_name material extends RigidBody2D
var maxHp
var hp
var visibledamage:Color
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 10
	maxHp = 40
	hp = maxHp
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass


func _on_body_entered(body: projectile) -> void:
	var damage = body.velocityBefCol / Global.meter
	print(damage)
	hp -= damage
	
	visibledamage = Color(1,clamp(remap(hp, maxHp, 0, 1, 0), 0, 1), clamp(remap(hp, maxHp, 0, 1, 0), 0, 1), 1)
	print(visibledamage)
	set_modulate(visibledamage)
	pass # Replace with function body.
