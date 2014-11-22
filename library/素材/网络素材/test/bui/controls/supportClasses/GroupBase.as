package bui.controls.supportClasses
{
	import bui.layouts.supportClasses.LayoutBase;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	/**
	 * GroupBase 类为显示可视元素的组件定义基类。
	 * group 组件不控制它所包含的可视项目的布局，而该布局是由单独的 layout 组件进行处理的。
	 */
	public class GroupBase extends Sprite
	{
		protected var _layout:LayoutBase;
		protected var _elements:Array;
		protected var _border:Boolean = false;
		protected var _borderColor:uint = 0xff0000;
		
		public function GroupBase()
		{
			_elements = new Array();
		}
		
		public function addElement(element:DisplayObject, index:int = -1):void
		{
			if(beforeAddElement(element, index))
			{
				_elements.splice(index, 0, element);
				addChild(element);
				_layout.elementAdded(index);
				afterAddElement(element, index);
			}
		}
		
		public function removeElement(index:int):void
		{
			if(beforeRemoveElement(index))
			{
				_elements.splice(index,-1);
			}
		}
		
		protected function beforeAddElement(element:DisplayObject, index:int):Boolean
		{
			return true;
		}
		
		protected function afterAddElement(element:DisplayObject, index:int):void
		{
			afterElementCountChange();
		}
		
		protected function beforeRemoveElement(index:int):Boolean
		{
			return true;
		}
		
		protected function afterRemoveElement(index:int):void
		{
			afterElementCountChange();
		}
		
		protected function afterElementCountChange():void
		{
			drawBorder();
		}
		
		protected function drawBorder():void
		{
			if(_border)
			{
				graphics.clear();
				graphics.lineStyle(1, _borderColor);
				graphics.moveTo(0, 0);
				graphics.lineTo(width, 0);
				graphics.lineTo(width, height);
				graphics.lineTo(0,height);
				graphics.endFill();
			}
		}
		
		public function set border(value:Boolean):void
		{
			_border = value;
		}
		
		public function get border():Boolean
		{
			return _border;
		}
		
		/**
		 * @todo 算法问题以后考虑
		 */
		/*
		public function mergeElement(element:DisplayObject, index:int = -1):int
		{
			if(index == -1)
			{
				_elements.push(element);
				return _elements.length - 1;
			}
			else if(index != -1 && index<_elements.length)
			{
				var newElements:Array = new Array();
				
				for(var i:int; i<_elements.length; i++)
				{
					if(i == index)
					{
						newElements.push(element);
					}
					newElements.push(_elements[i]);
				}
				
				_elements = newElements;
			}
			
			return index;
		}
		*/
		
		public function getElement(index:int):DisplayObject
		{
			if(index == -1)
			{
				return _elements[_elements.length - 1];	
			}
			
			return _elements[index];
		}
		
		public function get layout():LayoutBase
		{
			return _layout;
		}

		public function set layout(value:LayoutBase):void
		{
			_layout = value;
		}

		public function get elements():Array
		{
			return _elements;
		}

		public function set elements(value:Array):void
		{
			_elements = value;
		}


	}
}