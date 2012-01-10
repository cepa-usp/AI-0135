package mas.enviro
{
	import as3isolib.core.EventListenerDescriptor;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import mas.agent.Agent;
	import mas.enviro.Region;
	import model.Config;
	import model.creature1.Creature1;
	import model.FoodAgent;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class Environment
	{
		private var _agents:Vector.<Agent> = new Vector.<Agent>();
		private var regions:Vector.<Region> = new Vector.<Region>();
		private var enviro_width:int = 100;
		private var enviro_height:int = 100;
		private var resourceMap:Array;
		
		public function Environment() 
		{
			resourceMap = new Array(enviro_width);
			for (var i:int = 0; i < resourceMap.length; i++)  resourceMap[i] = new Array(enviro_height);		
			resourceMap[2][3] = new Object();
		}
		
		
		public function addRegion(r:Region):void {
			regions.push(r);
			var idx:int = regions.indexOf(r, 0);
			
		}
		
		private function getResourceValue(posX:int, posY:int, resource_type:String):Number {
			var region:Region = resourceMap[posX][posY];			
			return region.getResourceValue(resource_type);
			
		}
		
		public function registerAgent(a:Agent):void {
			agents.push(a);
		}			
		
		public function init():void {
			for each (var a:Agent in agents) {
				a.init(this, new Point(Math.random()*enviro_width, Math.random()*enviro_height));
			}
		}
		
		public function start():void {
			run();
			var t:Timer = new Timer(Config.t, 0);
			t.addEventListener(TimerEvent.TIMER, run)
		}
		
		private function run(e:Event = null):void {
			for each (var a:Agent in agents) {
				a.think();
			}
		}
		
		public function createNewAgents():void {
			for (var i:int = 0; i < 1; i++) {
				var creature:Creature1 = new Creature1();
				registerAgent(creature);
				
			}
			for (var ia:int = 0; ia < 4; ia++) {
				var food:FoodAgent = new FoodAgent();				
				registerAgent(food);				
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
		
		
	}
	
}