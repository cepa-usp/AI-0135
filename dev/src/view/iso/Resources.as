package  view.iso
{
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Alexandre
	 */
	
	 
	public final class Resources 
	{
		[Embed(source = "bkg.png")]
		public static var Bkg:Class;
		public static var BkgBmpd:BitmapData = new Bkg().bitmapData;
		
		[Embed(source = "sand.png")]
		public static var Sand:Class;
		public static var SandB:BitmapData = new Sand().bitmapData;
		
		public static var movimentos:Dictionary = new Dictionary(); /// String, Vector<BitmapData>
		
		public static function carregarMovimento(nomeMovimento:String/*, bounds:Rectangle*/, moviesrc:MovieClip, deslocamento:Point = null, frameIni:int = 1, frameFim:int = -1):void {
			if (frameFim == -1) frameFim = moviesrc.totalFrames;
			//var bd:Vector.<BitmapData> = new Vector.<BitmapData>();
			//bd = convertToBMPList(moviesrc, bounds);
			//movimentos[nomeMovimento] = bd;
			
			var bounds:Rectangle = getRect(moviesrc);
			var mov:Movimento = new Movimento(nomeMovimento, convertToBMPList(moviesrc, bounds), new Point(bounds.x, bounds.y));
			movimentos[nomeMovimento] = mov;
			
		}

		private static function convertToBMPList(object:MovieClip, bounds:Rectangle):Vector.<BitmapData> 
		{
			//var bounds:Rectangle = getRect(object);
			var nFrames:int = object.totalFrames;
			
			var listBmp:Vector.<BitmapData> = new Vector.<BitmapData>();
			
			for (var i:int = 1; i <= nFrames; i++) 
			{
				object.gotoAndStop(i);				
				var item:BitmapData = new BitmapData(bounds.width, bounds.height, true, 0x000000);				
				var matrix:Matrix = new Matrix(1, 0, 0, 1, -bounds.x, -bounds.y);				
				item.draw(object, matrix);
				listBmp.push(item);
			}		
			return listBmp;
		}
		
		private static function getRect(object:MovieClip):Rectangle
		{
			var bounds:Rectangle = new Rectangle(0,0,0,0);
			var nFrames:int = object.totalFrames;
			
			object.gotoAndStop(1);
			
			//bounds = object.getBounds(object);
			//bounds.width += 10;
			//bounds.height += 10;
			//bounds.x -= 5;
			//bounds.y -= 5;
			
			for (var i:int = 1; i <= nFrames; i++) {
				object.gotoAndStop(i);
				var bds:Rectangle = object.getBounds(object);
				if (bds.width > bounds.width) {
					bounds.width = bds.width;
					bounds.x = bds.x;
				}
				if (bds.height > bounds.height) {
					bounds.height = bds.height;
					bounds.y = bds.y;
				}
			}
			
			return bounds;
		}
			
		
	}

}