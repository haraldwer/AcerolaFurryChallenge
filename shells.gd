extends Node3D

@export var NumShells = 64
@export var ShellSpeed = 20.0

var Shells : Array

func _ready():
	createShells($"../Moustache", Vector3(0, 0, 0));
	createShells($"../Brow", Vector3(0, 50, 0));
	pass

func createShells(ogShell : MeshInstance3D, baseVelocity : Vector3) :
	for n in NumShells :
		var shell = ogShell.duplicate()
		add_child(shell)
		Shells.append(shell)
		var height = (float(n) / float(NumShells))
		var mat = shell.get_surface_override_material(0)
		var newMat = mat.duplicate()
		newMat.set_shader_parameter("Height", height)
		shell.set_surface_override_material(0, newMat)
		shell.Reference = ogShell
		shell.Height = height
		shell.BaseVel = baseVelocity
		shell.sorting_offset = n
	ogShell.hide()
	pass

func _process(delta):
	if delta > 0.02 :
		delta = 0.02
	for shell in Shells :
		shell.physics(delta)
	pass
