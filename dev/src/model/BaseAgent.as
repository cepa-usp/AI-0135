package model 
{
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import mas.enviro.Environment;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class BaseAgent 
	{
		protected var _environment:Environment;
		protected var _position:Point;
		protected var _extrablocks:Vector.<Point> = new Vector.<Point>();
		protected var _eventDispatcher:EventDispatcher = new EventDispatcher();
		protected var _block:Boolean = false;
		
		public function BaseAgent() 
		{
			
		}
		
		public function addblock(x:int, y:int):BaseAgent {
			extrablocks.push(new Point(x, y));
			return this;
		}
		
		public function get block():Boolean {
			return _block;
		}
		
		public function init(env:Environment, init_position:Point):void 
		{
			this._position = init_position;
			this._environment = env;
		}	
		
		public function get environment():Environment 
		{
			return _environment;
		}
		
		public function get position():Point 
		{
			return _position;
		}		
		
		public function set position(p:Point):void
		{
			_position = p;
		}		
		
		
		public function get extrablocks():Vector.<Point> 
		{
			return _extrablocks;
		}
		
		public function set extrablocks(value:Vector.<Point>):void 
		{
			_extrablocks = value;
		}

		public function get eventDispatcher():EventDispatcher 
		{
			return _eventDispatcher;
		}
		
	}
	
}