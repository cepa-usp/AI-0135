package view 
{
	import as3isolib.core.EventListenerDescriptor;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import mas.agent.Agent;
	import mas.enviro.DefaultRegion;
	import mas.enviro.Environment;
	import model.AgentEvent;
	import model.BioAction;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class MiniMap extends Sprite
	{
		private var agent_layer:Sprite = new Sprite();
		
		private var enviro:Environment;
		private var agts:Vector.<MiniAgent> = new Vector.<MiniAgent>();
		public function MiniMap(environment:Environment) 
		{
			enviro = environment;
			addChild(agent_layer);
			draw();
		}
		
		public function draw():void {
			graphics.lineStyle(1, 0, 1);
			graphics.beginFill(0xB9DC92, 1);
			this.graphics.drawRect(0, 0, 300, 300);			
			for each(var ag:Agent in enviro.agents) {
				var miniag:MiniAgent = new MiniAgent(ag);
				miniag.agent = ag;
				miniag.addEventListener(AgentEvent.ACTION_CHANGED, onAgentActionChange);
				agent_layer.addChild(miniag)
				
				var pos:Point = ag.position;
				var newpos:Point = new Point((width / enviro.width) * pos.x, (height / enviro.height) * pos.y)
				miniag.x = newpos.x;
				miniag.y = newpos.y;		
				miniag.draw();
				
				
			}
		}
		
		public function onAgentActionChange(e:AgentEvent):void {
			if(e.actionType = BioAction.ACTION_MOVING){
				var ma:MiniAgent = MiniAgent(e.tag);
				var pos:Point = e.agent.position;
				var newpos:Point = new Point((width / enviro.width) * e.destination.x, (height / enviro.height) * e.destination.y)
				ma.x = newpos.x;
				ma.y = newpos.y;
			}
		}
		
		
	}
	
}