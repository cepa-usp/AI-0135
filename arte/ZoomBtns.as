package 
{
	import cepa.utils.ToolTip;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	
	/**
	 * ...
	 * @author Alexandre
	 */
	public class ZoomBtns extends Sprite 
	{
		public static const ZOOM_IN:String = "zoomIn";
		public static const ZOOM_OUT:String = "zoomOut";
		
		private var zIn:MovieClip;
		private var zOut:MovieClip;
		
		/*
		 * Filtro de conversão para tons de cinza.
		 */
		private const GRAYSCALE_FILTER:ColorMatrixFilter = new ColorMatrixFilter([
			0.2225, 0.7169, 0.0606, 0, 0,
			0.2225, 0.7169, 0.0606, 0, 0,
			0.2225, 0.7169, 0.0606, 0, 0,
			0.0000, 0.0000, 0.0000, 1, 0
		]);
		
		public function ZoomBtns():void {
			makeConections();
		}
		
		public function start():void
		{
			initializeBtns();
		}
		
		private function makeConections():void
		{
			zIn = zoomIn;
			zOut = zoomOut;
		}
		
		private function initializeBtns():void 
		{
			overOutListeners(zIn, "Aumentar zoom");
			overOutListeners(zOut, "Diminuir zoom");
		}
		
		private function overOutListeners(btn:MovieClip, tt:String):void
		{
			btn.buttonMode = true;
			btn.mouseChildren = false;
			btn.gotoAndStop(1);
			btn.addEventListener(MouseEvent.MOUSE_OVER, overEnevt);
			btn.addEventListener(MouseEvent.MOUSE_OUT, outEnevt);
			
			var ttp:ToolTip = new ToolTip(btn, tt, 12, 0.8, 150, 0.6, 0.1);
			this.parent.addChild(ttp);
		}
		
		private function overEnevt(e:MouseEvent):void 
		{
			var btn:MovieClip = MovieClip(e.target);
			btn.gotoAndStop(2);
		}
		
		private function outEnevt(e:MouseEvent):void 
		{
			var btn:MovieClip = MovieClip(e.target);
			btn.gotoAndStop(1);
		}
		
		public function btnFunction(btn:String, func:Function):void
		{
			switch(btn) {
				case ZOOM_IN:
					zIn.addEventListener(MouseEvent.CLICK, func);
					break;
				case ZOOM_OUT:
					zOut.addEventListener(MouseEvent.CLICK, func);
					break;
				default:
					return;
			}
		}
		
		public function lockBtn(btn:String, value:Boolean):void
		{
			switch(btn) {
				case ZOOM_IN:
					if (value) {
						zIn.gotoAndStop(1);
						zIn.filters = [GRAYSCALE_FILTER];
						zIn.mouseEnabled = false;
						zIn.alpha = 0.3;
					}else {
						zIn.filters = [];
						zIn.mouseEnabled = true;
						zIn.alpha = 1;
					}
					break;
				case ZOOM_OUT:
					if (value) {
						zOut.gotoAndStop(1);
						zOut.filters = [GRAYSCALE_FILTER];
						zOut.mouseEnabled = false;
						zOut.alpha = 0.3;
					}else {
						zOut.filters = [];
						zOut.mouseEnabled = true;
						zOut.alpha = 1;
					}
					break;
				default:
					return;
			}
		}
		
	}
	
}