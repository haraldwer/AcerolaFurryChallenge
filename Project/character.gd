extends Node3D

@export var Sensitivity = 0.005
@export var Smoothing = 10.0

var Dragging = false
var TargetRot = Vector2(0.0, 0.0)
var CurrentRot = Vector2(0.0, 0.0)

func _ready():
	get_window().size = Vector2i(1000, 1000)
	pass

func _process(delta):
	Dragging = Input.is_action_pressed("drag")
	CurrentRot = CurrentRot.lerp(TargetRot, delta * Smoothing)
	$Character.rotation = Vector3(CurrentRot.y, CurrentRot.x, 0.0)
	pass

func _input(event):
	if event is InputEventMouseMotion:
		if Dragging :
			TargetRot += event.relative * Sensitivity
