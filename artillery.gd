extends Node2D
var force
var angle
var roundToFire = load("res://projectile.tscn")
var projectile
var barrelPos
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	barrelPos = $Wheel/Barrel/Node2D.get_global_position()
	angle = $Angle.value
	force = $Force.value
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_angle_value_changed(value: float) -> void:
	barrelPos = $Wheel/Barrel/Node2D.get_global_position()
	angle = value
	$Wheel/Barrel.set_rotation_degrees(- angle)
	pass # Replace with function body.


func _on_force_value_changed(value: float) -> void:
	print(value)
	force = value * Global.meter
	pass # Replace with function body.


func _on_button_pressed() -> void:
	projectile = roundToFire.instantiate()
	projectile.angle = angle
	projectile.force = force
	projectile.set_global_position(barrelPos)
	add_sibling(projectile)
	pass # Replace with function body.
