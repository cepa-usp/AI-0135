package  view.iso
{
	import as3isolib.display.IsoSprite;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import mas.agent.Agent;
	import model.BioAction;
	import model.BioAgent;
	import model.Config;
	import model.creature1.Creature1;
	import model.FoodAgent;
	
	/**
	 * ...
	 * @author Alexandre
	 */
	public class Personagem extends IsoSprite 
	{
		private var _type:int = 0;
		private var _agent:Agent;		
		private var bitmapFrame:AnimationFrame = new AnimationFrame();
		private var currentMoveName:String = "";
		private var shadow:DropShadowFilter = new DropShadowFilter(7, 90, 0, 0.5, 8, 8, 1, 1, false, false, true);
		private var s:Sprite = new Sprite();
		
		public function Personagem(agt:Agent) 
		{
			this._agent = agt;
			
			//s.graphics.beginFill(0, 1);
			//s.graphics.drawEllipse(-12, -5, 25, 13);
			
			bitmapFrame.addEventListener(Event.COMPLETE, onAnimationComplete);
			addEventListener(MouseEvent.CLICK, showdata);
			agent.eventDispatcher.addEventListener(Event.SELECT, setFocus);
			
			
		}
		
		private function onAnimationComplete(e:Event):void 
		{
			if (this.agent is BioAgent) {
				if (BioAgent(this.agent).mindState == BioAgent.MINDSTATE_DEAD) {
					bitmapFrame.stop();
				}
			}
		}
		
		private function showdata(e:Event):void 
		{
			if (agent is BioAgent) {
				Config.viewId = BioAgent(agent).id;
				trace("****** id ", BioAgent(agent).id, " *********")
				trace("velocidade: ", BioAgent(agent).velocity )
				trace("energia: ", BioAgent(agent).energy )
				trace("energia max: ", BioAgent(agent).current_maxenergy )
				trace("idade: ", BioAgent(agent).age )
				//Bitmap(this.actualSprites[0]).filters = [new GlowFilter(0xFF8000)]
				
				
			}
		}
		public function setFocus(e:Event):void {
			focus(true);
		}
		
		public function focus(val:Boolean):void {
			if (val) {
				if (this.actualSprites.length == 0) return;
				//Bitmap(this.actualSprites[0]).filters = [new GlowFilter(0x80FFFF)]
			} else {
				if (this.actualSprites.length == 0) return;
				//Bitmap(this.actualSprites[0]).filters = []
				//Sprite(this.actualSprites[0]).filters = []
			}
		}
		
		public function mudarMovimento(nomeMovimento:String):void {
			if (currentMoveName.match(nomeMovimento)) return;
			currentMoveName = nomeMovimento;
			bitmapFrame.setMovimento(nomeMovimento);
			this.sprites = [s, bitmapFrame];
		}
		
		public function draw():void {
			var str:String = getQualifiedClassName(this.agent) + "_INICIAL";
			str = str.toUpperCase().split("::")[1];
			mudarMovimento(str);
			bitmapFrame.play();

			//Bitmap(this.actualSprites[0]).filters = [shadow]
			Sprite(this.sprites[0]).filters = []
		}		
		

		public function get agent():Agent 
		{
			return _agent;
		}
		
		public function set agent(value:Agent):void 
		{
			_agent = value;
		}
		
		public function get type():int 
		{
			return _type;
		}
		
		public function set type(value:int):void 
		{
			_type = value;
		}
		
	}

}