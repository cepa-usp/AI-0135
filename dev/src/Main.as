package 
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import mas.enviro.Environment;
	import flash.display.Sprite;
	import flash.events.Event;
	import model.BioAgent;
	import model.LimitingFactorCurve;
	import view.MiniMap;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			var env:Environment = new Environment;
			env.createNewAgents();
			
			var minimap:MiniMap = new MiniMap(env);
			addChild(minimap)
			
		}
		
	}
	
}