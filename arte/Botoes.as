package 
{
	import cepa.utils.ToolTip;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Alexandre
	 */
	public class Botoes extends Sprite 
	{
		public static const TUTORIAL:String = "tutorial";
		public static const INSTRUCOES:String = "instrucoes";
		public static const RESET:String = "reset";
		public static const CREDITOS:String = "creditos";
		
		//private var tutoBtn:MovieClip;
		private var instBtn:MovieClip;
		private var intResetBtn:MovieClip;
		private var creditBtn:MovieClip;
		
		public function Botoes():void {
			makeConections();
		}
		
		public function start():void
		{
			initializeBtns();
		}
		
		private function makeConections():void
		{
			//tutoBtn = tutorialBtn;
			instBtn = instructionsBtn;
			intResetBtn = resetBtn;
			creditBtn = creditosBtn;
		}
		
		private function initializeBtns():void 
		{
			//overOutListeners(tutoBtn, "Reiniciar tutorial");
			overOutListeners(instBtn, "Orientações");
			overOutListeners(intResetBtn, "Reiniciar");
			overOutListeners(creditBtn, "Créditos");
		}
		
		private function overOutListeners(btn:MovieClip, tt:String):void
		{
			btn.buttonMode = true;
			btn.mouseChildren = false;
			btn.gotoAndStop(1);
			btn.addEventListener(MouseEvent.MOUSE_OVER, overEnevt);
			btn.addEventListener(MouseEvent.MOUSE_OUT, outEnevt);
			
			var ttp:ToolTip = new ToolTip(btn, tt, 12, 0.8, 150, 0.6, 0.1);
			this.parent.addChild(ttp);
		}
		
		private function overEnevt(e:MouseEvent):void 
		{
			var btn:MovieClip = MovieClip(e.target);
			btn.gotoAndStop(2);
		}
		
		private function outEnevt(e:MouseEvent):void 
		{
			var btn:MovieClip = MovieClip(e.target);
			btn.gotoAndStop(1);
		}
		
		public function btnFunction(btn:String, func:Function):void
		{
			switch(btn) {
				//case TUTORIAL:
					//tutoBtn.addEventListener(MouseEvent.CLICK, func);
					//break;
				case INSTRUCOES:
					instBtn.addEventListener(MouseEvent.CLICK, func);
					break;
				case RESET:
					intResetBtn.addEventListener(MouseEvent.CLICK, func);
					break;
				case CREDITOS:
					creditBtn.addEventListener(MouseEvent.CLICK, func);
					break;
				default:
					return;
			}
		}
		
	}
	
}