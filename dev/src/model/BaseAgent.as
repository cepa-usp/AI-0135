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
		private var _environment:Environment;
		private var _position:Point;
		
		public function BaseAgent() 
		{
			
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