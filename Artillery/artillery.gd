extends Node2D
var force:float
var angle:float
var roundToFire:Resource = load("res://Artillery/projectile.tscn")
var projectile:Node
var barrelPos:Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	angle = snapped($Angle.value, 0.1)
	force = snapped($Force.value, 0.1)
	$AngleText.set_text(str(angle))
	$InitVText.set_text(str(force))
	$Wheel/Barrel.set_rotation_degrees(- angle)
	
	barrelPos = $Wheel/Barrel/Node2D.get_global_position()
	$"../CanvasLayer/Label".text = str("Barrel x position is :", snapped(float(barrelPos.x/75), 0.1))
	
	get_parent().updateAngle(angle)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_angle_value_changed(value: float) -> void:
	barrelPos = $Wheel/Barrel/Node2D.get_global_position()
	#print(barrelPos)
	angle = snapped(value, 0.1)
	$AngleText.set_text(str(angle))
	$Wheel/Barrel.set_rotation_degrees(- angle)
	$Wheel/Barrel/Ring.set_rotation_degrees(- 2*angle)
	$"../CanvasLayer/Label".text = str("Barrel x position is :", snapped(float(barrelPos.x/75), 0.1))
	get_parent().updateAngle(angle)
	pass # Replace with function body.


func _on_force_value_changed(value: float) -> void:
	force = snapped(value, 0.1)
	$InitVText.set_text(str(force))
	pass # Replace with function body.


func _on_button_pressed() -> void:
	projectile = roundToFire.instantiate()
	projectile.angle = angle
	projectile.force = force * Global.meter
	projectile.initialPosition = barrelPos
	projectile.set_global_position(barrelPos)
	Global.gameMaster.disableInput()
	$Wheel/Barrel/GPUParticles2D.restart()
	$AudioStreamPlayer.play()
	add_sibling(projectile)
	pass # Replace with function body.
