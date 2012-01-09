package mas.enviro
{
	import flash.display.Sprite;
	import mas.agent.Agent;
	import mas.enviro.Region;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class Environment extends Sprite
	{
		private var agents:Vector.<Agent> = new Vector.<Agent>();
		private var regions:Vector.<Region> = new Vector.<Region>();
		private var enviro_width:int = 100;
		private var enviro_height:int = 100;
		private var resourceMap:Array;
		
		public function Environment() 
		{
			resourceMap = new Array(enviro_width, enviro_height);
			resourceMap[2][3] = 2;
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
		
		
	}
	
}