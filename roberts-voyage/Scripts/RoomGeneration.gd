extends Node

var currentBiom = "U"

var Bioms = ["U", "S", "H"]

var currentLevelinBiom = 0

#Old Room is a parameter to delete from the screen
func createnewroom(oldroom:Node2D):
	oldroom.queue_free();
	
