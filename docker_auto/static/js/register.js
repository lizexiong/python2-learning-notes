/**
 * Created by Administrator on 2018/1/8.
 */



function mail_verifcation(mail){
    /*执行函数就删除成功标记*/
    $('#inputEmail3').removeClass('isTrue')
    var mail
    var filter  = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
    if(!mail){
        showMess('mail_hint',"请输入@juntech.net邮箱。",'fail');return false
    }
    if(filter.test(mail)) {
        mail_to_after_check()
        return true;
    }
    else{
        showMess('mail_hint',"电子邮箱格式不正确",'fail');
        return false;
    }
}

function mail_to_after_check(){
    var mail = $('#inputEmail3').val();
    $.ajax({
        type:"post",
        url:"/mailverifcation",
        datatype:'json',
        data:{data:mail},
        success:function(callback) {
            if(callback == 'exist'){
                showMess('mail_hint','邮箱帐号已注册','fail')
                return false
            }else{
                showMess('mail_hint','邮箱可使用','succ')
                $('#inputEmail3').addClass('isTrue')
            }
        }
    })
}

function res_passwd1_check(passwd1){
    $('#inputPassword3').removeClass('isTrue')
    var pwdvalue=passwd1
    if (pwdvalue.indexOf(" ") != -1) {
        showMess('passwd1_hint',"不支持空格，请输入6-20个字符，包含数字、大小写字母和符号（空格除外）",'fail');
    }
    if(/.*[\u4e00-\u9fa5]+.*$/.test(pwdvalue)) {
        showMess('passwd1_hint',"不支持汉字，请输入6-20个字符，包含数字、大小写字母和符号（空格除外）",'fail');
    }
    if(pwdvalue==""){
        showMess('passwd1_hint',"请输入密码",'fail');return false
    }else if(pwdvalue.length<6){
        showMess('passwd1_hint',"密码长度不能小于6个字符。",'fail');return false
    }else if(pwdvalue.length>20){
        showMess('passwd1_hint',"密码长度不能大于20个字符。",'fail');return false
    }else{
        showMess('passwd1_hint','验证通过','succ');
        $('#inputPassword3').addClass('isTrue')
        return true
    }
}

function res_passwd2_check(passwd){
    $('#inputPassword4').removeClass('isTrue')
    var passwd1 = $('#inputPassword3').val();
    var passwd2 = passwd
    if(passwd2==""){
        showMess('passwd2_hint','请输入密码','fail');return false
    }else{
         if(passwd1 == passwd2){
             $('#inputPassword4').addClass('isTrue')
            showMess('passwd2_hint','密码一致','succ');return true
        }else{
            showMess('passwd2_hint','密码不一致','fail');return false
        }
    }
}

function submit_reg(){
    var email = $('#inputEmail3').hasClass('isTrue')
    var passwd1 = $('#inputPassword3').hasClass('isTrue')
    var passwd2 = $('#inputPassword4').hasClass('isTrue')
    if(email == true && passwd1 == true && passwd2 == true){
        var user_info = {}
        var email_res = $('#inputEmail3').val()
        var passwd_res = $('#inputPassword3').val()
        user_info['email'] = email_res
        user_info['passwd'] = passwd_res
        var user_info_json = JSON.stringify(user_info)
        $.ajax({
            type:'post',
            url:'/register',
            datatype:'json',
            async:'false',
            data:{data:user_info_json},
            success:function(callback){
                if(callback=="successfully added"){
                    window.location.href="/login"
                }else{
                    console.log(callback)
                    $('#inputEmail3').val('')
                    $('#inputPassword3').val('')
                    $('#inputPassword4').val('')
                    showMess('hint','账户已注册或注册失败','fail')
                    return false
                }
            }
        })
    }else{
        showMess('hint','请完成上述验证后在提交','fail')
        return false
    }
}

function showMess(name,mess,result){
    if(result == "succ"){
        message = "<li style='font-size:15px;color:green; list-style:disc;'>" + mess + "</li>"
    }else if(result == "fail"){
       message = "<li style='font-size:15px;color:red; list-style:disc;'>" + mess + "</li>"
    }
    $("."+name).html(message);
}