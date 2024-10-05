extends RigidBody2D
var maxHp
var hp
var visibledamage:Color

func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 10
	maxHp = 40

	hp = maxHp
	pass 


func _process(delta: float) -> void:
	pass


func _on_body_entered(body: projectile) -> void:
	var damage = body.velocityBefCol / Global.meter
	hp -= damage
	
	visibledamage = Color(1,clamp(remap(hp, maxHp, 0, 1, 0), 0, 1), clamp(remap(hp, maxHp, 0, 1, 0), 0, 1), 1)
	set_modulate(visibledamage)
	
	if (hp <= 0):
		queue_free()
	
	pass 
