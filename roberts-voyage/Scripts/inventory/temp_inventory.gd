extends Control

@onready var player_inventory: PanelContainer = $PlayerInventory

func setPlayerInventoryData(invData: InventoryData) -> void:
	if invData == null:
		print("inventory is null")
	else:
		player_inventory.setInventoryData(invData)
