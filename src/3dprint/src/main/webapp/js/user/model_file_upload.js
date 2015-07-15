
var globalFile = null;
var globalFileSeq = null;
$(function() {
	
	listenSelect();
	$('#selectFileHint').text('请选择后缀名为.stl，大小<100MB的模型文件');
	
	// 定义上传文件监听与回调
	$('#uploadInput').fileupload({
		add : selectFile,
		progress : function(e, data){
			uploading(e, data)
		},
		fail : function(e, data){
			fail(e, data);
		},
		success : function(data){
			success(data);
		}
	});
});

function listenSelect(){
	$('#selectFileBtn').text('选择模型文件');
	$('#selectFileBtn').removeClass('btn-danger');
	$('#selectFileBtn').addClass('btn-primary');
	$('#selectFileBtn').attr('disabled', false);
	$('#selectFileBtn').off('click').on('click', function(){
		$('#uploadInput').click();
	});
}

function cancelListenSelect(){
	$('#selectFileBtn').text('等待加载完毕');
	$('#selectFileBtn').attr('disabled', 'disabled');
	$('#selectFileBtn').off('click');
}

// 选择了一个模型文件
function selectFile(e, data){
	
	if(!data || !data.files || !data.files[0]){
		alert('选择文件失败，请重新选择');
		return;
	}
	globalFile = data.files[0];
	globalFileSeq = null;
	
	if(!checkModelFile(globalFile)){
		return;
	}

	cancelListenSelect();
	$('#selectFileHint').text(globalFile.name + '，加载中：0%');
	data.submit();
}

// 在上传过程中的回调
function uploading(e, data, seq){
	var per = parseInt(data.loaded / data.total * 100);
	$('#selectFileHint').text(globalFile.name + '，加载中：' + per + '%')
}

// 上传失败回调
function fail(e, data, seq){
	alert('服务器出错');
	listenSelect();
}

// 上传成功回调
function success(data, seq){
	if(data && data.success){
		$('#selectFileHint').text(globalFile.name + '，加载完毕')
		globalFileSeq = data.value;
	}else if(data){
		alert(data.message);
	}else{
		alert('服务器出错');
	}
	listenSelect();
}

// 检查文件是否符合格式
function checkModelFile(file){

	var name = file.name;
	var size = file.size;
	
	if(name.length < 4 || name.indexOf('.stl') != name.length-4){
		alert('只能上传后缀为.stl的模型文件。');
		return false;
	}
	
	var limit = 100;
	if(size > 1024*1024*limit){
		alert('只能上传小于' + limit + 'MB的模型文件。');
		return false;
	}
	
	return true;
}