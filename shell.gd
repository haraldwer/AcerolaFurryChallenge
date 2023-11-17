extends MeshInstance3D

@export var MinInterp = 2.0
@export var MaxInterp = 3.0
@export var Fric = 0.0002
@export var Gravity = 0.5

var Velocity = Vector3()
var Position = Vector3()
var Reference : Node3D
var Height
var BaseVel = Vector3()

func physics(delta) :
	
	var targetPos = Reference.global_position
	var difference = targetPos - Position
	var posDelta = BaseVel + difference / delta
	
	# Gravity
	Velocity.y -= Gravity * Height;
	
	# Acceleration
	var interp = lerp(MinInterp, MaxInterp, Height)
	Velocity = lerp(Velocity, posDelta, interp * delta)
	
	# Friction
	Velocity *= pow(Fric, delta)
	
	# Apply velocity
	Position += Velocity * delta
	
	global_position = lerp(targetPos, Position, Height)
	rotation = Reference.rotation
	scale = Reference.scale
	
	pass
