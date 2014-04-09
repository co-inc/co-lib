package co.events 
{
	import co.debug.CoTrace;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author chitose
	 */
	public class UserEvent extends Event 
	{
		static public const POINTER_DOWN:String = "pointerDown";
		static public const POINTER_UP:String = "pointerUp";
		static public const POINTER_RUN:String = "pointerRun";
		static public const POINTER_MOVE:String = "pointerMove";
		static public const POINTER_DRAG:String = "pointerDrag";
		static public const POINTER_ROLL_OVER:String = "pointerRollOver";
		static public const POINTER_ROLL_OUT:String = "pointerRollOut";
		
		//MouseEvent only
		public var buttonDown : Boolean 
		public var delta : int 
		public var clickCount : int 
		   
		//TouchEvent only
		public var touchPointID : int 
		public var isPrimaryTouchPoint : Boolean 
		public var sizeX : Number 
		public var sizeY : Number 
		public var pressure : Number 
		public var timestamp : Number 
		public var touchIntent : String 
		public var samples : ByteArray 
		public var isTouchPointCanceled : Boolean 
		   
		//common
		public var localX : Number 
		public var localY : Number 
		public var relatedObject : InteractiveObject 
		public var ctrlKey : Boolean 
		public var altKey : Boolean 
		public var shiftKey : Boolean 
		public var commandKey : Boolean 
		public var controlKey : Boolean
		
		//original
		public var startEvent:UserEvent;
		
		public function UserEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);

		}
		
		public function removeEventListener():void 
		{
			
		}

		
		/**
		 * 
		 * @param	displayObject
		 * @param	type
		 * @param	handler
		 */
		static public function addEventListener(displayObject:DisplayObject, type:String, handler:Function):void 
		{
			removeEventListener(displayObject, type, function(){} );
			switch(type) {
				case POINTER_DOWN:
					displayObject.addEventListener(MouseEvent.MOUSE_DOWN, pointerDown);
					displayObject.addEventListener(TouchEvent.TOUCH_BEGIN, pointerDown);
					break;
				case POINTER_UP:
					displayObject.addEventListener(MouseEvent.MOUSE_UP, pointerUp);
					displayObject.addEventListener(TouchEvent.TOUCH_END, pointerUp);
					break;
				case POINTER_RUN:
					displayObject.addEventListener(MouseEvent.CLICK, pointerRun);
					displayObject.addEventListener(TouchEvent.TOUCH_TAP, pointerRun);
					break;
				case POINTER_MOVE:
					displayObject.addEventListener(MouseEvent.MOUSE_MOVE,pointerMove);
					displayObject.addEventListener(TouchEvent.TOUCH_MOVE,pointerMove);
					break;
				//case POINTER_DRAG:
					//pointerDrag(displayObject, handler);
					//break;
				case POINTER_ROLL_OVER:
					displayObject.addEventListener(MouseEvent.ROLL_OVER, pointerRollOver );
					displayObject.addEventListener(TouchEvent.TOUCH_ROLL_OVER, pointerRollOver );
					break;
				case POINTER_ROLL_OUT:
					displayObject.addEventListener(MouseEvent.ROLL_OUT, pointerRollOut );
					displayObject.addEventListener(TouchEvent.TOUCH_ROLL_OUT, pointerRollOut );
					break;
			}
			displayObject.addEventListener(type, handler);
		}
		
		/**
		 * 
		 * @param	displayObject
		 * @param	type
		 * @param	handler
		 */
        static public function removeEventListener(displayObject:DisplayObject, type:String, handler:Function):void
        {
            switch(type) {
                case POINTER_DOWN:
                    displayObject.removeEventListener(MouseEvent.MOUSE_DOWN, pointerDown);
                    displayObject.removeEventListener(TouchEvent.TOUCH_BEGIN, pointerDown);
                    break;
                case POINTER_UP:
                    displayObject.removeEventListener(MouseEvent.MOUSE_UP, pointerUp);
                    displayObject.removeEventListener(TouchEvent.TOUCH_END, pointerUp);
                    break;
                case POINTER_RUN:
                    displayObject.removeEventListener(MouseEvent.CLICK, pointerRun);
                    displayObject.removeEventListener(TouchEvent.TOUCH_TAP, pointerRun);
                    break;
				case POINTER_MOVE:
					displayObject.removeEventListener(MouseEvent.MOUSE_MOVE,pointerMove);
					displayObject.removeEventListener(TouchEvent.TOUCH_MOVE,pointerMove);
					break;
				//case POINTER_DRAG:
					//displayObject.dispatchEvent(new RemoveEvent(POINTER_DRAG));
					//break;
				case POINTER_ROLL_OVER:
					displayObject.removeEventListener(MouseEvent.ROLL_OVER, pointerRollOver );
					displayObject.removeEventListener(TouchEvent.TOUCH_ROLL_OVER, pointerRollOver );
					break;
				case POINTER_ROLL_OUT:
					displayObject.removeEventListener(MouseEvent.ROLL_OUT, pointerRollOut );
					displayObject.removeEventListener(TouchEvent.TOUCH_ROLL_OUT, pointerRollOut );
					break;
            }
            displayObject.removeEventListener(type, handler);
        }
		
		
		/**
		 * 
		 * @param	displayObject
		 * @param	handler
		 */
		static private function pointerDrag(displayObject:DisplayObject,handler:Function):void 
		{
			//var ue:UserEvent = null;
			//var _ue:UserEvent = ue;
			//
			//UserEvent.addEventListener(Pointer)
			//displayObject.addEventListener(MouseEvent.MOUSE_MOVE,move);
			//displayObject.addEventListener(TouchEvent.TOUCH_MOVE,move);
			//displayObject.addEventListener(Event.ENTER_FRAME, enter);
			//
			//displayObject.addEventListener(POINTER_DRAG, remove);
			//
			//function move(e:Event):void {
				//var __ue:UserEvent=getNewUserEvent(POINTER_DRAG, e);
				//if (ue == null) startEvent = __ue;
				//ue = __ue;
			//}
			//function enter(e:Event):void {
				//if (ue != _ue) {
					//displayObject.dispatchEvent(ue);
					//_ue = ue;
				//}
			//}
			//function remove(e:RemoveEvent):void {
				//displayObject.removeEventListener(MouseEvent.MOUSE_MOVE,move);
				//displayObject.removeEventListener(TouchEvent.TOUCH_MOVE,move);
				//displayObject.removeEventListener(Event.ENTER_FRAME, enter);
				//displayObject.removeEventListener(POINTER_DRAG, remove);
			//}
		}
		
		static private function pointerMove(e:MouseEvent):void 
		{
			var displayObject:DisplayObject = e.currentTarget as DisplayObject;
			displayObject.dispatchEvent(getNewUserEvent(POINTER_MOVE, e));
		}
		
		/**
		 * クリックorタップ
		 * @param	e
		 */
		static private function pointerRun(e:Event):void 
		{
			var displayObject:DisplayObject = e.currentTarget as DisplayObject;
			displayObject.dispatchEvent(getNewUserEvent(POINTER_RUN, e));
		}
		
		/**
		 * ダウン
		 * @param	e
		 */
		static private function pointerDown(e:Event):void {
			var displayObject:DisplayObject = e.currentTarget as DisplayObject;
			displayObject.dispatchEvent(getNewUserEvent(POINTER_DOWN, e));
			//CoTrace.log("pointerDown",displayObject,e);
		}
		
		/**
		 * アップ
		 * @param	e
		 */
		static private function pointerUp(e:Event):void {
			var displayObject:DisplayObject = e.currentTarget as DisplayObject;
			displayObject.dispatchEvent(getNewUserEvent(POINTER_UP, e));
		}
		
		
		/**
		* ロールオーバー
		* @param	e
		*/
		static private function pointerRollOver( e:Event ):void{
			var displayObject:DisplayObject = e.currentTarget as DisplayObject;
			displayObject.dispatchEvent(getNewUserEvent(POINTER_ROLL_OVER, e));
		}
		
		/**
		* ロールアウト
		* @param	e
		*/
		static private function pointerRollOut( e:Event ):void{
			var displayObject:DisplayObject = e.currentTarget as DisplayObject;
			displayObject.dispatchEvent(getNewUserEvent(POINTER_ROLL_OUT, e));
		}
		
		/**
		 * MouseEvent と　TouchEventの混合Eventを作成
		 * @param	type
		 * @param	e
		 * @return
		 */
		static private function getNewUserEvent(type:String, e:Event):UserEvent 
		{
			var ue:UserEvent = new UserEvent(type);
			
			if (e is MouseEvent) {
				var me:MouseEvent = e as MouseEvent;
				ue.buttonDown = me.buttonDown;
				ue.delta = me.delta;
				ue.clickCount = me.clickCount;
				ue.touchPointID = -1;
			}else if (e is TouchEvent) {
				var te:TouchEvent = e as TouchEvent;
				ue.touchPointID = te.touchPointID;
				ue.isPrimaryTouchPoint = te.isPrimaryTouchPoint;
				ue.sizeX = te.sizeX;
				ue.sizeY = te.sizeY;
				ue.pressure = te.pressure;
				ue.timestamp = te.timestamp;
				ue.touchIntent = te.touchIntent;
				//ue.samples = te.samples;
				ue.isTouchPointCanceled = te.isTouchPointCanceled;
			}
			var oe:Object = e as Object;
			ue.localX = oe.localX;
			ue.localY = oe.localY;
			ue.relatedObject = oe.relatedObject;
			ue.ctrlKey = oe.ctrlKey;
			ue.altKey = oe.altKey;
			ue.shiftKey = oe.shiftKey;
			ue.commandKey = oe.commandKey;
			ue.controlKey = oe.controlKey;
			
			return ue;
		}	
	}
}
import flash.events.Event;
class RemoveEvent extends Event {
	public function RemoveEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
		super(type, bubbles, cancelable);
	}
	
}