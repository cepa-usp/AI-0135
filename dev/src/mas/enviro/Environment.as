package mas.enviro
{
	import as3isolib.core.EventListenerDescriptor;
	import eDpLib.events.EventDispatcherProxy;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import flash.utils.Timer;
	import mas.agent.Agent;
	import mas.enviro.Region;
	import model.actions.BioAgent_Born;
	import model.actions.BioAgent_Die;
	import model.actions.BioAgent_Idle;
	import model.AgentEvent;
	import model.Arvore1;
	import model.BaseAgent;
	import model.BioAction;
	import model.BioAgent;
	import model.Config;
	import model.creature1.Creature1;
	import model.creature2.Creature2;
	import model.EnvironmentEvent;
	import model.FoodAgent;
	import model.Pedra1;
	import model.Pedra2;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class Environment
	{
		private var _agents:Vector.<Agent> = new Vector.<Agent>();
		private var regions:Vector.<Region> = new Vector.<Region>();
		private var enviro_width:int = 60;
		private var enviro_height:int = 60;
		private var _resourceMap:Array;
		private var _blockMap:Array;
		private var _eventDispatcher:EventDispatcher = new EventDispatcher();
		private var ageTimer:Timer;
		private var hour:int = 0;
		
		public function Environment() 
		{
			resourceMap = new Array(enviro_width);
			blockMap = new Array(enviro_width);
			var i:int;
			var j:int;
			for (i = 0; i < resourceMap.length; i++)  {
				resourceMap[i] = new Array(enviro_height);	
				for (j = 0; j < resourceMap[i].length; j++) {
					resourceMap[i][j] = null;
				}
			}
			for (i = 0; i < blockMap.length; i++)  {
				blockMap[i] = new Array(enviro_height);		
				for (j = 0; j < blockMap[i].length; j++)  {
					blockMap[i][j] = false;
				}
			}
			
		}
		
		
		public function getRegion(p:Point):Region {
			var sel:Region = null;
			for each(var r:Region in regions) {
				if (pointintorect(p, r.area)) sel = r;
			}
			return sel;
		}
		
		private function pointintorect(p:Point, r:Rectangle):Boolean {
			return (p.x >= r.x && p.x <= (r.width + r.x) && p.y >= r.y && r.y <= (r.height + r.y));
		}
		
		
		public function addFood():void {
				var qtde:int = Math.random() * 7;
				
				for (var i:int = 0; i < qtde;i++ ) {
					var food:FoodAgent = new FoodAgent();				
					var pos:Point = getFreePosition();
					registerAgent(food, pos);					
				}
		}
		
		public function getFreePosition():Point {
			var x:int = Math.random() * this.width;
			var y:int = Math.random() * this.height;
			var cont:Boolean = true;
			
			while (cont) {
				if (x == this.width) x = 0;
				if (y == this.height) y = 0;
				if (resourceMap[x][y] == null) {
					return(new Point(x, y));
				} else {
					if (resourceMap[x][y].length == 0) {
						return(new Point(x, y));
					}
				}
				x++;
				y++;
			}
			return null;
		}
		
		
		public function computeHours(e:TimerEvent = null):void {
			if (e != null) {
				hour++;
				var a:Agent;
				for each(a in agents) {
					if (a is BioAgent) {
						BioAgent(a).calculateEnergyExpenditure(BioAgent(a).expenditures.expDefault);
						if (hour == Config.ageTurn) {
							BioAgent(a).addAge()
						}
					}
				}
				if (hour == Config.ageTurn) {
					addFood();
					hour = 0;
				}
			} else {
				ageTimer = new Timer(Config.hourTurn, 0) 
				ageTimer.addEventListener(TimerEvent.TIMER, computeHours);
				ageTimer.start();
			}
		}
		
		public function addRegion(r:Region):void {
			regions.push(r);
			var idx:int = regions.indexOf(r, 0);
			
		}
		
		private function getResourceValue(posX:int, posY:int, resource_type:String):Number {
			var region:Region = resourceMap[posX][posY];			
			return region.getResourceValue(resource_type);
			
		}
		
		public function moveAgent(e:AgentEvent):void {			
			// in this case destination is not destination itself but the agent's previous position			
			var arrObjs:Array = resourceMap[e.destination.x][e.destination.y];
			arrObjs.splice(arrObjs.indexOf(e.agent), 1);			
			blockMap[e.destination.x][e.destination.y] = false;
			setAgentPosition(BaseAgent(e.agent), e.agent.position);
		}
		
		
		public function fillExtraBlocks(a:BaseAgent):void {
			for each(var p:Point in a.extrablocks) {
				var x:int = p.x + a.position.x;
				var y:int = p.y + a.position.y;
				if (x >= resourceMap.length) continue;
				if (y >= resourceMap[x].length) continue;
				resourceMap[x][y] = [a];
				blockMap[x][y] = true;
			}
		}
		
		
		public function registerAgent(a:BaseAgent, pos:Point):void {
			agents.push(a);
			a.eventDispatcher.addEventListener(AgentEvent.MOVING_COMPLETE, moveAgent);
			if (a is BioAgent) {				
				a.eventDispatcher.addEventListener(AgentEvent.ACTION_CHANGED, bindAgentAction);
				a.eventDispatcher.addEventListener(AgentEvent.FEEDING_COMPLETE, feedAgent);
				a.eventDispatcher.addEventListener(AgentEvent.MATING_COMPLETE, onMatingComplete);
				a.eventDispatcher.addEventListener(AgentEvent.TERMINATED, onAgentTerminated);
			}
			setAgentPosition(a, pos);			
			a.init(this, pos);	
			fillExtraBlocks(a);			

			var ev:EnvironmentEvent = new EnvironmentEvent(EnvironmentEvent.AGENT_CREATED);
			ev.agent = Agent(a);
			eventDispatcher.dispatchEvent(ev);
		}			
		
		private function onAgentTerminated(e:AgentEvent):void 
		{
			deleteAgent(e.agent);
		}
		
		private function bindAgentAction(e:AgentEvent):void 
		{
			switch(e.actionType) {
				case BioAction.ACTION_EATING:
					startFeedAgent(BioAgent(e.agent), FoodAgent(e.tag));
					break;
				case BioAction.ACTION_DEAD:
					BioAgent(e.agent).enqueueAction(new BioAgent_Die(BioAgent(e.agent), 8000));	
					break;
			}
		}
		
		private function setAgentPosition(a:BaseAgent, pos:Point):void 
		{
			blockMap[pos.x][pos.y] = a.block;
			if (resourceMap[pos.x][pos.y] == null) resourceMap[pos.x][pos.y] = new Array();
			resourceMap[pos.x][pos.y].push(a);
			blockMap[pos.x][pos.y] = true;
		}
		
		public function exists(agt:Agent):Boolean {
			return (agents.indexOf(agt)>=0)
		}
		
		public function start():void {
			run();
			
		}
		
		private function run(e:Event = null):void {
			for each (var a:Agent in agents) {
				a.think();
			}
			
			
		}
		
		private function startFeedAgent(agt:BioAgent, food:FoodAgent):void {
			deleteAgent(food);					
		}
		
		private function deleteAgent(ag:Agent):void {
			var arr:Array = resourceMap[ag.position.x][ag.position.y];
			arr.splice(arr.indexOf(ag), 1);
			var idx:int = agents.indexOf(ag);
			agents.splice(idx, 1);
			var ev:EnvironmentEvent = new EnvironmentEvent(EnvironmentEvent.AGENT_DESTROYED);
			ev.agent = ag;
			eventDispatcher.dispatchEvent(ev);						
		}
		
		private function countSpecies(c:Class):int {
			var i:int = 0;
			for each (var a:Agent in agents) {
				if (a is c) i++;
			}
			return i;
		}
		
		private function feedAgent(e:AgentEvent):void {
			
			BioAgent(e.agent).recoverEnergy(FoodAgent(e.tag).energyProvided);
			
		}
		
		public function createNewAgents():void {
			var i:int  = 0;

			for (i = 0; i < 1; i++) {
				var pedra2:Pedra2 = new Pedra2();
				registerAgent(pedra2, getFreePosition()); 
				
			}

			for (i = 0; i < 3; i++) {
				var pedra1:Pedra1 = new Pedra1();
				registerAgent(pedra1, getFreePosition()); 
				
			}
			
			for (i = 0; i < 15; i++) {
				var arvore1:Arvore1 = new Arvore1();
				registerAgent(arvore1, getFreePosition()); 
				
			}

			for (i = 0; i < 15; i++) {
				var creature:Creature1 = new Creature1();
				registerAgent(creature, getFreePosition()); 
				
			}
			for (i = 0; i < 15; i++) {
				var creature2:Creature2 = new Creature2();
				registerAgent(creature2, getFreePosition()); 			
			}			
			for (var ia:int = 0; ia < 50; ia++) {
				var food:FoodAgent = new FoodAgent();				
				registerAgent(food, new Point(Math.floor(Math.random()*enviro_width), Math.floor(Math.random()*enviro_height)));				
				//registerAgent(food, new Point(0, 0));
			}		
			computeHours();
		}
		
		public function onMatingComplete(e:AgentEvent):void {
			var objclass:Class =  Class(getDefinitionByName(getQualifiedClassName(e.agent)))
			var qt:int = countSpecies(objclass);
			var pstar:Number = Config.calcPermissividadeNascimento(qt, 30, 6);
			var prob:Number = Math.random();
			trace("qt, pstar, prob: ", qt, pstar, prob)
			if (pstar > prob) {
				var creature:BioAgent = new objclass();
				registerAgent(creature, e.agent.position.clone());
				creature.mindState = BioAgent.MINDSTATE_IDLE;
				creature.enqueueAction(new BioAgent_Born(creature, 3000));	
				creature.enqueueAction(new BioAgent_Idle(creature, 10 * Config.t));
			}
		}
		
		public function get agents():Vector.<Agent> 
		{
			return _agents;
		}
		
		public function set agents(value:Vector.<Agent>):void 
		{
			_agents = value;
		}
		
		public function get width():int 
		{
			return enviro_width;
		}
		
		public function set width(value:int):void 
		{
			enviro_width = value;
		}
		
		public function get height():int 
		{
			return enviro_height;
		}
		
		public function set height(value:int):void 
		{
			enviro_height = value;
		}
		
		public function get resourceMap():Array 
		{
			return _resourceMap;
		}
		
		public function set resourceMap(value:Array):void 
		{
			_resourceMap = value;
		}
		
		public function get blockMap():Array 
		{
			return _blockMap;
		}
		
		public function set blockMap(value:Array):void 
		{
			_blockMap = value;
		}
		
		public function get eventDispatcher():EventDispatcher 
		{
			return _eventDispatcher;
		}
		
		public function set eventDispatcher(value:EventDispatcher):void 
		{
			_eventDispatcher = value;
		}
		
		
	}
	
}