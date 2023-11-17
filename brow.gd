extends Node3D

@export var MinPoseTime = 3.0
@export var MaxPoseTime = 5.0
@export var Interp = 10.0

var PoseTimer = 0.0
var TargetPose : Node3D

func _ready():
	setPose()
	pass

func setPose() :
	PoseTimer = randf_range(MinPoseTime, MaxPoseTime)
	var nC = get_child_count()
	var prevPose = TargetPose
	while prevPose == TargetPose :
		TargetPose = get_child(randi_range(0, nC - 1))
	pass


func _process(delta):
	
	var brow = $"../Character/Brow"
	var newTrans = brow.transform.interpolate_with(TargetPose.global_transform, Interp * delta)
	brow.transform = newTrans
	
	if Input.is_action_just_released("drag") :
		setPose()
	
	PoseTimer -= delta
	if PoseTimer < 0 :
		setPose()
	pass
