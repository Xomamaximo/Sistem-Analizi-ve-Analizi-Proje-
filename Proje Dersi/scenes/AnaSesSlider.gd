extends HSlider

var bus_name:String = "Music"
var bus_index:int

func _ready():
	bus_index = AudioServer.get_bus_index(bus_name)
	value_changed.connect(_on_value_changed)

func _on_value_changed():
	AudioServer.set_bus_volume_db(bus_index,linear_to_db(value))

func _process(delta):
	pass
