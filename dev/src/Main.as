package 
{
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import mas.enviro.Environment;
	import flash.display.Sprite;
	import flash.events.Event;
	import mas.enviro.Region;
	import model.BioAgent;
	import model.Config;
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
		private var controlTime:SliderComp;		
		private var compSlider:CompSlider;
		private var env:Environment;
		private var cenario:Cenario;
		private var btns:Botoes;
		private var borda:Borda;
		private var zoomBtns:ZoomBtns;
		
		private var cmdBorda:Sprite;
		private var cmdAtividade:Sprite;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);			
			
			addAnimations();
			reset();
			
		}
		

		
		private function reset():void 
		{
			if (cmdAtividade == null) {
				cmdAtividade = new Sprite();
				addChild(cmdAtividade);
			}
			
			if (cmdBorda == null) {
				cmdBorda = new Sprite();
				addChild(cmdBorda);
			}
			
			env = new Environment();
			setEnvironment(env);
			env.createNewAgents();
			
			//if (cenario != null) {
				//cmdAtividade.removeChild(cenario);
			//}
			cenario = new Cenario(env);
			cmdAtividade.addChild(cenario);
			cenario.init();
			cenario.addEventListener(Event.RESIZE, verifyZoom);
			
			
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
			verifyZoom();
		}
		
		private function configControls(config:Object):void 
		{
			if(compSlider == null){
				compSlider = new CompSlider(config);
				cmdBorda.addChild(compSlider);
				compSlider.x = 10;
				compSlider.y = 10;
				compSlider.addEventListener(Event.CHANGE, changeParameters)
			}
			compSlider.temperatura = 80;
			
			if(controlTime == null){
				controlTime = new SliderComp("Tempo", 100, 1200, 50, 200, 400, 300);
				//controlTime = new SliderComp("Tempo", 100, 3000, 100, 500, 400);
				controlTime.x = 200;
				controlTime.y = 565;
				controlTime.addEventListener(Event.CHANGE, changeTime)
				cmdBorda.addChild(controlTime);
			}
			controlTime.setValue(300);
			
			//var s:Sprite = new Sprite();
			//s.graphics.beginFill(0x800000);
			//s.graphics.drawRect(0, 0, 20, 20);			
			//s.addEventListener(MouseEvent.CLICK, getMouse)
			//cmdBorda.addChild(s);
			//s.x = 600;
			//s.y = 10;
			
			if(zoomBtns == null){
				zoomBtns = new ZoomBtns();
				zoomBtns.x = 10;
				zoomBtns.y = 100;
				cmdBorda.addChild(zoomBtns);
				zoomBtns.start();
				zoomBtns.btnFunction(ZoomBtns.ZOOM_IN, zoomInFunc);
				zoomBtns.btnFunction(ZoomBtns.ZOOM_OUT, zoomOutFunc);
			}
			
			if(btns == null){
				btns = new Botoes();
				btns.x = 747;
				btns.y = 435;
				cmdBorda.addChild(btns);
				btns.start();
				btns.btnFunction(Botoes.CREDITOS, openCredit);
				btns.btnFunction(Botoes.INSTRUCOES, openInstructions);
				btns.btnFunction(Botoes.TUTORIAL, restartTutorial);
				btns.btnFunction(Botoes.RESET, getMouse);
			}
			
			if(borda == null){
				borda = new Borda();
				cmdBorda.addChild(borda);
			}
			
			
		}
		
		private function zoomInFunc(e:MouseEvent):void 
		{
			cenario.zoomInFunc();
			verifyZoom();
		}
		
		private function zoomOutFunc(e:MouseEvent):void 
		{
			cenario.zoomOutFunc();
			verifyZoom();
		}
		
		private function verifyZoom(e:Event = null):void
		{
			if (cenario.zoom == 1) zoomBtns.lockBtn(ZoomBtns.ZOOM_IN, true);
			else zoomBtns.lockBtn(ZoomBtns.ZOOM_IN, false);
			
			if (Math.abs(cenario.zoom - 0.5) < 0.01) zoomBtns.lockBtn(ZoomBtns.ZOOM_OUT, true);
			else zoomBtns.lockBtn(ZoomBtns.ZOOM_OUT, false);
		}
		
		private function openCredit(e:MouseEvent):void 
		{
			
		}
		
		private function openInstructions(e:MouseEvent):void 
		{
			
		}
		
		private function restartTutorial(e:MouseEvent):void 
		{
			
		}
		
		private function getMouse(e:MouseEvent):void 
		{
				trace("reset")
				reset();
		}
		

		
		private function changeTime(e:Event):void 
		{
			Config.t = (1200 - controlTime.getValue()) + 100;
			//controlTime.labelTxt = int(Config.tpadrao / controlTime.getValue()).toString();
			
		}
		
		private function changeParameters(e:Event):void 
		{
			env.getRegion(new Point(0, 0)).setResourceValue(Region.TYPE_TEMPERATURE,  compSlider.temperatura);
			//env.getRegion(new Point(0, 0)).setResourceValue(Region.TYPE_PH,  compSlider.ph);
			env.getRegion(new Point(0, 0)).setResourceValue(Region.TYPE_HUMIDITY,  compSlider.umidade);
		}
		
		
		private function setEnvironment(env:Environment):void {
			var r:Region = new Region(new Rectangle(0, 0, env.width - 1, env.height - 1));
			r.resources[Region.TYPE_TEMPERATURE] = 21;
			r.resources[Region.TYPE_PH] = 5;
			r.resources[Region.TYPE_HUMIDITY] = 60;
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