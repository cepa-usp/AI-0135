package model
{
	import flash.events.Event;
	import flash.geom.Point;
	import mas.agent.Agent;
	import mas.agent.sensor.ISensor;
	import mas.enviro.Environment;
	import model.BioAction;
	import model.BioAgent;
	import model.Config;
	
	/**
	 * This is a sensor emulating simple eyes with some panoramic view
	 * It looks this way:
	 * 
	 * 
	 *                                 o
	 *                                 .
	 *                                ...
	 *                               .....
	 *                              .......
	 *                             .........
	 * 
	 * 
	 * @author Arthur Tofani
	 */
	public class SimpleEyes implements ISensor
	{
		
		private var maxDistance:int = 7;
		public function SimpleEyes() 
		{
			
		}
		
		/* INTERFACE mas.agent.sensor.ISensor */
		private var agent:BioAgent;
		public function receive(agt:Agent):void 
		{
			this.agent = BioAgent(agt);
			if(Config.SHOW_VISION) if (BioAgent(agent).id == Config.viewId) agent.eventDispatcher.dispatchEvent(new Event(Event.SELECT_ALL));
			var arrDist:Array = new Array();
			var range:int = 0;
			var env:Environment = agt.environment;
			var qt:int = 5;
				for (var d:int  = 0; d <= maxDistance; d++) {
				//trace("criatura ", agent.id, " dist ", d, " =======================")
				var objs:Array = new Array();
				var pos:Point = agt.position.clone();
				var y:int = pos.y;
				var x:int = pos.x;
				
				switch(agent.direction) {
					case BioAgent.DIR_UP:
						pos.y-=d;
						for (pos.x = x - d; pos.x <= x + d; pos.x++) {
							checkObjects(objs, pos, env);
						}
						break;
					case BioAgent.DIR_DOWN:
						pos.y+=d;
						for (pos.x = x - d; pos.x <= x + d; pos.x++) {
							checkObjects(objs, pos, env);
						}
						break;
					case BioAgent.DIR_LEFT:
						pos.x-=d;
						for (pos.y = y - d; pos.y <= y + d; pos.y++) {
							checkObjects(objs, pos, env);
						}
						break;
					case BioAgent.DIR_RIGHT:
						pos.x+=d;
						for (pos.y = y - d; pos.y <= y + d; pos.y++) {
							checkObjects(objs, pos, env);
						}
						break;
				}				
				range++;
				if (objs.length > 0) arrDist.push(objs);
 
			}
			agent.mindVars.focus = arrDist;
			
		}
		
		private function checkObjects(objs:Array, pos:Point, env:Environment):void 
		{		
				if (pos.x < 0 || pos.y < 0) return;
				if (env.resourceMap.length <= pos.x) return;
				if (env.resourceMap[pos.x].length <= pos.y) return;
				if (env.resourceMap[pos.x][pos.y]!=null) {
				
					
					for each (var agg:Agent in env.resourceMap[pos.x][pos.y]) {
						//trace(ag.description)
						if(Config.SHOW_VISION) if (BioAgent(agent).id == Config.viewId) agg.eventDispatcher.dispatchEvent(new Event(Event.SELECT));
						objs.push(agg);
						
						
					}
					
				}
			
		}
		
		
	}
	
}