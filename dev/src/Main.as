package 
{
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import mas.enviro.Environment;
	import flash.display.Sprite;
	import flash.events.Event;
	import mas.enviro.Region;
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
			setEnvironment(env);
			env.createNewAgents();
			
			//var minimap:MiniMap = new MiniMap(env);
			//addChild(minimap)
			
			
			var cenario:Cenario = new Cenario(env);
			addChild(cenario);
			cenario.init();
			
		}
		
		
		private function setEnvironment(env:Environment):void {
			var r:Region = new Region(new Rectangle(0, 0, env.width - 1, env.height - 1));
			r.resources[Region.TYPE_TEMPERATURE] = 21;
			r.resources[Region.TYPE_PH] = 7;
			env.addRegion(r)
		}
		
		private function addAnimations():void {
			Resources.carregarMovimento("FOODAGENT_INICIAL"/*, new Rectangle( -20, -22, 41, 44)*/, new grass()/*, new Point(-20, -22)*/);
			Resources.carregarMovimento("CREATURE1_INICIAL"/*, new Rectangle( 0, 0, 18, 35)*/, new StickMan()/*, new Point(-9, -18)*/);
			Resources.carregarMovimento("CREATURE1_IDLE"/*, new Rectangle( 0, 0, 18, 35)*/, new StickMan()/*, new Point(-9, -18)*/);
			Resources.carregarMovimento("CREATURE1_MOVE_4"/*, new Rectangle( 0, 0, 18, 35)*/, new Mario_up()/*, new Point(-9, -18)*/);
			Resources.carregarMovimento("CREATURE1_MOVE_6"/*, new Rectangle( 0, 0, 18, 35)*/, new Mario_down()/*, new Point(-9, -18)*/);
			Resources.carregarMovimento("CREATURE1_MOVE_2"/*, new Rectangle( 0, 0, 18, 35)*/, new Mario_left()/*, new Point(-9, -18)*/);
			Resources.carregarMovimento("CREATURE1_MOVE_8"/*, new Rectangle( 0, 0, 18, 35)*/, new Mario_right()/*, new Point(-9, -18)*/);
		}
		
	}
	
}