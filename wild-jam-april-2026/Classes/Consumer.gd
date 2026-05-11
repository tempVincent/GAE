class_name Consumer extends Machine
## A consumer is a trash bin for ingredients in the kitchen
## 
## The player can interact with it if their hand is not empty
## interaction with consumers are lower priority than interactions with processors

## this method is called from the player's interactive area.
func interact(player: PlayerController, item: Variant) -> void:
	if player.itemInHand == null:
		pass
	else:
		player.placeIteminHand(null)
