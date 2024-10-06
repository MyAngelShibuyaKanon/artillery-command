extends RigidBody2D
var maxHp:int
var hp:int
var visibleDamage:Color
var initPos:Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	maxHp = 20
	initPos = get_global_position()
	get_parent().get_parent().addEnemy(get_instance_id(), initPos, maxHp)
	contact_monitor = true
	max_contacts_reported = 10
	
	hp = maxHp
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_body_entered(body: Node) -> void:
	var damage:int
	#if body.is_in_group("material"):
		#damage = body.mass / 5
	if body.is_in_group("projectile"):
		damage = body.velocityBefCol.length() / 75
	else: return
		
	hp -= damage
	get_parent().get_parent().updateHp(get_instance_id(), hp)
	
	visibleDamage = Color(1,clamp(remap(hp, maxHp, 0, 1, 0), 0, 1), clamp(remap(hp, maxHp, 0, 1, 0), 0, 1), 1)
	set_modulate(visibleDamage)
	print("Enemy hp is ", hp)
	
	pass # Replace with function body.
