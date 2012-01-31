package mas.agent 
{
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import mas.enviro.Environment;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public interface Agent 
	{
		function think():void;
		function init(env:Environment, init_position:Point):void;
		function get eventDispatcher():EventDispatcher 		
		function get environment():Environment;
		//function get block():Boolean;
		function get position():Point;
		function get description():String;
		function select(val:Boolean):void;
	}

}