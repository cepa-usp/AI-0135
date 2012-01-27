package model.creature2
{
	import flash.geom.Point;
	import mas.agent.Agent;
	import mas.agent.reasoning.IReasoning;
	import mas.enviro.Environment;
	import model.BioAgent;
	import model.Config;
	import model.creature2.actions.Creature2_Mate;
	import model.creature2.actions.Creature2_Move;
	import model.creature2.Creature2;
	import model.FoodAgent;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class Reasoning_SearchMate  implements IReasoning
	{
		
		public function Reasoning_SearchMate() 
		{
			
		}
		
		
		public function think(agt:Agent):void 
		{
			
			var agent:BioAgent = BioAgent(agt);			
			if (agent.mindState != BioAgent.MINDSTATE_SEARCHING_MATE) return;
			var energy:Number = agent.energy;
			//if(agent.energy < DEFAULT_BIOAGENT_Ec)
			var targetmate:BioAgent = null;
			
			var posWalk:Array = null;
			var searchOther:Boolean = true;
			if (agent.mindState == BioAgent.MINDSTATE_SEARCHING_MATE) {				
				if (agent.mindVars["targetmate"] != null) {
					if (agent.environment.exists(Agent(agent.mindVars["targetmate"]))) {
						targetmate = agent.mindVars["targetmate"];
						bestPos = targetmate.position.clone();
						posWalk = walkCloser(agent, bestPos.clone());
						searchOther = false;
					} else {
						agent.mindVars["targetmate"] = null;
					}
				} 
				if(searchOther) {
					if (agent.mindVars["focus"] != null) {
						var bestPos:Point = null;
						for (var i:int = 0; i < agent.mindVars.focus.length; i++) {
							if(agent.mindVars.focus[i]!=null){
								for (var j:int = 0; j < agent.mindVars.focus[i].length; j++) {
									if (agent.mindVars.focus[i][j] != null) {
										var objfc:Object = agent.mindVars.focus[i][j];
										if (objfc is Creature2 && objfc!=agent) {
											if ( BioAgent(objfc).mindState == BioAgent.MINDSTATE_SEARCHING_MATE) {
												targetmate = BioAgent(objfc);
												bestPos = Creature2(agent.mindVars.focus[i][j]).position.clone();
												agent.mindVars.targetmate = targetmate;
											}
										}																				
									}
								}
							}
						}
						if (bestPos != null) {
							posWalk = walkCloser(agent, bestPos.clone());
						} else {
							posWalk = walkRandom(agent);
						}
						
					} else {
						posWalk = walkRandom(agent);
					}
				}	
			}
		
			if (posWalk != null) {
				agent.direction = posWalk[0];				
				var act:Creature2_Move = new Creature2_Move(agent, Config.t*(agent.velocity/100), posWalk[1].x, posWalk[1].y);
				agent.enqueueAction(act);

				if (targetmate != null) {
					//trace(Point.distance(posWalk[1], bestPos))
					if (posWalk[1] == null) return;
					if(Point.distance(posWalk[1], bestPos) <= 1){
						agent.mindState = BioAgent.MINDSTATE_MATING
						var mate:Creature2_Mate = new Creature2_Mate(agent, 2*Config.t, targetmate);					
						agent.enqueueAction(mate);
					}
				}				
			}

			
		}
		
		public function walkCloser(agent:BioAgent, destPos:Point):Array {
			
			var arr1:Array = [agent.position.clone(), agent.position.clone(), agent.position.clone(), agent.position.clone()];
			var arrDir:Array = [BioAgent.DIR_RIGHT, BioAgent.DIR_LEFT, BioAgent.DIR_DOWN,  BioAgent.DIR_UP];
			arr1[0].x++; arr1[1].x--; arr1[2].y++; arr1[3].y--;
			var arr2:Array = new Array();
			var i:int = 0;
			for each(var pos:Point in arr1) {
				if (isPositionAvailable(pos, agent.environment)) {
					arr2.push([arrDir[i], pos]);
				}
				i++;
			}
			lastComp = destPos;
			arr2.sort(comparepoints);
			var out:Array = arr2.shift();
			return out;
		}
		
		public function walkRandom(agent:BioAgent):Array {
			var arr1:Array = [BioAgent.DIR_LEFT, BioAgent.DIR_DOWN, BioAgent.DIR_RIGHT, BioAgent.DIR_UP, agent.direction, agent.direction, agent.direction, agent.direction, agent.direction, agent.direction];
			var arr2:Array = new Array();
			
			
			for each(var dir:int in arr1) {
				var pos:Point = agent.position.clone();
				switch(dir) {
					case BioAgent.DIR_DOWN:
						pos.y++;	
						break;
					case BioAgent.DIR_UP:
						pos.y--;	
						break;					
					case BioAgent.DIR_LEFT:
						pos.x--;	
						break;					
					case BioAgent.DIR_RIGHT:
						pos.x++;	
						break;					
				}
				if (isPositionAvailable(pos, agent.environment)) arr2.push([dir, pos]);
			}
			arr2.sort(shuffle);
			return arr2.pop();
		}
		
		private function isPositionAvailable(pos:Point, env:Environment):Boolean {
			if (pos.x < 0 || pos.y < 0) return false;
			if (env.resourceMap.length <= pos.x) return false;
			if (env.resourceMap[pos.x].length <= pos.y) return false;
			if (env.blockMap[pos.x][pos.y] == true) return false;
			return true;
		}
		
		private function shuffle(a:Object,b:Object):int {
			var num : int = Math.round(Math.random()*2)-1;
			return num;
		}
		
		private var lastComp:Point;
		private function comparepoints(ar1:Array, ar2:Array):int {
			var p1:Point = ar1[1];
			var p2:Point = ar2[1];
			if (lastComp == null) return 0;
			if (Point.distance(p1, lastComp) < Point.distance(p2, lastComp)) {
				return -1;
			} 
			return 1;
		}
		
	}
	
		
}
	
