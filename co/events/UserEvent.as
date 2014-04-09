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
		
		public function UserEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);

		}
		
		static public function addEventListener(displayObject:DisplayObject, type:String, handler:Function):void 
		{
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
			}
			displayObject.addEventListener(type, handler);
		}
		
		static private function pointerRun(e:Event):void 
		{
			var displayObject:DisplayObject = e.currentTarget as DisplayObject;
			displayObject.dispatchEvent(getNewUserEvent(POINTER_RUN, e));
		}
		
		static private function pointerDown(e:Event):void {
			var displayObject:DisplayObject = e.currentTarget as DisplayObject;
			displayObject.dispatchEvent(getNewUserEvent(POINTER_DOWN, e));
			//CoTrace.log("pointerDown",displayObject,e);
		}
		
		static private function pointerUp(e:Event):void {
			var displayObject:DisplayObject = e.currentTarget as DisplayObject;
			displayObject.dispatchEvent(getNewUserEvent(POINTER_UP, e));
		}
		
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