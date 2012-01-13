package  view.iso
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.setTimeout;
	/**
	 * ...
	 * @author Alexandre
	 */
	public class ArvoreBase extends Sprite
	{
		public var bitMap:Bitmap;
		private var sheet:BitmapData;
		private var rects:Array;
		private var internalCanvas:BitmapData;
		private var pos:Point = new Point();
		
		private var frame:int = 0;
		
		public function ArvoreBase(sheet:BitmapData, rects:Array) 
		{
			this.sheet = sheet;
			this.rects = rects;
			
			internalCanvas = new BitmapData(rects[0].width, rects[0].height, true);
			internalCanvas.copyPixels(sheet, rects[0], pos);
			bitMap = new Bitmap(internalCanvas);
			addChild(bitMap);
			bitMap.x = -21;
			bitMap.y = -21;
			
			setTimeout(render, Math.random() * 800 + 200);
		}
		
		public function render():void
		{
			//Quando a contagem chega a frameChangeCount faz uma mudança de estado do personagem, caso ele esteja se movimentando.
			internalCanvas.copyPixels(sheet, rects[frame], pos);
			frame++;
			if (frame == rects.length) frame = 0;
			
			dispatchEvent(new Event(Event.CHANGE, true));
			
			setTimeout(render, Math.random() * 800 + 200);
		}
		
	}

}