extends Sprite2D

@onready var _star: Sprite2D = $Star

@export var star_count: int = 200
@export var intensity_range := Vector2(0.4, 0.8)
@export var star_colors = [
		Color(1.0, 1.0, 1.0),
		Color(1.0, 0.9, 0.8),
		Color(1.0, 1.0, 0.6),
		Color(1.0, 0.7, 0.4),
		Color(1.0, 0.4, 0.3),
		Color(0.7, 0.8, 1.0),
		Color(0.6, 0.7, 1.0),
	]

func _ready():
	centered = false
	var img_w = Setup.screen_width
	var img_h = Setup.screen_height
	var image = Image.create(img_w, img_h, false, Image.FORMAT_RGBA8)
	image.fill(Color(0, 0, 0, 0))
	
	var frame_size = _star.texture.get_size() / Vector2(_star.hframes, 1)
	var star_image = _star.texture.get_image()

	for i in range(star_count):
		var random_frame = randi() % _star.hframes
		var src_x = random_frame * frame_size.x
		var src_y = 0

		var max_x = int(img_w - frame_size.x)
		var max_y = int(img_h - frame_size.y)
		var random_x = randi_range(0, max_x)
		var random_y = randi_range(0, max_y)

		var temp_image = Image.create(int(frame_size.x), int(frame_size.y), false, Image.FORMAT_RGBA8)
		temp_image.blit_rect(star_image,
			Rect2i(src_x, src_y, frame_size.x, frame_size.y),
			Vector2i(0, 0))

		# random color
		var star_color = star_colors[randi() % star_colors.size()]
		for x in range(int(frame_size.x)):
			for y in range(int(frame_size.y)):
				var pixel = temp_image.get_pixel(x, y)
				if pixel.a > 0:
					temp_image.set_pixel(x, y, pixel * star_color)

		# random intensity
		var random_intensity = randf_range(intensity_range.x, intensity_range.y)
		temp_image.adjust_bcs(random_intensity, 1.0, 1.0)

		image.blit_rect(temp_image,
			Rect2i(0, 0, frame_size.x, frame_size.y),
			Vector2i(random_x, random_y))

	texture = ImageTexture.create_from_image(image)
