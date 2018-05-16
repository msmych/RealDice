using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Attention as Attention;

class RealDiceView extends Ui.View {

	hidden var value = 0;

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.SingleDiceLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
    	var dice = findDrawableById("Dice");
    	dice.setValue(value);
    	dice.changeColor();
    	
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }
    
    function roll() {
    	value = Math.rand() % 6 + 1;
    	
    	if (Attention has :backlight) {
    		Attention.backlight(true);
    	}
    	
    	Ui.requestUpdate();
    }

}
