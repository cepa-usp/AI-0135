package model.creature1 
{
	import flash.geom.Point;
	import mas.agent.Agent;
	import mas.agent.sensor.ISensor;
	import mas.enviro.Environment;
	import model.BioAction;
	import model.BioAgent;
	
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
		
		private var maxDistance:int = 9;
		public function SimpleEyes() 
		{
			
		}
		
		/* INTERFACE mas.agent.sensor.ISensor */
		
		public function receive(agt:Agent):void 
		{
			var agent:BioAgent = BioAgent(agt);
			var arrDist:Array = new Array(maxDistance);
			var range:int = 0;
			var env:Environment = agt.environment;
			var qt:int = 2;
			
			for (var d:int  = 1; d <= maxDistance; d++) {
				var objs:Array = new Array();
				var pos:Point = agt.position.clone();
				var y:int = pos.y;
				var x:int = pos.x;

				switch(agent.direction) {
					case BioAgent.DIR_UP:
						pos.y--;
						for (pos.x = x - d; pos.x <= x + d; pos.x++) checkObjects(objs, pos, env);
						break;
					case BioAgent.DIR_DOWN:
						pos.y++;
						for (pos.x = x - d; pos.x <= x + d; pos.x++) checkObjects(objs, pos, env);
						break;
					case BioAgent.DIR_LEFT:
						pos.x--;
						for (pos.y = y - d; pos.y <= y + d; pos.y++) checkObjects(objs, pos, env);
						break;
					case BioAgent.DIR_RIGHT:
						pos.x--;
						for (pos.y = y - d; pos.y <= y + d; pos.y++) checkObjects(objs, pos, env);
						break;
				}				
				range++;
				if (objs.length > 0) {
					arrDist[d - 1] = objs;
				} else {
					arrDist[d - 1] = null;
				}
			}
			agent.mindVars.focus = arrDist;
			
		}
		
		private function checkObjects(objs:Array, pos:Point, env:Environment):void 
		{		
				if (pos.x < 0 || pos.y < 0) return;
				if (env.resourceMap.length <= pos.x) return;
				if (env.resourceMap[pos.x].length <= pos.y) return;
				if (env.resourceMap[pos.x][pos.y]!=null) {
					objs.push(env.resourceMap[pos.x][pos.y]);
				}
			
		}
		
		
	}
	
}