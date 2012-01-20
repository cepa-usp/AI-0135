package model 
{
	import flash.events.Event;
	import flash.geom.Point;
	import mas.enviro.Environment;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import mas.agent.Agent;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class FoodAgent extends BaseAgent implements Agent
	{		
		
		private var _energyProvided:int = 700;
		private var state:int = 0;
		private var _id:int;
		private var dispatcher:EventDispatcher = new EventDispatcher();
		
		public function FoodAgent() 
		{
		id = Config.getId();	
		}

		private function die():void {
			dispatcher.dispatchEvent(new Event(AgentEvent.TERMINATED));
		}
		
		
		public function think():void 
		{
			// food can't think
		}
		
		public function refresh():void 
		{
			// nothing
		}
		
		/* INTERFACE mas.agent.Agent */
		
		public function get block():Boolean 
		{
			return false;
		}
	
		
		public function get eventDispatcher():EventDispatcher 
		{
			return dispatcher;
		}
		
		public function get id():int 
		{
			return _id;
		}
		
		public function set id(value:int):void 
		{
			_id = value;
		}
		
		public function select(val:Boolean):void {
			//eventDispatcher.dispatchEvent(new Event(Event.CONNECT));
			eventDispatcher.dispatchEvent(new Event(Event.SELECT));
		}
		public function unselect():void {
			eventDispatcher.dispatchEvent(new Event(Event.CLEAR));
		}		
		
		
		public function get description():String {
			return "food [" + id.toString() + "]"
		}
		
	
		
		public function get energyProvided():int 
		{
			return _energyProvided;
		}
		
		public function set energyProvided(value:int):void 
		{
			_energyProvided = value;
		}
		
		public static const STATE_NORMAL:int = 0;
		public static const STATE_EATEN:int = 1;
		

		
	
		
	}
	
}