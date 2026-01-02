extends Sprite2D
@onready var _star: Sprite2D = %Star

func _ready():
	centered = false
	var img_w = Setup.screen_width
	var img_h = Setup.screen_height
	var image = Image.create(img_w, img_h, false, Image.FORMAT_RGBA8)
	var frame_size = _star.texture.get_size() / Vector2(_star.hframes, 1)
	
	image.fill(Color(0, 0, 0, 0))
	
	var star_image = _star.texture.get_image()
	
	# Barvy hvězd (realistické spektrální třídy)
	var star_colors = [
		Color(1.0, 1.0, 1.0),      # Bílá
		Color(1.0, 0.9, 0.8),      # Běložlutá
		Color(1.0, 1.0, 0.6),      # Žlutá
		Color(1.0, 0.7, 0.4),      # Oranžová
		Color(1.0, 0.4, 0.3),      # Červená
		Color(0.7, 0.8, 1.0),      # Modrobílá
		Color(0.6, 0.7, 1.0),      # Modrá
	]
	
	var star_count = 100
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
		
		# Náhodná barva
		var star_color = star_colors[randi() % star_colors.size()]
		
		# Aplikuj barvu na všechny pixely
		for x in range(int(frame_size.x)):
			for y in range(int(frame_size.y)):
				var pixel = temp_image.get_pixel(x, y)
				if pixel.a > 0:  # Jen ne-průhledné pixely
					pixel.r *= star_color.r
					pixel.g *= star_color.g
					pixel.b *= star_color.b
					temp_image.set_pixel(x, y, pixel)
		
		# Náhodná intenzita
		var random_intensity = randf_range(0.1, 0.8)
		temp_image.adjust_bcs(random_intensity, 1.0, 1.0)
		
		image.blit_rect(temp_image,
			Rect2i(0, 0, frame_size.x, frame_size.y),
			Vector2i(random_x, random_y))
	
	texture = ImageTexture.create_from_image(image)
