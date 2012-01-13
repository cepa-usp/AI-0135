package  view.iso
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import model.BioAgent;
	/**
	 * ...
	 * @author Alexandre
	 */
	public class PersonagemBase
	{
		private var sheet:BitmapData;
		private var rects:Array;
		private var internalCanvas:BitmapData;
		private var pos:Point = new Point();
		
		public var bitMap:Bitmap;
		private var direction:int = BioAgent.DIR_DOWN;
		private var frame:int = 0;
		private var count:int = 0;
		private var vel:Number = 2;
		private var frameChangeCount:int = 4;
		
		public function PersonagemBase(sheet:BitmapData, rects:Array) 
		{
			this.sheet = sheet;
			this.rects = rects;
			
			internalCanvas = new BitmapData(rects[sideToMove][frame].width, rects[sideToMove][frame].height, true);
			bitMap = new Bitmap(internalCanvas);
			bitMap.x = -15;
			bitMap.y = -20;
		}
		
		/**
		 * Função que atualiza a posição e o gráfico que o personagem se encontra de acordo com
		 * a direção que o personagem está se movendo.
		 */
		public function render():void
		{

			
			//Quando a contagem chega a frameChangeCount faz uma mudança de estado do personagem, caso ele esteja se movimentando.
			if (count == frameChangeCount) {
				if (movingDown || movingLeft || movingRight || movingUp) {
					//Determina qual frame (estado) o personagem vai, e quando atinge o último elemento do vetor retorna a 0.
					frame = (frame == rects[sideToMove].length - 1) ? 0 : frame + 1;
				}else {
					//Quando o personagem não está se movimentando ele fica no estado FRONT no estado de número 1 (olhar spritesheet)
					frame = 1;
					sideToMove = FRONT;
					count = 0;
				}
				//Quando o contador chega a 3 ele é zerado (evita estouro de pilha).
				count = 0;
			}
			//Atualiza a posição e o estado do personagem.
			//bitMap.x = x - rects[sideToMove][frame].width / 2;;
			//bitMap.y = y - rects[sideToMove][frame].height / 2;;
			internalCanvas.copyPixels(sheet, rects[sideToMove][frame], pos);
			count++;
		}
		
		public function get currentRect():Rectangle
		{
			return rects[sideToMove][frame];
		}
		
		/**
		 * Inicia a movimentação do personagem em alguma direção, de acordo com o parâmetro passado.
		 */
		public function moveLeft(value:Boolean):void
		{
			if (value) stopMoving();
			movingLeft = value;
		}
		
		public function moveRight(value:Boolean):void
		{
			if (value) stopMoving();
			movingRight = value;
		}
		
		public function moveUp(value:Boolean):void
		{
			if (value) stopMoving();
			movingUp = value;
		}
		
		public function moveDown(value:Boolean):void
		{
			if (value) stopMoving();
			movingDown = value;
		}
		
		/**
		 * Para a movimentação do personagem.
		 */
		public function stopMoving():void
		{
			movingLeft = false;
			movingRight = false;
			movingUp = false;
			movingDown = false;
		}
		
	}

}