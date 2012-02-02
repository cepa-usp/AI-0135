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
	import view.iso.SliderComp;
	import view.mini.MiniMap;
	
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class Main extends Sprite 
	{
		//private var controlTemp:SliderComp;
		//private var controlPh:SliderComp;
		//private var controlHumidade:SliderComp;
		//private var controlTime:SliderComp;
		
		private var compSlider:CompSlider;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			addAnimations();
			
			var env:Environment = new Environment();
			setEnvironment(env);
			env.createNewAgents();
			
			//var minimap:MiniMap = new MiniMap(env);
			//addChild(minimap)
			
			
			var cenario:Cenario = new Cenario(env);
			addChild(cenario);
			cenario.init();
			
			var configSlider:Object = {
				temp: {
					minimum: 5,
					maximum: 95,
					tick: 5,
					snap: 1,
					inicial: 20
				},
				ph: {
					minimum: 0,
					maximum: 7,
					tick: 1,
					snap: 0.5,
					inicial: 4
				},
				umidade: {
					minimum: 0,
					maximum: 100,
					tick: 10,
					snap: 1,
					inicial: 30
				}
			}
			
			configControls(configSlider);
			
		}
		
		private function configControls(config:Object):void 
		{
			compSlider = new CompSlider(config);
			addChild(compSlider);
			compSlider.x = 10;
			compSlider.y = 10;
			compSlider.temperatura = 80;
			
			/*
			controlTime = new SliderComp("Tempo", 0, 100, 1, 10, widthSlider);
			controlTime.x = 4 * spaceBetweenSliders + 3 * widthSlider;
			controlTime.y = 570;
			addChild(controlTime);
			*/
		}
		
		
		private function setEnvironment(env:Environment):void {
			var r:Region = new Region(new Rectangle(0, 0, env.width - 1, env.height - 1));
			r.resources[Region.TYPE_TEMPERATURE] = 21;
			r.resources[Region.TYPE_PH] = 7;
			env.addRegion(r)
		}
		
		private function addAnimations():void {
			//Resources.carregarMovimento("FOODAGENT_INICIAL"/*, new Rectangle( -20, -22, 41, 44)*/, new grass()/*, new Point(-20, -22)*/);
			//Resources.carregarMovimento("CREATURE1_INICIAL"/*, new Rectangle( 0, 0, 18, 35)*/, new StickMan()/*, new Point(-9, -18)*/);
			//Resources.carregarMovimento("CREATURE1_IDLE"/*, new Rectangle( 0, 0, 18, 35)*/, new StickMan()/*, new Point(-9, -18)*/);
			//Resources.carregarMovimento("CREATURE1_MOVE_4"/*, new Rectangle( 0, 0, 18, 35)*/, new Mario_up()/*, new Point(-9, -18)*/);
			//Resources.carregarMovimento("CREATURE1_MOVE_6"/*, new Rectangle( 0, 0, 18, 35)*/, new Mario_down()/*, new Point(-9, -18)*/);
			//Resources.carregarMovimento("CREATURE1_MOVE_2"/*, new Rectangle( 0, 0, 18, 35)*/, new Mario_left()/*, new Point(-9, -18)*/);
			//Resources.carregarMovimento("CREATURE1_MOVE_8"/*, new Rectangle( 0, 0, 18, 35)*/, new Mario_right()/*, new Point(-9, -18)*/);
			
			Resources.carregarMovimento("FOODAGENT_INICIAL", new Moita());
			Resources.carregarMovimento("CREATURE1_INICIAL", new C1_nascendo());
			//Resources.carregarMovimento("CREATURE1_INICIAL", new C1_idle());
			Resources.carregarMovimento("CREATURE1_IDLE", new C1_idle());
			Resources.carregarMovimento("CREATURE1_MOVE_4", new C1_up());
			Resources.carregarMovimento("CREATURE1_MOVE_6", new C1_down());
			Resources.carregarMovimento("CREATURE1_MOVE_2", new C1_left());
			Resources.carregarMovimento("CREATURE1_MOVE_8", new C1_right());
			Resources.carregarMovimento("CREATURE1_BORN", new C1_nascendo());
			Resources.carregarMovimento("CREATURE1_DEAD", new C1_morrendo());
			Resources.carregarMovimento("CREATURE1_EATING", new C1_Comendo());
			Resources.carregarMovimento("CREATURE1_MATE", new C1_Acasalando());

			
			
			Resources.carregarMovimento("PEDRA1_INICIAL", new Pedra_pequena());
			Resources.carregarMovimento("PEDRA2_INICIAL", new Pedra_grande());
			Resources.carregarMovimento("ARVORE1_INICIAL", new Arvore());
			Resources.carregarMovimento("ARVORE2_INICIAL", new Arvore_z1());
			
			
			Resources.carregarMovimento("CREATURE2_INICIAL", new CriaturaNascendo2());
			//Resources.carregarMovimento("CREATURE2_INICIAL", new CriaturaParada2());
			Resources.carregarMovimento("CREATURE2_IDLE", new CriaturaParada2());
			Resources.carregarMovimento("CREATURE2_MOVE_4", new CriaturaUp2());
			Resources.carregarMovimento("CREATURE2_MOVE_6", new CriaturaFrente2());
			Resources.carregarMovimento("CREATURE2_MOVE_2", new CriaturaLeft2());
			Resources.carregarMovimento("CREATURE2_MOVE_8", new CriaturaCostas2());
			Resources.carregarMovimento("CREATURE2_BORN", new CriaturaNascendo2());
			Resources.carregarMovimento("CREATURE2_DEAD", new CriaturaMorrendo2());
			Resources.carregarMovimento("CREATURE2_EATING", new CriaturaComendo2());
			Resources.carregarMovimento("CREATURE2_MATE", new CriaturaAcasalando2());			
		}
		
	}
	
}