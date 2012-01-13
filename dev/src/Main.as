package 
{
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import mas.enviro.Environment;
	import flash.display.Sprite;
	import flash.events.Event;
	import model.BioAgent;
	import model.creature1.Creature1;
	import model.LimitingFactorCurve;
	import view.iso.Cenario;
	import view.iso.Resources;
	import view.mini.MiniMap;
	
	
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
			
			addAnimations();
			
			var env:Environment = new Environment;
			env.createNewAgents();
			
			//var minimap:MiniMap = new MiniMap(env);
			//addChild(minimap)
			
			
			var cenario:Cenario = new Cenario(env);
			addChild(cenario);
			cenario.init();
			
		}
		
		private function addAnimations():void {
			Resources.carregarMovimento("CREATURE1_INICIAL", new Rectangle( -25, -25, 50, 50), new RodaDir())
			Resources.carregarMovimento("FOODAGENT_INICIAL", new Rectangle(-20,-22,41,44), new grass())
			Resources.carregarMovimento("CREATURE1_MOVE_6", new Rectangle( -25, -25, 50, 50), new Luigi())
			Resources.carregarMovimento("CREATURE1_MOVE_4", new Rectangle( -25, -25, 50, 50), new RodaEsq())
		}
		
	}
	
}