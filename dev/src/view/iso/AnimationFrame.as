package  view.iso
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.utils.setTimeout;
	import model.Config;
	/**
	 * ...
	 * @author Alexandre
	 */
	public class AnimationFrame extends Bitmap
	{
		private var _currentFrame:int = 0;
		private var movimento:Vector.<BitmapData>;
		private var _state:int = 0;
		private var _adjust:int = 0;

		private var mudou:Boolean = false;
		private static const STATE_STOPPED:int = 0;
		private static const STATE_PLAYING:int = 1;
		
		public function AnimationFrame() 
		{

		}
		
		public function setMovimento(nomeMovimento:String):void {
			currentFrame = 0;			
			//if(Resources.movimentos[nomeMovimento]!=null) movimento = Resources.movimentos[nomeMovimento];
			if (Resources.movimentos[nomeMovimento] != null) {
				movimento = Movimento(Resources.movimentos[nomeMovimento]).sprites;
				if (Movimento(Resources.movimentos[nomeMovimento]).deslocamento != null) {
					this.x = Movimento(Resources.movimentos[nomeMovimento]).deslocamento.x;
					this.y = Movimento(Resources.movimentos[nomeMovimento]).deslocamento.y;
				}else {
					this.x = 0;
					this.y = 0;
				}
			}
			
		}
		
		public function play():void {
			if (state == STATE_STOPPED) {
				state = STATE_PLAYING;
				changeGraphics();
			}			
		}
		
		public function stop():void {
			state = STATE_STOPPED;
		}
		

		private function changeGraphics(e:Event = null):void 
		{
			if (mudou) return;
			if (movimento == null) return;			
			this.bitmapData = movimento[currentFrame];
			currentFrame++;
			if (currentFrame == movimento.length) currentFrame = 0;			
			if (state == STATE_PLAYING) setTimeout(changeGraphics, Config.time + _adjust);

		}
		
		public function get currentFrame():int 
		{
			return _currentFrame;
		}
		
		public function set currentFrame(value:int):void 
		{
			_currentFrame = value;
		}

		
		public function get state():int 
		{
			return _state;
		}
		
		public function set state(value:int):void 
		{
			_state = value;
		}
		
		public function get adjust():int 
		{
			return _adjust;
		}
		
		public function set adjust(value:int):void 
		{
			_adjust = value;
		}
		
	}

}