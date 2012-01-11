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
		
		private var energyProvided:int = 50;
		private var state:int = 0;
		private var dispatcher:EventDispatcher = new EventDispatcher();
		
		public function FoodAgent() 
		{
			
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
		
		public static const STATE_NORMAL:int = 0;
		public static const STATE_EATEN:int = 1;
		

		
	
		
	}
	
}