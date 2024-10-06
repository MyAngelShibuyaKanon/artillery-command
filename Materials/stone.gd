extends RigidBody2D
var maxHp:int
var hp:int
var visibledamage:Color
var Contacts:Array[int] = []

func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 10
	maxHp = 60

	hp = maxHp
	pass 


func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node) -> void:
	if body.is_in_group("projectile"):
		if Contacts.find(body.get_instance_id()) == -1:
			$AudioStreamPlayer.play()
			Contacts.append(body.get_instance_id())
			
		var damage:int = body.velocityBefCol.length() / Global.meter
		hp -= damage
		print(hp)
		visibledamage = Color(1,clamp(remap(hp, maxHp, 0, 1, 0), 0, 1), clamp(remap(hp, maxHp, 0, 1, 0), 0, 1), 1)
		set_modulate(visibledamage)
		
		if (hp <= 0):
			queue_free()
	
	pass 
