extends RigidBody2D
var maxHp:int
var hp:int
var visibleDamage:Color
var initPos:Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initPos = get_global_position()
	get_parent().get_parent().addEnemy(initPos)
	contact_monitor = true
	max_contacts_reported = 10
	maxHp = 20
	hp = maxHp
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_body_entered(body: Node) -> void:
	var damage:int
	if body.is_in_group("material"):
		damage = body.mass / 5
	elif body.is_in_group("projectile"):
		damage = body.velocityBefCol / 75
	else: return
		
	hp -= damage
	
	visibleDamage = Color(1,clamp(remap(hp, maxHp, 0, 1, 0), 0, 1), clamp(remap(hp, maxHp, 0, 1, 0), 0, 1), 1)
	set_modulate(visibleDamage)
	print("Enemy hp is ", hp)
	if hp <= 0:
		get_parent().get_parent().killEnemy(initPos)
		queue_free()
		
		
	
	
	
	pass # Replace with function body.
