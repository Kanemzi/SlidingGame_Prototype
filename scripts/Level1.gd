extends Node2D

signal move_end

onready var blocks = $blocks

var levelData : Dictionary
var grid = []
var player : Node2D
var playerPos : Vector2
var moveComplete = false

func _ready():
	
	var file = File.new()
	file.open('res://levels/level1.json', File.READ)
	levelData = JSON.parse(file.get_as_text()).result
	get_node('/root/Loader').loadLevel(self, levelData)

	player.connect("move_up", self, "_on_player_move", [Vector2(0, -1)])
	player.connect("move_down", self, "_on_player_move", [Vector2(0, 1)])
	player.connect("move_left", self, "_on_player_move", [Vector2(-1, 0)])
	player.connect("move_right", self, "_on_player_move", [Vector2(1, 0)])
	player.connect("died", get_tree(), "reload_current_scene")
	pass
	
func _on_player_move(direction : Vector2) :
	$moveTimeout.start()
	
	moveComplete = false
	
	while not moveComplete :
	
		var target = move_until_collision(direction)
		
		var distance = playerPos.distance_to(target) + 0.001
		
		playerPos = target
		
		player.tween.interpolate_property(player, "position", 
				player.position, playerPos * 32,
				distance / player.SPEED, 
				Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
		
		player.tween.start()
		
		yield(player.tween, "tween_completed")
		
		var currentCell = grid[playerPos.y][playerPos.x]
		
		if currentCell == null :
			moveComplete = true
	
	emit_signal("move_end")
	pass

func _on_moveTimeout_timeout():
	pass

func move_until_collision(direction : Vector2) :
	var checked = Vector2(playerPos.x, playerPos.y)
	
	var stop = false
	
	while grid[checked.y][checked.x] == null || not stop :
		if (checked.x < 0 || checked.x >= grid[0].size() || checked.y < 0 || checked.y >= grid.size()) :
			return checked + direction * 100
		
		var cell = grid[checked.y][checked.x]
		if cell.is_in_group('blocks') :
			stop = true
		
		checked += direction
		
	return checked - direction