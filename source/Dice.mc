using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Math as Math;

class Dice extends Ui.Drawable {

	hidden const MAX_SIZE = 100;
	hidden const SIZE_FACTOR = 2.0f/3.0f;
	hidden const PEN_WIDTH = 3;
	hidden const RADIUS_FACTOR = 1.0f/12.0f;
	hidden const SIDE_DOT_FACTOR = 0.27f;

	hidden const colors = [
		Gfx.COLOR_WHITE,
		Gfx.COLOR_RED,
		Gfx.COLOR_YELLOW,
		Gfx.COLOR_GREEN,
		Gfx.COLOR_BLUE,
		Gfx.COLOR_PINK
	];
	
	hidden var value = 0;
	hidden var color = Gfx.COLOR_PINK;

	function initialize() {
		var settings = {
			:identifier => "Dice"
		};
		Drawable.initialize(settings);
	}
	
	function draw(dc) {
		var width = dc.getWidth();
		var height = dc.getHeight();
		var shortSide = width < height ? width : height;
		var size = shortSide * SIZE_FACTOR;
		if (size > MAX_SIZE) {
			size = MAX_SIZE;
		}
		var x = (width - size)/2;
		var y = (height - size)/2;
		var radius = size * RADIUS_FACTOR;
	
		dc.setColor(color, Gfx.COLOR_TRANSPARENT);
		dc.setPenWidth(PEN_WIDTH);
		dc.drawRoundedRectangle(x, y, size, size, radius);
		switch (value) {
			case 0:
				dc.drawText(width/2, height/2, Gfx.FONT_LARGE, "ROLL ME", Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);
				break;
			case 1:
				drawCentralDot(dc, radius);
				break;
			case 2:
				drawAngularUpDots(dc, size, radius);
				break;
			case 3:
				drawCentralDot(dc, radius);
				drawAngularUpDots(dc, size, radius);
				break;
			case 4:
				drawAngularUpDots(dc, size, radius);
				drawAngularDownDots(dc, size, radius);
				break;
			case 5:
				drawCentralDot(dc, radius);
				drawAngularUpDots(dc, size, radius);
				drawAngularDownDots(dc, size, radius);
				break;
			case 6:
				drawAngularUpDots(dc, size, radius);
				drawAngularDownDots(dc, size, radius);
				drawSideDots(dc, size, radius);
		}
	}
	
	hidden function drawCentralDot(dc, radius) {
		dc.fillCircle(dc.getWidth()/2, dc.getHeight()/2, radius);
	}
	
	hidden function drawAngularUpDots(dc, size, radius) {
		var xCenter = dc.getWidth()/2;
		var yCenter = dc.getHeight()/2;
		var sideDotDistance = size * SIDE_DOT_FACTOR;
		dc.fillCircle(xCenter - sideDotDistance, yCenter + sideDotDistance, radius);
		dc.fillCircle(xCenter + sideDotDistance, yCenter - sideDotDistance, radius);
	}
	
	hidden function drawAngularDownDots(dc, size, radius) {
		var xCenter = dc.getWidth()/2;
		var yCenter = dc.getHeight()/2;
		var sideDotDistance = size * SIDE_DOT_FACTOR;
		dc.fillCircle(xCenter - sideDotDistance, yCenter - sideDotDistance, radius);
		dc.fillCircle(xCenter + sideDotDistance, yCenter + sideDotDistance, radius);
	}
	
	hidden function drawSideDots(dc, size, radius) {
		var xCenter = dc.getWidth()/2;
		var yCenter = dc.getHeight()/2;
		var sideDotDistance = size * SIDE_DOT_FACTOR;
		dc.fillCircle(xCenter - sideDotDistance, yCenter, radius);
		dc.fillCircle(xCenter + sideDotDistance, yCenter, radius);
	}
	
	function setValue(newValue) {
		value = newValue;
	}
	
	function changeColor() {
		var i = 0;
		var j = 0;
		var colorOptions = new [colors.size() - 1];
		while (i < colors.size()) {
			if (colors[i] != color) {
				colorOptions[j] = colors[i];
				j += 1;
			}
			i += 1;
		}
		color = colorOptions[Math.rand() % colorOptions.size()];
	}

}