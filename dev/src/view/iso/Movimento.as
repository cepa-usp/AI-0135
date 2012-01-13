package view.iso 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class Movimento	
	{
		private var _nome:String = ""
		private var _sprites:Vector.<BitmapData> = new Vector.<BitmapData>();
		
		public function Movimento(nome:String, sprites:Vector.<BitmapData>) 
		{
			this.nome = nome;
			this.sprites = sprites;
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
		
		
		
	}
	
}