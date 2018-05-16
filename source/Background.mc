using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class Background extends Ui.Drawable {

	function initialize() {
		var settings = {
			:identifier => "Background"
		};
		Drawable.initialize(settings);
	}
	
	function draw(dc) {
		dc.setColor(Gfx.COLOR_TRANSPARENT, Gfx.COLOR_BLACK);
		dc.clear();
	}

}