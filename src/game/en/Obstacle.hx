package en;

class Obstacle extends Entity {
	public function new() {
		super(0, 0);
		setPivots(0.5);

		var b = new h2d.Bitmap(h2d.Tile.fromColor(Red, iwid, ihei), spr);
		b.tile.setCenterRatio(0.5, 0.5);
	}

	override public function dispose() {
		super.dispose();
	}
}
