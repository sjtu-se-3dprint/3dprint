var instruction = 'getModelTypeList';
var modelTypeList;
var current_page_amount = 9;
var current_active_page;
var current_model_type;
var current_sort_type;
var current_key_word = '';
var current_total_model_count = 0;

/*初始化函数*/
$(function() {
	/*事件监听*/
	$('#key_word_search_btn').click(get_current_key_word);
	
	getModelTypeListAjax();
	getModelList();
});

function getModelList() {
	get_current_active_page();
	get_current_model_type();
	get_current_sort_type();
	get_current_key_word();
	getModelListAjax();
}

/*通过ajax请求获取模型的类型列表*/
function getModelTypeListAjax() {
	$.ajax({
		url : ContextPath+'/common/modelTypeList.ajax',
		type : 'post',
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify({
			instr : instruction
		}),
		
		success : function(resp) {
			if (resp && resp.success) {
				modelTypeList = resp.value;
				//这里应该与更新列表的操作
				updateModelTypeList(modelTypeList);
			}
			else if (resp) {
				alert(resp.message);
			}
		},
		
		error : function(err) {
			alert('未知错误')
		}
	});
}

/*通过Ajax请求获取模型的列表并显示模型*/
function getModelListAjax() {
	$.ajax({
		url : ContextPath+'/common/modelList.ajax',
		type : 'post',
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify({
			active_page : current_active_page,
			page_amount : current_page_amount,
			model_type : current_model_type,
			sort_type : current_sort_type,
			key_word : current_key_word
		}),
		
		success : function(resp) {
			if (resp && resp.success) {
				console.log(resp.value);
			}
			else if (resp) {
				alert(resp.message);
			}
		},
		
		error : function(err) {
			alert('未知错误')
		}
	});
}

function getModelCountAjax() {
	$.ajax({
		url : ContextPath+'/common/modelCount.ajax',
		type : 'post',
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify({
			model_type : current_model_type,
			key_word : current_key_word
		}),
		
		success : function(resp) {
			if (resp && resp.success) {
				current_total_model_count = resp.value;
			}
			else if (resp) {
				alert(resp.meesgae);
			}
		},
		
		error : function(err) {
			alert('未知错误')
		}
	});
}


/*更新模型列表*/
function updateModelList()
{
	
}

/*更新模型类型列表*/
function updateModelTypeList(typeList) {
	var init_item = "<a href=\"#\" class=\"list-group-item active\" id=\"model_type_all\">全部</a>";
	$('#model_type_list').append(init_item);
	$('#model_type_all').click(function() {
		$(this).attr("class", "list-group-item active");
		$(this).siblings().attr("class", "list-group-item");
	});
	var i;
	for (i = 0; i<typeList.length; i++) {
		var item = "<a href=\"#\" class=\"list-group-item\" id=\"model_type_" + i + "\">";
		item = item + typeList[i].model_type_name;
		item = item + "</a>"
		$('#model_type_list').append(item);
		$('#model_type_'+i).click(function() {
			$(this).attr("class", "list-group-item active");
			$(this).siblings().attr("class", "list-group-item");
		});
	}
}

/*获取当前页*/
function get_current_active_page() {
	current_active_page = $('#model_paging').children().filter(".active").text();
}

/*设置当前页*/
function set_current_active_page(page) {
	
}

/*获取当前用户选择的模型类型*/
function get_current_model_type() {
	current_model_type = $('#model_type_list').children().filter(".active").text();
}

/*获取当前模型的排序类型*/
function get_current_sort_type() {
	current_sort_type = $('#sortType').find("option:selected").text();
}

/*获取当前的搜索关键字*/
function get_current_key_word() {
	current_key_word = $('#key_word_input').val();
}

/*当前模型类别事件响应函数*/
function on_model_type_clicked() {
	current_active_page = 1;
	current_key_word = '';
	
}