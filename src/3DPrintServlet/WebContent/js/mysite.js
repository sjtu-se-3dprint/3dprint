/**
 * Created by shuying on 2014/12/1.
 */
 
 //添加事件函数
function addListener(obj,fn,ev){
	if(obj.addEventListener){
		obj.addEventListener(ev,fn,false);
		}
	else if(obj.attachEvent){
		obj.attachEvent('on'+ev,fn);
		}
	else{
		obj['on'+ev]=fn;
		}
	}


//排序事件
var start=0;
function sortchages(){
	var bnt=document.getElementById('mybutton');
	var btntime=document.getElementById('btntime');
	addListener(bnt,function(){
		btntime.innerHTML='上传时间';
		if(start===0){
			this.innerHTML='规模↑';
			start=1;
			}
		else if(start===1){
			this.innerHTML='规模↓';
			start=0;
			}
		},'click');
	addListener(btntime,function(){
		var change='上传时间↑';
		bnt.innerHTML='规模';
		if(this.innerHTML!=change){
			this.innerHTML=change;
		}
		else{
			 this.innerHTML='上传时间';
			}
		},'click');
	}
	addListener(window,sortchages,'load');

//排序事件--时尚
var starts=0;
function sortchageshi(){
	var bnt=document.getElementById('mybuttons');
	var btntime=document.getElementById('btntimes');
	addListener(bnt,function(){
		btntime.innerHTML='上传时间';
		if(starts===0){
			this.innerHTML='规模↑';
			starts=1;
		}
		else if(starts===1){
			this.innerHTML='规模↓';
			starts=0;
		}
	},'click');
	addListener(btntime,function(){
		var change='上传时间↑';
		bnt.innerHTML='规模';
		if(this.innerHTML!=change){
			this.innerHTML=change;
		}
		else{
			this.innerHTML='上传时间';
		}
	},'click');
}
addListener(window,sortchageshi,'load');

//排序事件--家居
var startj=0;
function sortchagejia(){
	var bnt=document.getElementById('mybuttonj');
	var btntime=document.getElementById('btntimej');
	addListener(bnt,function(){
		btntime.innerHTML='上传时间';
		if(startj===0){
			this.innerHTML='规模↑';
			startj=1;
		}
		else if(startj===1){
			this.innerHTML='规模↓';
			startj=0;
		}
	},'click');
	addListener(btntime,function(){
		var change='上传时间↑';
		bnt.innerHTML='规模';
		if(this.innerHTML!=change){
			this.innerHTML=change;
		}
		else{
			this.innerHTML='上传时间';
		}
	},'click');
}
addListener(window,sortchagejia,'load');

//排序事件--零件
var startl=0;
function sortchageling(){
	var bnt=document.getElementById('mybuttonl');
	var btntime=document.getElementById('btntimel');
	addListener(bnt,function(){
		btntime.innerHTML='上传时间';
		if(startl===0){
			this.innerHTML='规模↑';
			startl=1;
		}
		else if(startl===1){
			this.innerHTML='规模↓';
			startl=0;
		}
	},'click');
	addListener(btntime,function(){
		var change='上传时间↑';
		bnt.innerHTML='规模';
		if(this.innerHTML!=change){
			this.innerHTML=change;
		}
		else{
			this.innerHTML='上传时间';
		}
	},'click');
}
addListener(window,sortchageling,'load');