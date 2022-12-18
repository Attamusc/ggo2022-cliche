package en;

import dn.legacy.Color;
import h2d.Graphics;
import hxd.Window;
import h2d.col.RoundRect;

class Golfer extends Entity {
	var ca: ControllerAccess<GameAction>;
	var currentBall: Ball;
	var sightLine: h2d.Graphics;

	var rotationSpeed: Float = 0.5;

	public function angToMouse(?offX = 0, ?offY = 0) {
		return Math.atan2(App.ME.mouseY - centerY + offY, App.ME.mouseX - centerX + offX);
	}

	public function new() {
		super(0, 0);
		setPivots(0.5);

		// Starting point using level entity "PlayerStart"
		var start = level.data.l_Entities.all_PlayerStart[0];
		if (start != null) {
			setPosCase(start.cx, start.cy);
		}

		camera.trackEntity(this, true);
		camera.clampToLevelBounds = true;

		// Init controller
		ca = App.ME.controller.createAccess();
		ca.lockCondition = Game.isGameControllerLocked;

		spr.set(Assets.entities);
		spr.setCenterRatio(start.pivotX, start.pivotY);

		spr.anim.registerStateAnim("hero_idle", 0, 1.0);
		
		sightLine = new h2d.Graphics();
		game.scroller.add(sightLine, Const.DP_TOP);
	}

	override function dispose() {
		super.dispose();
		ca.dispose();
	}

	override function frameUpdate() {
		super.frameUpdate();

		// keyboard-based character rotation
		if (ca.getAnalogDist2(MoveLeft, MoveRight) > 0) {
			spr.rotate(ca.getAnalogValue2(MoveLeft, MoveRight) * rotationSpeed);
		}

		var facingAngle = angToMouse();
		spr.rotation = facingAngle + (90 * Math.PI / 180);

		// draw a line from the player to the mouse
		sightLine.clear();
		sightLine.lineStyle(5, White);
		sightLine.beginFill(White, 1.0);
		sightLine.moveTo(attachX, attachY);
		sightLine.lineTo(App.ME.mouseX, App.ME.mouseY);
		sightLine.endFill();

		if (ca.isPressed(Swing)) {
			if (currentBall != null) {
				currentBall.destroy();
				currentBall = null;
			}

			currentBall = new Ball(M.round(centerX), M.round(centerY), facingAngle);
		}
	}
}
