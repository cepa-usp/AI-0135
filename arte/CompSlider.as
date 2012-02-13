package
{
	import fl.controls.Slider;
	import fl.transitions.easing.None;
	import fl.transitions.Tween;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author Alexandre
	 */
	public class CompSlider extends MovieClip
	{
		private var sliderTemp:Slider;
		//private var sliderPh:Slider;
		private var sliderUmidade:Slider;
		
		private var openCloseBtn:MovieClip;
		private var slidersContainer:MovieClip;
		
		private var txtTemp:TextField;
		//private var txtPh:TextField;
		private var txtUmidade:TextField;
		
		private var txtFormat:TextFormat = new TextFormat("arial", 14);
		private var slidersOpen:Boolean = false;
		private var tweenX:Tween;
		
		private const closePosSliders:Number = -90;
		private const openPosSliders:Number = 92;
		
		public function CompSlider(config:Object = null) 
		{
			if (config == null) {
				config = {
					temp: {
						minimum: 5,
						maximum: 95,
						tick: 5,
						snap: 1,
						inicial: 20
					},
					//ph: {
						//minimum: 0,
						//maximum: 7,
						//tick: 1,
						//snap: 0.5,
						//inicial: 4
					//},
					umidade: {
						minimum: 0,
						maximum: 100,
						tick: 10,
						snap: 1,
						inicial: 30
					}
				}
			}
			makeConections();
			configureComponents(config);
			addListeners();
			updateTextFields(null);
		}
		
		private function makeConections():void 
		{
			sliderTemp = this.sliders.sliderTemp;
			//sliderPh = this.sliders.sliderPh;
			sliderUmidade = this.sliders.sliderUmidade;
			
			openCloseBtn = this.sliders.openCloseButton;
			slidersContainer = this.sliders;
			
			txtTemp = this.temp;
			//txtPh = this.pH;
			txtUmidade = this.umid;
		}
		
		private function configureComponents(config:Object):void 
		{
			sliderTemp.liveDragging = true;
			sliderTemp.minimum = config.temp.minimum;
			sliderTemp.maximum = config.temp.maximum;
			sliderTemp.tickInterval = config.temp.tick;
			sliderTemp.snapInterval = config.temp.snap;
			sliderTemp.value = config.temp.inicial;
			
			//sliderPh.liveDragging = true;
			//sliderPh.minimum = config.ph.minimum;
			//sliderPh.maximum = config.ph.maximum;
			//sliderPh.tickInterval = config.ph.tick;
			//sliderPh.snapInterval = config.ph.snap;
			//sliderPh.value = config.ph.inicial;
			
			sliderUmidade.liveDragging = true;
			sliderUmidade.minimum = config.umidade.minimum;
			sliderUmidade.maximum = config.umidade.maximum;
			sliderUmidade.tickInterval = config.umidade.tick;
			sliderUmidade.snapInterval = config.umidade.snap;
			sliderUmidade.value = config.umidade.inicial;
			
			txtTemp.defaultTextFormat = txtFormat;
			//txtPh.defaultTextFormat = txtFormat;
			txtUmidade.defaultTextFormat = txtFormat;
			
			openCloseBtn.buttonMode = true;
		}
		
		private function addListeners():void 
		{
			sliderTemp.addEventListener(Event.CHANGE, updateTextFields);
			//sliderPh.addEventListener(Event.CHANGE, updateTextFields);
			sliderUmidade.addEventListener(Event.CHANGE, updateTextFields);
			
			openCloseBtn.addEventListener(MouseEvent.CLICK, openCloseSliders);
		}
		
		private function updateTextFields(e:Event):void 
		{
			txtTemp.text = String(sliderTemp.value);
			//txtPh.text = String(sliderPh.value);
			txtUmidade.text = String(sliderUmidade.value);
			
			dispatchEvent(new Event(Event.CHANGE, true));
		}
		
		private function openCloseSliders(e:MouseEvent):void 
		{
			if (!slidersOpen) {//FECHADO
				slidersOpen = true;
				openCloseBtn.gotoAndStop(2);
				if (tweenX != null) tweenX.stop();
				tweenX = new Tween(slidersContainer, "x", None.easeOut, slidersContainer.x, openPosSliders, 0.4, true);
			}else {//ABERTO
				slidersOpen = false;
				openCloseBtn.gotoAndStop(1);
				if (tweenX != null) tweenX.stop();
				tweenX = new Tween(slidersContainer, "x", None.easeIn, slidersContainer.x, closePosSliders, 0.4, true);
			}
		}
		
		public function get temperatura():Number
		{
			return sliderTemp.value;
		}
		
		//public function get ph():Number
		//{
			//return sliderPh.value;
		//}
		
		public function get umidade():Number
		{
			return sliderUmidade.value;
		}
		
		public function set temperatura(value:Number):void
		{
			sliderTemp.value = value;
			updateTextFields(null);
		}
		
		//public function set ph(value:Number):void
		//{
			//sliderPh.value = value;
			//updateTextFields(null);
		//}
		
		public function set umidade(value:Number):void
		{
			sliderUmidade.value = value;
			updateTextFields(null);
		}
	}

}