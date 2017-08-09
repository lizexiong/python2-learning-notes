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
					tr.children().each(function(){
						var td=$(this);
						if(td.attr('edit') == 'True'){
							var text = td.text();
							var temp = "<input type='text' value='" +text+ "'/>";
							td.html(temp);
						}
					})
				}
			}
	})
}

function EditMode(ths,tb){
	var isEditing = $(ths).hasClass('editing');
	if(isEditing){
			$(ths).removeClass('editing');
	}else{
			$(ths).addClass('editing');
	}
}