package model 
{
	import flash.events.Event;
	import mas.agent.Agent;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class EnvironmentEvent extends Event 
	{
		private var _agent:Agent;
		public function EnvironmentEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new EnvironmentEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("EnvironmentEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public static const AGENT_CREATED:String = "agentCreated";
		
		public function get agent():Agent 
		{
			return _agent;
		}
		
		public function set agent(value:Agent):void 
		{
			_agent = value;
		}
		
	}
	
}