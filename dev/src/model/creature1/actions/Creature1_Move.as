package model.creature1.actions 
{
	import flash.geom.Point;
	import mas.agent.action.Action;
	import model.AgentEvent;
	import model.BioAction;
	import model.BioAgent;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class Creature1_Move extends Action
	{
		
		private var _destination:Point;
		private var direction:int;
		private var startpos:Point;
		
		public function Creature1_Move(agt:BioAgent, duration:Number, dest_x:int, dest_y:int) 
		{
			super(agt, duration, BioAction.ACTION_MOVING)
			this.destination = new Point(dest_x, dest_y);
			this.direction = agt.direction;
			startpos = agt.position.clone();
			
		}
		
		override public function onStart():void {
			BioAgent(agent).direction = direction;
			//trace(this.toString())
			var ev:AgentEvent = new AgentEvent(AgentEvent.ACTION_CHANGED, agent);
			ev.walkingDirection = direction;
			ev.destination = destination;
			ev.duration = duration;
			ev.actionType = BioAction.ACTION_MOVING;
			agent.eventDispatcher.dispatchEvent(ev);
		}
		
		override public function onFinish():void {
			var ev:AgentEvent = new AgentEvent(AgentEvent.MOVING_COMPLETE, agent, true);
			agent.position.x = destination.x;
			agent.position.y = destination.y;
			ev.destination = startpos.clone();
			agent.eventDispatcher.dispatchEvent(ev);
			calculateEnergyCost();
		}	

		private function calculateEnergyCost():void 
		{
			BioAgent(agent).calculateEnergyExpenditure(BioAgent(agent).expenditures.expWalking);
		}		
		
/**		override public function getEvent():AgentEvent {
			var ev:AgentEvent = super.getEvent();
			//ev.walkingDirection
		} */
		
		public function get destination():Point 
		{
			return _destination;
		}
		
		public function set destination(value:Point):void 
		{
			_destination = value;
		}
		
		public function toString():String {
			return "agent " + BioAgent(agent).id.toString() + "from: " + startpos.toString() + " to: " + destination.toString();
		}
	}
	
}