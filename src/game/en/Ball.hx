package en;

class Ball extends Entity {
	var speed: Float = 5;

	public function new(x: Int, y: Int, angle: Float) {
		super(0, 0);

		setPosPixel(x, y);

		var xSpeed = Math.cos(angle) * speed;
		var ySpeed = Math.sin(angle) * speed;

		v.dx = xSpeed;
		v.dy = ySpeed;

		v.setFricts(0.98, 0.98);

		var b = new h2d.Bitmap(h2d.Tile.fromColor(Red, M.round(iwid / 2), M.round(ihei / 2)), spr);
		b.tile.setCenterRatio(x, y);
	}

	override function onPreStepX() {
		super.onPreStepX();

		if (xr > 0.8 && level.hasCollision(cx + 1, cy)) {
			xr = 0.8;
			v.dx = -v.dx;
		}

		if (xr < 0.2 && level.hasCollision(cx - 1, cy)) {
			xr = 0.2;
			v.dx = -v.dx;
		}
	}

	override function onPreStepY() {
		super.onPreStepY();

		if (yr > 0.8 && level.hasCollision(cx, cy + 1)) {
			yr = 0.8;
			v.dy = -v.dy;
		}

		if (yr < 0.2 && level.hasCollision(cx, cy - 1)) {
			yr = 0.2;
			v.dy = -v.dy;
		}
	}
}
