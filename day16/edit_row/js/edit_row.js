status1 = [
	{'id':1, 'text': "在线"},
	{'id':2, 'text': "下线"}
];

business = [
	{'id':1,'text': "许嵩"},
	{'id':2,'text': "周杰伦"},
	{'id':3,'text': "陈奕迅"} 
];


function CheckAll(mode,tb){
	//1.选中checkbox，如果已经进入编辑模式，让选中行进入编辑模式。
	$(tb).children().each(function(){
			//$(this)代表循环过程中,每一个tr,每一行数据
			//这里要使用for循环把tr拿出来是因为有很多个tr
			var tr=$(this);
			//  :checkbox  : 代表查找当前tr下的td
			var isChecked = $(this).find(':checkbox').prop('checked');
			if(isChecked == true){
			}else{
				$(this).find(':checkbox').prop('checked',true);
				//如果已经进入编辑模式，让选中行变为编辑状态
				var isEditMode = $(mode).hasClass('editing');
				if(isEditMode){
					RowIntoEditMode(tr)
				}
			}
	})
}


function CheckReverse(mode,tb){
	//是否进入编辑模式
	isEditMode = $(mode).hasClass('editing');
	if(isEditMode){
		//遍历所有tr
		$(tb).children().each(function(){
			var tr = $(this)
			var check_box = tr.children().first().find(':checkbox');
			if(check_box.prop('checked')){
				check_box.prop('checked',false);
				RowOutEditMode(tr);
			}else{
					check_box.prop('checked',true);
					RowIntoEditMode(tr);
			}
		})
	}else{
				$(tb).children().each(function(){
					var tr=$(this);
					var check_box =tr.children().first().find(":checkbox");
					if(check_box.prop('checked')){
						check_box.prop('checked',false);
					}else{
						check_box.prop('checked',true);
					}
				})
			}
}


function CheckCancel(mode,tb){
		//1.取消选中checkbox
		//2.如果已经进入编辑模式，让选中行退出编辑状态
	$(tb).children().each(function(){
		var tr = $(this)
		var isChecked = tr.find(":checkbox").prop('checked');
		if(isChecked == true){
			tr.find(":checkbox").prop('checked',false);
			var isEditing = $(mode).hasClass('editing');
			if(isEditing){
				//当前行，退出编辑模式
				RowOutEditMode(tr);
			}
		}
		
	})
}

function EditMode(ths,tb){
	var isEditing = $(ths).hasClass('editing');
	if(isEditing){
			$(ths).removeClass('editing');
			$(ths).text('进入编辑模式');
			$(tb).children().each(function(){
				var tr= $(this);
				var isChecked = tr.find(":checkbox").prop('checked');
				if(isChecked){
					RowOutEditMode(tr);
				}
			})
	}else{
			$(ths).addClass('editing');
			$(ths).text('退出编辑模式')
			$(tb).children().each(function(){
				var tr = $(this);
				var isChecked = tr.find(":checkbox").prop('checked');
				if(isChecked == true){
					RowIntoEditMode(tr);
				}
			})
	}
}


function RowIntoEditMode(tr){
	tr.children().each(function(){
	var td=$(this);
	if(td.attr('edit') == 'True'){
		if(td.attr('edit-type') == "select"){
			var all_values = window[td.attr('global-key')];			//获取全局变量，简单来说就是找到这个文件中global-key的字典
			var select_val = td.attr('select_val');
			select_val = parseInt(select_val);
			var options = "";
			$.each(all_values, function(index, value){
				if(select_val == value.id){
					options += "<option selected='selected' >" + value.text + "</option>"
				}else{
						options += "<option>" + value.text + "</option>"
				}
			})
			var temp = "<select onchange='MultiChange(this);'>" + options + "</select>";
			td.html(temp);	
		}else{
			
				var text = td.text();
				var temp = "<input type='text' value='" +text+ "'/>";
				td.html(temp);
			}
		}
	})
}

function RowOutEditMode(tr){
		tr.children().each(function(){
					var td=$(this);
					if(td.attr('edit') == 'True'){
						var inp =td.children();
						var input_value = inp.val();
						console.log(inp)
						td.text(input_value);
					}
				})
}

$(function(){
	$('#tb').find(':checkbox').click(function(){
		var tr=$(this).parent().parent();
		if($('#edit_mode').hasClass('editing')){
			if($(this).prop('checked')){
				RowIntoEditMode(tr);
			}else{
				RowOutEditMode(tr);
				//console.log($(this).prop('checked'))
			}
		}
	})
})


//监听ctrl键的代码为什么在函数外面？因为按下这个事件的时候，我必须要知道用户是否按下ctrl键。
globalCtrlKeyPress = false;
window.onkeydown = function(event){
//console.log(event.keyCode);
	if(event && event.keyCode == 17){
		window.globalCtrlKeyPress = true;
	}else{
		window.globalCtrlKeyPress = false;
	}
}
//这里还有一个小bug，就是按照ctrl之后·，必须再按别的键值才能设置回来。


function MultiChange(ths){
	console.log(window.globalCtrlKeyPress)
	
	if(window.globalCtrlKeyPress == true){
		//找到td所在tr中的索引位置
		var index = $(ths).parent().index(); //这里索引值应该为4
		var value = $(ths).val();
		//循环所有被选中状态的checkbox,因为只有选择状态的才需要修改
		$(ths).parent().parent().nextAll().find("td input[type='checkbox']:checked").each(function(){
			$(this).parent().parent().children().eq(index).children().val(value);
			console.log($(this).parent().parent().children())
			//这里为什么是父亲的父亲的儿子？因为如果之间父亲，那么就只找到一个tr，并不是所有tr.
		});	
	}
}
