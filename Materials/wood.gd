extends RigidBody2D
var maxHp:int
var hp:int
var visibledamage:Color
var Contacts:Array[int] = []
func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 10
	maxHp = 40

	hp = maxHp
	pass 


func _process(delta: float) -> void:
	if (hp <= 0 && !$AudioStreamPlayer.playing):
			queue_free()
	pass


func _on_body_entered(body: Node) -> void:
	if body.is_in_group("projectile"):
		if Contacts.find(body.get_instance_id()) == -1:
			$AudioStreamPlayer.play()
			Contacts.append(body.get_instance_id())
		
		var damage:int = body.velocityBefCol / Global.meter
		hp -= damage
		
		visibledamage = Color(1,clamp(remap(hp, maxHp, 0, 1, 0), 0, 1), clamp(remap(hp, maxHp, 0, 1, 0), 0, 1), 1)
		set_modulate(visibledamage)
		
		
	
	pass 
