package view 
{
	import flash.display.Sprite;
	import mas.agent.Agent;
	import model.AgentEvent;
	import model.creature1.Creature1;
	import model.FoodAgent;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class MiniAgent  extends Sprite
	{
		
		private var _type:int = 0;
		private var _agent:Agent;
		
		public function MiniAgent(agt:Agent) 
		{
				this._agent = agt;
		}
		
		
		
		public function draw():void {
			if (_agent is Creature1) {
				graphics.beginFill(0x004080, 1);
				graphics.drawCircle(0, 0, 3);
			}
			if (_agent is FoodAgent) {
				graphics.beginFill(0xFF0080, 1);
				graphics.drawRect( -2, -2, 4, 4);				
			}
		}
		
		public function get type():int 
		{
			return _type;
		}
		
		public function set type(value:int):void 
		{
			_type = value;
		}
		
		public function get agent():Agent 
		{
			return _agent;
		}
		
		public function set agent(value:Agent):void 
		{			
			_agent = value;
			_agent.eventDispatcher.addEventListener(AgentEvent.ACTION_CHANGED, onAgentActionChange)
		}
		
		private function onAgentActionChange(e:AgentEvent):void 
		{
			e.tag = this;
			dispatchEvent(e);
		}
		
		
		
	}
	
}