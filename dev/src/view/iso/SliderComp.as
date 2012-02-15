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
			
			slider.addEventListener(Event.CHANGE, setTextLabel);
			
			setTextLabel();
			
			addChild(slider);
		}
		
		private function drawBackground(width:Number):void 
		{
			graphics.beginFill(0xDBDBDB, 1);
			//graphics.drawRect(0, -2, width, 30);
			graphics.drawRoundRect(0, -2, width, 40, 10, 10);
		}
		
		private function setTextLabel(e:Event = null):void 
		{
			if(label == null){
				label = new TextField();
				label.defaultTextFormat = new TextFormat("arial", 14, null, null, null, null, null, null, "left");
				//label.autoSize = TextFieldAutoSize.RIGHT;
				label.width = 300;
				label.y = 18;
				label.selectable = false;
				addChild(label);
				//label.text = labelTxt;
				label.x = 100;
			}
			setText();
			dispatchEvent(new Event(Event.CHANGE, true));
		}
		
		private function setText():void
		{
			if (slider.value == 300) label.text = labelTxt + "normal";
			else if (slider.value < 300) label.text = labelTxt + "lento";
			else if (slider.value > 300 && slider.value < 1000) label.text = labelTxt + "rápido";
			else if(slider.value >= 1000) label.text = labelTxt + "muito rápido";
			//else label.text = labelTxt;
			
			//label.x = (widthSlider - label.width) / 2 + borda;
		}
		
		public function getValue():Number {
			return slider.value;
		}
		
		public function setValue(value:Number):void{
			slider.value = value;
			setText();
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