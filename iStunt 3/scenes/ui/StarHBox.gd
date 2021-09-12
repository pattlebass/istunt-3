extends HBoxContainer


onready var label = $Label
var total_stars := 0
var stars_collected := 0


func _ready() -> void:
	for i in get_tree().get_nodes_in_group("stars"):
		total_stars += 1
		i.connect("star_collected", self, "star_collected")
	label.text = "%s / %s" % [0, total_stars]


func star_collected() -> void:
	stars_collected += 1
	label.text = "%s / %s" % [stars_collected, total_stars]
