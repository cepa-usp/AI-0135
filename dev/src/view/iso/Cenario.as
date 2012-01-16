package  view.iso
{
	import as3isolib.core.ClassFactory;
	import as3isolib.display.IsoSprite;
	import as3isolib.display.IsoView;
	import as3isolib.display.primitive.IsoBox;
	import as3isolib.display.renderers.DefaultViewRenderer;
	import as3isolib.display.renderers.ViewBoundsRenderer;
	import as3isolib.display.scene.IsoGrid;
	import as3isolib.display.scene.IsoScene;
	import as3isolib.geom.Pt;
	import as3isolib.graphics.Stroke;
	import com.eclecticdesignstudio.motion.Actuate;
	import com.eclecticdesignstudio.motion.easing.Linear;
	import com.eclecticdesignstudio.motion.easing.Quad;
	import fl.transitions.easing.None;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.setInterval;
	import mas.agent.Agent;
	import mas.enviro.Environment;
	import model.AgentEvent;
	import model.BioAction;
	import model.BioAgent;
	import model.creature1.Creature1;
	import model.EnvironmentEvent;
	import model.FoodAgent;
	
	/**
	 * ...
	 * @author Alexandre
	 */
	public class Cenario extends Sprite 
	{
		private static const CELL_SIZE:Number = 20;
		private static const GRID_SIZE:Point = new Point(60, 60);
		private static const VIEW_SIZE:Point = new Point(800, 600);
		private var center_point:Pt = new Pt(400, 400, 0);		
		private var grid:IsoGrid;
		private var scene:IsoScene;
		private var sceneObj:IsoScene;
		private var view:IsoView;		
		private var personagens:Vector.<Personagem>;	
		private var enviro:Environment;


		public function Cenario(environment:Environment):void 
		{
			enviro = environment;
		}
		
		public function init():void {
			setupVariables();
			setupIsoLib();
			//createScenario();
			//stage.addEventListener(MouseEvent.CLICK, center);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, panViewIni);
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, viewZoom);
			enviro.eventDispatcher.addEventListener(EnvironmentEvent.AGENT_CREATED, onAgentCreated)
			enviro.eventDispatcher.addEventListener(EnvironmentEvent.AGENT_DESTROYED, onAgentDestroyed)
			
			// adiciona os agentes 
			for each(var ag:Agent in enviro.agents) addNewAgent(ag);
			sceneObj.render();
		}
		
		private function onAgentDestroyed(e:EnvironmentEvent):void 
		{
			for each(var pers:Personagem in personagens) {
				if (pers.agent == e.agent) {
					personagens.splice(personagens.indexOf(pers), 1);
					if(e.agent is FoodAgent) sceneObj.removeChild(pers);
					else scene.removeChild(pers);
					return;
				}
			}
		}
		
		private function onAgentCreated(e:EnvironmentEvent):void 
		{
			addNewAgent(e.agent);
		}		

		private function setupVariables():void {
			personagens = new Vector.<Personagem>();
		}		
		
		public function addNewAgent(ag:Agent):void {
			var newChar:Personagem;
			newChar = new Personagem(ag);
			personagens.push(newChar);
			ag.eventDispatcher.addEventListener(AgentEvent.ACTION_CHANGED, onAgentActionChange);
			if (ag is FoodAgent) {
				sceneObj.addChild(newChar);
			}else {	
				//ag.eventDispatcher.addEventListener(AgentEvent.ACTION_CHANGED, onAgentActionChange);
				
				scene.addChild(newChar);
			}
			var pos:Point = ag.position.clone();
				
			newChar.x = getScenePosition(pos).x;
			newChar.y = getScenePosition(pos).y;
			newChar.draw();
		}		
		
		// TODO:ajustar posição		
		public function getScenePosition(p:Point):Point {
			return new Point(p.x*CELL_SIZE, p.y*CELL_SIZE);
		}
		
		private function getPersonagem(a:Agent):view.iso.Personagem {
				for each (var pers:view.iso.Personagem in personagens) {
				if (pers.agent == a) {						
					return pers;
				}
			}
			return null;
		}
		
		private function onAgentActionChange(e:AgentEvent):void 
		{
			var personagem:Personagem = getPersonagem(e.agent);
			if (personagem == null) return;
			
			if (e.agent is Creature1) {
				if (e.actionType == BioAction.ACTION_MOVING) {
					personagem.mudarMovimento("CREATURE1_MOVE_" + e.walkingDirection.toString());
					var newpos:Point = getScenePosition(e.destination);
					Actuate.defaultEase = Linear.easeNone;
					
					Actuate.tween(personagem, e.duration/1000, { x:newpos.x,  y:newpos.y})
				}							
			}

		}
		
		private var zoom:Number = 1;
		private function viewZoom(e:MouseEvent):void
		{
			if(e.delta > 0)
			{
				if(zoom < 1) zoom +=  0.10;
			}
			if(e.delta < 0)
			{
				if(zoom > 0.6) zoom -=  0.10;
			}
			view.currentZoom = zoom;
		}
		
		private function createScenario():void 
		{
			var iso:IsoSprite;
			var array:Array; // = Resources.parseXMLA(new Resources.XMLSheetA);
			
			for (var i:int = 0; i < GRID_SIZE.x; i++) 
			{
				for (var j:int = 0; j < GRID_SIZE.y; j++) 
				{
					/*
					if (Math.random() > 0.95) {
						iso = new IsoSprite();
						//var arvore:ArvoreBase = new ArvoreBase(Resources.sheetA, array);
						//iso.sprites = [arvore];
						
						var teste:MCtoBMP = new MCtoBMP(new grass(), new Rectangle(-20,-22,41,44));
						teste.x = -21;
						teste.y = -22;
						iso.sprites = [teste];
						
						//var av:grass = new grass();
						//av.graphics.
						//av.cacheAsBitmap = true;
						//iso.sprites = [av.];
						iso.moveBy(j * CELL_SIZE, i * CELL_SIZE, 0);
						sceneObj.addChild(iso);
					}else if (Math.random() > 0.99) {*/
						iso = new IsoSprite();
						var terra:Bitmap = new Bitmap(Resources.SandB);
						terra.x = -20;
						terra.y = -1;
						iso.sprites = [terra];
						//iso.sprites = [sand];
						iso.moveBy(j * CELL_SIZE, i * CELL_SIZE, 0);
						sceneObj.addChild(iso);
					//}
					
				}
				
			}
			sceneObj.render();
		}
		
		private var inicialClickPos:Point;
		private function panViewIni(e:MouseEvent):void 
		{
			inicialClickPos = new Point(stage.mouseX, stage.mouseY);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, panView);
			stage.addEventListener(MouseEvent.MOUSE_UP, panViewEnd);
		}
		
		private function panView(e:MouseEvent):void 
		{
			var mousePos:Point = new Point(stage.mouseX, stage.mouseY);
			
			var difPos:Point = new Point(mousePos.x - inicialClickPos.x, mousePos.y - inicialClickPos.y);
			view.panBy( -difPos.x, -difPos.y);
			
			inicialClickPos = new Point(stage.mouseX, stage.mouseY);
		}
		
		private function panViewEnd(e:MouseEvent):void 
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, panView);
			stage.removeEventListener(MouseEvent.MOUSE_UP, panViewEnd);
		}
		
		private function center(e:MouseEvent):void 
		{
			view.centerOnPt(view.localToIso(new Pt(stage.mouseX, stage.mouseY)));
		}
		
		/**
		 * Cria a grid (pode ser omitida no projeto final).
		 * Cria a cena, onde serão inseridos os personagens e cenário.
		 * Cria o view, onde a cena é adicionada.
		 */
		private function setupIsoLib():void 
		{
			grid = new IsoGrid();
			grid.setGridSize(GRID_SIZE.x, GRID_SIZE.y, 1);
			grid.gridlines = new Stroke(0.5, 0x000000);
			grid.showOrigin = false;
			grid.cellSize = CELL_SIZE;
			
			scene = new IsoScene();
			sceneObj = new IsoScene();
			
			view = new IsoView();
			view.setSize(VIEW_SIZE.x, VIEW_SIZE.y);
			view.centerOnPt(center_point);
			view.addScene(sceneObj);
			view.addScene(scene);
			//scene.addChild(grid);
			
			var bg:Bitmap = new Bitmap(Resources.BkgBmpd);
			bg.x = -bg.width / 2;
			bg.y = -100;
			
			view.backgroundContainer.addChild(bg);
			view.rangeOfMotionTarget = bg;
		
			addChild(view);
			
			addEventListener(Event.ENTER_FRAME, renderScene);
		}
		
		/**
		 * Função que renderiza a cena inteira, começando pelos personagens e cenário.
		 */
		private function renderScene(e:Event):void 
		{

			//Renderiza a cena
			scene.render();
		}

		
		
	}
	
}