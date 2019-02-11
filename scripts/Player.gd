extends KinematicBody2D

signal move_up
signal move_down
signal move_left
signal move_right

signal died

const SPEED = 50

var moving = false
onready var tween = $MoveTween

func _ready():
	get_tree().get_current_scene().connect("move_end", self, "_on_move_end")
	pass # Replace with function body.

func _process(delta):
	if position.x < 0 || position.x > get_viewport().size.x || position.y < 0 ||  position.y > get_viewport().size.y:
		emit_signal("died")
		
	if moving :
		return
	if Input.is_action_pressed("ui_up") :
		emit_signal("move_up")
		moving = true
	elif Input.is_action_pressed("ui_down") :
		emit_signal("move_down")
		moving = true
	elif Input.is_action_pressed("ui_left") :
		emit_signal("move_left")
		moving = true
	elif Input.is_action_pressed("ui_right") :
		emit_signal("move_right")
		moving = true

func _input(event):
	pass
		
func _on_move_end() :
	moving = false
	pass
	