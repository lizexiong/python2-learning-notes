status = [
	{'id':1,'text':"在线"},
	{'id':2,'text':"下线"}
];

business = [
	{'id'=1,'text'="许嵩"},
	{'id'=2,'text'='周杰伦'},
	{'id'=3,'text'='陈奕迅'}
]


function CheckAll(mode,tb){
	//1.选中checkbox，如果已经进入编辑模式，让选中行进入编辑模式。
	$(tb).children().each(function(){
			//$(this)代表循环过程中,每一个tr,每一行数据
			//这里要使用for循环把tr拿出来是因为有很多个tr
			var tr=$(this);
			var isChecked = $(this).find(':checkbox').prop('checked');
			if(isChecked == true){
			}else{
				$(this).find(':checkbox').prop('checked',true);
				//如果已经进入编辑模式，让选中行变为编辑状态
				var isEditMode = $(mode).hasClass('editing');
				if(isEditMode){
					RowIntoEditModeEx(tr)
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
					RowIntoEditModeEx(tr);
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
				}else{
					tr.children().each(function(){
						var td=$(this);
						if(td.attr('edit') == 'True'){
							//这里如果children()什么都没有获取到，那么便不会执行，而不是把值设置为空
							//这里也算程序的一个小bug吧。
							ii = td.find('input').length;
							console.log(ii)
							if(ii>0){
								var inp = td.children().val();
								td.text(inp);
							}
						}
					})
				}
			})
	}else{
			$(ths).addClass('editing');
			$(ths).text('退出编辑模式')
			$(tb).children().each(function(){
				var tr = $(this);
				var isChecked = tr.find(":checkbox").prop('checked');
				if(isChecked == true){
					RowIntoEditModeEx(tr);
				}
			})
	}
}

function RowIntoEditMode(tr){
			tr.children().each(function(){
				var td=$(this);
				if(td.attr('edit') == 'True'){
						var text = td.text();
						var temp =  "<input type='text' value='" +text+ "'/>";
						td.html(temp);
				}
			})
}

function RowIntoEditModeEx(tr){
	tr.children().each(function(){
	var td=$(this);
	if(td.attr('edit') == 'True'){
			// ii = td.children().length;
			ii = td.find('input').length;
			if(ii>0){
				var inp = td.children(':first'); 
				var input_value=inp.val();
				td.text(input_value);
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
						td.text(input_value);
					}
				})
}


