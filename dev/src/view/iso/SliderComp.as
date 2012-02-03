package view.iso 
{
	import fl.controls.Slider;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author Alexandre
	 */
	public class SliderComp extends Sprite
	{
		private var slider:Slider;
		private var label:TextField;
		private var widthSlider:Number;
		private var _labelTxt:String;
		
		private var borda:Number = 5;
		
		public function SliderComp(label:String, min:Number, max:Number, snapInt:Number, tickInt:Number, width:Number, ini:Number) 
		{
			widthSlider = width;
			labelTxt = label;
			drawBackground(width);
			
			slider = new Slider();
			slider.minimum = min;
			slider.maximum = max;
			slider.value = ini;
			slider.snapInterval = snapInt;
			slider.tickInterval = tickInt;
			slider.width = width - 2 * borda;
			slider.liveDragging = true;
			slider.x = borda;
			slider.y = borda;
			addChild(slider);
			slider.addEventListener(Event.CHANGE, setTextLabel);
			
			setTextLabel();
		}
		
		private function drawBackground(width:Number):void 
		{
			graphics.beginFill(0x80FFFF, 0.8);
			graphics.drawRect(0, -2, width, 30);
		}
		
		private function setTextLabel(e:Event = null):void 
		{
			if(label == null){
				label = new TextField();
				label.defaultTextFormat = new TextFormat("arial", 14);
				label.autoSize = TextFieldAutoSize.CENTER;
				label.y = 10;
				label.selectable = false;
				addChild(label);
			}
			label.text = labelTxt + ": " + String(slider.value);			
			
			dispatchEvent(new Event(Event.CHANGE, true));
			label.x = (widthSlider - label.width) / 2 + borda;
		}
		
		public function getValue():Number {
			return slider.value;
		}
		
		public function get labelTxt():String 
		{
			return _labelTxt;
		}
		
		public function set labelTxt(value:String):void 
		{
			_labelTxt = value;
		}
		
	}

}