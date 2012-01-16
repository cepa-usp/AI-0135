package  view.iso
{
	import as3isolib.display.IsoSprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import mas.agent.Agent;
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

		
		public function Personagem(agt:Agent) 
		{
			this._agent = agt;
			
		}
		
		public function mudarMovimento(nomeMovimento:String) {
			if (currentMoveName.match(nomeMovimento)) return;
			currentMoveName = nomeMovimento;
			bitmapFrame.setMovimento(nomeMovimento);
			this.sprites = [bitmapFrame];
		}
		
		public function draw():void {
			var str:String = getQualifiedClassName(this.agent) + "_INICIAL";
			str = str.toUpperCase().split("::")[1];
			mudarMovimento(str);
			bitmapFrame.play();

			
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