package model 
{
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
		protected var extrablocks:Vector.<Point> = new Vector.<Point>();
		
		public function BaseAgent() 
		{
			
		}
		
		public function addblock(x:int, y:int):BaseAgent {
			extrablocks.push(new Point(x, y));
			return this;
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
		
	}
	
}