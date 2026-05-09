class_name Ingredient extends Resource

enum Flavour {
	apple,
	banana,
	chilli,
	pear
}

@export var id: String
@export var displayName: String
@export var displayTexture: Texture2D
@export var flavour: Flavour
