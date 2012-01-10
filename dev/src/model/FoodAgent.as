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

		private function die() {
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
	
		
		public function get eventDispatcher():EventDispatcher 
		{
			return dispatcher;
		}
		
		public static const STATE_NORMAL = 0;
		public static const STATE_EATEN = 1;
		

		
	
		
	}
	
}