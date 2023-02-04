extends Area2D


enum ResourceType {LIQUID, SOLID, GAS}
export (ResourceType) var resource_type


func try_fill(player):
	if false: # Can fill
		player.deactivate()
		# Call main for fill, wait for fill
		player.activate()
