package model
{
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.getQualifiedClassName;
	import mas.agent.Agent;
	import mas.agent.sensor.ISensor;
	import mas.enviro.Environment;
	import model.actions.BioAgent_Born;
	import model.BioAction;
	import model.BioAgent;
	import model.Config;
	
	/**
	 * @author Arthur Tofani
	 */
	public class MateFinder implements ISensor
	{
		
		public function MateFinder() 
		{
			
		}
		
		/* INTERFACE mas.agent.sensor.ISensor */
		private var agent:BioAgent;
		public function receive(agt:Agent):void 
		{
			this.agent = BioAgent(agt);
			var nearestMate:BioAgent = null;
			var distance:Number = 999999;
			
			for (var a:Agent in agent.environment.agents) {
				if (a == agent) continue;
				if (getQualifiedClassName(a).match(getQualifiedClassName(agent))) {
					if (BioAgent(a).mindState == BioAgent.MINDSTATE_SEARCHING_MATE) {
						var dd:Number = Point.distance(a.position, agent.position);
						if (dd<distance) {
							distance = dd;
							nearestMate = BioAgent(a);
						}
					}
				}
			}
			
			agent.mindVars.nearestMate = nearestMate;
			
		}
		
		
		
	}
	
}