/**
 * Created by Administrator on 2018/1/14.
 */

//EasyUI使用onkeyup方式,暂时只找到这种解决方式
//$(function(){
//    $("input",$("#mail").next("span")).keyup(function(){
//        mail_check()
//    });
//    $("input",$("#mail").next("span")).blur(function(){
//        mail_check()
//    });
//})



function mail_check(mail){
    //首先删除认证通过的标记
    $('#mail').removeClass('isTrue')
    var mail = mail
    console.log("mail",mail)
    var filter  = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
    if(!mail){
        result="fail"
        mess="请输入邮箱"
        showMess('mail_hint',mess,result)
    }
    if(filter.test(mail)){
        mail_verification(mail)
    }else{
        result="fail"
        mess="邮箱输入不合法"
        showMess('mail_hint',mess,result)
    }
}

function mail_verification(mail){
    console.log(mail,'---')
    $.ajax({
        type:'post',
        url:'/mailverifcation',
        data_type:'json',
        data:{data:mail},
        success:function(callback){
            if(callback== 'exist'){
                 mess= '邮箱验证通过'
                $('#mail').addClass('isTrue')
                showMess('mail_hint',mess,'succ')
            }else{
                mess='用户不存在'
                showMess('mail_hint',mess,'fail')
            }
        }
    })
}

function passwd1_check(passwd1){
    $('#userpwd').removeClass('isTrue')
    var pwdvalue=passwd1
    if (pwdvalue.indexOf(" ") != -1) {
        showMess('passwd1_hint',"不支持空格，请输入6-20个字符，包含数字、大小写字母和符号（空格除外",'fail');
    }
    if(/.*[\u4e00-\u9fa5]+.*$/.test(pwdvalue)) {
        showMess('passwd1_hint',"不支持汉字，请输入6-20个字符，包含数字、大小写字母和符号（空格除外）",'fail');
    }
    if(pwdvalue==""){
        showMess('passwd1_hint',"请输入密码。",'fail');
    }else if(pwdvalue.length<6){
        showMess('passwd1_hint',"密码长度不能小于6个字符。",'fail');
    }else if(pwdvalue.length>20){
        showMess('passwd1_hint',"密码长度不能大于20个字符。",'fail');
    }else{
        showMess('passwd1_hint',"密码通过",'succ');
        $('#userpwd').addClass('isTrue')
    }
}

function passwd2_check(passwd){
    $('#userpwd2').removeClass('isTrue')
    var passwd1 = $("#userpwd").val()
    var passwd2 = passwd
    if(passwd2==""){
        showMess('passwd2_hint',"请输入密码。",'fail');
    }else{
        if(passwd1 == passwd2){
            showMess('passwd2_hint','密码一致','succ')
            $('#userpwd2').addClass('isTrue')
        }else{
            showMess('passwd2_hint','密码不一致','fail')
            $('#userpwd2').removeClass('isTrue')
        }
    }
}

function submit_form_info(){
    var mail =  $('#mail').hasClass('isTrue')
    var passwd1 =  $('#userpwd').hasClass('isTrue')
    var passwd2 =  $('#userpwd2').hasClass('isTrue')
    if(mail == true && passwd1 == true && passwd2 == true){
        submit_ajax()
    }else{
        showMess('hint','请通过以上验证','fail')
    }
}

function submit_ajax(){
    $.ajax({
        cache: true,
        type: "POST",
        url:'/userreset',
        data:$('#user_info').serialize(),// 你的formid
        error: function(request) {
            alert("Connection error");
        },
        success: function(data) {
            if(data== 'successfully reset'){
                alert('重置成功')
                parent.rightFrame.location.reload()
            }else{
                alert('重置失败')
            }
        }
    });
}

function form_clear(){
    $('#user_info')[0].reset();
}

function showMess(name,mess,result){
    console.log("result",result)
    if(result == "succ"){
        message = "<li style='font-size:15px;color:green; list-style:disc;'>" + mess + "</li>"
    }else if(result == "fail"){
       message = "<li style='font-size:15px;color:red; list-style:disc;'>" + mess + "</li>"
    }
    $("#"+name).html(message);
}