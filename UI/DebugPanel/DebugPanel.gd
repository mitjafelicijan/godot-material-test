extends Control

onready var fps = $MarginContainer/VBoxContainer/FPS
onready var objects_rendered = $MarginContainer/VBoxContainer/ObjectsRendered
onready var vertices_rendered = $MarginContainer/VBoxContainer/VerticesRendered
onready var draw_calls = $MarginContainer/VBoxContainer/DrawCalls
onready var video_mem_used = $MarginContainer/VBoxContainer/VideoMemUsed

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			if event.scancode == KEY_ESCAPE:
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				
			if event.scancode == KEY_X:
				get_tree().quit()
				
			if event.scancode == KEY_F:
				OS.window_fullscreen = !OS.window_fullscreen
			
			if event.scancode == KEY_C:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	fps.set_text("FPS: %s" % [str(Performance.get_monitor(Performance.TIME_FPS))])
	objects_rendered.set_text("Objects: %s" % [str(Performance.get_monitor(Performance.RENDER_OBJECTS_IN_FRAME))])
	vertices_rendered.set_text("Vertices: %s" % [str(Performance.get_monitor(Performance.RENDER_VERTICES_IN_FRAME))])
	draw_calls.set_text("Draw calls: %s" % [str(Performance.get_monitor(Performance.RENDER_DRAW_CALLS_IN_FRAME))])
	video_mem_used.set_text("Video Mem used: %s" % [str(Performance.get_monitor(Performance.RENDER_USAGE_VIDEO_MEM_TOTAL/1024)) + "MB"])
