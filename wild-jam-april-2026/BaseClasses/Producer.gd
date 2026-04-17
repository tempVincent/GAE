class_name Producer extends Machine

var productPath: String

func produce(carrier: Node2D) -> Portable:
	var newProduct: Portable = load(productPath).instantiate()
	carrier.add_child(newProduct)
	newProduct.isBeingCarried = true
	newProduct.freeze = true
	newProduct.collision.disabled = true
	newProduct.scale = Vector2(0.5,0.5)
	return newProduct
