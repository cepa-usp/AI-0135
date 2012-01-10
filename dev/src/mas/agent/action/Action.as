package mas.agent.action 
{
	import mas.agent.Agent;
	import model.AgentEvent;

	public class Action
	{
		private var _duration:Number = 0;
		private var _action:int = 0;
		private var _cancelOthers:Boolean = false;
		protected var agent:Agent;
		protected var costMax:Number;
		protected var costMin:Number;

		public function Action(agt:Agent, duration:Number, action:int) 
		{
			this.duration = duration;
			this.action = action;
			this.agent = agt;
		}
		
		public function getEvent():AgentEvent {
			var ev:AgentEvent = new AgentEvent(AgentEvent.ACTION_CHANGED, agent);
			ev.actionType = this.action;
			ev.duration = this.duration;
			return ev;
		}
		
		
		protected function calculateEnergyCost():void {
			
		}
		
		public function onStart():void {
			
		}
		public function onFinish():void {
			
		}		
		
		public function get duration():Number 
		{
			return _duration;
		}
		
		public function set duration(value:Number):void 
		{
			_duration = value;
		}
		
		public function get action():int 
		{
			return _action;
		}
		
		public function set action(value:int):void 
		{
			_action = value;
		}
		
		public function get cancelOthers():Boolean 
		{
			return _cancelOthers;
		}
		
		public function set cancelOthers(value:Boolean):void 
		{
			_cancelOthers = value;
		}
		
	}
	
}