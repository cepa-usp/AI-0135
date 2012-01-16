package view.iso 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class Movimento	
	{
		private var _nome:String = ""
		private var _sprites:Vector.<BitmapData> = new Vector.<BitmapData>();
		private var _deslocamento:Point;
		
		public function Movimento(nome:String, sprites:Vector.<BitmapData>, deslocamento:Point) 
		{
			this.nome = nome;
			this.sprites = sprites;
			if (deslocamento != null) this.deslocamento = deslocamento;
		}
		
		public function get sprites():Vector.<BitmapData> 
		{
			return _sprites;
		}
		
		public function set sprites(value:Vector.<BitmapData>):void 
		{
			_sprites = value;
		}
		
		public function get nome():String 
		{
			return _nome;
		}
		
		public function set nome(value:String):void 
		{
			_nome = value;
		}
		
		public function get deslocamento():Point 
		{
			return _deslocamento;
		}
		
		public function set deslocamento(value:Point):void 
		{
			_deslocamento = new Point(value.x, value.y);
		}
		
		
		
	}
	
}