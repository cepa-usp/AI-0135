package model 
{
	import flash.events.Event;
	import flash.geom.Point;
	import mas.agent.Agent;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class AgentEvent extends Event
	{
		private var _walkingDirection:int = -1
		private var _mindstate:int = -1;
		private var _movementState:int = 0;
		private var _actionType:int = 0;
		private var _destination:Point = null;
		private var _tag:Object;
		private var _duration:Number = 0;
		private var _agent:Agent = null;
		
		public function AgentEvent(type:String, agt:Agent, bubbles:Boolean = false, cancelable:Boolean = false):void
		{
			super(type, bubbles, cancelable);
			agent = agt;
		}
		
		public function get walkingDirection():int 
		{
			return _walkingDirection;
		}
		
		public function set walkingDirection(value:int):void 
		{
			_walkingDirection = value;
		}
		

		
		public function get destination():Point 
		{
			return _destination;
		}
		
		public function set destination(value:Point):void 
		{
			_destination = value;
		}
		
		public function get duration():Number 
		{
			return _duration;
		}
		
		public function set duration(value:Number):void 
		{
			_duration = value;
		}
		
		public function get actionType():int
		{
			return _actionType;
		}
		
		public function set actionType(value:int):void 
		{
			_actionType = value;
		}
		
		public function get mindstate():int 
		{
			return _mindstate;
		}
		
		public function set mindstate(value:int):void 
		{
			_mindstate = value;
		}
		
		public function get agent():Agent 
		{
			return _agent;
		}
		
		public function set agent(value:Agent):void 
		{
			_agent = value;
		}
		
		public function get tag():Object 
		{
			return _tag;
		}
		
		public function set tag(value:Object):void 
		{
			_tag = value;
		}
		

		
		public static const INITIALIZED : String = "initialized";
		public static const MINDSTATE_CHANGED: String = "mindstateChanged";	
		public static const ACTION_CHANGED: String = "actionChanged";	
		public static const AGE_COMPUTED: String = "ageComputed";	
		public static const ENERGY_CHANGED: String = "energyChanged";
		public static const TERMINATED: String = "terminated";
		
	}
	
}