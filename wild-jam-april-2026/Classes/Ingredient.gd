class_name Ingredient extends Resource

enum Flavour {
	banana,
	chilli
}

@export var id: String
@export var displayName: String
@export var displayTexture: Texture2D
@export var flavour: Flavour
