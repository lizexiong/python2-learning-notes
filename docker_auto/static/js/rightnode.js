/**
 * Created by Administrator on 2018/1/6.
 */

function CheckAll(mode,tb){
    $(tb).children().each(function(){
            var tr = $(this)
            //  :checkbox  : 代表查找当前tr下的td
            var isChecked = $(tr).find(":checkbox").prop('checked');
            if(isChecked){
            }else{
                $(tr).find(":checkbox").prop('checked',true);
            }
    })
}

function CheckReverse(mode,tb){
    $(tb).children().each(function(){
        var tr = $(this)
        var isChecked = $(tr).find(":checkbox").prop('checked');
        if(isChecked){
            $(tr).find(":checkbox").prop('checked',false)
        }else{
            $(tr).find(":checkbox").prop('checked',true)
        }
    })
}

function ConStart(tb){
    layer.msg('多个容器启动中,请耐心等待页面自动刷新...')
    var host_dict = HostDict()
    //这里的host_dict是个对象，如果要给后台,必须转换成json发送到后台
    //JSON.stringify 把一个对象转换成json字符串，
    //JSON.parse 把一个json字符串解析成对象。
    var host_dict_json=JSON.stringify(host_dict);
    $.ajax({
        type:"get",
        url:"/multicontaineroperation?action=start",
        datatype:"json",
        data:{data:host_dict_json},
        success:function(callback){
            res(callback)
        }
    })
}

function ConStop(tb){
    layer.msg('多个容器停止中,请耐心等待页面自动刷新...')
    var host_dict = HostDict()
    var host_dict_json=JSON.stringify(host_dict);
    $.ajax({
        type:"get",
        url:"/multicontaineroperation?action=stop",
        datatype:"json",
        data:{data:host_dict_json},
        success:function(callback){
            res(callback)
        }
    })
}

function ConRem(tb){
    layer.msg('多个容器删除中,请耐心等待页面自动刷新...')
    var host_dict = HostDict()
    //这里的host_dict是个对象，如果要给后台,必须转换成json发送到后台
    //JSON.stringify 把一个对象转换成json字符串，
    //JSON.parse 把一个json字符串解析成对象。
    var host_dict_json=JSON.stringify(host_dict);
    $.ajax({
        type:"get",
        url:"/multicontaineroperation?action=rem",
        datatype:"json",
        data:{data:host_dict_json},
        success:function(callback){
            res(callback)
        }
    })
}




function HostDict(){

    var node_ip = $(".node_ip").text();
    var temp_host_list = new Array();
    var host_dict = {}

    $("#tb").children().each(function(){
        var isChecked = $(this).find(":checkbox").prop('checked');
        if(isChecked){
            //console.log($(this).children().eq(2).text())   //两种获取方式,那种都可以
            var host_ip = $(this).children(".con_id").text()
            temp_host_list.push(host_ip)
        }else{
        }
    })
    host_dict[node_ip] = temp_host_list
    //console.log(host_dict,'host_dict')
    //这里的host_dict虽然是字典格式,但是是一个jquery对象,要传送到后台需要转换成json字符画窜
    return host_dict
}


function EditMode(ths,tb){
    var isChecked = $(ths).hasClass('editing');
    if(isChecked){
        $(".MultiSelect").children("input").remove()
        $(ths).removeClass('editing');
        $('#th').children().children().first().remove()
        $('#tb').children().each(function(){
            tr = $(this)
            $(tr).children().first().remove()
        })
        $(ths).text('Go to multimode');
    }else{
        $(ths).addClass('editing');
        $(ths).text('Exit multi-mode');
        //在一下beforce,html等里面最好不要放置空格以及多于的引号
        $(ths).before("<input  type='button' onclick=CheckAll('#edit_mode','#tb') value='全选' />")
        $(ths).before("<input  type='button' onclick=CheckReverse('#edit_mode','#tb') value='反选'/>")
        $(ths).before("<input  type='button' onclick=ConStart('#tb') value='启动'/>")
        $(ths).before("<input  type='button' onclick=ConStop('#tb') value='停止'/>")
        $(ths).before("<input  type='button' onclick=ConRem('#tb') value='删除'/>")
        $('#th').children().children().first().before("<th class='sorting_asc' tabindex='0' aria-controls='conlist' rowspan='1' colspan='1' aria-sort='ascending' aria-label='选择: activate to sort column descending' style='width: 44px;'>选择</th>")
        $('#tb').children().each(function(){
            tr = $(this)
            $(tr).children().first().before("<td><input type='checkbox'></td>")
        })
    }
}

function res(callback){
    if(callback=='start_succed' || callback =='stop_succed' || callback=='rem_succed'){
                alert('启动/停止/删除操作成功')
            parent.rightFrame.location.reload();
        //下面这种方式在浏览器界面可以使用,这里无法使用
        //document.getElementById('rightFrame').contentWindow.location.reload(true);
            }else if(callback=='not_id'){
                alert('请选择容器后在操作')
                parent.rightFrame.location.reload();
            }else{
                alert('个别容器操作过程中出现错误,请手动检查')
                parent.rightFrame.location.reload();
            }
    //只刷新frame这部分的页面
}