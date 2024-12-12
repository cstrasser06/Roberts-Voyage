extends Node

var currentBiom = 0

var Bioms = ["U", "S", "H"]

var currentLevelinBiom = 0

var characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
var loaded_scene = load("res://Scenes/Rooms/Room_UA0.tscn");
var currentscene = loaded_scene.instantiate();

var enemyamount = 0
var gobj

func initrooms(gameobj):
	gobj = gameobj
	await get_tree().create_timer(1).timeout;
	loaded_scene = load("res://Scenes/Rooms/Room_UA0.tscn");
	currentscene = loaded_scene.instantiate();
	gobj.call_deferred("add_child", currentscene)

func increaselevel():
	currentLevelinBiom += 1;

func increaseBiom():
	currentLevelinBiom = 0;
	currentBiom += 1

func createnewroom():
	currentscene.queue_free();
	
	await get_tree().create_timer(1).timeout;
	if(currentLevelinBiom >= 3):
		var load = load("res://Scenes/Rooms/Room_"+ Bioms[currentBiom] + characters[randi_range(0,0)]+"1.tscn");
		currentscene = load.instantiate()
		gobj.add_child(currentscene)
		
		load = load("res://Scenes/BarStats.tscn")
		var scene = load.instantiate()
		currentscene.add_child(scene)
		
		for i in randi_range(1,3):
			Enemyspawning.spawn_energyball()
	else:
		var load = load("res://Scenes/Rooms/Room_"+ Bioms[currentBiom] + characters[randi_range(0,8)]+"0.tscn");
		currentscene = load.instantiate()
		#get_tree().root.call_deferred("add_child", currentscene)
		gobj.add_child(currentscene)
		
		load = load("res://Scenes/BarStats.tscn")
		var scene = load.instantiate()
		currentscene.add_child(scene)
		
		for i in randi_range(1,3):
			Enemyspawning.spawn_energyball()
			
	


func createnewbossroom():
	currentscene.queue_free();
	await get_tree().create_timer(1).timeout;
	var load = load("res://Scenes/Rooms/Bossroom_"+ Bioms[currentBiom] + characters[randi_range(0,0)]+".tscn");
	currentscene = load.instantiate()
	#get_tree().root.call_deferred("add_child", currentscene)
	gobj.add_child(currentscene)
	Enemyspawning.spawn_bossU()
