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
		
		public function Creature1_Move(agt:BioAgent, duration:Number, dest_x:int, dest_y:int) 
		{
			super(agt, duration, BioAction.ACTION_MOVING)
			this.destination = new Point(dest_x, dest_y);
			direction = ;
			
		}
		
		override function onStart() {
			BioAgent(agent).direction = direction;
		}
		
		override function onFinish() {
			agent.setPosition(destination.x, destination.y);
			calculateEnergyCost();
		}	
		
		override function getEvent():AgentEvent {
			var ev:AgentEvent = super.getEvent();
			ev.walkingDirection
		}
		
		public function get destination():Point 
		{
			return _destination;
		}
		
		public function set destination(value:Point):void 
		{
			_destination = value;
		}
	}
	
}