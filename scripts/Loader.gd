extends Node2D

func loadLevel(node, level) :
	
	var blocks = node.get_node('blocks')
	var grid = node.grid
	
	var playerSpawned = false
	
	if ! blocks :
		print('[Error] : level can\'t be loaded')
		return
	
	var Block = preload('res://prefabs/Block.tscn')
	var SlopeBlock = preload('res://prefabs/SlopeBlock.tscn')
	var Start = preload('res://prefabs/StartPoint.tscn')
	var End = preload('res://prefabs/EndPoint.tscn')
	var Player = preload('res://prefabs/Player.tscn')
	
	for y in range(0, level.height) :
		grid.append([])
		for x in range(0, level.width) :
			
			var n = level.data[y][x]
			
			if n ==	1 :
				var b = Block.instance()
				b.position = Vector2(x * 32, y * 32)
				blocks.add_child(b)
				grid[y].append(b)
			elif n == 2 :
				var s = Start.instance()
				s.position = Vector2(x * 32, y * 32)
				blocks.add_child(s)
				grid[y].append(s)
				
				if !playerSpawned :
					playerSpawned = true
					var p = Player.instance()
					p.position = Vector2(s.position.x, s.position.y)
					blocks.add_child(p)
					node.player = p
					node.playerPos = Vector2(x, y)
				
			elif n == 3 :
				var e = End.instance()
				e.position = Vector2(x * 32, y * 32)
				blocks.add_child(e)
				grid[y].append(e)
				
			elif n >= 4 and n <= 7 :
				var sb = SlopeBlock.instance()
				sb.position = Vector2(x * 32, y * 32)
				sb.id = n
				sb.rotation_degrees = (n - 4) * 90
				blocks.add_child(sb)
				grid[y].append(sb)
			else :
				grid[y].append(null)
	print(grid)