// 用于管理拖动的插件，从网上找的

// 作者：JayChow 
// 摘自：http://www.cnblogs.com/ljchow/archive/2010/04/27/1721695.html
// 出处：http://ljchow.cnblogs.com 

// ps：修改了一些代码

var Common = {
	getEvent : function() {// ie/ff
		if (document.all) {
			return window.event;
		}
		func = getEvent.caller;
		while (func != null) {
			var arg0 = func.arguments[0];
			if (arg0) {
				if ((arg0.constructor == Event || arg0.constructor == MouseEvent)
						|| (typeof (arg0) == "object" && arg0.preventDefault && arg0.stopPropagation)) {
					return arg0;
				}
			}
			func = func.caller;
		}
		return null;
	},
	getMousePos : function(ev) {
		if (!ev) {
			ev = this.getEvent();
		}
		if (ev.pageX || ev.pageY) {
			return {
				x : ev.pageX,
				y : ev.pageY
			};
		}

		if (document.documentElement && document.documentElement.scrollTop) {
			return {
				x : ev.clientX + document.documentElement.scrollLeft
						- document.documentElement.clientLeft,
				y : ev.clientY + document.documentElement.scrollTop
						- document.documentElement.clientTop
			};
		} else if (document.body) {
			return {
				x : ev.clientX + document.body.scrollLeft
						- document.body.clientLeft,
				y : ev.clientY + document.body.scrollTop
						- document.body.clientTop
			};
		}
	},
	getItself : function(id) {
		return "string" == typeof id ? document.getElementById(id) : id;
	},
	getViewportSize : {
		w : (window.innerWidth) ? window.innerWidth
				: (document.documentElement && document.documentElement.clientWidth) ? document.documentElement.clientWidth
						: document.body.offsetWidth,
		h : (window.innerHeight) ? window.innerHeight
				: (document.documentElement && document.documentElement.clientHeight) ? document.documentElement.clientHeight
						: document.body.offsetHeight
	},
	isIE : document.all ? true : false,
	setOuterHtml : function(obj, html) {
		var Objrange = document.createRange();
		obj.innerHTML = html;
		Objrange.selectNodeContents(obj);
		var frag = Objrange.extractContents();
		obj.parentNode.insertBefore(frag, obj);
		obj.parentNode.removeChild(obj);
	}
}

