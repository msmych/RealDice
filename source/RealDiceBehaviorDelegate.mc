using Toybox.WatchUi as Ui;
using Toybox.Timer as Timer;
using Toybox.Sensor as Sensor;

class RealDiceBehaviorDelegate extends Ui.BehaviorDelegate {
	
	hidden const Z_CHAIN_LENGTH = 5;
	hidden const ROLL_THRESHOLD = 700;
	
	hidden var parent;
	hidden var timer;
	hidden var zChain = new [Z_CHAIN_LENGTH];
	
	function initialize(parentView) {
		parent = parentView;
		emptyZChain();
		timer = new Timer.Timer();
		timer.start(method(:tick), 100, true);
		BehaviorDelegate.initialize();
	}
	
	function tick() {
		var info = Sensor.getInfo();
		
		for (var i = 0; i < Z_CHAIN_LENGTH - 1; i += 1) {
			zChain[i] = zChain[i + 1];
		}
		if (info has :accel and info.accel != null) {
			zChain[Z_CHAIN_LENGTH - 1] = info.accel[2];
		}
		if (zChain[Z_CHAIN_LENGTH - 1] - zChain[0] > ROLL_THRESHOLD) {
			parent.roll();
			emptyZChain();
		}
	}
	
	hidden function emptyZChain() {
		for (var i = 0; i < Z_CHAIN_LENGTH; i += 1) {
			zChain[i] = 0;
		}
	}
	
	function onNextPage() {
		parent.roll();
		return true;
	}
	
}