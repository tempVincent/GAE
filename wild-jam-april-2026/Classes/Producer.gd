class_name Producer extends Machine
## A producer is a source of ingredients in the kitchen
## 
## The player can interact with it if their hand is empty
## interaction with producers are lower priority than any other interaction

var product: Node2D = null

## this method is called from the player's interactive area.
func interact(player: PlayerController, item: Variant) -> void:
	if player.itemInHand != null:
		pass
	else:
		player.placeIteminHand(product)