// /------------------------------------------------------------------------------------------------------
var Class = {
	create : function() {
		return function() {
			this.init.apply(this, arguments);
		}
	}
}
var Drag = Class.create();
Drag.prototype = {
	init : function(titleBar, dragDiv, Options, callback) {
		// 设置点击是否透明，默认不透明
		titleBar = Common.getItself(titleBar);
		dragDiv = Common.getItself(dragDiv);
		if (callback) {
			this.callback = callback;
		}
		this.dragArea = {
			maxLeft : 0,
			maxRight : Common.getViewportSize.w - dragDiv.offsetWidth - 2,
			maxTop : 0,
			maxBottom : Common.getViewportSize.h - dragDiv.offsetHeight - 2
		};
		if (Options) {
			this.opacity = Options.opacity ? (isNaN(parseInt(Options.opacity)) ? 100
					: parseInt(Options.opacity))
					: 100;
			this.keepOrigin = Options.keepOrigin ? ((Options.keepOrigin == true || Options.keepOrigin == false) ? Options.keepOrigin
					: false)
					: false;
			if (this.keepOrigin) {
				this.opacity = 50;
			}
			if (Options.area) {
				if (Options.area.left && !isNaN(parseInt(Options.area.left))) {
					this.dragArea.maxLeft = Options.area.left
				}
				;
				if (Options.area.right && !isNaN(parseInt(Options.area.right))) {
					this.dragArea.maxRight = Options.area.right
				}
				;
				if (Options.area.top && !isNaN(parseInt(Options.area.top))) {
					this.dragArea.maxTop = Options.area.top
				}
				;
				if (Options.area.bottom
						&& !isNaN(parseInt(Options.area.bottom))) {
					this.dragArea.maxBottom = Options.area.bottom
				}
			}
		} else {
			this.opacity = 100, this.keepOrigin = false;
		}
		this.originDragDiv = null;
		this.tmpX = 0;
		this.tmpY = 0;
		this.moveable = false;
		this.scale = false;

		var dragObj = this;

		titleBar.onmousedown = function(e) {
			var ev = e || window.event || Common.getEvent();
			// 只允许通过鼠标左键进行拖拽,IE鼠标左键为1 FireFox为0
			if (Common.isIE && ev.button == 1 || !Common.isIE && ev.button == 0) {
			} else {
				return false;
			}

			if (dragObj.keepOrigin) {
				dragObj.originDragDiv = document.createElement("div");
				dragObj.originDragDiv.style.cssText = dragDiv.style.cssText;
				dragObj.originDragDiv.style.width = dragDiv.offsetWidth;
				dragObj.originDragDiv.style.height = dragDiv.offsetHeight;
				dragObj.originDragDiv.innerHTML = dragDiv.innerHTML;
				dragDiv.parentNode.appendChild(dragObj.originDragDiv);
			}

			dragObj.moveable = true;
			dragDiv.style.zIndex = dragObj.GetZindex() + 1;
			var downPos = Common.getMousePos(ev);
			dragObj.tmpX = downPos.x - dragDiv.offsetLeft;
			dragObj.tmpY = downPos.y - dragDiv.offsetTop;

			titleBar.style.cursor = "move";
			if (Common.isIE) {
				dragDiv.setCapture();
			} else {
				window.captureEvents(Event.mousemove);
			}

			dragObj.SetOpacity(dragDiv, dragObj.opacity);

			// FireFox 去除容器内拖拽图片问题
			if (ev.preventDefault) {
				ev.preventDefault();
				ev.stopPropagation();
			}
			
			var dx = downPos.x - this.getBoundingClientRect().left+document.documentElement.scrollLeft
			var dy = downPos.y - this.getBoundingClientRect().top+document.documentElement.scrollTop;
			var len = 10;
			
			if(parseInt(dragDiv.style.width)-dx < len && parseInt(dragDiv.style.height)-dy < len){
				dragObj.scale = true;
				titleBar.style.cursor = 'nw-resize';
			}else{
				dragObj.scale = false;
			}

			document.onmousemove = function(e) {
				if (dragObj.moveable) {
					var ev = e || window.event || Common.getEvent();
					// IE 去除容器内拖拽图片问题
					if (document.all) // IE
					{
						ev.returnValue = false;
					}

					var movePos = Common.getMousePos(ev);
					var width = parseInt(dragDiv.style.width);
					var height = parseInt(dragDiv.style.height);

					var left = Math.max(Math.min(movePos.x - dragObj.tmpX,
							dragObj.dragArea.maxRight - width),
							dragObj.dragArea.maxLeft);
					var top = Math.max(Math.min(movePos.y - dragObj.tmpY,
							dragObj.dragArea.maxBottom - height),
							dragObj.dragArea.maxTop);
					
					if(dragObj.scale){
						var dx = movePos.x - dragObj.tmpX - parseInt(dragDiv.style.left);
						var dy = movePos.y - dragObj.tmpY - parseInt(dragDiv.style.top);
						var d = dx < dy ? dx : dy;
						if(parseInt(dragDiv.style.width) + d < 30){
							d = parseInt(dragDiv.style.width) + d < 30 ? 30 - parseInt(dragDiv.style.width) : d;
						}
						if(parseInt(dragDiv.style.width) + d + parseInt(dragDiv.style.left) > dragObj.dragArea.maxRight){
							d = dragObj.dragArea.maxRight - (parseInt(dragDiv.style.width) + parseInt(dragDiv.style.left));
						}
						if(parseInt(dragDiv.style.height) + d + parseInt(dragDiv.style.top) > dragObj.dragArea.maxBottom){
							d = dragObj.dragArea.maxBottom - (parseInt(dragDiv.style.height) + parseInt(dragDiv.style.top));
						}
						var newWidth = (parseInt(dragDiv.style.width) + d);
						if(newWidth >= 30 && newWidth+parseInt(dragDiv.style.left)<=dragObj.dragArea.maxRight){
							dragDiv.style.width = (parseInt(dragDiv.style.width) + d) + 'px';
							dragDiv.style.height = (parseInt(dragDiv.style.height) + d) + 'px';
							dragObj.tmpX += d;
							dragObj.tmpY += d;	
						}
					}else{
						dragDiv.style.left = left + 'px';
						dragDiv.style.top = top + 'px';
					}

					if (callback) {
						callback();
					}
				}
			};

			document.onmouseup = function() {
				if (dragObj.keepOrigin) {
					if (Common.isIE) {
						dragObj.originDragDiv.outerHTML = "";
					} else {
						Common.setOuterHtml(dragObj.originDragDiv, "");
					}
				}
				if (dragObj.moveable) {
					if (Common.isIE) {
						dragDiv.releaseCapture();
					} else {
						window.releaseEvents(dragDiv.mousemove);
					}
					dragObj.SetOpacity(dragDiv, 100);
					titleBar.style.cursor = "default";
					dragObj.moveable = false;
					dragObj.tmpX = 0;
					dragObj.tmpY = 0;
				}
			};
		}
	},
	SetOpacity : function(dragDiv, n) {
		if (Common.isIE) {
			dragDiv.filters.alpha.opacity = n;
		} else {
			dragDiv.style.opacity = n / 100;
		}

	},
	GetZindex : function() {
		var maxZindex = 0;
		var divs = document.getElementsByTagName("div");
		for (z = 0; z < divs.length; z++) {
			maxZindex = Math.max(maxZindex, divs[z].style.zIndex);
		}
		return maxZindex;
	}
}