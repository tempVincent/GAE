class_name Producer extends StaticBody2D

var product: PackedScene

func receiveTo(carrier: Node2D) -> Carryable:
	var newProduct: Carryable = product.instantiate()
	carrier.add_child(newProduct)
	newProduct.isBeingCarried = true
	return newProduct
