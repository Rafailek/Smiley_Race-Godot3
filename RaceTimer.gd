extends Label

var running = true;
var elapsed = 0;

func _process(delta):
	if (running):
		elapsed += delta;
	text = "%0.3f" % elapsed

func stop_timer():
	running = false
