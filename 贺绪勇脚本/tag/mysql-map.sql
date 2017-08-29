
==================================== BEGIN ntf/MailMsg.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:17:07 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="MailMsg">
 <resultMap id="mailMsg" type="com.djb.domain.ntf.MailMsg" extends="DomainObject.domainObject">
  <result property="questionPageLink" column="question_page_link"/>
  <result property="questionContent" column="question_content"/>
  <result property="answerContent" column="answer_content"/>
  <result property="subjectContent" column="subject_content"/>
  <result property="sendStatus" column="send_status"/>
  <result property="mailType" column="mail_type"/>
  <result property="to" column="mail_to"/>
  <result property="remark" column="remark"/>
  <result property="planSendTime" column="plan_send_time"/>
  <result property="actualSendTime" column="actual_send_time"/>
  <result property="arrivalTime" column="arrival_time"/>
 </resultMap>

 <select id="load" resultMap="mailMsg">
  SELECT *
  FROM
    SM_QA_MAIL
  WHERE
    id=#{id} 
  AND delete_flag='0'
 </select>
 
 <insert id="insert" parameterType="com.djb.domain.ntf.MailMsg">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO 
   SM_QA_MAIL(
    id,
    question_page_link,
    question_content,
    answer_content, 
    subject_content, 
    senidatus, 
    mail_type, 
    mail_to, 
    remark, 
    plan_send_time, 
    actual_send_time, 
    arrival_time,
    create_user_id, 
    create_time, 
    update_user_id, 
    update_time,
    delete_flag
   )
  VALUES(
   #{id},
   #{questionPageLink},
   #{questionContent},
   #{answerContent},
   #{subjectContent},
   #{sendStatus},
   #{mailType},
   #{to},
   #{remark},
   #{planSendTime},
   #{actualSendTime},
   #{arrivalTime},
   #{createUserId},
   #{createDateTime},
   #{updateUserId},
   #{updateDateTime},
   #{deleteFlag}
  )
  </insert>
  
</mapper>
==================================== END ntf/MailMsg.xml =========================


==================================== BEGIN ntf/MailBean.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:17:06 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="MailBean">

 <resultMap id="mailBean" type="com.djb.domain.mail.MailBean">
    <result property="id" column="id"/> 
  <result property="from" column="From"/>
  <result property="fromName" column="From_Name"/>
  <result property="recipientTo" column="Recipient_To"/>
  <result property="recipientCc" column="Recipient_Cc"/>
  <result property="mailType" column="Mail_Type"/>
  <result property="subject" column="Subject"/>
  <result property="templateFile" column="Template_File"/>
  <result property="replaceContent" column="Replace_Content"/>
  <result property="sendStatus" column="Send_Status"/>
  <result property="remark" column="Remark"/>
  <result property="planSendTime" column="Plan_Send_Time"/>
  <result property="actualSendTime" column="Actual_Send_Time"/>
  <result property="mailGuid" column="Mail_Guid"/>
  <result property="deleteFlag" column="delete_flag"/>
  <result property="createUserId" column="create_user_id"/>
    <result property="createDateTime" column="create_time"/>
    <result property="updateUserId" column="update_user_id"/>
    <result property="updateDateTime" column="update_time"/>
 </resultMap>
 
 <select id="load" resultMap="mailBean">
  SELECT * 
    FROM Sm_Mail
   WHERE id=#{id}
     AND Delete_Flag=0
 </select>
 
 <select id="getUnSendMail" resultMap="mailBean">
      SELECT * 
       FROM Sm_Mail
        WHERE Send_Status = #{sendStatus}
  AND  (Plan_Send_Time IS NULL OR Plan_Send_Time &lt;= now()) 
       AND delete_flag = '0'
    ORDER BY  Plan_Send_Time
    LIMIT 20
  </select>
 
 <update id="update" parameterType="com.djb.domain.mail.MailBean">
  UPDATE Sm_Mail
    SET
       `FROM`=#{from}
      ,From_Name=#{fromName}
      ,Recipient_To=#{recipientTo}
      ,Recipient_Cc=#{recipientCc}
      ,Mail_Type=#{mailType}
      ,Subject=#{subject}
      ,Template_File=#{templateFile}
      ,Replace_Content=#{replaceContent}
      ,Send_Status=#{sendStatus}
      ,Plan_Send_Time=#{planSendTime}
      ,Actual_Send_Time=#{actualSendTime}
      ,Remark = #{remark}
      ,update_time = #{updateDateTime}
      ,update_user_id = #{updateUserId}
      ,delete_flag = #{deleteFlag}
   WHERE id = #{id}
 </update>
 
 <select id="getMailByGUId" resultMap="mailBean">
    SELECT *
      FROM Sm_Mail
     WHERE Mail_Guid = #{guid}
   </select>
 
 <insert id="insert" parameterType="com.djb.domain.mail.MailBean">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO 
   Sm_Mail(
    `FROM`
     ,From_Name
     ,Recipient_To
     ,Recipient_Cc
     ,Mail_Type
     ,Subject
     ,Template_File
     ,Replace_Content
     ,Send_Status
     ,Plan_Send_Time
     ,Actual_Send_Time
    ,Remark
    ,Mail_Guid
    ,create_time
    ,create_user_id
    ,update_time
    ,update_user_id
    ,delete_flag
   )
  VALUES(
    #{from}
    ,#{fromName}
    ,#{recipientTo}
    ,#{recipientCc}
    ,#{mailType}
    ,#{subject}
    ,#{templateFile}
    ,#{replaceContent}
    ,#{sendStatus}
    ,#{planSendTime}
    ,#{actualSendTime}
    ,#{remark}
    ,#{mailGuid}
    ,#{createDateTime}
    ,#{createUserId}
    ,#{updateDateTime}
    ,#{updateUserId}
    ,#{deleteFlag}
  )
 </insert>
 
 <delete id="deleteByPrimaryKey">
  DELETE FROM 
   Sm_Mail
  WHERE
   id = #{id}
 </delete>
</mapper>
==================================== END ntf/MailBean.xml =========================


==================================== BEGIN ntf/MobileMsg.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:17:07 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="MobileMsg">
 <resultMap id="mobileMsg" type="com.djb.domain.ntf.MobileMsg">
  <result property="id" column="id"/>
  <result property="phoneNo" column="Mobilephone"/>
  <result property="msgContent" column="Sms_Content"/>
  <result property="type" column="Sms_Type"/>
  <result property="sendStatus" column="Sms_Status"/>
  <result property="planSendTime" column="Plan_Send_Time"/>
  <result property="submitTime" column="Arrival_Time"/>
  <result property="sendUserId" column="Send_User_Id"/>
  <result property="platform" column="Sms_Platform"/>
  <result property="remark" column="Remark"/>
 </resultMap>

 <select id="load" resultMap="mobileMsg">
  SELECT *
  FROM
    sm_sms
  WHERE
    id=#{id} 
 </select>
 
 <insert id="insert" parameterType="com.djb.domain.ntf.MobileMsg">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO 
   sm_sms(
    id,
    Mobilephone,
    Sms_Content,
    Sms_Type,
    Sms_Status,
    Plan_Send_Time,
    Arrival_Time,
    Send_User_Id,
    Sms_Platform,
    Remark,
    create_time,
    create_user_id,
    update_time,
    update_user_id,
    delete_flag
   )
  VALUES(
    #{id},
    #{phoneNo},
    #{msgContent},
    #{type},
    #{sendStatus},
    #{planSendTime},
    #{submitTime},
    #{sendUserId},
    #{platform},
    #{remark},
    #{createDateTime},
    #{createUserId},
    #{updateDateTime},
    #{updateUserId},
    #{deleteFlag}
  )
  </insert>
  
  <delete id="removeByFKey">
   DELETE FROM
    sm_sms
   WHERE
    id = #{id}
  </delete>
  
</mapper>
==================================== END ntf/MobileMsg.xml =========================


==================================== BEGIN citysite/CitysiteRecommendAgent.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="CitysiteRecommendAgent" >

 <resultMap id="citysiteRecommendAgent" type="com.djb.domain.citysite.CitysiteRecommendAgent" extends="DomainObject.domainObject" >
  <result property="agent.id" column="Agent_Id" />
  <result property="module" column="Module" />
  <result property="citysiteId" column="Citysite_Id" />
 </resultMap>

 <select id="load" resultMap="citysiteRecommendAgent" >
  SELECT  *
    FROM  Sm_Citysite_Recommend_Agent
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.citysite.CitysiteRecommendAgent" >
  UPDATE  Sm_Citysite_Recommend_Agent
     SET  
   Agent_Id=#{agent.id}
   ,Module=#{module}
   ,Citysite_Id=#{citysiteId}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   WHERE  id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.citysite.CitysiteRecommendAgent" >
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Sm_Citysite_Recommend_Agent(
   Agent_Id
   ,Module
   ,Citysite_Id
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{agent.id}
   ,#{module}
   ,#{citysiteId}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey" >
  DELETE FROM  Sm_Citysite_Recommend_Agent
        WHERE  id = #{id}
 </delete>
 
 <select id="findByCitysiteRecommendAgent" parameterType="com.djb.domain.citysite.CitysiteRecommendAgent" resultMap="citysiteRecommendAgent">
  SELECT  *
    FROM  Sm_Citysite_Recommend_Agent
   WHERE delete_flag='0'
  <if test="citysiteId!=null">
   AND Citysite_Id=#{citysiteId}
  </if>
  <if test="module!=null">
   AND Module=#{module}
  </if>
 </select>
</mapper>
==================================== END citysite/CitysiteRecommendAgent.xml =========================


==================================== BEGIN citysite/CitysiteCity.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="CitysiteCity" >

 <resultMap id="citysiteCity" type="com.djb.domain.citysite.CitysiteCity" extends="DomainObject.domainObject" >
  <result property="city.id" column="City_Id" />
  <result property="area" column="Area" />
  <result property="showFlagStatus" column="Show_Flag_Status" />
  <result property="needAgentCount" column="Need_Agent_Count" />
 </resultMap>

 <select id="load" resultMap="citysiteCity" >
  SELECT  *
    FROM  Sm_Citysite_City
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.citysite.CitysiteCity" >
  UPDATE  Sm_Citysite_City
     SET  
   City_Id=#{city.id}
   ,Area=#{area}
   ,Show_Flag_Status=#{showFlagStatus}
   ,Need_Agent_Count=#{needAgentCount}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   WHERE  id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.citysite.CitysiteCity" >
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Sm_Citysite_City(
   City_Id
   ,Area
   ,Show_Flag_Status
   ,Need_Agent_Count
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{city.id}
   ,#{area}
   ,#{showFlagStatus}
   ,#{needAgentCount}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey" >
  DELETE FROM  Sm_Citysite_City
        WHERE  id = #{id}
 </delete>
 
 <select id="findAll" resultMap="citysiteCity" >
  SELECT  *
    FROM  Sm_Citysite_City
   WHERE   delete_flag='0'
 </select>
 
 <select id="findByCitysiteCity" parameterType="com.djb.domain.citysite.CitysiteCity" resultMap="citysiteCity">
  SELECT  *
    FROM  Sm_Citysite_City
   WHERE delete_flag='0'
  <if test="city!=null">
   and City_Id=#{city.id}
  </if>
  
  <if test="area!=null">
   and Area=#{area}
  </if>
  
  <if test="showFlagStatus!=null">
   and Show_Flag_Status=#{showFlagStatus}
  </if>
 </select>
 
 <select id="findCitysiteByQueryBean" parameterType="com.djb.domain.citysite.CitysiteCityQueryBean" resultMap="citysiteCity">
  SELECT  *
    FROM  Sm_Citysite_City
   WHERE delete_flag='0' 
  <if  test="showStatusStr == 'batch'">
   and Show_Flag_Status in (1,2)
  </if>
  <if test="area!=null">
   and Area=#{area}
  </if>
 </select>
 
 <update id="changeCitysiteShowFlagStatus">
  UPDATE  Sm_Citysite_City
     SET  
   Show_Flag_Status=2
   WHERE  Show_Flag_Status=1
   and delete_flag=0
 </update>
 
</mapper>
==================================== END citysite/CitysiteCity.xml =========================


==================================== BEGIN citysite/CitysiteCmsKeyword.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="CitysiteCmsKeyword" >

 <resultMap id="citysiteCmsKeyword" type="com.djb.domain.citysite.CitysiteCmsKeyword" extends="DomainObject.domainObject" >
  <result property="module" column="Module" />
  <result property="keyword" column="Keyword" />
 </resultMap>

 <select id="load" resultMap="citysiteCmsKeyword" >
  SELECT  *
    FROM  Sm_Citysite_Cms_Keyword
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.citysite.CitysiteCmsKeyword" >
  UPDATE  Sm_Citysite_Cms_Keyword
     SET  
   Module=#{module}
   ,Keyword=#{keyword}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   WHERE  id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.citysite.CitysiteCmsKeyword" >
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Sm_Citysite_Cms_Keyword(
   Module
   ,Keyword
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{module}
   ,#{keyword}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey" >
  DELETE FROM  Sm_Citysite_Cms_Keyword
        WHERE  id = #{id}
 </delete>
 
 <select id="findByModuleId" parameterType="long" resultMap="citysiteCmsKeyword">
  SELECT *
    FROM  Sm_Citysite_Cms_Keyword
   WHERE delete_flag='0'
   and Module=#{moduleId}
   ORDER BY Update_Time desc
   LIMIT 1
 </select>
 
 <select id="findAllKeyword" resultMap="citysiteCmsKeyword">
  SELECT  *
    FROM  Sm_Citysite_Cms_Keyword
   WHERE delete_flag='0'
    ORDER BY Update_Time desc
 </select>
</mapper>
==================================== END citysite/CitysiteCmsKeyword.xml =========================


==================================== BEGIN mail/MailBean.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:18:14 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="MailBean">
 <resultMap id="mailBean" type="com.djb.domain.mail.MailBean">
    <result property="id" column="id"/> 
  <result property="from" column="From"/>
  <result property="fromName" column="From_Name"/>
  <result property="recipientTo" column="Recipient_To"/>
  <result property="recipientCc" column="Recipient_Cc"/>
  <result property="mailType" column="Mail_Type"/>
  <result property="subject" column="Subject"/>
  <result property="templateFile" column="Template_File"/>
  <result property="replaceContent" column="Replace_Content"/>
  <result property="sendStatus" column="Send_Status"/>
  <result property="remark" column="Remark"/>
  <result property="planSendTime" column="Plan_Send_Time"/>
  <result property="actualSendTime" column="Actual_Send_Time"/>
  <result property="mailGuid" column="Mail_Guid"/>
  <result property="deleteFlag" column="delete_flag"/>
  <result property="createUserId" column="create_user_id"/>
    <result property="createDateTime" column="create_time"/>
    <result property="updateUserId" column="update_user_id"/>
    <result property="updateDateTime" column="update_time"/>
 </resultMap>
 
 <select id="getUnSendMail" resultMap="mailBean">
      SELECT * 
       FROM Sm_Mail
        WHERE Send_Status = #{sendStatus}
  AND  (Plan_Send_Time IS NULL OR Plan_Send_Time &lt;= now()) 
       AND delete_flag = '0'
    ORDER BY  Plan_Send_Time
    LIMIT 20
  </select>
  
   <select id="getMailByGUId" resultMap="mailBean">
    SELECT *
      FROM Sm_Mail
     WHERE Mail_Guid = #{guid}
   </select>
   
 <update id="update" parameterType="com.djb.domain.mail.MailBean">
  UPDATE Sm_Mail
    SET
       `FROM`=#{from}
      ,From_Name=#{fromName}
      ,Recipient_To=#{recipientTo}
      ,Recipient_Cc=#{recipientCc}
      ,Mail_Type=#{mailType}
      ,Subject=#{subject}
      ,Template_File=#{templateFile}
      ,Replace_Content=#{replaceContent}
      ,Send_Status=#{sendStatus}
      ,Plan_Send_Time=#{planSendTime}
      ,Actual_Send_Time=#{actualSendTime}
      ,Remark = #{remark}
      ,update_time = #{updateDateTime}
      ,update_user_id = #{updateUserId}
      ,delete_flag = #{deleteFlag}
   WHERE id = #{id}
 </update>
 
 <insert id="insert" parameterType="com.djb.domain.mail.MailBean">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO 
   Sm_Mail(
    id
    ,`FROM`
     ,From_Name
     ,Recipient_To
     ,Recipient_Cc
     ,Mail_Type
     ,Subject
     ,Template_File
     ,Replace_Content
     ,Send_Status
     ,Plan_Send_Time
     ,Actual_Send_Time
    ,Remark
    ,Mail_Guid
    ,create_time
    ,create_user_id
    ,update_time
    ,update_user_id
    ,delete_flag
   )
  VALUES(
   #{id}
   ,#{from}
   ,#{fromName}
   ,#{recipientTo}
   ,#{recipientCc}
   ,#{mailType}
   ,#{subject}
   ,#{templateFile}
   ,#{replaceContent}
   ,#{sendStatus}
   ,#{planSendTime}
   ,#{actualSendTime}
   ,#{remark}
   ,#{mailGuid}
   ,#{createDateTime}
   ,#{createUserId}
   ,#{updateDateTime}
   ,#{updateUserId}
   ,#{deleteFlag}
  )
 </insert>
 
 <delete id="deleteByPrimaryKey">
  DELETE FROM 
   Sm_Mail
  WHERE
   id = #{id}
 </delete>
 
</mapper>
==================================== END mail/MailBean.xml =========================


==================================== BEGIN sms/SmsAgentSendTo.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 15:34:33 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="SmsAgentSendTo">
  <resultMap id="smsAgentSendTo" type="com.djb.domain.sms.SmsAgentSendTo">
 <result property="id" column="id"/> 
 <result property="agentSend.id" column="Sms_Send_Id"/>
 <result property="contacts" column="Contacts"/>
 <result property="remark" column="Remark"/>
 <result property="deleteFlag" column="delete_flag"/>
 <result property="createUserId" column="create_user_id"/>
   <result property="createDateTime" column="create_time"/>
   <result property="updateUserId" column="update_user_id"/>
   <result property="updateDateTime" column="update_time"/>
  </resultMap>
  
  <update id="update" parameterType="com.djb.domain.sms.SmsAgentSendTo">
  UPDATE 
    Sm_Sms_Agent_Send_To
        SET 
    Sms_Send_Id=#{agentSend.id}
    ,Contacts=#{contacts}
    ,Remark=#{remark}
    ,Delete_Flag=#{deleteFlag}
    ,Create_User_Id=#{createUserId}
    ,Create_Time=#{createDateTime}
    ,Update_User_Id=#{updateUserId}
    ,Update_Time=#{updateDateTime}
      WHERE
    id = #{id}
 </update>

  <insert id="insert" parameterType="com.djb.domain.sms.SmsAgentSendTo">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
    INSERT INTO Sm_Sms_Agent_Send_To (
   Sms_Send_Id
   ,Contacts
   ,Remark
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
    ) VALUES (
      #{agentSend.id}
      ,#{contacts}
      ,#{remark}
      ,#{deleteFlag}
      ,#{createUserId}
      ,#{createDateTime}
      ,#{updateUserId}
      ,#{updateDateTime}
    )
  </insert>
</mapper>
==================================== END sms/SmsAgentSendTo.xml =========================


==================================== BEGIN sms/SmSmsRecv.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 15:34:33 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="SmSmsRecv">

  <!--
  Sorry, I can`t migrate SmSmsRecv
  See console output for further details 
 -->

  <sql id="SmSmsRecv.select">
    SELECT
      UUID uuid,
      MOBILE_PHONE mobilePhone,
      SMS_CONTENT smsContent,
      SMS_STATUS smsStatus,
      EMPP_MSG_ID emppMsgId,
      SMS_PLATFORM smsPlatform,
      REMARK remark,
      create_user_id createUserId,
      create_datetime createDatetime,
      update_user_id updateUserId,
      update_datetime updateDatetime,
      delete_flag deleteFlag
    FROM SM_SMS_RECV
    WHERE 1 = 1 
  </sql>

  <sql id="SmSmsRecv.where">
    <if test="uuid != null">AND
        UUID = #{uuid}
    </if>
    <if test="mobilePhone != null">AND
        MOBILE_PHONE = #{mobilePhone}
    </if>
    <if test="smsContent != null">AND
        SMS_CONTENT = #{smsContent}
    </if>
    <if test="smsStatus != null">AND
        SMS_STATUS = #{smsStatus}
    </if>
    <if test="emppMsgId != null">AND
        EMPP_MSG_ID = #{emppMsgId}
    </if>
    <if test="smsPlatform != null">AND
        SMS_PLATFORM = #{smsPlatform}
    </if>
    <if test="remark != null">AND
        REMARK = #{remark}
    </if>
    <if test="createUserId != null">AND
        create_user_id = #{createUserId}
    </if>
    <if test="createDatetime != null">AND
        create_datetime = #{createDatetime}
    </if>
    <if test="updateUserId != null">AND
        update_user_id = #{updateUserId}
    </if>
    <if test="updateDatetime != null">AND
        update_datetime = #{updateDatetime}
    </if>
    <if test="deleteFlag != null">AND
        delete_flag = #{deleteFlag}
    </if>
  </sql>

  <sql id="SmSmsRecv.where.by.id">
    WHERE UUID = #{uuid}
  </sql>

  <select id="select" parameterType="SmSmsRecv" resultType="SmSmsRecv">
    <include refid="SmSmsRecv.select"/>
    <include refid="SmSmsRecv.where"/>
  </select>

  <select id="total" parameterType="SmSmsRecv" resultType="Integer">
    SELECT count(*) total FROM (
      <include refid="SmSmsRecv.select"/>
      <include refid="SmSmsRecv.where"/>
    )
  </select>

  <update id="updateById" parameterType="SmSmsRecv">
    UPDATE SM_SMS_RECV SET
    <if test="mobilePhone != null">
        MOBILE_PHONE = #{mobilePhone},
    </if>
    <if test="smsContent != null">
        SMS_CONTENT = #{smsContent},
    </if>
    <if test="smsStatus != null">
        SMS_STATUS = #{smsStatus},
    </if>
    <if test="emppMsgId != null">
        EMPP_MSG_ID = #{emppMsgId},
    </if>
    <if test="smsPlatform != null">
        SMS_PLATFORM = #{smsPlatform},
    </if>
    <if test="remark != null">
        REMARK = #{remark},
    </if>
    <if test="createUserId != null">
        create_user_id = #{createUserId},
    </if>
    <if test="createDatetime != null">
        create_datetime = #{createDatetime},
    </if>
    <if test="updateUserId != null">
        update_user_id = #{updateUserId},
    </if>
    <if test="updateDatetime != null">
        update_datetime = #{updateDatetime},
    </if>
    <if test="deleteFlag != null">
        delete_flag = #{deleteFlag},
    </if>
    UUID = #{uuid}
    <include refid="SmSmsRecv.where.by.id"/>
  </update>

  <delete id="deleteById" parameterType="SmSmsRecv">
    DELETE FROM SM_SMS_RECV
    <include refid="SmSmsRecv.where.by.id"/>
  </delete>

  <insert id="insert" parameterType="SmSmsRecv">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
    INSERT INTO SM_SMS_RECV (
      UUID,
      MOBILE_PHONE,
      SMS_CONTENT,
      SMS_STATUS,
      EMPP_MSG_ID,
      SMS_PLATFORM,
      REMARK,
      create_user_id,
      create_datetime,
      update_user_id,
      update_datetime,
      delete_flag
    ) VALUES (
      rand(),
      #{mobilePhone},
      #{smsContent},
      #{smsStatus},
      #{emppMsgId},
      #{smsPlatform},
      #{remark},
      #{createUserId},
      #{createDatetime},
      #{updateUserId},
      #{updateDatetime},
      #{deleteFlag}
    )
  </insert>

</mapper>
==================================== END sms/SmSmsRecv.xml =========================


==================================== BEGIN sms/SmsAgentSend.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 15:34:33 
 CST 2013 -->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="SmsAgentSend">
 <resultMap id="smsAgentSend" type="com.djb.domain.sms.SmsAgentSend">
  <result property="id" column="id" />
  <result property="agent.id" column="Agent_Id" />
  <result property="smsContent" column="Sms_Content" />
  <result property="signature" column="Signature" />
  <result property="planSendTime" column="Plan_Send_Time" />
  <result property="realSendTime" column="Real_Send_Time" />
  <result property="userNum" column="User_Num" />
  <result property="smsNum" column="Sms_Num" />
  <result property="smsBalance" column="Sms_Balance" />
  <result property="status" column="Status" />
  <result property="smsPlatform" column="Sms_Platform" />
  <result property="remark" column="Remark" />
  <result property="deleteFlag" column="delete_flag" />
  <result property="createUserId" column="create_user_id" />
  <result property="createDateTime" column="create_time" />
  <result property="updateUserId" column="update_user_id" />
  <result property="updateDateTime" column="update_time" />
 </resultMap>

 <select id="findLatestSms" resultMap="smsAgentSend">
  SELECT *
  FROM Sm_Sms_Agent_Send
  WHERE Delete_Flag = 0
  AND Agent_Id = #{id}
  ORDER BY Create_Time DESC
  LIMIT 1
 </select>

 <sql id="findAgentBatchSendSmsRef">
  FROM Sm_Sms_Agent_Send
  WHERE Agent_Id = #{agentId}
  <if test="timeFrom != null">
   AND Create_Time &gt;= #{timeFrom}
  </if>
  <if test="timeTo != null">
   AND Create_Time &lt;= #{timeTo}
  </if>
  <if test="textSend != null">
   AND Sms_Content like '%${textSend}%'
  </if>
  AND Delete_Flag = 0
 </sql>

 <select id="findAgentBatchSendSmsCount" resultType="int"
  parameterType="com.djb.domain.sms.AgentSmsQueryBean">
  SELECT COUNT(*)
  <include refid="findAgentBatchSendSmsRef" />
 </select>

 <select id="findAgentBatchSendSms" resultMap="smsAgentSend"
  parameterType="com.djb.domain.sms.AgentSmsQueryBean">
  SELECT *
  <include refid="findAgentBatchSendSmsRef" />
  ORDER BY Create_Time DESC
  LIMIT ${startIndex}, ${pageSize}
 </select>

 <update id="update" parameterType="com.djb.domain.sms.SmsAgentSend">
  UPDATE Sm_Sms_Agent_Send
  SET Agent_Id=#{agent.id}
  ,Sms_Content=#{smsContent}
  ,Signature=#{signature}
  ,Plan_Send_Time=#{planSendTime}
  ,Real_Send_Time=#{realSendTime}
  ,User_Num=#{userNum}
  ,Sms_Num=#{smsNum}
  ,Sms_Platform=#{smsPlatform}
  ,Sms_Balance=#{smsBalance}
  ,Status=#{status}
  ,Remark=#{remark}
  ,Delete_Flag=#{deleteFlag}
  ,Create_User_Id=#{createUserId}
  ,Create_Time=#{createDateTime}
  ,Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime}
  WHERE id = #{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.sms.SmsAgentSend">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO Sm_Sms_Agent_Send (
  Agent_Id
  ,Sms_Content
  ,Signature
  ,Plan_Send_Time
  ,Real_Send_Time
  ,User_Num
  ,Sms_Num
  ,Sms_Balance
  ,Status
  ,Sms_Platform
  ,Remark
  ,Delete_Flag
  ,Create_User_Id
  ,Create_Time
  ,Update_User_Id
  ,Update_Time
  ) VALUES (
  #{agent.id}
  ,#{smsContent}
  ,#{signature}
  ,#{planSendTime}
  ,#{realSendTime}
  ,#{userNum}
  ,#{smsNum}
  ,#{smsBalance}
  ,#{status}
  ,#{smsPlatform}
  ,#{remark}
  ,#{deleteFlag}
  ,#{createUserId}
  ,#{createDateTime}
  ,#{updateUserId}
  ,#{updateDateTime}
  )
 </insert>
</mapper>
==================================== END sms/SmsAgentSend.xml =========================


==================================== BEGIN sms/SmSmsSend.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 15:34:33 
 CST 2013 -->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="SmSmsSend">
 <resultMap id="smSmsSend" type="com.djb.domain.sms.SmSmsSend">
  <result property="id" column="id" />
  <result property="mobilePhone" column="Mobile_phone" />
  <result property="smsContent" column="Sms_Content" />
  <result property="smsType" column="Sms_Type" />
  <result property="smsStatus" column="Sms_Status" />
  <result property="planSendTime" column="Plan_Send_Time" />
  <result property="arrivalTime" column="Arrival_Time" />
  <result property="sendUserId" column="Send_User_Id" />
  <result property="smsPlatform" column="Sms_Platform" />
  <result property="realSendTime" column="Real_Send_Time" />
  <result property="sendCount" column="Send_Count" />
  <result property="emppMsgId" column="Empp_Msg_Id" />
  <result property="remark" column="Remark" />
  <result property="deleteFlag" column="delete_flag" />
  <result property="createUserId" column="create_user_id" />
  <result property="createDatetime" column="create_time" />
  <result property="updateUserId" column="update_user_id" />
  <result property="updateDatetime" column="update_time" />
 </resultMap>

 <select id="findByEmppMsgId" resultMap="smSmsSend">
  SELECT *
  FROM Sm_Sms_Send
  WHERE Empp_Msg_Id = #{msgId}
  AND delete_flag = '0'
 </select>


 <select id="getLatestSendList" parameterType="com.djb.domain.sms.SmSmsSend"
  resultMap="smSmsSend">
  SELECT *
  FROM Sm_Sms_Send
  WHERE Sms_Status = #{smsStatus}
  AND (Plan_Send_Time IS NULL
  OR (Plan_Send_Time &lt;= now() AND Plan_Send_Time &gt;= now()
  -0.5 )
  )
  AND delete_flag = '0'
  ORDER BY Plan_Send_Time LIMIT 50
 </select>

 <select id="total" parameterType="com.djb.domain.sms.SmSmsSend"
  resultType="Integer">
  SELECT count(*) total
  FROM Sm_Sms_Send
  WHERE Sms_Status = #{smsStatus}
  AND (Plan_Send_Time IS NULL
  OR (Plan_Send_Time &lt;= now() AND Plan_Send_Time &gt;= now()
  -0.5 )
  )
  AND delete_flag = '0'
 </select>

 <update id="update" parameterType="com.djb.domain.sms.SmSmsSend">
  UPDATE
  Sm_Sms_Send
  SET
  Mobile_phone=#{mobilePhone}
  ,Sms_Content=#{smsContent}
  ,Sms_Type=#{smsType}
  ,Sms_Status=#{smsStatus}
  ,Plan_Send_Time=#{planSendTime}
  ,Arrival_Time=#{arrivalTime}
  ,Send_User_Id=#{sendUserId}
  ,Sms_Platform=#{smsPlatform}
  ,Real_Send_Time=#{realSendTime}
  ,Send_Count=#{sendCount}
  ,Empp_Msg_Id=#{emppMsgId}
  ,Remark=#{remark}
  ,Delete_Flag=#{deleteFlag}
  ,Create_User_Id=#{createUserId}
  ,Create_Time=#{createDatetime}
  ,Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDatetime}
  WHERE
  id = #{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.sms.SmSmsSend">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO Sm_Sms_Send (
  Mobile_phone
  ,Sms_Content
  ,Sms_Type
  ,Sms_Status
  ,Plan_Send_Time
  ,Arrival_Time
  ,Send_User_Id
  ,Sms_Platform
  ,Real_Send_Time
  ,Send_Count
  ,Empp_Msg_Id
  ,Remark
  ,Delete_Flag
  ,Create_User_Id
  ,Create_Time
  ,Update_User_Id
  ,Update_Time
  ) VALUES (
  #{mobilePhone}
  ,#{smsContent}
  ,#{smsType}
  ,#{smsStatus}
  ,#{planSendTime}
  ,#{arrivalTime}
  ,#{sendUserId}
  ,#{smsPlatform}
  ,#{realSendTime}
  ,#{sendCount}
  ,#{emppMsgId}
  ,#{remark}
  ,#{deleteFlag}
  ,#{createUserId}
  ,#{createDatetime}
  ,#{updateUserId}
  ,#{updateDatetime}
  )
 </insert>

 <select id="getSmsSendList" parameterType="map" resultMap="smSmsSend">
  SELECT *
  FROM Sm_Sms_Send
  WHERE Sms_Type = #{smsType}
  and Mobile_phone = #{mobileNo}
  and datediff(Create_Time, now()) = 0
  AND delete_flag = '0'
  ORDER BY id desc
 </select>

 <sql id="getSmsSendListAgentRef">
  FROM Sm_Sms_Send sms
  LEFT JOIN Du_Agent_Detail agent ON agent.Mobilephone=sms.Mobile_phone AND
  agent.Delete_Flag=0
  WHERE 1=1
  <if test="userName != null and userName != ''">AND
   agent.True_Name like '%${userName}%'
  </if>
  <if test="mobilePhone != null and mobilePhone != ''">AND
   sms.Mobile_phone = #{mobilePhone}
  </if>
  <if test="feeStatus != null">AND
   agent.Fee_Status=#{feeStatus}
  </if>
  <if test="smsType != null">AND
   sms.Sms_Type=#{smsType}
  </if>
  <if test="smsContent != null and smsContent != ''">AND
   sms.Sms_Content like '%${smsContent}%'
  </if>
  <if test="fromDate != null">AND
   sms.Plan_Send_Time &gt;= #{fromDate}
  </if>
  <if test="toDate != null">AND
   sms.Plan_Send_Time &lt;= #{toDate}
  </if>
 </sql>

 <select id="getSmsSendListAgent" parameterType="map" resultMap="smSmsSend">
  SELECT sms.*
  <include refid="getSmsSendListAgentRef" />
  ORDER BY sms.create_time DESC LIMIT ${startIndex}, ${pageSize}
 </select>

 <select id="getSmsSendListCountAgent" parameterType="map"
  resultType="int">
  SELECT count(*)
  <include refid="getSmsSendListAgentRef" />
 </select>
</mapper>
==================================== END sms/SmSmsSend.xml =========================


==================================== BEGIN user/AgentSeller.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:02:50 
 CST 2013 -->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="AgentSeller">

 <resultMap id="agentSeller" type="com.djb.domain.user.AgentSeller"
  extends="DomainObject.domainObject">
  <result property="agentUser.id" column="Agent_Id" />
  <result property="trueName" column="True_Name" />
  <result property="sex" column="Sex" />
  <result property="mobilephone" column="Mobilephone" />
  <result property="email" column="Email" />
  <result property="promotionCode" column="Promotion_Code" />
  <result property="discount" column="Discount" />
  <result property="sellType" column="Sell_Type" />
  <result property="password" column="Password" />
  <result property="province.id" column="Province" />
  <result property="city.id" column="City" />
  <result property="district.id" column="District" />
  <result property="invitePromotionCode" column="Invite_Promotion_Code" />
  <result property="companyType" column="Company_Type" />
  <result property="company" column="Company" />
  <result property="idcardNumber" column="Idcard_Number" />
  <result property="withdrawalType" column="Withdrawal_Type" />
  <result property="subbranch" column="Subbranch" />
  <result property="bankAccounts" column="Bank_Accounts" />
  <result property="accountBalance" column="Account_Balance" />
  <result property="totalRevenue" column="Total_Revenue" />
  <result property="verifyStatus" column="Verify_Status" />
  <result property="parentIds" column="Parent_Ids" />
  <result property="referNum" column="Refer_Num" />
 </resultMap>

 <select id="load" resultMap="agentSeller">
  SELECT *
  FROM Du_Agent_Seller
  WHERE id = #{id}
  AND delete_flag='0'
 </select>

 <select id="findSellerList" parameterType="com.djb.domain.sell.SellerQueryBean"
  resultMap="agentSeller">
  SELECT *
  FROM Du_Agent_Seller
  WHERE Mobilephone=#{mobilephone}
  AND delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.user.AgentSeller">
  UPDATE Du_Agent_Seller
  SET
  Agent_Id=#{agentUser.id}
  ,True_Name=#{trueName}
  ,Sex=#{sex}
  ,Mobilephone=#{mobilephone}
  ,Email=#{email}
  ,Promotion_Code=#{promotionCode}
  ,Discount=#{discount}
  ,Sell_Type=#{sellType}
  ,Password=#{password}
  ,Province=#{province.id}
  ,City=#{city.id}
  ,District=#{district.id}
  ,Invite_Promotion_Code=#{invitePromotionCode}
  ,Company_Type=#{companyType}
  ,Company=#{company}
  ,Idcard_Number=#{idcardNumber}
  ,Withdrawal_Type=#{withdrawalType}
  ,Subbranch=#{subbranch}
  ,Bank_Accounts=#{bankAccounts}
  ,Account_Balance=#{accountBalance}
  ,Total_Revenue=#{totalRevenue}
  ,Verify_Status=#{verifyStatus}
  ,Parent_Ids=#{parentIds}
  ,Refer_Num=#{referNum}
  ,Delete_Flag=#{deleteFlag}
  ,Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime}
  WHERE id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.user.AgentSeller">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO Du_Agent_Seller(
  Agent_Id
  ,True_Name
  ,Sex
  ,Mobilephone
  ,Email
  ,Promotion_Code
  ,Discount
  ,Sell_Type
  ,Password
  ,Province
  ,City
  ,District
  ,Invite_Promotion_Code
  ,Company_Type
  ,Company
  ,Idcard_Number
  ,Withdrawal_Type
  ,Subbranch
  ,Bank_Accounts
  ,Account_Balance
  ,Total_Revenue
  ,Verify_Status
  ,Parent_Ids
  ,Refer_Num
  ,Delete_Flag
  ,Create_User_Id
  ,Create_Time
  ,Update_User_Id
  ,Update_Time
  )
  VALUES(
  #{agentUser.id}
  ,#{trueName}
  ,#{sex}
  ,#{mobilephone}
  ,#{email}
  ,#{promotionCode}
  ,#{discount}
  ,#{sellType}
  ,#{password}
  ,#{province.id}
  ,#{city.id}
  ,#{district.id}
  ,#{invitePromotionCode}
  ,#{companyType}
  ,#{company}
  ,#{idcardNumber}
  ,#{withdrawalType}
  ,#{subbranch}
  ,#{bankAccounts}
  ,#{accountBalance}
  ,#{totalRevenue}
  ,#{verifyStatus}
  ,#{parentIds}
  ,#{referNum}
  ,#{deleteFlag}
  ,#{createUserId}
  ,#{createDateTime}
  ,#{updateUserId}
  ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey">
  DELETE FROM Du_Agent_Seller
  WHERE id = #{id}
 </delete>
 <select id="findAgentSellerByCode" parameterType="string"
  resultMap="agentSeller">
  SELECT *
  FROM Du_Agent_Seller
  WHERE delete_flag = 0
  AND Promotion_Code = #{promotionCode} AND Verify_Status = 1
 </select>

 <sql id="findSellerByQueryBeanRef">
  FROM Du_Agent_Seller agentSeller
  WHERE delete_flag=0
  <if test="mobilephone">AND
   Mobilephone=#{mobilephone}
  </if>
  <if test="trueName != null">
   AND True_Name like '%${trueName}%'
  </if>
  <if test="mobileOrName != null">
   AND (Mobilephone=#{mobileOrName} OR True_Name like '%${mobileOrName}%')
  </if>
  <if test="provinceId != null">
   AND Province = #{provinceId}
  </if>
  <if test="cityId != null">
   AND City = #{cityId}
  </if>
  <if test="districtId != null">
   AND District = #{districtId}
  </if>
  <if test="parentId != null">
   AND Parent_Ids like ',%${parentId}%,'
  </if>
 </sql>

 <select id="findSellerByQueryBean" parameterType="com.djb.domain.sell.SellerQueryBean"
  resultMap="agentSeller">
  SELECT agentSeller.*
  <include refid="findSellerByQueryBeanRef" />
  <if test="orderByProperties != null">
   ORDER BY ${orderByFiled}
  </if>
  <if test="orderByProperties == null">
   ORDER BY agentSeller.create_time DESC
  </if>
  LIMIT ${startIndex}, ${pageSize}
 </select>


 <select id="getCountByQueryBean" parameterType="com.djb.domain.sell.SellerQueryBean"
  resultType="int">
  SELECT count(*)
  <include refid="findSellerByQueryBeanRef" />
 </select>
</mapper>
==================================== END user/AgentSeller.xml =========================


==================================== BEGIN user/AnonymousUser.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:02:52 
 CST 2013 -->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="AnonymousUser">
 <resultMap id="anonymousUser" type="com.djb.domain.user.AnonymousUser"
  extends="DomainObject.domainObject">
  <result property="trueName" column="name" />
  <result property="mobileNo" column="phone" />
  <result property="mail" column="mail" />
  <result property="ip" column="access_ip" />
  <result property="imagePath" column="image_path" />
  <result property="accessToken" column="Access_Token" />
  <result property="openId" column="Open_ID" />
  <result property="webLoginType" column="Web_Login_Type" />
  <result property="tokenExpire" column="Token_Expire" />
  <result property="webLoginTime" column="Web_Login_Time" />
 </resultMap>

 <select id="load" resultMap="anonymousUser">
  SELECT *
  FROM Du_Anonymous
  WHERE id=#{id} AND delete_flag='0'
 </select>

 <select id="getByIp" resultMap="anonymousUser">
  SELECT * 
  FROM Du_Anonymous
  WHERE Access_Ip=#{ip} AND delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.user.AnonymousUser">
  UPDATE Du_Anonymous
  SET name = #{trueName},
   phone = #{mobileNo},
   mail = #{mail},
   access_ip = #{ip},
   Access_Token = #{accessToken},
   Open_Id = #{openId},
   Web_Login_Type = #{webLoginType},
   Token_Expire = #{tokenExpire},
   update_time = #{updateDateTime},
   update_user_id = #{updateUserId},
   delete_flag = #{deleteFlag}
  <if test="webLoginTime != null">,
   Web_Login_Time = #{webLoginTime}
  </if>
  WHERE id = #{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.user.AnonymousUser">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO Du_Anonymous(
   name,
   phone,
   mail,
   access_ip,
   image_path,
   Access_Token,
   Open_Id,
   Web_Login_Type,
   Token_Expire,
   create_time,
   create_user_id,
   update_time,
   update_user_id,
   delete_flag
  ) VALUES(
   #{trueName},
   #{mobileNo},
   #{mail},
   #{ip},
   #{imagePath},
   #{accessToken},
   #{openId},
   #{webLoginType},
   #{tokenExpire},
   #{createDateTime},
   #{createUserId},
   #{updateDateTime},
   #{updateUserId},
   #{deleteFlag}
  )
 </insert>


 <delete id="deleteByPrimaryKey">
  DELETE FROM Du_Anonymous
  WHERE id = #{id}
 </delete>
</mapper>

==================================== END user/AnonymousUser.xml =========================


==================================== BEGIN user/AgentValueAddedService.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:02:51 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="AgentValueAddedService">

 <resultMap id="agentValueAddedService" type="com.djb.domain.user.AgentValueAddedService" extends="DomainObject.domainObject">
  <result property="agent.id" column="User_Id"/>
  <result property="service.id" column="Service_Id"/>
  <result property="balance" column="Balance"/>
  <result property="total" column="Total" />
  <result property="validTime" column="Valid_Time"/>
 </resultMap>

 <select id="load" resultMap="agentValueAddedService">
  SELECT  *
    FROM  Du_Agent_Value_Added_Service
   WHERE  id = #{id}
     AND  delete_flag = 0
 </select>
 
 <select id="findValueAddedServiceByAgent" parameterType="com.djb.domain.user.AgentUser" resultMap="agentValueAddedService">
  SELECT  *
    FROM  Du_Agent_Value_Added_Service
   WHERE  User_Id = #{id}
     AND  delete_flag = 0
 </select>
 
 <select id="findValueAddedServiceByAgentService" parameterType="java.util.HashMap" resultMap="agentValueAddedService">
  SELECT  *
    FROM  Du_Agent_Value_Added_Service
   WHERE  User_Id = #{userId}
     AND Service_Id = #{serviceId}
     AND  delete_flag = 0
 </select>
 
 <update id="update" parameterType="com.djb.domain.user.AgentValueAddedService">
  UPDATE  Du_Agent_Value_Added_Service
     SET  
    User_Id=#{agent.id}
    ,Service_Id=#{service.id}
    ,Balance=#{balance}
    ,Total=#{total}
    ,Valid_Time=#{validTime}
    ,Delete_Flag=#{deleteFlag}
    ,Update_User_Id=#{updateUserId}
    ,Update_Time=#{updateDateTime}
   WHERE Id = #{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.user.AgentValueAddedService">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Du_Agent_Value_Added_Service(
   User_Id
   ,Service_Id
   ,Balance
   ,Total
   ,Valid_Time
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{agent.id}
   ,#{service.id}
   ,#{balance}
   ,#{total}
   ,#{validTime}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
  
  
 </insert>

</mapper>
==================================== END user/AgentValueAddedService.xml =========================


==================================== BEGIN user/UserLoginInfo.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:02:52 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="UserLoginInfo">
 <resultMap id="userLoginInfo" type="com.djb.domain.user.UserLoginInfo" extends="DomainObject.domainObject">
  <result property="userName" column="User_Name"/>
  <result property="password" column="Password"/>
  <result property="accountType" column="Account_Type"/>
  <result property="type" column="User_Type"/>
  <result property="status" column="User_Status"/>
  <result property="province.id" column="Province"/>
  <result property="city.id" column="City"/>
  <result property="district.id" column="District"/>
  <result property="registerIp" column="Register_Ip"/>
  <result property="nickName" column="Nick_Name"/>
 </resultMap>

 <select id="load" resultMap="userLoginInfo">
  SELECT *
   FROM Du_User
   WHERE id=#{id}
     AND Delete_Flag = '0'
 </select>
 
 <update id="logicDelete" parameterType="long">
  UPDATE Du_User
     SET delete_flag = 1
   WHERE  id = #{id}
 </update>
</mapper>
==================================== END user/UserLoginInfo.xml =========================


==================================== BEGIN user/UserLoginLog.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:02:53 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="UserLoginLog">

 <resultMap id="userLoginLog" type="com.djb.domain.user.UserLoginLog" extends="DomainObject.domainObject">
  <result property="userId" column="User_Id"/>
  <result property="loginFrom" column="Login_From"/>
  <result property="loginIp" column="Login_Ip"/>
  <result property="clientType" column="Client_Type"/>
  <result property="loginOS" column="Login_OS"/>
  <result property="loginBrowser" column="Login_Browser"/>
  <result property="fromUrl" column="From_Url"/>
  <result property="loginType" column="Login_Type"/>
  <result property="resolution" column="Resolution"/>
 </resultMap>
 
 <select id="findLatestLog" resultMap="userLoginLog" parameterType="map">
  SELECT  *
    FROM  Du_User_Login_Log
   WHERE  User_Id = #{userId}
     AND  delete_flag='0'
     <choose>
     	<when test="timeRange == 1">
     		AND DATE_FORMAT(Create_Time,'%H') <![CDATA[>=]]> 0
     		AND DATE_FORMAT(Create_Time,'%H') <![CDATA[<=]]> 10	
     	</when>
     	<when test="timeRange == 2">
     		AND DATE_FORMAT(Create_Time,'%H') <![CDATA[>=]]> 11
     		AND DATE_FORMAT(Create_Time,'%H') <![CDATA[<=]]> 13	
     	</when>
     	<when test="timeRange == 3">
     		AND DATE_FORMAT(Create_Time,'%H') <![CDATA[>=]]> 14
     		AND DATE_FORMAT(Create_Time,'%H') <![CDATA[<=]]> 18	
     	</when>
     	<when test="timeRange == 4">
     		AND DATE_FORMAT(Create_Time,'%H') <![CDATA[>=]]> 19
     		AND DATE_FORMAT(Create_Time,'%H') <![CDATA[<=]]> 23	
     	</when>
     </choose>
     AND create_time > date_add(now(), interval -30 day)
 </select>

 <select id="load" resultMap="userLoginLog">
  SELECT  *
    FROM  Du_User_Login_Log
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.user.UserLoginLog">
  UPDATE  Du_User_Login_Log
     SET  
      User_Id = #{userId}
   ,Login_From=#{loginFrom}
   ,Login_Ip=#{loginIp}
   ,Client_Type=#{clientType}
   ,Login_OS=#{loginOS}
   ,Login_Browser=#{loginBrowser}
   ,From_Url=#{fromUrl}
   ,Login_Type=#{loginType}
   ,Resolution=#{resolution}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   WHERE  id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.user.UserLoginLog">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Du_User_Login_Log(
   User_Id
   ,Login_From
   ,Login_Ip
   ,Client_Type
   ,Login_OS
   ,Login_Browser
   ,From_Url
   ,Login_Type
   ,Resolution
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{userId}
   ,#{loginFrom}
   ,#{loginIp}
   ,#{clientType}
   ,#{loginOS}
   ,#{loginBrowser}
   ,#{fromUrl}
   ,#{loginType}
   ,#{resolution}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
  
  
 </insert>

 <delete id="deleteByPrimaryKey">
  DELETE FROM  Du_User_Login_Log
        WHERE  id = #{id}
 </delete>
</mapper>
==================================== END user/UserLoginLog.xml =========================


==================================== BEGIN user/AgentUser.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:02:50 
 CST 2013 -->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="AgentUser">

 <cache type="com.djb.cache.MemcachedCache">
  <property name="timeout" value="1800" />
 </cache>
 <resultMap id="agentUser" type="com.djb.domain.user.AgentUser"
  extends="DomainObject.domainObject">
  <result property="trueName" column="True_Name" />
  <result property="sex" column="Sex" />
  <result property="mobileNo" column="Mobilephone" />
  <result property="email" column="Email" />
  <result property="imagePath" column="Image_Url" />
  <result property="feeStatus" column="Fee_Status" />
  <result property="packageType" column="Package_Type" />
  <result property="verifyStatus" column="Verify_Status" />
  <result property="company.id" column="Company" />
  <result property="provinceId" column="Province" />
  <result property="department" column="Department" />
  <result property="serviceArea" column="Service_Area" />
  <result property="serviceSpecialty" column="Service_Specialty" />
  <result property="idType" column="ID_Type" />
  <result property="idcardNumber" column="Idcard_Number" />
  <result property="professionalNunber" column="Professional_Nunber" />
  <result property="professionalExpireDate" column="Professional_Expire_date" />
  <result property="careerStartTime" column="Career_Start_time" />
  <result property="introduction" column="Introduction" />
  <result property="commitment" column="Commitment" />
  <result property="imageStatus" column="Image_Status" />
  <result property="mobilePhoneStatus" column="Mobile_Phone_Status" />
  <result property="promotionCode" column="Promotion_Code" />
  <result property="qq" column="qq" />
  <result property="isArchive" column="Is_Archive" />
  <result property="oldMobilePhone" column="Old_Mobile_Phone" />
  <result property="accountBalance" column="Account_Balance" />
  <result property="securitySetting" column="Security_Setting" />
  <result property="inviteId" column="Invite_Id" />
  <result property="isJoinFenhong" column="Is_Join_Fenhong" />
  <result property="salManager" column="Sale_Manager" />
  <result property="dispatchTime" column="Dispatch_Time" />
  <result property="shopName" column="Shop_Name" />
  <result property="shopIntroduce" column="Shop_Introduce" />
  <result property="isShowCareerTime" column="Is_Show_Career_Time" />
  <result property="wpStatus" column="Wp_Status" />
  <result property="recommondNum" column="Recommond_Num" />
  <result property="creditPoint" column="Credit_Point" />
  <result property="callNo400" column="callno_400"/>
  <collection property="loginInfo" resultMap="UserLoginInfo.userLoginInfo" />
 </resultMap>

 <select id="load" resultMap="agentUser">
  SELECT *
  FROM Du_Agent_Detail detail
  INNER JOIN Du_User agentUser ON detail.id = agentUser.id
  WHERE detail.id=#{id}
  AND detail.delete_flag = '0'
 </select>

 <select id="getTotalCount" resultType="int">
  SELECT count(*)
  FROM Du_Agent_Detail detail
  WHERE detail.delete_flag = '0'
 </select>

 <select id="getAgentByProvinceMobilephone" resultMap="agentUser">
  SELECT *
  FROM Du_Agent_Detail detail
  INNER JOIN Du_User agentUser ON detail.id = agentUser.id
  WHERE detail.Mobilephone=#{mobilePhone}
  AND agentUser.province = #{province.id}
  AND detail.delete_flag = 0
  AND agentUser.delete_flag = 0
 </select>

 <select id="getAgentByMobilephone" resultMap="agentUser">
  SELECT *
  FROM Du_Agent_Detail detail
  INNER JOIN Du_User agentUser ON detail.id = agentUser.id
  WHERE detail.Mobilephone=#{mobileNo}
  AND detail.delete_flag = '0'
 </select>

 <select id="getAgentByName" resultMap="agentUser">
  SELECT *
  FROM Du_Agent_Detail detail
  INNER JOIN Du_User agentUser ON detail.id = agentUser.id
  WHERE detail.True_Name=#{name}
  AND detail.delete_flag = '0'
 </select>

 <select id="getAgentByEmail" resultMap="agentUser">
  SELECT *
  FROM Du_Agent_Detail detail
  INNER JOIN Du_User agentUser ON detail.id = agentUser.id
  WHERE detail.Email=#{email}
  AND detail.delete_flag = 0
 </select>

 <select id="validateIdCard" resultType="int">
  SELECT COUNT(ID)
  FROM Du_Agent_Detail
  WHERE Idcard_Number = #{idcardNumber}
  AND ID_Type = #{idType}
  AND Delete_Flag = '0'
  <if test="id != null">
   AND Id != #{id}
  </if>
 </select>

 <select id="validateProfessionalNumber" resultType="int">
  SELECT COUNT(ID)
  FROM Du_Agent_Detail
  WHERE Professional_Nunber = #{professionalNunber}
  AND Delete_Flag = '0'
  <if test="id != null">
   AND Id != #{id}
  </if>
 </select>

 <select id="validateEmail" resultType="int">
  SELECT COUNT(ID)
  FROM Du_Agent_Detail
  WHERE Email = #{email}
  AND Delete_Flag = '0'
  <if test="id != null">
   AND Id != #{id}
  </if>
 </select>

 <select id="validateMobilePhone" resultType="int">
  SELECT COUNT(ID)
  FROM Du_Agent_Detail
  WHERE Mobilephone = #{mobileNo}
  AND Delete_Flag = '0'
  <if test="id != null">
   AND Id != #{id}
  </if>
 </select>

 <select id="validateMobilePhonePass" resultType="int">
  SELECT COUNT(ID)
  FROM Du_Agent_Detail
  WHERE Mobilephone = #{mobileNo}
  AND Delete_Flag = '0'
  AND Mobile_Phone_Status='1'
  <if test="id != null">
   AND Id != #{id}
  </if>
 </select>

 <update id="updateAuthentication" parameterType="com.djb.domain.user.AgentUser">
  update
  Du_Agent_Detail
  set
  Idcard_Number=#{idcardNumber}
  ,ID_Type=#{idType}
  ,Professional_Nunber=#{professionalNunber}
  ,Professional_Expire_date=#{professionalExpireDate}
  ,Verify_Status=#{verifyStatus} ,Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime}
  WHERE Id=#{id}
 </update>

 <update id="update" parameterType="com.djb.domain.user.AgentUser">
  UPDATE Du_Agent_Detail
  SET
  Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime}
  <if test="rmdStatus != null">,
   Rmd_Status=#{rmdStatus}
  </if>
  <if test="lastLoginTime != null">,
   Last_Login_Time = #{lastLoginTime}
  </if>
  <if test="isArchive != null">
   ,Is_Archive=#{isArchive}
  </if>
  <if test="oldMobilePhone != null">
   ,Old_Mobile_Phone=#{oldMobilePhone}
  </if>
  <if test="email != null and email != ''">
   ,email=#{email}
  </if>
  <if test="securitySetting != null">
   ,Security_Setting=#{securitySetting}
  </if>
  <if test="accountBalance != null">
   ,Account_Balance=#{accountBalance}
  </if>
  <if test="trueName != null">
   ,True_Name=#{trueName}
  </if>
  <if test="sex != null">
   ,Sex=#{sex}
  </if>
  <if test="idcardNumber != null">
   ,Idcard_Number=#{idcardNumber}
  </if>
  <if test="professionalNunber != null">
   ,Professional_Nunber=#{professionalNunber}
  </if>
  <if test="imageUrl != null">
   ,Image_Url=#{imageUrl}
  </if>
  <if test="verifyStatus != null">
   ,Verify_Status=#{verifyStatus}
  </if>
  <if test="callNo400 != null and callNo400 != ''">
   ,callno_400=#{callNo400}
  </if>
  WHERE id=#{id}
 </update>

 <update id="updateUserInfo" parameterType="com.djb.domain.user.AgentUser">
  UPDATE Du_User
  SET
  Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime}
  <if test="loginInfo.password != null">
   ,Password=#{loginInfo.password}
  </if>
  <if test="loginInfo.province.id">
   ,Province=#{loginInfo.province.id}
  </if>
  <if test="loginInfo.city.id">
   ,City=#{loginInfo.city.id}
  </if>
  <if test="loginInfo.district.id">
   ,District=#{loginInfo.district.id}
  </if>
  WHERE id=#{id}
 </update>

 <update id="updateDetailInfo" parameterType="com.djb.domain.user.AgentUser">
  UPDATE Du_Agent_Detail
  SET
  Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime}
  <if test="serviceArea != null">,
   Service_Area=#{serviceArea}
  </if>
  <if test="email != null">,
   Email=#{email}
  </if>
  <if test="company!=null">
   <if test="company.id!=null">,
    Company=#{company.id}
   </if>
  </if>
  <if test="trueName!=null">,
   True_Name=#{trueName}
  </if>
  <if test="inviteId!=null">,
   Invite_Id=#{inviteId}

  </if>
  <if test="promotionCode!=null">,
   Promotion_Code=#{promotionCode}

  </if>
  WHERE id=#{id}
 </update>

 <update id="updateWithoutFlush" parameterType="com.djb.domain.user.AgentUser"
  flushCache="false">
  UPDATE Du_Agent_Detail
  SET
  Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime}
  <if test="rmdStatus != null">,
   Rmd_Status=#{rmdStatus}
  </if>
  <if test="lastLoginTime != null">,
   Last_Login_Time = #{lastLoginTime}
  </if>
  WHERE id=#{id}
 </update>

 <update id="updateBaseInfo" parameterType="com.djb.domain.user.AgentUser">
  UPDATE Du_Agent_Detail
  set
  Sex=#{sex.value}
  ,Email=#{email}
  ,Company=#{company.id}
  ,Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime}
  WHERE Id=#{id}
 </update>

 <update id="updatePassword" parameterType="com.djb.domain.user.AgentUser">
  UPDATE Du_User
  set
  Password=#{loginInfo.password}
  ,Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime}
  WHERE Id=#{id}
 </update>

 <update id="updateMobilePhoneStatus" parameterType="com.djb.domain.user.AgentUser">
  update
  Du_Agent_Detail
  set
  Mobile_Phone_Status=#{mobilePhoneStatus}
  ,Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime}
  WHERE Id=#{id}
 </update>

 <update id="updateUserName" parameterType="com.djb.domain.user.AgentUser">
  UPDATE Du_User
  SET
  User_Name=#{mobileNo}
  ,Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime}
  WHERE Id=#{id}
 </update>

 <update id="updateMobilePhone" parameterType="com.djb.domain.user.AgentUser">
  UPDATE Du_Agent_Detail
  SET
  Mobilephone=#{mobileNo}
  ,Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime}
  <if test="isArchive != null">
   ,Is_Archive=#{isArchive}
  </if>
  <if test="oldMobilePhone != null">
   ,Old_Mobile_Phone=#{oldMobilePhone}
  </if>
  WHERE Id=#{id}
 </update>

 <update id="updateImageUrl" parameterType="com.djb.domain.user.AgentUser">
  UPDATE Du_Agent_Detail
  set
  Image_Url=#{imageUrl}
  ,Image_Status=#{imageStatus}
  ,Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime}
  WHERE Id=#{id}
 </update>

 <update id="updateStoreBaseInfo" parameterType="com.djb.domain.user.AgentUser">
  update
  Du_Agent_Detail
  set
  Service_Area=#{serviceArea}
  ,Service_Specialty=#{serviceSpecialty}
  ,Career_Start_time=#{careerStartTime}
  ,Introduction=#{introduction}
  ,Commitment=#{commitment}
  ,Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime} ,qq=#{qq}
  ,Shop_Name=#{shopName} ,Shop_Introduce=#{shopIntroduce}
  ,Is_Show_Career_Time=#{isShowCareerTime}
  WHERE Id=#{id}
 </update>

 <update id="updateDetail" parameterType="com.djb.domain.user.AgentUser">
  UPDATE Du_Agent_Detail
  set
  Sex=#{sex.value}
  ,True_Name=#{trueName}
  ,Email=#{email}
  ,Mobilephone=#{mobileNo}
  ,Service_Area=#{serviceArea}
  ,Service_Specialty=#{serviceSpecialty}
  ,Career_Start_time=#{careerStartTime} ,Is_Join_Fenhong=#{isJoinFenhong}
  ,Introduction=#{introduction}
  ,Commitment=#{commitment} ,Account_Balance=#{accountBalance}
  ,Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime} ,Sale_Manager=#{salManager} ,Dispatch_Time=#{dispatchTime}
  WHERE Id=#{id}
 </update>

 <update id="updateBaseUser" parameterType="com.djb.domain.user.AgentUser">
  UPDATE Du_User
  SET
  User_Name=#{mobileNo}
  ,Nick_Name=#{trueName}
  ,Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime}
  WHERE Id=#{id}
 </update>

 <update id="updateContractPack" parameterType="com.djb.domain.user.AgentUser">
  update
  Du_Agent_Detail
  set
  Fee_Status = #{feeStatus}
  ,Package_Type = #{packageType} ,Wp_Status = #{wpStatus}
  ,Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime}
  WHERE Id=#{id}
 </update>

 <insert id="saveBaseInfo" parameterType="com.djb.domain.user.AgentUser">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO
  Du_User(
  User_Name
  ,Password
  ,Account_Type
  ,User_Type
  ,User_Status
  ,Province
  ,City
  ,District
  ,Register_Ip
  ,Nick_Name ,Utm_Source ,Utm_Medium ,Utm_Campaign
  ,Delete_Flag
  ,Create_User_Id
  ,Create_Time ,Utm_Term ,Utm_Content ,OS ,Browser
  )
  VALUES(
  #{loginInfo.userName}
  ,#{loginInfo.password}
  ,#{loginInfo.accountType}
  ,#{userType}
  ,#{loginInfo.status}
  ,#{loginInfo.province.id}
  ,#{loginInfo.city.id}
  ,#{loginInfo.district.id}
  ,#{loginInfo.registerIp}
  ,#{loginInfo.nickName} ,#{loginInfo.utmSource} ,#{loginInfo.utmMedium}
  ,#{loginInfo.utmCampaign}
  ,#{loginInfo.deleteFlag}
  ,#{loginInfo.createUserId}
  ,#{loginInfo.createDateTime} ,#{loginInfo.utmTerm} ,#{loginInfo.utmContent} ,#{loginInfo.os}
  ,#{loginInfo.browser}
  )
 </insert>

 <insert id="saveDetailInfo" parameterType="com.djb.domain.user.AgentUser">
  INSERT INTO
  Du_Agent_Detail(
  Id,
  True_Name
  ,Sex
  ,Mobilephone
  ,Fee_Status
  ,Verify_Status
  ,Company
  ,Image_Status
  ,Mobile_Phone_Status
  ,Promotion_Code
  ,Service_Area
  ,Delete_Flag
  ,Create_User_Id
  ,Create_Time ,Province_Id ,City_Id ,Account_Balance ,Invite_Id ,Is_Join_Fenhong
  ,callno_400
  )
  VALUES(
  #{id}
  ,#{trueName}
  ,#{sex}
  ,#{mobileNo}
  ,#{feeStatus}
  ,#{verifyStatus}
  ,#{company.id}
  ,#{imageStatus}
  ,#{mobilePhoneStatus}
  ,#{promotionCode}
  ,#{serviceArea}
  ,#{loginInfo.deleteFlag}
  ,#{loginInfo.createUserId}
  ,#{loginInfo.createDateTime} ,#{loginInfo.province.id} ,#{loginInfo.city.id} ,#{accountBalance}
  ,#{inviteId} ,#{isJoinFenhong}
  ,#{callNo400}
  )
 </insert>

 <select id="findOldVersionUUID" parameterType="long" resultType="string">
  SELECT c.Uuid
  FROM Du_User a, Tmp_Uuid_Mapping c
  WHERE a.Province = 2
  and a.Id = c.New_Id
  and c.Type = 7
  and a.id = #{agentId}
 </select>
 
 <sql id="findAgentListByQueryBeanRef">
  		FROM 
							(
								 SELECT d.*
										,u.User_Name
										,u.Password
										,u.Account_Type
										,u.User_Type
										,u.User_Status
										,u.Province
										,u.City
										,u.District
										,u.Register_Ip
										,u.Nick_Name
								  FROM	Du_Agent_Detail d
							INNER JOIN	Du_User u on u.Id=d.Id
								 WHERE  (d.Rmd_Status &lt;&gt; #{blackListAgent} OR d.Rmd_Status IS NULL ) 
									 <if test="specialty != null and specialty != ''">AND
										d.Service_Specialty like '%${specialty}%'
									 </if>
									 <if test="sex != null">AND
										d.sex=#{sex}
									 </if>
									 <if test="company != null">AND
										d.company=#{company}
									 </if>
									 <if test="searchText != null and searchText != ''">AND
										d.Service_Specialty like '%${searchText}%'
									 </if>
									 <if test="city != null">AND
									 	(u.Province = #{city} OR u.City = #{city})
									 </if>
								  AND	d.Delete_Flag = 0
								  AND	d.Verify_Status = 1
						<if test="searchText != null and searchText != ''">UNION
							   SELECT	d.*
							   			,u.User_Name
							   			,u.Password
							   			,u.Account_Type
							   			,u.User_Type
							   			,u.User_Status
							   			,u.Province
							   			,u.City
							   			,u.District
							   			,u.Register_Ip
							   			,u.Nick_Name
								 FROM	Du_Agent_Detail d
						   INNER JOIN	Du_User u on u.Id=d.Id
								WHERE	d.true_name like '%${searchText}%'
						 AND	(d.Rmd_Status &lt;&gt; #{blackListAgent} OR d.Rmd_Status IS NULL ) 
									<if test="specialty != null and specialty != ''">AND
										d.Service_Specialty like '%${specialty}%'
									</if>
									<if test="sex != null">AND
										d.sex=#{sex}
									</if>
									<if test="company != null">AND
										d.company=#{company}
									</if>
									<if test="city != null">AND
									 	(u.Province = #{city} OR u.City = #{city})
									 </if>
								  AND	d.Delete_Flag = 0
								  AND	d.Verify_Status = 1
						</if>	
						
						<if test="searchText != null and searchText != ''">UNION
							   SELECT	d.*
							   			,u.User_Name
							   			,u.Password
							   			,u.Account_Type
							   			,u.User_Type
							   			,u.User_Status
							   			,u.Province,u.City,u.District
							   			,u.Register_Ip,u.Nick_Name
								 FROM	Du_Agent_Detail d
						   INNER JOIN	Du_User u on u.Id=d.Id
						   INNER JOIN	Sm_Company c ON c.id=d.Company
								WHERE 	(d.Rmd_Status &lt;&gt; #{blackListAgent} OR d.Rmd_Status IS NULL ) 
								  AND	c.Company_Name like '%${searchText}%'
									 <if test="specialty != null and specialty != ''">AND
										d.Service_Specialty like '%${specialty}%'
									 </if>
									 <if test="sex != null">AND
										d.sex=#{sex}
									 </if>
									 <if test="company != null">AND
										d.company=#{company}
									 </if>
									 <if test="city != null">AND
									 	(u.Province = #{city} OR u.City = #{city})
									 </if>
								  AND	d.Delete_Flag = 0
								  AND	d.Verify_Status = 1
						</if>		 
			
			
					) AS t
 </sql>

 <select id="findAgentListByQueryBean" parameterType="com.djb.domain.pro.AgentUserQueryBean"
  resultMap="agentUser">
  SELECT * <include refid="findAgentListByQueryBeanRef"/> 
  ORDER BY t.Fee_Status ASC,t.Fee_Time DESC,t.create_time DESC
  LIMIT ${startIndex}, ${pageSize}
 </select>

 <select id="findAgentListCountByQueryBean" parameterType="com.djb.domain.pro.AgentUserQueryBean"
  resultType="int">
  SELECT count(*) <include refid="findAgentListByQueryBeanRef"/>
 </select>

<sql id="findAgentByQueryBeanRef">
		FROM	Du_Agent_Detail detail
		  LEFT	JOIN Du_User baseUser ON detail.Id = baseUser.Id
		  LEFT	JOIN Sm_Company cmp ON detail.Company = cmp.Id
		 WHERE	detail.Delete_Flag = 0
		   AND	baseUser.Delete_Flag = 0
		   AND	cmp.Delete_Flag = 0
		   <if test="regStartTime != null">
		   AND	detail.create_time >= #{regStartTime}
		   </if>
		   <if test="regEndTime != null">
		   AND	detail.create_time &lt; #{regEndTime}
		   </if>
		   <if test="emp != null">
		   AND	detail.Sale_Manager = #{emp.id}
		   </if>
		   <if test="verifyStatus != null">
		   <if test="verifyStatus == 1">
		   AND	detail.Mobile_Phone_Status = 0
		   </if>
		   <if test="verifyStatus == 2">
		   AND	detail.Mobile_Phone_Status = 1
		   </if>
		   <if test="verifyStatus == 3">
		   AND	detail.Verify_Status = 4
		   </if>
		   <if test="verifyStatus == 4">
		   AND	detail.Verify_Status in (1,3)
		   </if>
		   </if>
		   <if test="payStatus != null">
		   <if test="payStatus == 1">
		   AND	EXISTS(
		select	1
		  from	Sm_Order
		 where	status = 1
		   and	delete_flag = 0
		   and	user_id = detail.id
		   AND	Buy_Scene = 1
		   AND	Create_time > date_add(now(), interval -7 day)
		   )
		   </if>
		   <if test="payStatus == 2">
		   AND	NOT EXISTS(
		select	1
		  from	Sm_Order
		 where	status = 1
		   and	delete_flag = 0
		   and	user_id = detail.id
		   AND	Buy_Scene = 1
		   AND	Create_time > date_add(now(), interval -7 day)
		   )
		   </if>
		   </if>
		   <if test="dispatchStatus != null">
		   <if test="dispatchStatus == 1">
		   AND	detail.Sale_Manager is not null
		   </if>
		   <if test="dispatchStatus == 2">
		   AND	detail.Sale_Manager is null
		   </if>
		   </if>
		   <if test="province != null and province != ''">
		   AND	baseUser.Province = #{province.id}
		   </if>
		   <if test="city != null and city != ''">
		   AND	baseUser.City = #{city.id}
		   </if>
		   <if test="district != null and district != ''">
		   AND	baseUser.District = #{district.id}
		   </if>
		   <if test="feeStatus != null and feeStatus != ''">
		   AND	detail.Fee_Status = #{feeStatus}
		   </if>
		   <if test="userName != null and userName != ''">
		   AND	detail.True_Name = #{userName}
		   </if>
		   <if test="mobileNo != null and mobileNo != ''">
		   AND	detail.Mobilephone = #{mobileNo}
		   </if>
		   <if test="isArchive != null">
		   AND	detail.Is_Archive = #{isArchive}
		   </if>
		   <if test="company != null and company != ''">
		   AND	(cmp.Company_Name like '%${company}%' OR cmp.Company_Nick_Name like '%${company}%')
		   </if>
		   <if test="type != null and type != ''">
		   <if test="type == 1">
		   AND	Verify_Status in (2,3)
		   </if>
		   <if test="type == 2">
		   AND	Image_Status in (2,3)
		   </if>
		   <if test="type == 3">
		   
		   AND	(Verify_Status &lt;&gt; 1 OR Image_Status &lt;&gt; 1)
		   
		   </if>
		   </if>
	</sql>
	
	<select id="findAgentCountByQueryBean" parameterType="com.djb.domain.agent.AgentQueryBean" resultType="int">
		SELECT COUNT(*) <include refid="findAgentByQueryBeanRef"/>
	</select>
	
	<select id="findAgentByQueryBean" parameterType="com.djb.domain.agent.AgentQueryBean" resultMap="agentUser">
		SELECT	* FROM (	
		SELECT	detail.*,baseUser.User_Name,baseUser.Password,baseUser.Province,baseUser.City,baseUser.Account_Type,baseUser.User_Type,baseUser.Nick_Name,baseUser.Register_Ip,baseUser.User_Status,baseUser.District
			<include refid="findAgentByQueryBeanRef"/>
		) AS t
		ORDER BY <if test="creditPointOrder!=null">${creditPointOrder} ,</if> t.Fee_Status DESC,t.create_time DESC
		LIMIT ${startIndex}, ${pageSize}
	</select>

 <select id="getTotalFenhongUser" resultType="int">
  SELECT count(1)
  FROM Du_Agent_Detail
  WHERE delete_flag = 0
  and Is_Join_Fenhong = 1
  and Company is not null
  and Rmd_Status = 0
 </select>

 <select id="getLatestJoinUser" resultMap="agentUser">
  SELECT *
  FROM Du_Agent_Detail
  WHERE delete_flag = 0
  and Is_Join_Fenhong = 1
  and Rmd_Status = 0
  and Company is not null
  ORDER BY id DESC
  LIMIT 24
 </select>
 <update id="logicDelete" parameterType="long">
  UPDATE Du_Agent_Detail
  SET delete_flag = 1
  WHERE id = #{id}
 </update>

 <select id="getCountByIp" parameterType="com.djb.domain.pro.AgentUserQueryBean"
  resultType="int">
  SELECT COUNT(*)
  FROM Du_User
  WHERE Register_Ip=#{registerIp}
  AND Create_Time &gt;= #{startDate}
  AND Create_Time &lt; #{endDate}
 </select>

 <select id="findPaidAgentByQueryBean" parameterType="com.djb.domain.agent.AgentQueryBean"
  resultType="int">
  SELECT COUNT(1)
  FROM Du_Agent_Detail detail
  LEFT JOIN Du_User baseUser ON detail.Id = baseUser.Id
  LEFT JOIN Sm_Company cmp ON detail.Company = cmp.Id
  WHERE detail.Delete_Flag = 0
  AND baseUser.Delete_Flag = 0
  AND detail.Fee_Status = 1
  AND cmp.Delete_Flag = 0
  <if test="regStartTime != null">
   AND detail.create_time >= #{regStartTime}
  </if>
  <if test="regEndTime != null">
   AND detail.create_time &lt; #{regEndTime}
  </if>
  <if test="emp != null">
   AND detail.Sale_Manager = #{emp.id}
  </if>
  <if test="verifyStatus != null">
   <if test="verifyStatus == 1">
    AND detail.Mobile_Phone_Status = 0
   </if>
   <if test="verifyStatus == 2">
    AND detail.Mobile_Phone_Status = 1
   </if>
   <if test="verifyStatus == 3">
    AND detail.Verify_Status = 4
   </if>
   <if test="verifyStatus == 4">
    AND detail.Verify_Status in (1,3)
   </if>
  </if>
  <if test="payStatus != null">
   <if test="payStatus == 1">
    AND EXISTS(
    SELECT 1
    FROM Sm_Order
    WHERE status = 1
    and delete_flag = 0
    and user_id = detail.id
    )
   </if>
   <if test="payStatus == 2">
    AND NOT EXISTS(
    SELECT 1
    FROM Sm_Order
    WHERE status = 1
    and delete_flag = 0
    and user_id = detail.id
    )
   </if>
  </if>
  <if test="dispatchStatus != null">
   <if test="dispatchStatus == 1">
    AND detail.Sale_Manager is not null
   </if>
   <if test="dispatchStatus == 2">
    AND detail.Sale_Manager is null
   </if>
  </if>
  <if test="province != null and province != ''">
   AND baseUser.Province = #{province.id}
  </if>
  <if test="city != null and city != ''">
   AND baseUser.City = #{city.id}
  </if>
  <if test="district != null and district != ''">
   AND baseUser.District = #{district.id}
  </if>
  <if test="feeStatus != null and feeStatus != ''">
   AND detail.Fee_Status = #{feeStatus}
  </if>
  <if test="userName != null and userName != ''">
   AND detail.True_Name = #{userName}
  </if>
  <if test="mobileNo != null and mobileNo != ''">
   AND detail.Mobilephone = #{mobileNo}
  </if>
  <if test="isArchive != null">
   AND detail.Is_Archive = #{isArchive}
  </if>
  <if test="company != null and company != ''">
   AND (cmp.Company_Name like '%${company}%' OR cmp.Company_Nick_Name like
   '%${company}%')
  </if>
  <if test="type != null and type != ''">
   <if test="type == 1">
    AND Verify_Status = 3
   </if>
   <if test="type == 2">
    AND Image_Status = 3
   </if>
   <if test="type == 3">

    AND (Verify_Status &lt;&gt; 1 OR Image_Status &lt;&gt; 1)

   </if>
  </if>
 </select>

 <select id="findAllByAgentUser" resultMap="agentUser" parameterType="com.djb.domain.user.AgentUser">
		select *
		  from	Du_Agent_Detail 
		  <where>
		  		delete_flag = 0
		  		and callno_400 is null
		  		<if test="feeStatus != null">
		  			and Fee_Status = #{feeStatus} 
		  		</if>
		  </where>
 </select>

 <select id="findAll" resultMap="agentUser">
  SELECT *
  FROM Du_Agent_Detail
  WHERE delete_flag = 0
 </select>

 <update id="updateWpStatus" parameterType="com.djb.domain.user.AgentUser">
  UPDATE Du_Agent_Detail
  SET
  Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime}
  <if test="wpStatus != null">,
   Wp_Status=#{wpStatus}
  </if>
  WHERE id=#{id}
 </update>
 <update id="updateRecommondNum" parameterType="com.djb.domain.user.AgentUser">
  UPDATE
  Du_Agent_Detail
  SET
  Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime}
  ,Recommond_Num=Recommond_Num+1
  WHERE id=#{id}
 </update>
 <update id="updateCreditPoint" parameterType="com.djb.domain.user.AgentUser">
  UPDATE
  Du_Agent_Detail
  SET
  Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime}
  ,Credit_Point=#{creditPoint}
  WHERE id=#{id}
 </update>

 <select id="findNewIdAgent" parameterType="map" resultMap="agentUser">
  SELECT du.id
  FROM Du_Agent_Detail detail
  LEFT JOIN Du_User du on detail.Id = du.Id
  WHERE du.Delete_Flag = 0
  and detail.Delete_Flag = 0
  and detail.Fee_Status = 1
  and detail.Verify_Status = 1
  and detail.Image_Status = 1
  ORDER BY rand()
  LIMIT ${size}
 </select>

 <select id="findByLikeName" parameterType="com.djb.domain.agent.AgentQueryBean"
  resultMap="agentUser">
  SELECT detail.*
  FROM Du_Agent_Detail detail
  LEFT JOIN Du_User du on detail.Id = du.Id
  WHERE du.Delete_Flag = 0
  and detail.Delete_Flag = 0
  and detail.Fee_Status = 1
  and detail.Verify_Status = 1
  and detail.Image_Status = 1
  <if test="userName!=null">
   and detail.True_Name like concat('%',#{userName},'%')
  </if>
 </select>
 
 <!-- 验证400电话在代理人是否存在 -->
<select id="checkCallNo400Exists" parameterType="java.lang.String" resultType="java.lang.Long">
		select COUNT(*) from Du_Agent_Detail ad where ad.callno_400=#{callNo400,jdbcType=VARCHAR}
</select>
</mapper>
==================================== END user/AgentUser.xml =========================


==================================== BEGIN user/Invite.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="Invite">

 <resultMap id="invite" type="com.djb.domain.user.Invite"
  extends="DomainObject.domainObject">
  <result property="regUserId" column="Reg_User_Id" />
  <result property="inviteUserId" column="Invite_User_Id" />
  <result property="regTime" column="Reg_Time" />
  <result property="consumeTime" column="Consume_Time" />
  <result property="amount" column="Amount" />
  <result property="consumeAmount" column="Consume_Amount" />
  <result property="status" column="Status" />
 </resultMap>

 <select id="load" resultMap="invite">
  SELECT *
  FROM Du_Invite
  WHERE id = #{id}
  AND delete_flag='0'
 </select>

 <select id="findByRegUser" resultMap="invite" parameterType="long">
  SELECT *
  FROM Du_Invite
  WHERE Reg_User_Id = #{agentId}
  AND delete_flag='0'
 </select>

 <sql id="findPageDataRef">
  FROM Du_Invite
  WHERE delete_flag = 0
  <if test="null != inviteUserId">
   AND Invite_User_Id = #{inviteUserId}
  </if>
  <if test="null != status">
   AND status = #{status}
  </if>
  <if test="1 == type">
   <if test="null != startTime">
    AND Consume_Time >= #{startTime}
   </if>
   <if test="null != endTime">
    AND Consume_Time &lt;= #{endTime}
   </if>
  </if>
  <if test="2 == type">
   <if test="null != startTime">
    AND Reg_Time >= #{startTime}
   </if>
   <if test="null != endTime">
    AND Reg_Time &lt;= #{endTime}
   </if>
  </if>
 </sql>

 <select id="getTotalNum" resultType="int"
  parameterType="com.djb.domain.user.InviteQueryBean">
  SELECT count(*)
  <include refid="findPageDataRef" />
 </select>

 <select id="findPageData" resultMap="invite"
  parameterType="com.djb.domain.user.InviteQueryBean">
  SELECT *
  <include refid="findPageDataRef" />
  ORDER BY create_time DESC
  LIMIT ${startIndex}, ${pageSize}
 </select>

 <select id="getConsumeCount" resultType="int"
  parameterType="com.djb.domain.user.InviteQueryBean">
  SELECT count(1)
  FROM Du_Invite
  WHERE delete_flag = 0
  AND Consume_Time is not null
  <if test="null != inviteUserId">
   AND Invite_User_Id = #{inviteUserId}
  </if>
  <if test="null != status">
   AND status = #{status}
  </if>
  <if test="1 == type">
   <if test="null != startTime">
    AND Consume_Time >= #{startTime}
   </if>
   <if test="null != endTime">
    AND Consume_Time &lt;= #{endTime}
   </if>
  </if>
  <if test="2 == type">
   <if test="null != startTime">
    AND Reg_Time >= #{startTime}
   </if>
   <if test="null != endTime">
    AND Reg_Time &lt;= #{endTime}
   </if>
  </if>
 </select>

 <select id="getTotal" resultType="int"
  parameterType="com.djb.domain.user.InviteQueryBean">
  SELECT sum(Amount)
  FROM Du_Invite
  WHERE delete_flag = 0
  <if test="null != inviteUserId">
   AND Invite_User_Id = #{inviteUserId}
  </if>
  <if test="null != status">
   AND status = #{status}
  </if>
  <if test="1 == type">
   <if test="null != startTime">
    AND Consume_Time >= #{startTime}
   </if>
   <if test="null != endTime">
    AND Consume_Time &lt;= #{endTime}
   </if>
  </if>
  <if test="2 == type">
   <if test="null != startTime">
    AND Reg_Time >= #{startTime}
   </if>
   <if test="null != endTime">
    AND Reg_Time &lt;= #{endTime}
   </if>
  </if>
 </select>

 <select id="getIssued" resultType="int"
  parameterType="com.djb.domain.user.InviteQueryBean">
  SELECT sum(Amount)
  FROM Du_Invite
  WHERE delete_flag = 0
  AND status = 3
  <if test="null != inviteUserId">
   AND Invite_User_Id = #{inviteUserId}
  </if>
  <if test="null != status">
   AND status = #{status}
  </if>
  <if test="1 == type">
   <if test="null != startTime">
    AND Consume_Time >= #{startTime}
   </if>
   <if test="null != endTime">
    AND Consume_Time &lt;= #{endTime}
   </if>
  </if>
  <if test="2 == type">
   <if test="null != startTime">
    AND Reg_Time >= #{startTime}
   </if>
   <if test="null != endTime">
    AND Reg_Time &lt;= #{endTime}
   </if>
  </if>
 </select>

 <select id="getUnissued" resultType="int"
  parameterType="com.djb.domain.user.InviteQueryBean">
  SELECT sum(Amount)
  FROM Du_Invite
  WHERE delete_flag = 0
  AND status = 2
  <if test="null != inviteUserId">
   AND Invite_User_Id = #{inviteUserId}
  </if>
  <if test="null != status">
   AND status = #{status}
  </if>
  <if test="1 == type">
   <if test="null != startTime">
    AND Consume_Time >= #{startTime}
   </if>
   <if test="null != endTime">
    AND Consume_Time &lt;= #{endTime}
   </if>
  </if>
  <if test="2 == type">
   <if test="null != startTime">
    AND Reg_Time >= #{startTime}
   </if>
   <if test="null != endTime">
    AND Reg_Time &lt;= #{endTime}
   </if>
  </if>
 </select>

 <select id="findSettlementList" resultMap="invite">
  SELECT *
  FROM Du_Invite
  WHERE delete_flag=0
  AND status = 2
  AND Update_Time &lt; date_add(now(), interval -15 day)
 </select>

 <update id="update" parameterType="com.djb.domain.user.Invite">
  UPDATE Du_Invite
  SET
  Reg_User_Id=#{regUserId}
  ,Invite_User_Id=#{inviteUserId}
  ,Reg_Time=#{regTime}
  ,Consume_Time=#{consumeTime}
  ,Amount=#{amount}
  ,Consume_Amount=#{consumeAmount}
  ,Status=#{status}
  ,Delete_Flag=#{deleteFlag}
  ,Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime}
  WHERE id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.user.Invite">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO Du_Invite(
  Reg_User_Id
  ,Invite_User_Id
  ,Reg_Time
  ,Consume_Time
  ,Amount
  ,Consume_Amount
  ,Status
  ,Delete_Flag
  ,Create_User_Id
  ,Create_Time
  ,Update_User_Id
  ,Update_Time
  )
  VALUES(
  #{regUserId}
  ,#{inviteUserId}
  ,#{regTime}
  ,#{consumeTime}
  ,#{amount}
  ,#{consumeAmount}
  ,#{status}
  ,#{deleteFlag}
  ,#{createUserId}
  ,#{createDateTime}
  ,#{updateUserId}
  ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey">
  DELETE FROM Du_Invite
  WHERE id = #{id}
 </delete>
</mapper>
==================================== END user/Invite.xml =========================


==================================== BEGIN app/AppDeveloper.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="AppDeveloper">

 <resultMap id="appDeveloper" type="com.djb.domain.app.AppDeveloper"
  extends="DomainObject.domainObject">
  <result property="name" column="Name" />
  <result property="nickName" column="Nick_Name" />
  <result property="homePage" column="Home_Page" />
  <result property="description" column="Description" />
  <result property="orderId" column="Order_Id" />
 </resultMap>

 <select id="load" resultMap="appDeveloper">
  SELECT *
  FROM Dp_App_Developer
  WHERE id = #{id}
  AND delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.app.AppDeveloper">
  UPDATE Dp_App_Developer
  SET
  Name=#{name}
  ,Nick_Name=#{nickName}
  ,Home_Page=#{homePage}
  ,Description=#{description}
  ,Order_Id=#{orderId}
  ,Delete_Flag=#{deleteFlag}
  ,Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime}
  WHERE id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.app.AppDeveloper">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO Dp_App_Developer(
  Name
  ,Nick_Name
  ,Home_Page
  ,Description
  ,Order_Id
  ,Delete_Flag
  ,Create_User_Id
  ,Create_Time
  ,Update_User_Id
  ,Update_Time
  )
  VALUES(
  #{name}
  ,#{nickName}
  ,#{homePage}
  ,#{description}
  ,#{orderId}
  ,#{deleteFlag}
  ,#{createUserId}
  ,#{createDateTime}
  ,#{updateUserId}
  ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey">
  DELETE FROM Dp_App_Developer
  WHERE id = #{id}
 </delete>

 <sql id="finDeveloperListRef">
  FROM Dp_App_Developer developer
  WHERE delete_flag=0
  <if test="name != null and name != ''">AND
   developer.name like concat('%',#{name},'%')
  </if>
  <if test="id != null">AND
   developer.id = #{id}
  </if>
  <if test="homePage != null">AND
   developer.homePage like concat('%',#{homePage},'%')
  </if>
 </sql>

 <!-- 根据queryBean查找类别的数量 -->
 <select id="getCountByQueryBean" parameterType="com.djb.domain.app.DeveloperQueryBean"
  resultType="int">
  SELECT count(*)
  <include refid="finDeveloperListRef" />
 </select>

 <!-- 根据queryBean查找所有符合条件的类别 -->
 <select id="finDeveloperList" parameterType="com.djb.domain.app.DeveloperQueryBean"
  resultMap="appDeveloper">
  SELECT developer.*
  <include refid="finDeveloperListRef" />
  <if test="orderByProperties != null">
   ORDER BY ${orderByFiled}
  </if>
  <if test="orderByProperties == null">
   ORDER BY developer.Order_Id,developer.create_time DESC
  </if>
  LIMIT ${startIndex}, ${pageSize}
 </select>
</mapper>
==================================== END app/AppDeveloper.xml =========================


==================================== BEGIN app/AppProduct.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="AppProduct">

 <resultMap id="appProduct" type="com.djb.domain.app.AppProduct"
  extends="DomainObject.domainObject">
  <result property="name" column="Name" />
  <result property="logo" column="Logo" />
  <result property="categorys" column="Categorys" />
  <result property="appDevId" column="App_Dev_Id" />
  <result property="description" column="Description" />
  <result property="images" column="Images" />
  <result property="feeType" column="Fee_Type" />
  <result property="unit" column="Unit" />
  <result property="unitFee" column="Unit_Fee" />
  <result property="buyText" column="Buy_Text" />
  <result property="insourcing" column="Insourcing" />
  <result property="helpPage" column="Help_Page" />
  <result property="afterSalePage" column="After_Sale_Page" />
  <result property="orderId" column="Order_Id" />
  <result property="recommend" column="Recommend" />
  <result property="status" column="Status" />
  <result property="packageType" column="Package_Type" />
  <result property="packageId" column="Package_Id" />
  <result property="buyCounts" column="Buy_Counts" />
  <result property="durationUnit" column="Duration_Unit" />
  <result property="quantityUnit" column="Quantity_Unit" />
 </resultMap>

 <select id="load" resultMap="appProduct">
  SELECT *
  FROM Dp_App_Product
  WHERE id = #{id}
  AND delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.app.AppProduct">
  UPDATE Dp_App_Product
  SET
  Name=#{name}
  ,Logo=#{logo}
  ,Categorys=#{categorys}
  ,App_Dev_Id=#{appDevId}
  ,Description=#{description}
  ,Images=#{images}
  ,Fee_Type=#{feeType}
  ,Unit=#{unit}
  ,Duration_Unit=#{durationUnit}
  ,Quantity_Unit=#{quantityUnit}
  ,Unit_Fee=#{unitFee}
  ,Buy_Text=#{buyText}
  ,Insourcing=#{insourcing}
  ,Help_Page=#{helpPage}
  ,After_Sale_Page=#{afterSalePage}
  ,Order_Id=#{orderId}
  ,Recommend=#{recommend}
  ,Status=#{status}
  <if test="doBuy">
   ,Buy_Counts=Buy_Counts+1
  </if>
  ,Delete_Flag=#{deleteFlag}
  ,Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime}
  WHERE id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.app.AppProduct">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO Dp_App_Product(
  Name
  ,Logo
  ,Categorys
  ,App_Dev_Id
  ,Description
  ,Images
  ,Fee_Type
  ,Unit
  ,Duration_Unit
  ,Quantity_Unit
  ,Unit_Fee
  ,Buy_Text
  ,Insourcing
  ,Help_Page
  ,After_Sale_Page
  ,Order_Id
  ,Recommend
  ,Status
  ,Package_Type
  ,Package_Id
  ,Delete_Flag
  ,Create_User_Id
  ,Create_Time
  ,Update_User_Id
  ,Update_Time
  )
  VALUES(
  #{name}
  ,#{logo}
  ,#{categorys}
  ,#{appDevId}
  ,#{description}
  ,#{images}
  ,#{feeType}
  ,#{unit}
  ,#{durationUnit}
  ,#{quantityUnit}
  ,#{unitFee}
  ,#{buyText}
  ,#{insourcing}
  ,#{helpPage}
  ,#{afterSalePage}
  ,#{orderId}
  ,#{recommend}
  ,#{status}
  ,#{packageType}
  ,#{packageId}
  ,#{deleteFlag}
  ,#{createUserId}
  ,#{createDateTime}
  ,#{updateUserId}
  ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey">
  DELETE FROM Dp_App_Product
  WHERE id = #{id}
 </delete>

 <sql id="findProductListRef">
  FROM Dp_App_Product product
  WHERE Delete_flag = '0'
  <if test="productName != null and productName != ''">AND
   product.name like concat('%', #{productName},'%')
  </if>
  <if test="id != null">AND
   product.name = #{id}
  </if>
  <if test="status != null">AND
   product.status = #{status}
  </if>
  <if test="categoryId != null">AND
   (Categorys like '%,${categoryId},%' OR Categorys like '${categoryId},%')
  </if>
  <if test="developerId != null">AND
   product.App_Dev_Id = #{developerId}
  </if>
  <if test="packageType != null">AND
   product.Package_Type = #{packageType}
  </if>
  <if test="packageId != null">AND
   product.Package_Id = #{packageId}
  </if>
 </sql>

 <!-- 根据queryBean查找类别的数量 -->
 <select id="getCountByQueryBean" parameterType="com.djb.domain.app.AppProductQueryBean"
  resultType="int">
  SELECT count(*)
  <include refid="findProductListRef" />
 </select>

 <!-- 根据queryBean查找所有符合条件的类别 -->
 <select id="findProductList" parameterType="com.djb.domain.app.AppProductQueryBean"
  resultMap="appProduct">
  SELECT *
  <include refid="findProductListRef" />
  <if test="orderByProperties != null">
   ORDER BY ${orderByFiled}
  </if>
  <if test="orderByProperties == null">
   ORDER BY product.Order_Id,product.update_time DESC
  </if>
  LIMIT ${startIndex}, ${pageSize}
 </select>
</mapper>
==================================== END app/AppProduct.xml =========================


==================================== BEGIN app/AppProductSale.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="AppProductSale" >

 <resultMap id="appProductSale" type="com.djb.domain.app.AppProductSale" extends="DomainObject.domainObject" >
  <result property="appProductId" column="App_Product_Id" />
  <result property="saleType" column="Sale_Type" />
  <result property="saleMonths" column="Sale_Months" />
  <result property="saleNums" column="Sale_Nums" />
 </resultMap>

 <select id="load" resultMap="appProductSale" >
  SELECT  *
    FROM  Dp_App_Product_Sale
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.app.AppProductSale" >
  UPDATE  Dp_App_Product_Sale
     SET  
   App_Product_Id=#{appProductId}
   ,Sale_Type=#{saleType}
   ,Sale_Months=#{saleMonths}
   ,Sale_Nums=#{saleNums}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   WHERE  id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.app.AppProductSale" >
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Dp_App_Product_Sale(
   App_Product_Id
   ,Sale_Type
   ,Sale_Months
   ,Sale_Nums
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{appProductId}
   ,#{saleType}
   ,#{saleMonths}
   ,#{saleNums}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey" >
  DELETE FROM  Dp_App_Product_Sale
        WHERE  id = #{id}
 </delete>
 
 <update id="deleteByProductId" >
  UPDATE Dp_App_Product_Sale
     SET Delete_Flag = 1
        WHERE  App_Product_Id = #{productId}
 </update>
 
 <select id="findProductSales" resultMap="appProductSale">
  SELECT * 
    FROM Dp_App_Product_Sale
   WHERE Delete_Flag = 0
     AND App_Product_Id = #{productId}
     <if test="buyMonths != null">
     AND Sale_Months &lt;= #{buyMonths}
     </if>
   ORDER BY Sale_Months DESC,Sale_Nums DESC
 </select>
</mapper>
==================================== END app/AppProductSale.xml =========================


==================================== BEGIN app/AppProductSaleNumber.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="AppProductSaleNumber" >

 <resultMap id="appProductSaleNumber" type="com.djb.domain.app.AppProductSaleNumber" extends="DomainObject.domainObject" >
  <result property="appProductId" column="App_Product_Id" />
  <result property="proNumber" column="Pro_Number" />
  <result property="proPrice" column="Pro_Price" />  
 </resultMap>

 <select id="load" resultMap="appProductSaleNumber" >
  SELECT  *
    FROM  Dp_App_Pro_Num_Price
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.app.AppProductSaleNumber" >
  UPDATE  Dp_App_Pro_Num_Price
     SET  
   App_Product_Id=#{appProductId}
   ,Pro_Number=#{proNumber}
   ,Pro_Price=#{proPrice}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   WHERE  id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.app.AppProductSaleNumber" >
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Dp_App_Pro_Num_Price(
   App_Product_Id
   ,Pro_Number
   ,Pro_Price
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{appProductId}
   ,#{proNumber}
   ,#{proPrice}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey" >
  DELETE FROM  Dp_App_Pro_Num_Price
        WHERE  id = #{id}
 </delete>
 
 
 <select id="findProductNumber" resultMap="appProductSaleNumber">
  SELECT * 
    FROM Dp_App_Pro_Num_Price
   WHERE Delete_Flag = 0
     AND App_Product_Id = #{appProductId}    
 </select>
 
 <update id="deleteByProductId" >
  UPDATE Dp_App_Pro_Num_Price
     SET Delete_Flag = 1
        WHERE  App_Product_Id = #{productId}
 </update> 
 
 <select id="findProductNumbers" resultMap="appProductSaleNumber">
  SELECT * 
    FROM Dp_App_Pro_Num_Price
   WHERE Delete_Flag = 0
     AND App_Product_Id = #{appProductId} 
     AND Pro_Number=#{proNumber}   
 </select>

 
</mapper>
==================================== END app/AppProductSaleNumber.xml =========================


==================================== BEGIN app/AppProductVer.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="AppProductVer" >

 <resultMap id="appProductVer" type="com.djb.domain.app.AppProductVer" extends="DomainObject.domainObject" >
  <result property="appProductId" column="App_Product_Id" />
  <result property="version" column="Version" />
  <result property="title" column="Title" />
  <result property="updateContent" column="Update_Content" />
 </resultMap>

 <select id="load" resultMap="appProductVer" >
  SELECT  *
    FROM  Dp_App_Product_Ver
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.app.AppProductVer" >
  UPDATE  Dp_App_Product_Ver
     SET  
   App_Product_Id=#{appProductId}
   ,Version=#{version}
   ,Title=#{title}
   ,Update_Content=#{updateContent}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   WHERE  id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.app.AppProductVer" >
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Dp_App_Product_Ver(
   App_Product_Id
   ,Version
   ,Title
   ,Update_Content
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{appProductId}
   ,#{version}
   ,#{title}
   ,#{updateContent}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey" >
  DELETE FROM  Dp_App_Product_Ver
        WHERE  id = #{id}
 </delete>
 
 <select id="findProductVers" resultMap="appProductVer">
  SELECT * 
    FROM Dp_App_Product_Ver
   WHERE Delete_Flag = 0
     AND App_Product_Id = #{productId}
   ORDER BY Id DESC
 </select>
</mapper>
==================================== END app/AppProductVer.xml =========================


==================================== BEGIN app/AppProductAgent.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="AppProductAgent">

 <resultMap id="appProductAgent" type="com.djb.domain.app.AppProductAgent"
  extends="DomainObject.domainObject">
  <result property="appProductId" column="App_Product_Id" />
  <result property="userId" column="User_Id" />
  <result property="validTime" column="Valid_Time" />
  <result property="orderItemId" column="Order_Item_Id" />
 </resultMap>

 <select id="load" resultMap="appProductAgent">
  SELECT *
  FROM Dp_Agent_App_Product
  WHERE id = #{id}
  AND delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.app.AppProductAgent">
  UPDATE Dp_Agent_App_Product
  SET
  App_Product_Id=#{appProductId}
  ,User_Id=#{userId}
  ,Valid_Time=#{validTime}
  ,Order_Item_Id=#{orderItemId}
  ,Delete_Flag=#{deleteFlag}
  ,Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime}
  WHERE id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.app.AppProductAgent">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO Dp_Agent_App_Product(
  App_Product_Id
  ,User_Id
  ,Valid_Time
  ,Order_Item_Id
  ,Delete_Flag
  ,Create_User_Id
  ,Create_Time
  ,Update_User_Id
  ,Update_Time
  )
  VALUES(
  #{appProductId}
  ,#{userId}
  ,#{validTime}
  ,#{orderItemId}
  ,#{deleteFlag}
  ,#{createUserId}
  ,#{createDateTime}
  ,#{updateUserId}
  ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey">
  DELETE FROM Dp_Agent_App_Product
  WHERE id = #{id}
 </delete>

 <sql id="findProductAgentListRef">
  FROM Dp_Agent_App_Product productAgent
  WHERE Delete_flag = '0'
  <if test="userId != null">AND
   User_Id = #{userId}
  </if>
  <if test="productId != null">AND
   App_Product_Id = #{productId}
  </if>
 </sql>

 <select id="findProductAgentList" parameterType="com.djb.domain.app.ProductAgentQueryBean"
  resultMap="appProductAgent">
  SELECT *
  <include refid="findProductAgentListRef" />
  <if test="orderByProperties != null">
   ORDER BY ${orderByFiled}
  </if>
  <if test="orderByProperties == null">
   ORDER BY productAgent.update_time DESC
  </if>
  LIMIT ${startIndex}, ${pageSize}
 </select>

 <select id="getCountByQueryBean" parameterType="com.djb.domain.app.ProductAgentQueryBean"
  resultType="int">
  SELECT count(*)
  <include refid="findProductAgentListRef" />
 </select>

 <select id="getCountByAgentAppProduct" parameterType="com.djb.domain.user.AgentUser"
  resultType="int">
  SELECT count(*)
  FROM Dp_Agent_App_Product app_Product,Sm_Order_Item order_Item
  WHERE app_Product.Order_Item_Id=order_Item.id
  and app_Product.user_id = #{id}
  and order_Item.Item_Id=13
  and order_Item.Item_Type=6
 </select>

</mapper>
==================================== END app/AppProductAgent.xml =========================


==================================== BEGIN app/AppStoreSlide.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="AppStoreSlide" >

 <resultMap id="appStoreSlide" type="com.djb.domain.app.AppStoreSlide" extends="DomainObject.domainObject" >
  <result property="imagePath" column="Image_Path" />
  <result property="imageLink" column="Image_Link" />
  <result property="openType" column="Open_Type" />
  <result property="orderNo" column="Order_No" />
 </resultMap>

 <select id="load" resultMap="appStoreSlide" >
  SELECT  *
    FROM  Dp_App_Store_Slide
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.app.AppStoreSlide" >
  UPDATE  Dp_App_Store_Slide
     SET  
   Image_Link=#{imageLink}
   <if test="imagePath!=null">
      ,Image_Path=#{imagePath}
     </if>
   ,Open_Type=#{openType}
   ,Order_No=#{orderNo}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   WHERE  id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.app.AppStoreSlide" >
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Dp_App_Store_Slide(
   Image_Path
   ,Image_Link
   ,Open_Type
   ,Order_No
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{imagePath}
   ,#{imageLink}
   ,#{openType}
   ,#{orderNo}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey" >
  DELETE FROM  Dp_App_Store_Slide
        WHERE  id = #{id}
 </delete>
 
 <select id="selectByOrderNo" parameterType="int" resultMap="appStoreSlide">
  SELECT *
    FROM  Dp_App_Store_Slide
   WHERE  Order_No = #{orderNo}
     AND  delete_flag='0'
     LIMIT 1
 </select>
 
 <select id="findAllAppStoreSlide" resultMap="appStoreSlide">
  SELECT  *
    FROM  Dp_App_Store_Slide
   WHERE   delete_flag='0'
 
 </select>
</mapper>
==================================== END app/AppStoreSlide.xml =========================


==================================== BEGIN DomainObject.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:27:20 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="DomainObject">

  <resultMap id="domainObject" type="com.djb.domain.DomainObject">
   <result property="id" column="id"/>  
   <result property="createUserId" column="create_user_id"/>
   <result property="createDateTime" column="create_time"/>
   <result property="updateUserId" column="update_user_id"/>
   <result property="updateDateTime" column="update_time"/>
   <result property="deleteFlag" column="delete_flag"/>
  </resultMap>
  
  <parameterMap id="sequenceMap" type="map">
    <parameter property="sequenceTable" jdbcType="VARCHAR" javaType="java.lang.String" mode="IN"/>
    <parameter property="result" jdbcType="BIGINT" javaType="java.lang.Long" mode="OUT"/>
 </parameterMap> 
 
</mapper>
==================================== END DomainObject.xml =========================


==================================== BEGIN callcenter/CallDetailRecord.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="CallDetailRecord" >

 <resultMap id="callDetailRecord" type="com.djb.domain.callcenter.CallDetailRecord" extends="DomainObject.domainObject" >
  <result property="cdrId" column="CdrId" />
  <result property="caller" column="Caller" />
  <result property="called" column="Called" />
  <result property="shopCode" column="Shop_Code" />
  <result property="type" column="Type" />
  <result property="callDirect" column="Call_Direct" />
  <result property="answerTime" column="Answer_Time" />
  <result property="startTime" column="Start_Time" />
  <result property="endTime" column="End_Time" />
  <result property="bridgeTime" column="Bridge_Time" />
  <result property="duration" column="Duration" />
  <result property="billableSeconds" column="Billable_Seconds" />
  <result property="uniqueId" column="Unique_Id" />
  <result property="uuid" column="Uuid" />
 </resultMap>

 <select id="load" resultMap="callDetailRecord" >
  SELECT  *
    FROM  Dp_Call_Detail_Record
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>
 
 <sql id="findByCallDetailRef">
  FROM  Dp_Call_Detail_Record
    WHERE delete_flag='0'
    <if test="phoneType != null">
       <if test="phoneType == 1">
          <if test="phone != null">
            AND Caller=#{phone}
          </if>
       </if>
       <if test="phoneType == 2">
        <if test="phone != null">
          AND Called=#{phone}
        </if>
       </if>
    </if>
    <if test="startTime != null">
    AND Start_Time &gt; #{startTime}
    </if>
    <if test="endTime != null">
    AND End_Time &lt; #{endTime}
    </if>
 </sql>
 
 <select id="findByCallDetail" parameterType="com.djb.domain.callcenter.CallDetailQueryBean" resultMap="callDetailRecord">
     SELECT  * <include refid="findByCallDetailRef"/>
     ORDER BY Create_Time desc
     LIMIT ${startIndex}, ${pageSize}  
 </select>
 
 <select id="exportCallDetailRecord" parameterType="com.djb.domain.callcenter.CallDetailQueryBean" resultMap="callDetailRecord">
    SELECT *
    FROM  Dp_Call_Detail_Record
    WHERE delete_flag='0'
    <if test="phoneType != null">
       <if test="phoneType == 1">
          <if test="phone != null">
            AND Caller=#{phone}
          </if>
       </if>
       <if test="phoneType == 2">
        <if test="phone != null">
          AND Called=#{phone}
        </if>
       </if>
    </if>
    <if test="startTime != null">
    AND Start_Time &gt; #{startTime}
    </if>
    <if test="endTime != null">
    AND End_Time &lt; #{endTime}
    </if>
 </select>
 
 
 
 <select id="countByCallDetail" parameterType="com.djb.domain.callcenter.CallDetailQueryBean" resultType="int">
   SELECT count(*) <include refid="findByCallDetailRef"/>
 </select>
 

 <update id="update" parameterType="com.djb.domain.callcenter.CallDetailRecord" >
  UPDATE  Dp_Call_Detail_Record
     SET  
   CdrId=#{cdrId}
   ,Caller=#{caller}
   ,Called=#{called}
   ,Shop_Code=#{shopCode}
   ,Type=#{type}
   ,Call_Direct=#{callDirect}
   ,Answer_Time=#{answerTime}
   ,Start_Time=#{startTime}
   ,End_Time=#{endTime}
   ,Bridge_Time=#{bridgeTime}
   ,Duration=#{duration}
   ,Billable_Seconds=#{billableSeconds}
   ,Unique_Id=#{uniqueId}
   ,Uuid=#{uuid}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   WHERE  id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.callcenter.CallDetailRecord" >
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Dp_Call_Detail_Record(
   CdrId
   ,Caller
   ,Called
   ,Shop_Code
   ,Type
   ,Call_Direct
   ,Answer_Time
   ,Start_Time
   ,End_Time
   ,Bridge_Time
   ,Duration
   ,Billable_Seconds
   ,Unique_Id
   ,Uuid
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{cdrId}
   ,#{caller}
   ,#{called}
   ,#{shopCode}
   ,#{type}
   ,#{callDirect}
   ,#{answerTime}
   ,#{startTime}
   ,#{endTime}
   ,#{bridgeTime}
   ,#{duration}
   ,#{billableSeconds}
   ,#{uniqueId}
   ,#{uuid}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey" >
  DELETE FROM  Dp_Call_Detail_Record
        WHERE  id = #{id}
 </delete>
</mapper>
==================================== END callcenter/CallDetailRecord.xml =========================


==================================== BEGIN qa/QARecommend.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:11:59 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="QARecommend">

 <cache type="com.djb.cache.MemcachedCache">
  <property name="timeout" value="7200"/>
 </cache>
 
 <resultMap id="qARecommend" type="com.djb.domain.qa.QARecommend" extends="DomainObject.domainObject">
  <result property="referenceId" column="Reference_Id"/>
  <result property="link" column="link"/>
  <result property="title" column="title"/>
  <result property="type" column="type"/>
 </resultMap>

 <select id="load" resultMap="qARecommend">
  SELECT *
   FROM Sm_Qa_Recommend
   WHERE id = #{id} 
    AND delete_flag = '0'
 </select>
 
 <select id="findByType" resultMap="qARecommend">
  SELECT *
   FROM Sm_Qa_Recommend
   WHERE type = #{type}
    AND delete_flag='0'
 </select>
 
 
 <insert id="insert" parameterType="com.djb.domain.qa.QARecommend">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO 
   Sm_Qa_Recommend(
    reference_id,
    link, 
    title, 
    type,
    create_user_id, 
    create_time, 
    update_user_id, 
    update_time,
    delete_flag
   )
  VALUES(
   #{relationTip.id}, 
   #{link}, 
   #{title}, 
   #{type},
   #{createUserId},
   #{createDateTime},
   #{updateUserId},
   #{updateDateTime},
   #{deleteFlag}
  )
  
  
  </insert>
  
  <update id="update" parameterType="com.djb.domain.qa.QARecommend">
  UPDATE
   Sm_Qa_Recommend
  SET
   reference_id = #{relationTip.id},
   link = #{link},
   title = #{title},
   type = #{type},
   update_time = #{updateDateTime},
   update_user_id = #{updateUserId},
   delete_flag = #{deleteFlag}
  WHERE
   id = #{id}
 </update>

</mapper>
==================================== END qa/QARecommend.xml =========================


==================================== BEGIN qa/Question.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:12:00 
	CST 2013 -->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="Question">

	<cache type="com.djb.cache.MemcachedCache">
		<property name="timeout" value="3600" />
		<property name="disFlushQuery"
			value="findRelationQuestions,findArticleRelatedQuestion,findCmsRelatedQuestion" />
	</cache>
	<resultMap id="question" type="com.djb.domain.qa.Question"
		extends="DomainObject.domainObject">
		<result property="content" column="content" />
		<result property="additionDesc" column="addition_desc" />
		<result property="type" column="type" />
		<result property="referId" column="refer_id" />
		<result property="status" column="status" />
		<result property="keyword" column="key_word" />
		<result property="latestCount" column="latest_count" />
		<result property="latestAnswer" column="latest_answer" />
		<result property="latestAnswerTime" column="latest_answer_time" />
		<result property="latestAnswerUserId" column="latest_answer_user_id" />
		<result property="latestAnswerUserName" column="latest_answer_user" />
		<result property="expertSettingTime" column="expert_setting_time" />
		<result property="bestSettingTime" column="best_setting_time" />
		<result property="totalAnswerCount" column="total_answer_count" />
		<result property="solrjStatus" column="solr_indexed_status" />
		<result property="updatedAfterIndex" column="updated_after_index" />
		<result property="createUsername" column="create_username" />
		<result property="createUserIp" column="create_user_ip" />
		<result property="isAdminQuestion" column="admin_question" />
	</resultMap>

	<resultMap id="relationQuestion" type="com.djb.domain.qa.Question">
		<result property="id" column="id" />
		<result property="content" column="content" />
	</resultMap>

	<select id="load" resultMap="question">
		SELECT *
		FROM Dq_Question
		WHERE id = #{id}
		AND delete_flag='0'
	</select>

	<!-- 该方法主要用于加载全文检索同步时的问题， 如果问题是新增问题那么需要将新增问题加入到全文检索中， 如果问题被删除，那么需要将该问题从全文检索中删除， 
		如果问题的答案发生了变化，那么需要更新该全文检索 -->
	<select id="findFullTextQuestions" resultMap="question"
		useCache="false">
		SELECT *
		FROM Dq_Question
		WHERE delete_flag = #{delete_flag}
		AND solr_indexed_status = #{solrjStatus}

		<if test="updatedAfterIndex != null">
			AND updated_after_index = #{updatedAfterIndex}
		</if>
	</select>

	<update id="update" parameterType="com.djb.domain.qa.Question">
		UPDATE
		Dq_Question
		SET
		content = #{content},
		addition_desc = #{additionDesc},
		type = #{type},
		status = #{status},
		key_word = #{keyword},
		latest_count = #{latestCount},
		latest_answer = #{latestAnswer},
		latest_answer_time = #{latestAnswerTime},
		latest_answer_user = #{latestAnswerUserName},
		expert_setting_time = #{expertSettingTime}, best_setting_time = #{bestSettingTime},
		total_answer_count = #{totalAnswerCount},
		solr_indexed_status = #{solrjStatus},
		updated_after_index = #{updatedAfterIndex},
		create_username = #{createUsername},
		create_user_ip = #{createUserIp},
		update_time = #{updateDateTime},
		update_user_id = #{updateUserId},
		delete_flag = #{deleteFlag}
		<if test="isAdminQuestion != null">
			,admin_question = #{isAdminQuestion}
		</if>
		<if test="latestAnswerUserId != null">
			,latest_answer_user_id=#{latestAnswerUserId}
		</if>
		WHERE
		id = #{id}
	</update>

	<update id="solrUpdate" parameterType="com.djb.domain.qa.Question"
		flushCache="false">
		UPDATE
		Dq_Question
		SET
		solr_indexed_status = #{solrjStatus},
		updated_after_index = #{updatedAfterIndex},
		update_time = #{updateDateTime},
		update_user_id = #{updateUserId}
		WHERE
		id = #{id}
	</update>

	<update id="logicDelete" parameterType="long">
		UPDATE
		Dq_Question
		SET
		delete_flag = '1'
		WHERE
		id = #{id}
	</update>



	<insert id="insert" parameterType="com.djb.domain.qa.Question">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
		INSERT INTO
		Dq_Question(
		id,
		content,
		addition_desc,
		type,
		refer_id,
		status,
		key_word,
		latest_count,
		latest_answer,
		latest_answer_time,
		latest_answer_user,
		expert_setting_time, best_setting_time,
		total_answer_count,
		solr_indexed_status,
		updated_after_index,
		create_username,
		create_user_ip,
		create_time,
		create_user_id,
		update_time,
		update_user_id,
		delete_flag,
		latest_answer_user_id,
		admin_question
		)
		VALUES(
		#{id},
		#{content},
		#{additionDesc},
		#{type},
		#{referId},
		#{status},
		#{keyword},
		#{latestCount},
		#{latestAnswer},
		#{latestAnswerTime},
		#{latestAnswerUserName},
		#{expertSettingTime}, #{bestSettingTime},
		#{totalAnswerCount},
		#{solrjStatus},
		#{updatedAfterIndex},
		#{createUsername},
		#{createUserIp},
		#{createDateTime},
		#{createUserId},
		#{updateDateTime},
		#{updateUserId},
		#{deleteFlag},
		#{latestAnswerUserId},
		#{isAdminQuestion}
		)
	</insert>

	<delete id="deleteByPrimaryKey">
		DELETE FROM
		Dq_Question
		WHERE
		id = #{id}
	</delete>

	<!-- 查询某一种类型，某个状态的问题总条数 -->
	<select id="findQuestionsCount" parameterType="java.util.Map"
		resultType="int">
		SELECT
		count(*)
		FROM
		Dq_Question
		WHERE
		<if test="statuses != null">
			status in
			<foreach collection="statuses" item="item" separator=","
				close=")" open="(">
				#{item}
			</foreach>
			AND
		</if>

		<if test="statuses != null">
			type in
			<foreach collection="types" item="item" separator="," close=")"
				open="(">
				#{item}
			</foreach>
			AND
		</if>
		delete_flag='0'
	</select>

	<!-- 查询相关问题 -->
	<select id="findRelationQuestions" parameterType="java.util.Map"
		resultMap="question">
		SELECT *
		FROM
		Dq_Question AS QUESTION
		WHERE
		EXISTS (
		SELECT 1
		FROM Dq_Question_Classify AS QC
		INNER JOIN Dp_Insurance_Classify AS IC ON QC.classify_id = IC.id
		WHERE QC.question_id = QUESTION.id
		AND IC.value IN
		<foreach collection="classifies" item="item" separator=","
			close=")" open="(">
			#{item}
		</foreach>
		AND QC.delete_flag='0'
		)
		AND QUESTION.delete_flag='0'
		ORDER BY
		QUESTION.status DESC,
		QUESTION.latest_answer_time DESC LIMIT ${size}
	</select>

	<!-- 根据queryBean， 查找问题的的个数 -->
	<sql id="answeredCondition">
		(
		SELECT 1
		FROM Dq_Answer
		WHERE Question_Id = QUESTION.id
		AND Create_User_Id = #{agentUserId}
		)
	</sql>

	<sql id="queryBeanCondition">
		QUESTION.delete_flag='0'
		<if test="isAnswered != null">
			<if test="!isAnswered">
				AND NOT EXISTS
				<include refid="answeredCondition" />
			</if>

			<if test="isAnswered">
				AND EXISTS
				<include refid="answeredCondition" />
			</if>
		</if>

		<!-- 问题类型 -->
		<if test="questionTypes != null">
			<if test="questionTypeValue == 1">
				AND EXISTS(
				SELECT 1
				FROM Dp_Program program
				INNER JOIN Du_Agent_Detail agent ON agent.Id = program.User_Id
				WHERE program.Id = QUESTION.Refer_Id
				AND agent.Id = #{agentUserId}
				)
			</if>

			<if test="questionTypeValue == 2">
				AND QUESTION.refer_id = #{agentUserId}
			</if>

			<if test="questionTypeValue == 3">
				AND EXISTS(
					SELECT 1
					FROM Dp_Product product
					WHERE QUESTION.refer_id = product.Id
						AND (
							EXISTS(
								SELECT 1
								FROM Du_Agent_Detail agent1
								INNER JOIN Sm_Company company1 ON agent1.Company = company1.id
								WHERE agent1.Id = #{agentUserId}
								AND company1.id = product.company_id
							)
						OR
							EXISTS(
								SELECT 1
								FROM Du_Agent_Detail agent2
								INNER JOIN Sm_Company company2 ON agent2.Company = company2.id
								INNER JOIN Dp_Distributor_Product disPro ON 
								company2.id = disPro.Distributor_Id
								WHERE agent2.id = #{agentUserId}
								AND disPro.Link_Id = product.id
							)
						)
				)
			</if>
		</if>

		<if test="questionContent != null">
			AND QUESTION.content like #{questionContent}
		</if>

		<if test="questionUsername != null">
			AND QUESTION.question_username = #{questionUsername}
		</if>

		<if test="questionUserIp != null">
			AND QUESTION.create_user_ip = #{questionUserIp}
		</if>

		<if test="answerCount != null">
			AND QUESTION.total_answer_count = #{answerCount}
		</if>

		<if test="questionStatus != null">
			AND QUESTION.status IN
			<foreach collection="questionStatus" item="item" separator=","
				close=")" open="(">
				#{item}
			</foreach>
		</if>
		<if test="questionTypes != null">
			AND QUESTION.type IN
			<foreach collection="questionTypes" item="item" separator=","
				close=")" open="(">
				#{item}
			</foreach>
		</if>
		<if test="classifyValues != null">
			AND EXISTS(
			SELECT 1
			FROM
			Dq_Question_Classify AS QC
			INNER JOIN Dp_Insurance_Classify AS IC ON QC.classify_id = IC.id
			WHERE
			QC.question_id = QUESTION.id
			AND IC.value IN
			<foreach collection="classifyValues" item="item" separator=","
				close=")" open="(">
				#{item}
			</foreach>
			AND QC.delete_flag='0'
			)
		</if>


		<if test="isAgentToSolve != null">
			<if test="isAgentToSolve">
				and not exists(
				SELECT 1
				FROM Dq_Answer
				WHERE Question_Id = QUESTION.id
				AND Create_User_Id = #{agentUserId}
				)
			</if>
		</if>
	</sql>


	<select id="getQuestionCountByQueryBean" parameterType="com.djb.domain.qa.QuestionQueryBean"
		resultType="int">
		SELECT
		count(*)
		FROM
		Dq_Question AS QUESTION
		WHERE
		<include refid="queryBeanCondition" />
	</select>

	<!-- 根据queryBean， 查找当前页问题 -->
	<select id="getQuestionsByQueryBean" parameterType="com.djb.domain.qa.QuestionQueryBean"
		resultMap="question">
		SELECT * FROM Dq_Question AS QUESTION WHERE
		<include refid="queryBeanCondition" />
		<if test="orderByProperties != null">
			ORDER BY ${orderByFiled}
		</if>
		LIMIT ${startIndex}, ${pageSize}
	</select>

	<sql id="getReferQstsRef">
		FROM
		Dq_Question AS QUESTION
		WHERE
		QUESTION.delete_flag='0'
		<if test="questionStatus != null">
			AND QUESTION.status IN
			<foreach collection="questionStatus" item="item" separator=","
				close=")" open="(">
				#{item}
			</foreach>
		</if>
		<if test="referId != null and referId != ''">
			AND QUESTION.refer_id = #{referId}
			AND QUESTION.type = #{referType}
		</if>
	</sql>
	<!-- 根据queryBean， 查找店铺或者是方案的问题个数 -->
	<select id="getReferQstCount" parameterType="com.djb.domain.qa.QuestionQueryBean"
		resultType="int">
		SELECT count(*)
		<include refid="getReferQstsRef" />
	</select>

	<select id="getReferQsts" parameterType="com.djb.domain.qa.QuestionQueryBean"
		resultMap="question">
		SELECT *
		<include refid="getReferQstsRef" />
		<if test="orderByProperties != null">
			ORDER BY ${orderByFiled}
		</if>
		LIMIT ${startIndex}, ${pageSize}
	</select>

	<select id="findProductSEOQuestions" parameterType="java.util.Map"
		resultMap="question">
		SELECT dq.*
		FROM Dq_Question dq
		LEFT JOIN Dp_Product dp on (dq.Refer_Id = dp.Id and dq.Type = #{type})
		WHERE dp.Insurance_Classify_Id = #{classifyId}
		and dq.status = #{status}
		and dq.delete_flag = 0
		and dp.id is not null
		ORDER BY dq.create_time DESC
		LIMIT ${size}
	</select>

	<!-- 查询文章相关问题 -->
	<select id="findArticleRelatedQuestion" parameterType="java.util.Map"
		resultMap="relationQuestion">
		SELECT DISTINCT
		QUESTION.id,
		QUESTION.content,
		QUESTION.create_time
		FROM Dq_Question QUESTION
		INNER JOIN Dq_Question_Classify QUESTION_CLASSIFY ON QUESTION.id =
		QUESTION_CLASSIFY.question_id
		WHERE QUESTION.delete_flag='0'
		<if test="notStatus != null">AND
			QUESTION.Status != #{notStatus}
		</if>
		AND EXISTS (
		SELECT 1
		FROM Dq_Article AR
		INNER JOIN Dq_Article_Classify AC ON AC.article_id = AR.id
		WHERE AC.delete_flag='0'
		AND AR.id=#{articleId}
		AND AC.classify_id = QUESTION_CLASSIFY.classify_id
		)
		ORDER BY QUESTION.create_time DESC LIMIT ${size}
	</select>

	<!-- 查询问题的相关问题 -->
	<select id="findRelatedQuestion" parameterType="java.util.Map"
		resultMap="relationQuestion">
		SELECT DISTINCT
		QUESTION.id,
		QUESTION.content,
		QUESTION.create_time, QUESTION.type, QUESTION.refer_id as referId
		FROM Dq_Question QUESTION
		INNER JOIN Dq_Question_Classify QUESTION_CLASSIFY ON QUESTION.id =
		QUESTION_CLASSIFY.question_id
		WHERE QUESTION.delete_flag='0'
		<if test="notStatus != null">AND
			QUESTION.Status != #{notStatus}
		</if>
		AND EXISTS (
		SELECT 1
		FROM Dq_Question SQ
		INNER JOIN Dq_Question_Classify QC ON QC.question_id = SQ.id
		WHERE QC.delete_flag='0'
		AND SQ.id=#{questionId}
		AND QC.classify_id = QUESTION_CLASSIFY.classify_id
		)
		AND QUESTION.id != #{questionId}
		ORDER BY QUESTION.create_time DESC LIMIT ${size}
	</select>
 
 <!-- 查询方案的相关问题 -->
	<select id="findRelatedProgram" parameterType="java.util.Map"
		resultMap="relationQuestion">
		SELECT DISTINCT
		QUESTION.id,
		QUESTION.content,
		QUESTION.update_time,
		QUESTION.type,
		QUESTION.refer_id as referId
		FROM Dq_Question QUESTION
		INNER JOIN Dq_Question_Classify QUESTION_CLASSIFY ON QUESTION.id =
		QUESTION_CLASSIFY.question_id
		INNER JOIN Dp_Program program ON program.Id=#{programId}
		WHERE QUESTION.delete_flag='0'
		AND QUESTION.Status =20
		AND program.Insurance_Classify_Id like concat('%',
		cast(QUESTION_CLASSIFY.Classify_Id as varchar(50)), '%')
		AND QUESTION_CLASSIFY.delete_flag='0'

		ORDER BY QUESTION.update_time DESC
		LIMIT ${size}
	</select>

	<select id="findRelatedProgramII" parameterType="java.util.Map"
		resultMap="relationQuestion">
		SELECT *
		FROM Dq_Question
		WHERE Delete_Flag = 0
		and Type = 0
		<if test="kw!=null">
			and (
			<foreach collection="kw" item="item" separator="or">
				Content like concat('%',#{item},'%')
			</foreach>
			)
		</if>
		ORDER BY Update_Time DESC
		LIMIT 5
	</select>
	<!-- 查询一段时间内同一个IP发的问题的总数 -->
	<select id="findQuestionsTimeCount" parameterType="java.util.Map"
		resultType="int" useCache="false">
		SELECT
		count(*)
		FROM
		Dq_Question
		WHERE 1=1
		<if test="fromTime != null">AND
			create_time &gt;= #{fromTime}
		</if>
		<if test="endTime != null">AND
			create_time &lt;= #{endTime}
		</if>
		<if test="createUserIp != null">AND
			Create_User_Ip = #{createUserIp}
		</if>



		AND delete_flag='0'
	</select>
	<!-- 得到cms关联的问题 -->
	<select id="findCmsRelatedQuestion" parameterType="map"
		resultMap="question">
		SELECT DISTINCT
		QUESTION.*
		FROM Dq_Question QUESTION
		INNER JOIN Dq_Question_Classify QUESTION_CLASSIFY ON QUESTION.id =
		QUESTION_CLASSIFY.question_id
		INNER JOIN Dp_Cms_Content_Classify classify ON
		classify.cms_content_id=#{contentId}
		AND classify.Classify_Id=QUESTION_CLASSIFY.classify_id
		AND classify.delete_Flag=0
		AND QUESTION_CLASSIFY.delete_Flag=0
		WHERE QUESTION.delete_flag='0'
		AND QUESTION.status=30
		ORDER BY QUESTION.create_time DESC LIMIT ${size}
	</select>

	<update id="deleteByProductId">
		UPDATE Dq_Question
		SET Delete_Flag=1
		WHERE type=#{type}
		AND refer_Id=#{productId}
		AND Delete_Flag=0
	</update>

	<select id="findEssenceAnswer" resultMap="question">
		SELECT question.*
		FROM (
		SELECT Question_Id,
		COUNT(DISTINCT Answer_User_Name) Answer_Count,
		MAX(CASE WHEN Type = 1 THEN Create_Time ELSE NULL END) Best_Answer_Time
		FROM Dq_Answer
		WHERE Delete_Flag = 0
		GROUP BY Question_Id
		having COUNT(DISTINCT Answer_User_Name) > 5) answer
		LEFT JOIN Dq_Question question on answer.Question_Id = question.Id
		WHERE question.Status &gt;= 20
		and question.Delete_Flag = 0
		and answer.Best_Answer_Time &gt;= date_add(now(), interval -30 day)
		ORDER BY answer.Answer_Count DESC
		LIMIT ${value}
	</select>

	<select id="findEssenceAnswerProduct" parameterType="map"
		resultMap="question">
		SELECT question.*
		FROM (
		SELECT Question_Id,
		COUNT(DISTINCT Answer_User_Name) Answer_Count,
		MAX(CASE WHEN Type = 1 THEN Create_Time ELSE NULL END) Best_Answer_Time
		FROM Dq_Answer
		WHERE Delete_Flag = 0
		GROUP BY Question_Id
		having COUNT(DISTINCT Answer_User_Name) > 5) answer
		LEFT JOIN Dq_Question question on answer.Question_Id = question.Id
		WHERE question.Status &gt;= 20
		and question.Delete_Flag = 0
		and question.Type = 3
		and question.Refer_Id in (
		SELECT Id
		FROM Dp_Product
		WHERE Delete_Flag = 0
		<if test="null != classify">
			and Insurance_Classify_Id = #{classify}
		</if>
		<if test="null != subClassify">
			and Insurance_Subclass_Id = #{subClassify}
		</if>
		)
		and answer.Best_Answer_Time &gt;= date_add(now(), interval -30 day)
		ORDER BY answer.Answer_Count DESC
		LIMIT ${size}
	</select>

	<select id="loadRelatedQustion" parameterType="map" resultMap="question">
		SELECT *
		FROM (
		SELECT *
		FROM Dq_Question
		WHERE Delete_Flag = 0
		and Key_Word like concat('%',#{keyword},'%')
		<if test="type == 3">
			union
			SELECT *
			FROM Dq_Question
			WHERE Delete_Flag = 0
			and Type = 3
			and Refer_Id = #{refer}
		</if>)
		tmp
		WHERE tmp.Id &lt;&gt; #{question}
		and tmp.Status >= 20
		ORDER BY tmp.Update_Time DESC
		LIMIT 7
	</select>

	<select id="loadFaq" parameterType="map" resultMap="question">
		SELECT *
		FROM Dq_Question
		WHERE Delete_Flag = 0
		and Key_Word concat('%',#{keyword},'%')
		and Id &lt;&gt; #{question}
		and Status >= 30
		ORDER BY Update_Time DESC
		LIMIT 7
	</select>

	<select id="getAlreadyReplyNum" parameterType="long" resultType="int">
		SELECT count(*) FROM Dq_Question
		WHERE refer_id=#{agentId}
		and delete_flag=0
		and status=10
		and latest_count=1
	</select>

	<sql id="getProcessedAgentListRef">
		FROM (
		SELECT Question_Id, MAX(Create_Time) as Create_Time
		FROM Dq_Answer
		WHERE Create_User_Id = #{agentUserId}
		And delete_flag=0
		<if test="isProcessAgent">
			and type = 1
		</if>
		GROUP BY Question_Id
		) a
		LEFT JOIN Dq_Question q on a.Question_Id=q.Id
		WHERE q.Type in (0,3) and q.delete_flag=0
	</sql>

	<select id="getCountProcessedAgent" parameterType="com.djb.domain.qa.QuestionQueryBean"
		resultType="int">
		SELECT count(*)
		<include refid="getProcessedAgentListRef" />
	</select>
	<select id="getProcessedAgentList" parameterType="com.djb.domain.qa.QuestionQueryBean"
		resultMap="question">
		SELECT q.*
		<include refid="getProcessedAgentListRef" />
		ORDER BY a.Create_Time DESC
		LIMIT ${startIndex}, ${pageSize}
	</select>
</mapper>
==================================== END qa/Question.xml =========================


==================================== BEGIN qa/Article.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:11:57 
 CST 2013 -->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="Article">

 <cache type="com.djb.cache.MemcachedCache">
  <property name="timeout" value="7200" />
 </cache>
 <resultMap id="article" type="com.djb.domain.qa.Article"
  extends="DomainObject.domainObject">
  <result property="title" column="title" />
  <result property="articleType" column="article_type" />
  <result property="content" column="content" />
  <association property="classifies" select="Article.findArticleClassify"
   column="id" />
 </resultMap>

 <resultMap id="insuranceClassify" type="com.djb.domain.InsuranceClassify">
  <result property="name" column="name" />
  <result property="value" column="value" />
  <result property="insuranceClassifyType" column="type" />
 </resultMap>

 <resultMap id="relationArticle" type="com.djb.domain.qa.Article">
  <result property="title" column="title" />
  <result property="id" column="id" />
 </resultMap>

 <select id="load" resultMap="article">
  SELECT ARTICLE.*
  FROM Dq_Article ARTICLE
  WHERE id=#{id}
  AND delete_flag='0'
 </select>

 <select id="findArticleClassify" resultMap="insuranceClassify">
  SELECT *
  FROM Dp_Insurance_Classify IC
  INNER JOIN Dq_Article_Classify AC ON IC.id = AC.classify_id
  INNER JOIN Dq_Article AS A ON A.id = AC.article_id
  WHERE A.id = #{articleId}
  AND AC.delete_flag = '0'
  AND IC.delete_flag = '0'
  AND A.delete_flag = '0'
 </select>

 <select id="getArticlesCount" parameterType="java.util.Map"
  resultType="int">
  SELECT COUNT(*)
  FROM Dq_Article ARTICLE
  WHERE ARTICLE.delete_flag='0'
  AND ARTICLE.article_type=#{typeValue}
 </select>

 <select id="findArticles" parameterType="java.util.Map"
  resultMap="article">
  SELECT ARTICLE.* FROM Dq_Article ARTICLE WHERE
  ARTICLE.delete_flag='0' AND ARTICLE.article_type=#{typeValue} ORDER BY
  ARTICLE.create_time DESC LIMIT ${startIndex}, ${pageSize}
 </select>

 <!-- 查询相关问题 -->
 <select id="findRelatedArticle" parameterType="java.util.Map"
  resultMap="relationArticle">
  SELECT
  ARTICLE.title,
  ARTICLE.id,
  ARTICLE.create_time
  FROM Dq_Article ARTICLE
  INNER JOIN Dq_Article_Classify ARTICLE_CLASSIFY ON
  ARTICLE.id = ARTICLE_CLASSIFY.article_id
  WHERE ARTICLE.delete_flag='0'
  AND EXISTS(
  SELECT 1
  FROM Dq_Article AR
  INNER JOIN Dq_Article_Classify AC ON AC.article_id = AR.id
  WHERE AC.delete_flag = '0'
  AND AR.id = #{articleId}
  AND AC.classify_id = ARTICLE_CLASSIFY.classify_id
  )
  AND ARTICLE.id != #{articleId}
  ORDER BY ARTICLE.create_time DESC LIMIT ${size}
 </select>

 <insert id="insert" parameterType="com.djb.domain.qa.Article">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO
  Dq_Article(
  id,
  title,
  article_type,
  content,
  create_user_id,
  create_time,
  update_user_id,
  update_time,
  delete_flag
  )
  VALUES(
  #{id},
  #{title},
  #{articleType},
  #{content},
  #{createUserId},
  #{createDateTime},
  #{updateUserId},
  #{updateDateTime},
  #{deleteFlag}
  )
 </insert>

 <update id="update" parameterType="com.djb.domain.qa.Article">
  UPDATE Dq_Article
  SET
  title=#{title},
  article_type=#{articleType},
  content=#{content},
  update_user_id=#{updateUserId},
  update_time=#{updateDateTime},
  delete_flag=#{deleteFlag}
  WHERE id=#{id}
 </update>

 <delete id="deleteByPrimaryKey">
  DELETE FROM Dq_Article
  WHERE id = #{id}
 </delete>
</mapper>
==================================== END qa/Article.xml =========================


==================================== BEGIN qa/IpBlocker.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:11:59 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="IpBlocker">
 
 <cache type="com.djb.cache.MemcachedCache">
  <property name="timeout" value="7200"/>
 </cache>

 <resultMap id="ipBlocker" type="com.djb.domain.qa.IpBlocker" extends="DomainObject.domainObject">
  <result property="ip" column="ip"/>
 </resultMap>


 <select id="load" resultMap="ipBlocker">
  SELECT IPBLOCK.*
   FROM Sm_Ip_Block IPBLOCK
   WHERE id=#{id} 
    AND delete_flag='0'
 </select>
 
 <select id="getBlockIp" resultMap="ipBlocker">
  SELECT IPBLOCK.*
  FROM
    Sm_Ip_Block IPBLOCK
  WHERE
    ip=#{ip} 
  AND delete_flag='0'
 </select>
 
 <insert id="insert" parameterType="com.djb.domain.qa.IpBlocker">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO 
   Sm_Ip_Block(
    ip,
    block_agent_id,
    create_user_id, 
    create_time, 
    update_user_id, 
    update_time,
    delete_flag
   )
  VALUES(
   #{ip},
   #{blockAgentId}, 
   #{createUserId},
   #{createDateTime},
   #{updateUserId},
   #{updateDateTime},
   #{deleteFlag}
  )
  
  
  </insert>
  
  <delete id="deleteByIp" parameterType="String">
   DELETE FROM
    Sm_Ip_Block
   WHERE
    Sm_Ip_Block.ip = #{ip}
  </delete>
  
  <select id="getAll" resultMap="ipBlocker">
   SELECT * FROM Sm_Ip_Block WHERE delete_flag='0'
  </select>
</mapper>
==================================== END qa/IpBlocker.xml =========================


==================================== BEGIN qa/Answer.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:11:57 
 CST 2013 -->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="Answer">
 <resultMap id="answer" type="com.djb.domain.qa.Answer"
  extends="DomainObject.domainObject">
  <result property="content" column="content" />
  <result property="type" column="type" />
  <result property="answerUserName" column="answer_user_name" />
  <result property="answerUserPhoto" column="answer_user_photo" />
  <result property="isAdminAnswer" column="admin_answer" />
  <result property="answerUserCompanyName" column="company_name" />
  <association property="question" select="Question.load"
   column="question_id" />
 </resultMap>

 <resultMap id="answerExpert" type="com.djb.domain.qa.AnswerExpert">
  <result property="agentId" column="agent_id" />
  <result property="agentName" column="agent_name" />
  <result property="answerCount" column="answer_count" />
 </resultMap>

 <resultMap id="angentAnswer" type="com.djb.domain.qa.Answer"
  extends="DomainObject.domainObject">
  <result property="question.id" column="question_id" />
  <result property="content" column="content" />
 </resultMap>

 <select id="load" resultMap="answer">
  SELECT ANSWER.*,
  COMPANY.company_name AS company_name
  FROM Dq_Answer AS ANSWER
  LEFT JOIN Du_Agent_Detail AS AGENT ON ANSWER.create_user_id = AGENT.id
  LEFT JOIN Sm_Company AS COMPANY ON COMPANY.id = AGENT.company
  WHERE ANSWER.id=#{uuid}
  AND ANSWER.delete_flag = '0'
 </select>

 <select id="findAnswersByQuestionId" resultMap="answer">
  SELECT ANSWER.*,
  COMPANY.company_name AS company_name
  FROM Dq_Answer AS ANSWER
  LEFT JOIN Du_Agent_Detail AS AGENT ON ANSWER.create_user_id = AGENT.id AND
  AGENT.delete_flag = '0'
  LEFT JOIN Sm_Company AS COMPANY ON COMPANY.id = AGENT.company
  WHERE question_id=#{questionId}
  AND ANSWER.delete_flag = '0'
  ORDER BY
  create_time DESC
 </select>

 <!-- 查询最佳答案最多的前n个代理人 -->
 <select id="findExperts" parameterType="map" resultMap="answerExpert">
  SELECT
  count(*) answer_count,
  AGENT.id agent_id,
  true_name agent_name
  FROM
  Dq_Answer ANSWER
  INNER JOIN Du_Agent_Detail AGENT ON AGENT.id = ANSWER.create_user_id AND
  AGENT.Delete_Flag=0
  WHERE ANSWER.type=${type}
  AND ANSWER.delete_flag = '0'
  GROUP BY
  AGENT.id,
  true_name
  ORDER BY answer_count DESC LIMIT ${size}
 </select>

 <select id="findAnswersByQstAndAgentId" parameterType="map"
  resultMap="angentAnswer">
  SELECT *
  FROM Dq_Answer ANSWER
  WHERE ANSWER.create_user_id = #{agentUserId}
  AND ANSWER.delete_flag = '0'
  <if test="questionIds != null">
   AND ANSWER.question_id IN
   <foreach collection="questionIds" item="item" separator=","
    close=")" open="(">
    #{item}
   </foreach>
  </if>
  ORDER BY ANSWER.create_time DESC
 </select>

 <insert id="insert" parameterType="com.djb.domain.qa.Answer">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO
  Dq_Answer(
  id,
  question_id,
  content,
  type,
  answer_user_name,
  answer_user_photo,
  create_user_id,
  create_time,
  update_user_id,
  update_time,
  delete_flag,
  admin_answer
  )
  VALUES(
  #{uuid},
  #{question.uuid},
  #{content},
  #{type},
  #{answerUserName},
  #{answerUserPhoto},
  #{createUserId},
  #{createDateTime},
  #{updateUserId},
  #{updateDateTime},
  #{deleteFlag},
  #{isAdminAnswer}
  )
 </insert>

 <update id="update" parameterType="com.djb.domain.qa.Answer">
  UPDATE
  Dq_Answer
  SET
  content=#{content},
  type=#{type},
  answer_user_name=#{answerUserName},
  answer_user_photo=#{answerUserPhoto},
  update_user_id=#{updateUserId},
  update_time=#{updateDateTime},
  delete_flag=#{deleteFlag}
  <if test="isAdminAnswer != null">
   ,admin_answer = #{isAdminAnswer}
  </if>
  WHERE
  id=#{uuid}
 </update>

 <delete id="removeByFKey">
  DELETE FROM Dq_Answer
  WHERE question_id = #{fKey}
 </delete>

 <update id="deleteByPrimaryKey">
  UPDATE Dq_Answer
  SET update_user_id=#{updateUserId}, update_time=#{updateDateTime}, delete_flag = '1'
  WHERE id=#{uuid}
 </update>


 <update id="logicDeleteByFKey">
  UPDATE
  Dq_Answer
  SET
  delete_flag = '1'
  WHERE
  question_id = #{fKey}
 </update>

 <update id="logicDelete">
  UPDATE Dq_Answer
  SET delete_flag = '1'
  WHERE id = #{uuid}
 </update>

 <update id="deleteByProductId" parameterType="map">
  UPDATE Dq_Answer
  SET delete_flag = '1'
  WHERE Question_Id IN(
   SELECT Id FROM Dq_Question
   WHERE type=#{type} AND refer_Id=#{productId})
 </update>

 <select id="findByAnswer" parameterType="com.djb.domain.qa.Answer"
  resultMap="answer">
  SELECT * FROM Dq_Answer a
  INNER JOIN Dq_Question q
  on a.Question_Id=q.Id
  WHERE a.Delete_Flag=0 and q.Delete_Flag=0
  and a.Create_User_Id=#{createUserId}
  and q.Type in (0,3)
  and a.Create_Time = (
    SELECT max(Create_Time) ansCreTime FROM Dq_Answer
    WHERE Create_User_Id = #{createUserId}
    and Dq_Answer.Id=a.id
  )
 </select>

 <select id="findAnswerCountByQuestionId" parameterType="long"
  resultType="int">
  SELECT count(1)
  FROM Dq_Answer AS ANSWER
  LEFT JOIN Du_Agent_Detail AS AGENT ON ANSWER.create_user_id = AGENT.id AND
  AGENT.delete_flag = '0'
  LEFT JOIN Sm_Company AS COMPANY ON COMPANY.id = AGENT.company
  WHERE question_id=#{questionId}
  AND ANSWER.delete_flag = '0'
 </select>

</mapper>
==================================== END qa/Answer.xml =========================


==================================== BEGIN qa/ArticleClassify.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:11:58 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="ArticleClassify">
 <resultMap id="articleClassify" type="com.djb.domain.qa.ArticleClassify">
  <result property="id" column="id"/>
  <result property="articleId" column="article_id"/>
  <result property="classifyId" column="classify_id"/>
  <result property="deleteFlag" column="delete_flag"/>
 </resultMap>

 <select id="load" resultMap="articleClassify">
  SELECT *
  FROM
    Dq_Article_Classify
  WHERE
    id=#{id} 
  AND delete_flag='0'
 </select>
 

 <update id="logicDeleteByFKey">
 UPDATE Dq_Article_Classify    
    SET delete_flag='1'
  WHERE article_id=#{articleId}
 </update>
 
 <insert id="insert" parameterType="com.djb.domain.qa.ArticleClassify">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO 
   Dq_Article_Classify(
    article_id,
    classify_id,
    delete_flag,
    create_user_id,
    create_time,
    update_user_Id,
    update_time
   )
  VALUES(
   #{articleId}, 
   #{classifyId}, 
   #{deleteFlag},
   #{createUserId},
   #{createDateTime},
   #{updateUserId},
   #{updateDateTime}
  )
  
  
  </insert>
  
  <delete id="deleteByPrimaryKey">
  DELETE FROM Dq_Article_Classify 
      WHERE id = #{id}
 </delete>
</mapper>
==================================== END qa/ArticleClassify.xml =========================


==================================== BEGIN qa/QuestionClassify.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:12:00 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="QuestionClassify">
 <resultMap id="questionClassify" type="com.djb.domain.qa.QuestionClassify" extends="DomainObject.domainObject">
  <result property="question.id" column="question_id"/>
  <result property="insuranceClassify.id" column="classify_id"/>
 </resultMap>

 <select id="getSubClassifyCount" resultType="java.util.HashMap">
  SELECT count(QC.id) COUNT, IC.id id
   FROM Dq_Question_Classify QC
RIGHT JOIN Dp_Insurance_Classify AS IC ON QC.classify_id = IC.id
INNER JOIN Dq_Question AS Q ON QC.question_id = Q.id
   WHERE IC.parent_id=#{classifyId}
    AND QC.delete_flag='0'
    AND IC.delete_flag='0'
    AND  Q.type = 0
    AND  Q.delete_flag ='0'
 GROUP BY IC.id
 ORDER BY IC.id
 </select>
 
 <update id="update" parameterType="com.djb.domain.qa.QuestionClassify">
  UPDATE
   Dq_Question_Classify
  SET
   question_id = #{question.id},
   classify_id = #{insuranceClassify.id},
   update_time = #{updateDateTime},
   update_user_id = #{updateUserId},
   delete_flag = #{deleteFlag}
  WHERE
   id = #{id}
 </update>
 
 <insert id="insert" parameterType="com.djb.domain.qa.QuestionClassify">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO 
   Dq_Question_Classify(
    question_id,
    classify_id,
    create_time,
    create_user_id,
    update_time,
    update_user_id,
    delete_flag
   )
  VALUES(
   #{question.id},
   #{insuranceClassify.id},
   #{createDateTime},
   #{createUserId},
   #{updateDateTime},
   #{updateUserId},
   #{deleteFlag}
  )
  
  
 </insert>
 
 <update id="logicDeleteByFKey">
  UPDATE
   Dq_Question_Classify
  SET
   delete_flag = '1'
  WHERE
   question_id = #{questionId}
 </update>
 
 <delete id="removeByFKey">
  DELETE FROM 
   Dq_Question_Classify
  WHERE
   question_id = #{questionId}
 </delete>
 
 <delete id="deleteByPrimaryKey">
  DELETE FROM 
   Dq_Question_Classify
  WHERE
   id = #{id}
 </delete>
</mapper>
==================================== END qa/QuestionClassify.xml =========================


==================================== BEGIN yqb/UserLogin.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="UserLogin" >

 <resultMap id="userLogin" type="com.djb.domain.yqb.UserLogin">
  <result property="userlogid" column="user_log_id" />
  <result property="userid" column="user_id" />
  <result property="sessionkey" column="session_key" />
  <result property="createdate" column="create_date" />
  <result property="updatedate" column="update_date" />
  <result property="status" column="status" />
  <result property="terminalcode" column="terminal_code" />
 </resultMap>

 <select id="load" resultMap="userLogin" >
  SELECT  *
    FROM  tr_user_login
   WHERE  user_log_id=#{userlogid}
 </select>

 <update id="update" parameterType="com.djb.domain.yqb.UserLogin" >
  UPDATE  tr_user_login
     SET  
    user_id=#{userid}
   ,session_key=#{sessionkey}
   ,create_date=#{createdate}
   ,update_date=#{updatedate}
   ,status=#{status}
   ,terminal_code=#{terminalcode}
   WHERE  user_log_id=#{userlogid}
 </update>

 <insert id="insert" parameterType="com.djb.domain.yqb.UserLogin" >
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  tr_user_login(
    user_id
   ,session_key
   ,create_date
   ,update_date
   ,status
   ,terminal_code
  )
  VALUES(
    #{userid}
   ,#{sessionkey}
   ,#{createdate}
   ,#{updatedate}
   ,#{status}
   ,#{terminalcode}
  )
 </insert>

 <delete id="deleteByPrimaryKey" >
  DELETE FROM  tr_user_login
        WHERE user_log_id=#{userlogid}
 </delete>
</mapper>
==================================== END yqb/UserLogin.xml =========================


==================================== BEGIN yqb/Order.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="yqbOrder" >

 <resultMap id="order" type="com.djb.domain.yqb.Order">
  <result property="orderid" column="order_id" />
  <result property="totalamount" column="total_amount" />
  <result property="applynumber" column="apply_number" />
  <result property="skucode" column="sku_code" />
  <result property="prodcutid" column="prodcut_id" />
  <result property="productname" column="product_name" />
  <result property="specialcode" column="special_code" />
  <result property="userid" column="user_id" />
  <result property="holdername" column="holder_name" />
  <result property="holderemail" column="holder_email" />
  <result property="holdercerttype" column="holder_cert_type" />
  <result property="holdercertno" column="holder_cert_no" />
  <result property="holdersex" column="holder_sex" />
  <result property="holdermobile" column="holder_mobile" />
  <result property="holderprovincecode" column="holder_province_code" />
  <result property="holdercitycode" column="holder_city_code" />
  <result property="holderaddress" column="holder_address" />
  <result property="holderzipcode" column="holder_zip_code" />
  <result property="isholder" column="is_holder" />
  <result property="islegal" column="is_legal" />
  <result property="status" column="status" />
  <result property="proposalno" column="proposal_no" />
  <result property="underwriteflag" column="underwrite_flag" />
  <result property="failreason" column="fail_reason" />
  <result property="producttype" column="product_type" />
  <result property="ordertype" column="order_type" />
  <result property="bankcode" column="bank_code" />
  <result property="cardtype" column="card_type" />
  <result property="cardno" column="card_no" />
  <result property="realamount" column="real_amount" />
  <result property="createdate" column="create_date"/>
  <result property="updatedate" column="update_date"/>
 </resultMap>

 <select id="load" resultMap="order" >
  SELECT  *
    FROM  tt_order
   WHERE  order_id = #{orderid}    
 </select>
 
 <select id="findByUserToOrder" parameterType="long" resultMap="order">
   SELECT  *
    FROM  tt_order
    WHERE user_id=#{userid}
    ORDER BY create_date desc
 </select>

 <update id="update" parameterType="com.djb.domain.yqb.Order" >
  UPDATE  Order
     SET  
   total_amount=#{totalamount}
   ,apply_number=#{applynumber}
   ,sku_code=#{skucode}
   ,prodcut_id=#{prodcutid}
   ,product_name=#{productname}
   ,special_code=#{specialcode}
   ,user_id=#{userid}
   ,holder_name=#{holdername}
   ,holder_email=#{holderemail}
   ,holder_cert_type=#{holdercerttype}
   ,holder_cert_no=#{holdercertno}
   ,holder_sex=#{holdersex}
   ,holder_mobile=#{holdermobile}
   ,holder_province_code=#{holderprovincecode}
   ,holder_city_code=#{holdercitycode}
   ,holder_address=#{holderaddress}
   ,holder_zip_code=#{holderzipcode}
   ,is_holder=#{isholder}
   ,is_legal=#{islegal}
   ,status=#{status}
   ,proposal_no=#{proposalno}
   ,underwrite_flag=#{underwriteflag}
   ,fail_reason=#{failreason}
   ,product_type=#{producttype}
   ,order_type=#{ordertype}
   ,bank_code=#{bankcode}
   ,card_type=#{cardtype}
   ,card_no=#{cardno}
   ,real_amount=#{realamount}
   ,create_date=#{create_date}
   ,update_date=#{update_date}
   WHERE order_id=#{orderid}
 </update>

 <insert id="insert" parameterType="com.djb.domain.yqb.Order" >
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Order(
   total_amount
   ,apply_number
   ,sku_code
   ,prodcut_id
   ,product_name
   ,special_code
   ,user_id
   ,holder_name
   ,holder_email
   ,holder_cert_type
   ,holder_cert_no
   ,holder_sex
   ,holder_mobile
   ,holder_province_code
   ,holder_city_code
   ,holder_address
   ,holder_zip_code
   ,is_holder
   ,is_legal
   ,status
   ,proposal_no
   ,underwrite_flag
   ,fail_reason
   ,create_date
   ,update_date
   ,product_type
   ,order_type
   ,bank_code
   ,card_type
   ,card_no
   ,real_amount
  )
  VALUES(
   #{totalamount}
   ,#{applynumber}
   ,#{skucode}
   ,#{prodcutid}
   ,#{productname}
   ,#{specialcode}
   ,#{userid}
   ,#{holdername}
   ,#{holderemail}
   ,#{holdercerttype}
   ,#{holdercertno}
   ,#{holdersex}
   ,#{holdermobile}
      ,#{holderprovincecode}
   ,#{holdercitycode}
   ,#{holderaddress}
   ,#{holderzipcode}
   ,#{isholder}
   ,#{islegal}
   ,#{status}
   ,#{proposalno}
   ,#{underwriteflag}
   ,#{failreason}
   ,#{createdate}
   ,#{updatedate}
   ,#{producttype}
   ,#{ordertype}
   ,#{bankcode}
   ,#{cardtype}
   ,#{cardno}
   ,#{realamount}
  )
 </insert>

 <delete id="deleteByPrimaryKey" >
  DELETE FROM  Order
        WHERE  order_id=#{orderid}
 </delete>
</mapper>
==================================== END yqb/Order.xml =========================


==================================== BEGIN yqb/User.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="User" >

 <resultMap id="user" type="com.djb.domain.yqb.User" >
  <result property="userinfoid" column="user_info_id" />
  <result property="username" column="user_name" />
  <result property="certtype" column="cert_type" />
  <result property="certno" column="cert_no" />
  <result property="email" column="email" />
  <result property="provincename" column="province_name" />
  <result property="provincecode" column="province_code" />
  <result property="cityname" column="city_name" />
  <result property="citycode" column="city_code" />
  <result property="district" column="district" />
  <result property="street" column="street" />
  <result property="mobile" column="mobile" />
  <result property="userid" column="user_id" />
  <result property="createdate" column="create_date"/>
  <result property="updatedate" column="updatedate"/>
  <collection property="deviceNumber" resultMap="User.userLogin"/>
 </resultMap>
 
 <resultMap id="userLogin" type="com.djb.domain.yqb.UserLogin">  
  <result property="terminalcode" column="code" />
 </resultMap>

 <select id="load" resultMap="user" >
  SELECT  *
    FROM  tr_user_info
   WHERE  user_info_id=#{userinfoid}
 </select>
 
 <select id="loadUserId" parameterType="long" resultMap="user" >
  SELECT  *
    FROM  tr_user_info
   WHERE  user_id=#{userid}
 </select>
 
 <select id="findPageUser" resultMap="user">
  SELECT  info.*
    FROM  tr_user_info info
    LEFT JOIN tt_user u
          on info.user_id=u.user_id
    ORDER BY info.create_date desc
  	LIMIT ${startIndex}, ${pageSize}
 </select>
 
 <select id="findPageDevice" resultMap="user">
  SELECT  info.* ,l.terminal_code code
    FROM  tr_user_info info
    LEFT JOIN tt_user u
          on info.user_id=u.user_id
          LEFT JOIN tr_user_login l
     on u.user_id=l.user_id
     ORDER BY info.create_date desc
     LIMIT ${startIndex}, ${pageSize}
 </select>
 
 <select id="countUserJoinDevice" resultType="int">
  SELECT count(1) FROM tr_user_info info
      LEFT JOIN tt_user u
      on info.user_id=u.user_id
      LEFT JOIN tr_user_login l
      on u.user_id=l.user_id
 </select>
 
 
 <select id="countUserInfo" resultType="int">
      SELECT count(1)
        FROM tr_user_info info
        LEFT JOIN tt_user u
       on info.user_id=u.user_id
 </select>
 

 <update id="update" parameterType="com.djb.domain.yqb.User" >
  UPDATE  tr_user_info
     SET     
    user_name=#{username}
   ,cert_type=#{certtype}
   ,cert_no=#{certno}
   ,email=#{email}
   ,province_name=#{provincename}
   ,province_code=#{provincecode}
   ,city_name=#{cityname}
   ,city_code=#{citycode}
   ,district=#{district}
   ,street=#{street}
   ,mobile=#{mobile}
   ,update_date=#{updatedate}   
   ,create_date=#{createdate}
   ,user_id=#{userid}
   WHERE  user_info_id=#{userinfoid}
 </update>

 <insert id="insert" parameterType="com.djb.domain.yqb.User" >
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  tr_user_info(
   user_name
   ,cert_type
   ,cert_no
   ,email
   ,province_name
   ,province_code
   ,city_name
   ,city_code
   ,district
   ,street
   ,mobile
   ,create_date
   ,update_date   
   ,user_id
  )
  VALUES(
    #{username}
   ,#{certtype}
   ,#{certno}
   ,#{email}
   ,#{provincename}
   ,#{provincecode}
   ,#{cityname}
   ,#{citycode}
   ,#{district}
   ,#{street}
   ,#{mobile}
   ,#{createdate}
   ,#{updatedate}   
   ,#{userid}
  )
 </insert>

 <delete id="deleteByPrimaryKey" >
  DELETE FROM  tr_user_info
        WHERE  user_info_id=#{userinfoid}
 </delete>
</mapper>
==================================== END yqb/User.xml =========================


==================================== BEGIN yqb/Product.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="yqbProduct" >

 <resultMap id="product" type="com.djb.domain.yqb.Product" >
  <result property="productid" column="product_id" />
  <result property="productname" column="product_name" />
  <result property="producttype" column="product_type" />
  <result property="lowestamount" column="lowest_amount" />
  <result property="skucode" column="sku_code" />
  <result property="issuecompany" column="issue_company" />
  <result property="subproducttype" column="sub_product_type" />
  <result property="productcomments" column="product_comments" />
  <result property="productcode" column="product_code" />
  <result property="companyname" column="company_name" />
  <result property="companyid" column="company_id" />
  <result property="remark" column="remark" />
  <result property="recommendflag" column="recommend_flag" />
  <result property="transtype" column="trans_type" />
  <result property="limittype" column="limit_type" />
  <result property="daylimit" column="day_limit" />
  <result property="fee" column="fee" />
  <result property="evaluate" column="evaluate" />
  <result property="producttags" column="product_tags" />
  <result property="createdate" column="create_date"/>
  <result property="updatedate" column="update_date"/>
  <result property="rank" column="rank"/>
  <result property="status" column="status"/>
 </resultMap>

 <select id="load" resultMap="product" >
  SELECT  *
    FROM  tt_product
   WHERE  product_id=#{productid} 
 </select>
 
 <select id="findAllProduct" parameterType="com.djb.domain.yqb.ProductQueryBean" resultMap="product">
  SELECT  * from(
     SELECT  * 
     FROM  tt_product
     WHERE status=1
    <if test="productName != null">
     AND product_name like concat('%',#{productName},'%')
    </if>
   union
      SELECT  * 
      FROM  tt_product
      WHERE status=0
     <if test="productName != null">
      AND product_name like concat('%',#{productName},'%')
     </if>
   )
   ORDER BY p.status desc,p.create_date desc
   limit ${startIndex}, ${pageSize}
 </select>
 
 <select id="countProduct" parameterType="com.djb.domain.yqb.ProductQueryBean" resultType="int">
   SELECT  count(1) from(
     SELECT  * 
     FROM  tt_product
     WHERE status=1
    <if test="productName != null">
     AND product_name like concat('%',#{productName},'%')
    </if>
   union
      SELECT  * 
      FROM  tt_product
      WHERE status=0
     <if test="productName != null">
      AND product_name like concat('%',#{productName},'%')
     </if>
   ) p
 </select>
 
 <select id="findByFlag" resultMap="product">
  SELECT * 
    FROM tt_product WHERE recommend_flag = 1
  LIMIT 1
 </select>
 
 <update id="update" parameterType="com.djb.domain.yqb.Product" >
  UPDATE tt_product
     SET  
    product_name=#{productname}
   ,product_type=#{producttype}
   ,lowest_amount=#{lowestamount}
   ,sku_code=#{skucode}
   ,issue_company=#{issuecompany}
   ,sub_product_type=#{subproducttype}
   ,product_comments=#{productcomments}
   ,product_code=#{productcode}
   ,company_name=#{companyname}
   ,company_id=#{companyid}
   ,update_date=#{updatedate}
   ,remark=#{remark}
   ,recommend_flag=#{recommendflag}
   ,trans_type=#{transtype}
   ,limit_type=#{limittype}
   ,day_limit=#{daylimit}
   ,fee=#{fee}
   ,evaluate=#{evaluate}
   ,product_tags=#{producttags}
   ,create_date=#{createdate}
   ,rank=#{rank}
   ,status=#{status}
   WHERE  product_id=#{productid}
 </update>

 <insert id="insert" parameterType="com.djb.domain.yqb.Product" >
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  tt_product(
    product_name
   ,product_type
   ,lowest_amount
   ,sku_code
   ,issue_company
   ,sub_product_type
   ,product_comments
   ,product_code
   ,company_name
   ,company_id
      ,create_time
   ,update_time
   ,remark
   ,recommend_flag
   ,trans_type
   ,limit_type
   ,day_limit
   ,fee
   ,evaluate
   ,product_tags
   ,rank
   ,status
  )
  VALUES(
   #{productname}
   ,#{producttype}
   ,#{lowestamount}
   ,#{skucode}
   ,#{issuecompany}
   ,#{subproducttype}
   ,#{productcomments}
   ,#{productcode}
   ,#{companyname}
   ,#{companyid}
   ,#{createtime}
   ,#{updatetime}
   ,#{remark}
   ,#{recommendflag}
   ,#{transtype}
   ,#{limittype}
   ,#{daylimit}
   ,#{fee}
   ,#{evaluate}
   ,#{producttags}
   ,#{rank}
   ,#{status}
  )
 </insert>

 <delete id="deleteByPrimaryKey" >
  DELETE FROM  tt_product
        WHERE  product_id=#{productid}
 </delete>
</mapper>

==================================== END yqb/Product.xml =========================


==================================== BEGIN yqb/UserMessge.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="UserMessge" >

 <resultMap id="userMessge" type="com.djb.domain.yqb.UserMessge">
  <result property="usermessegeid" column="user_message_id" />
  <result property="userid" column="user_id" />
  <result property="messegetype" column="message_type" />
  <result property="messegetext" column="message_text" />
  <result property="status" column="status" />
  <result property="createdate" column="create_date"/>
  <result property="updatedate" column="update_date"/>
 </resultMap>

 <select id="load" resultMap="userMessge" >
  SELECT  *
    FROM  tr_user_message
   WHERE  user_message_id=#{usermessegeid}
 </select>
 
 <select id="findByUserId" parameterType="int" resultMap="userMessge">
   SELECT  *
     FROM  tr_user_message
     WHERE 1=1
     AND message_type=1
     <if test="null != userid">
       AND user_id=#{userid}
     </if>
     <if test="null != status">
       AND status=#{status}
     </if>
 </select>
 
 <select id="findHistoryMessege" parameterType="int" resultMap="userMessge">
   SELECT  *
     FROM  tr_user_message
     WHERE 1=1
     <if test="null != userid">
       AND user_id=#{userid}
     </if>
     <if test="null != status">
       AND status=#{status}
     </if>
 </select>

 <update id="update" parameterType="com.djb.domain.yqb.UserMessge" >
  UPDATE  tr_user_message
     SET     
    user_id=#{userid}
   ,message_type=#{messegetype}
   ,message_text=#{messegetext}
   ,status=#{status}
   ,update_date=#{updatedate}
   ,create_date=#{create_date}
   WHERE  user_messaga_id=#{usermessegeid}
 </update>
 
 <update id="updateStatus" parameterType="long">
  UPDATE  tr_user_message
     SET status=1
     WHERE user_id=#{userid}
 </update>

 <insert id="insert" parameterType="com.djb.domain.yqb.UserMessge" >
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  tr_user_message(
   user_id
   ,message_type
   ,message_text
   ,create_date
   ,status
   ,update_date
  )
  VALUES(
    #{userid}
   ,#{messegetype}
   ,#{messegetext}
   ,#{createdate}
   ,#{status}
   ,#{updatedate}
  )
 </insert>

 <delete id="deleteByPrimaryKey" >
  DELETE FROM  tr_user_message
        WHERE  user_message_id=#{usermessegeid}
 </delete>
</mapper>
==================================== END yqb/UserMessge.xml =========================


==================================== BEGIN stat/StatAgentRecommend.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:06:01 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="StatAgentRecommend">

 <resultMap id="statAgentRecommend" type="com.djb.domain.stat.StatAgentRecommend" extends="DomainObject.domainObject">
  <result property="statAgentBase.id" column="Stat_Agent_Base_Id"/>
  <result property="agentUserId" column="Agent_User_Id"/>
  <result property="year" column="Year"/>
  <result property="month" column="Month"/>
  <result property="programCount" column="Program_Count"/>
  <result property="agentCount" column="Agent_Count"/>
  <result property="programWebcallCount" column="Program_Webcall_Count"/>
  <result property="programWebcallSuccessCount" column="Program_Webcall_Success_Count"/>
  <result property="agentWebcallCount" column="Agent_Webcall_Count"/>
  <result property="agentWebcallSuccessCount" column="Agent_Webcall_Success_Count"/>
 </resultMap>
 
 <resultMap id="calResult" type="com.djb.domain.stat.StatAgentRecommend">
  <result property="agentUserId" column="Agent_User_Id"/>
  <result property="programCount" column="Program_Count"/>
  <result property="agentCount" column="Agent_Count"/>
  <result property="programWebcallCount" column="Program_Webcall_Count"/>
  <result property="programWebcallSuccessCount" column="Program_Webcall_Success_Count"/>
  <result property="agentWebcallCount" column="Agent_Webcall_Count"/>
  <result property="agentWebcallSuccessCount" column="Agent_Webcall_Success_Count"/>
 </resultMap>
 
 <resultMap id="statRmdTotal" type="com.djb.domain.stat.StatAgentRecommend">
  <result property="agentUserId" column="Agent_User_Id"/>
  <result property="tmpTotalCount" column="Tmp_Total_Count"/>
 </resultMap>
 
 <!-- 代理人推荐数 -->
 <select id="findRmdAgentTotalCount" parameterType="java.util.Map" resultMap="statRmdTotal">
   SELECT AGENT.Id Agent_User_Id
       ,COUNT(*) Tmp_Total_Count
       FROM Dp_Tender_Recommend_Record RMD_RECORD
 INNER JOIN Du_Agent_Detail AGENT ON RMD_RECORD.Refer_Id = AGENT.Id
     WHERE RMD_RECORD.Delete_Flag = '0'
      AND RMD_RECORD.Tender_Recommed_Type = #{recommedType}
      AND RMD_RECORD.Create_Time &gt; #{startMonthTime}
     AND RMD_RECORD.Create_Time &lt; #{endMonthTime}
  GROUP BY AGENT.Id
  ORDER BY AGENT.Id
 </select>      

 <!-- 方案推荐数 -->
 <select id="findRmdPgmTotalCount" parameterType="java.util.Map" resultMap="statRmdTotal">
   SELECT AGENT.Id Agent_User_Id
       ,COUNT(*) Tmp_Total_Count
       FROM Dp_Tender_Recommend_Record RMD_RECORD
 INNER JOIN Dp_Program PGM ON RMD_RECORD.Refer_Id = PGM.Id
 INNER JOIN Du_Agent_Detail AGENT ON PGM.User_Id = AGENT.Id
    WHERE RMD_RECORD.Tender_Recommed_Type = #{recommedType}
      AND RMD_RECORD.Create_Time &gt; #{startMonthTime}
     AND RMD_RECORD.Create_Time &lt; #{endMonthTime}
   GROUP BY AGENT.Id
  ORDER BY AGENT.Id
 </select>
 
 <!-- 方案推荐电话接通数, 代理人推荐电话接通数-->
 <select id="getWebcallCount" parameterType="java.util.Map" resultMap="statRmdTotal">
      SELECT AGENT.Id Agent_User_Id
          ,COUNT(*) Tmp_Total_Count
       FROM Dp_Call_Record CALL_RECORD 
    INNER JOIN Du_Agent_Detail AGENT ON AGENT.Mobilephone = CALL_RECORD.Called_Phone_Number
       WHERE CALL_RECORD.Delete_Flag = '0'
         AND CALL_RECORD.Call_Position = #{rmdCallPosition}
         AND CALL_RECORD.Create_Time &gt; #{startMonthTime}
         AND CALL_RECORD.Create_Time &lt; #{endMonthTime}
    AND  CALL_RECORD.Called_Phone_Number &lt;&gt; CALL_RECORD.Caller_Phone_Number 
     GROUP BY AGENT.Id
     ORDER BY AGENT.Id
 </select>
 
  <!-- 方案电话接通成功数, 代理人推荐电话接成功数-->
 <select id="getWebcallSuccessCount" parameterType="java.util.Map" resultMap="statRmdTotal">
      SELECT AGENT.Id Agent_User_Id
          ,COUNT(*) Tmp_Total_Count
       FROM Dp_Call_Record CALL_RECORD 
    INNER JOIN Du_Agent_Detail AGENT ON AGENT.Mobilephone = CALL_RECORD.Called_Phone_Number
       WHERE CALL_RECORD.Delete_Flag = '0'
         AND CALL_RECORD.Call_Position = #{rmdCallPosition}
         AND CALL_RECORD.Create_Time &gt; #{startMonthTime}
         AND CALL_RECORD.Create_Time &lt; #{endMonthTime}
    AND  CALL_RECORD.Called_Phone_Number &lt;&gt; CALL_RECORD.Caller_Phone_Number 
         AND EXISTS(
            SELECT 1
             FROM Sm_Call_Result CALL_RESULT
             WHERE CALL_RESULT.Sequence_Id = CALL_RECORD.Call_Sequence_Id
               AND CALL_RESULT.Call_Result = 1
         )
     GROUP BY AGENT.Id
     ORDER BY AGENT.Id
 </select>
 
 <!-- 统计月次数据，总计数据-->
 <select id="calStatData" parameterType="java.util.Map" resultMap="calResult">
      SELECT STAT.Agent_User_Id Agent_User_Id
          ,SUM(Program_Count) Program_Count
          ,SUM(Agent_Count) Agent_Count
          ,SUM(Program_Webcall_Count) Program_Webcall_Count
          ,SUM(Program_Webcall_Success_Count) Program_Webcall_Success_Count
          ,SUM(Agent_Webcall_Count) Agent_Webcall_Count
          ,SUM(Agent_Webcall_Success_Count) Agent_Webcall_Success_Count
       FROM Stat_Agent_Recommend STAT
         WHERE STAT.Stat_Type = #{statType}
          AND STAT.Delete_Flag = '0'
     GROUP BY STAT.Agent_User_Id
      ORDER BY STAT.Agent_User_Id
 </select>
 
 <!-- 获取已经统计的数据 -->
 <select id="findStatDataByType" parameterType="java.util.Map" resultMap="statAgentRecommend">
     SELECT *
       FROM Stat_Agent_Recommend STAT
      WHERE STAT.Delete_Flag = '0'
  <if test="year != null">
        AND STAT.Year = #{year}
  </if>
  <if test="month != null">
        AND STAT.Month = #{month}
  </if>
  <if test="week != null">
        AND STAT.Week = #{week}
  </if>
        AND STAT.Stat_Type = #{statType}
    ORDER BY STAT.Agent_User_Id
 </select>

 <insert id="insert" parameterType="com.djb.domain.stat.StatAgentRecommend">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO
   Stat_Agent_Recommend(
    Agent_User_Id
    ,Stat_Agent_Base_Id
    ,Year
    ,Month
    ,Week
    ,Stat_Type
    ,Program_Count
    ,Agent_Count
    ,Program_Webcall_Count
    ,Program_Webcall_Success_Count
    ,Agent_Webcall_Count
    ,Agent_Webcall_Success_Count
    ,Create_Time
    ,Create_User_Id
    ,Update_Time
    ,Update_User_Id
    ,Delete_Flag
  )
  VALUES(
    #{agentUserId}
    ,#{statAgentBase.id}
    ,#{year}
    ,#{month}
    ,#{week}
    ,#{statType}
    ,#{programCount}
    ,#{agentCount}
    ,#{programWebcallCount}
    ,#{programWebcallSuccessCount}
    ,#{agentWebcallCount}
    ,#{agentWebcallSuccessCount}
    ,#{createDateTime}
    ,#{createUserId}
    ,#{updateDateTime}
    ,#{updateUserId}
    ,#{deleteFlag}
  )
   
  
 </insert>
 
 <update id="update" parameterType="com.djb.domain.stat.StatAgentRecommend">
  UPDATE
   Stat_Agent_Recommend
  SET
     Program_Count=#{programCount}
     ,Agent_Count=#{agentCount}
     ,Program_Webcall_Count=#{programWebcallCount}
     ,Program_Webcall_Success_Count=#{programWebcallSuccessCount}
     ,Agent_Webcall_Count=#{agentWebcallCount}
     ,Agent_Webcall_Success_Count=#{agentWebcallSuccessCount}
     ,Update_Time=#{updateDateTime}
     ,Update_User_Id=#{updateUserId}
     ,Delete_Flag=#{deleteFlag}
  WHERE
   id = #{id}
 </update>
 
</mapper>
==================================== END stat/StatAgentRecommend.xml =========================


==================================== BEGIN stat/StatWebcall.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:06:03 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="StatWebcall">

 <resultMap id="statWebcall" type="com.djb.domain.stat.StatWebcall" extends="DomainObject.domainObject">
  <result property="statAgentBase.id" column="Stat_Agent_Base_Id"/>
  <result property="agentUserId" column="Agent_User_Id"/>
  <result property="year" column="Year"/>
  <result property="month" column="Month"/>
  <result property="week" column="Week"/>
  <result property="statType" column="Stat_Type"/>
  <result property="callUserCount" column="Call_User_Count"/>
  <result property="totalCount" column="Total_Count"/>
  <result property="successCount" column="Success_Count"/>
  <result property="avgCalltime" column="Avg_Call_time"/>
  <result property="failedCount" column="Failed_Count"/>
  <result property="callerFailedCount" column="Caller_Failed_Count"/>
  <result property="calledCutoffCount" column="Called_Cutoff_Count"/>
  <result property="calledFailedCount" column="Called_Failed_Count"/>
  <result property="calledCallingCount" column="Called_Calling_Count"/>
  <result property="failedOtherCount" column="Failed_Other_Count"/>
 </resultMap>
 
 <resultMap id="calStatedWebcall" type="com.djb.domain.stat.StatWebcall">
  <result property="agentUserId" column="Agent_User_Id"/>
  <result property="callUserCount" column="Call_User_Count"/>
  <result property="totalCount" column="Total_Count"/>
  <result property="successCount" column="Success_Count"/>
  <result property="avgCalltime" column="Avg_Call_time"/>
  <result property="failedCount" column="Failed_Count"/>
  <result property="callerFailedCount" column="Caller_Failed_Count"/>
  <result property="calledCutoffCount" column="Called_Cutoff_Count"/>
  <result property="calledFailedCount" column="Called_Failed_Count"/>
  <result property="calledCallingCount" column="Called_Calling_Count"/>
  <result property="failedOtherCount" column="Failed_Other_Count"/>
 </resultMap>
 
 <resultMap id="statWebcallTotal" type="com.djb.domain.stat.StatWebcall">
  <result property="agentUserId" column="Agent_User_Id"/>
  <result property="tmpTotalCount" column="Tmp_Total_Count"/>
 </resultMap>
 
  <!-- 呼叫用户数 -->
 <select id="getCallUserCount" parameterType="java.util.Map" resultMap="statWebcallTotal">
  SELECT Agent_User_Id
     ,COUNT(*) Tmp_Total_Count
    FROM(
    SELECT DISTINCT AGENT.Id Agent_User_Id
            ,CALL_RECORD.Caller_Phone_Number
         FROM Dp_Call_Record CALL_RECORD 
      INNER JOIN Du_Agent_Detail AGENT ON AGENT.Mobilephone = CALL_RECORD.Called_Phone_Number
         WHERE CALL_RECORD.Delete_Flag = '0'
      AND  CALL_RECORD.Called_Phone_Number &lt;&gt; CALL_RECORD.Caller_Phone_Number 
           AND CALL_RECORD.Create_Time &gt; #{startMonthTime}
           AND CALL_RECORD.Create_Time &lt; #{endMonthTime}
       ) SUB_QUERY
 GROUP BY Agent_User_Id
 </select>
 
 
 <!-- WEBCALL合计值统计 -->
 <select id="getWebcallCount" parameterType="java.util.Map" resultMap="statWebcallTotal">
      SELECT AGENT.Id Agent_User_Id
          ,COUNT(*) Tmp_Total_Count
       FROM Dp_Call_Record CALL_RECORD 
    INNER JOIN Du_Agent_Detail AGENT ON AGENT.Mobilephone = CALL_RECORD.Called_Phone_Number
       WHERE CALL_RECORD.Delete_Flag = '0'
    AND  CALL_RECORD.Called_Phone_Number &lt;&gt; CALL_RECORD.Caller_Phone_Number 
         AND CALL_RECORD.Create_Time &gt; #{startWeeklyDate}
         AND CALL_RECORD.Create_Time &lt; #{endWeeklyDate}
<if test="callResults != null">
         AND EXISTS(
            SELECT 1
             FROM Sm_Call_Result CALL_RESULT
             WHERE CALL_RESULT.Sequence_Id = CALL_RECORD.Call_Sequence_Id
               AND CALL_RESULT.Call_Result IN
                   <foreach collection="callResults" item="item" separator="," close=")" open="(">
                  #{item}
                </foreach>
            <if test="failReason != null">       
             AND CALL_RESULT.Fail_Reason = #{failReason}
            </if>
         )
</if>
     GROUP BY AGENT.Id
     ORDER BY AGENT.Id
 </select>
 
 <!-- 呼叫失败总数 -->
 <select id="getFailedTotalCount" parameterType="java.util.Map" resultMap="statWebcallTotal">
 SELECT SUB_QUERY.Agent_User_Id Agent_User_Id
     ,SUM(COUNT) Tmp_Total_Count
   FROM
    (
      SELECT AGENT.Id Agent_User_Id
          ,COUNT(*) Count
       FROM Dp_Call_Record CALL_RECORD 
    INNER JOIN Du_Agent_Detail AGENT ON AGENT.Mobilephone = CALL_RECORD.Called_Phone_Number
       WHERE CALL_RECORD.Delete_Flag = '0'
    AND  CALL_RECORD.Called_Phone_Number &lt;&gt; CALL_RECORD.Caller_Phone_Number 
         AND CALL_RECORD.Create_Time &gt; #{startWeeklyDate}
         AND CALL_RECORD.Create_Time &lt; #{endWeeklyDate}
         AND NOT EXISTS(
            SELECT 1
             FROM Sm_Call_Result CALL_RESULT
             WHERE CALL_RESULT.Sequence_Id = CALL_RECORD.Call_Sequence_Id
         )
      GROUP BY AGENT.Id   
     UNION ALL
     
       SELECT AGENT.Id Agent_User_Id
          ,COUNT(*) Count
       FROM Dp_Call_Record CALL_RECORD 
    INNER JOIN Du_Agent_Detail AGENT ON AGENT.Mobilephone = CALL_RECORD.Called_Phone_Number
       WHERE CALL_RECORD.Delete_Flag = '0'
    AND  CALL_RECORD.Called_Phone_Number &lt;&gt; CALL_RECORD.Caller_Phone_Number 
         AND CALL_RECORD.Create_Time &gt; #{startWeeklyDate}
         AND CALL_RECORD.Create_Time &lt; #{endWeeklyDate}
         AND EXISTS(
            SELECT 1
             FROM Sm_Call_Result CALL_RESULT
             WHERE CALL_RESULT.Sequence_Id = CALL_RECORD.Call_Sequence_Id
         AND CALL_RESULT.Call_Result &lt;&gt; #{callResult} 
         )
     GROUP BY AGENT.Id
   ) SUB_QUERY
   GROUP BY SUB_QUERY.Agent_User_Id
   ORDER BY SUB_QUERY.Agent_User_Id
 </select>
 
 
 <!-- 主叫未接通数 -->
 <select id="getCallerFailedCont" parameterType="java.util.Map" resultMap="statWebcallTotal">
      SELECT AGENT.Id Agent_User_Id
          ,COUNT(*) Tmp_Total_Count
       FROM Dp_Call_Record CALL_RECORD 
    INNER JOIN Du_Agent_Detail AGENT ON AGENT.Mobilephone = CALL_RECORD.Called_Phone_Number
       WHERE CALL_RECORD.Delete_Flag = '0'
    AND  CALL_RECORD.Called_Phone_Number &lt;&gt; CALL_RECORD.Caller_Phone_Number 
         AND CALL_RECORD.Create_Time &gt; #{startWeeklyDate}
         AND CALL_RECORD.Create_Time &lt; #{endWeeklyDate}
         AND NOT EXISTS(
            SELECT 1
             FROM Sm_Call_Result CALL_RESULT
             WHERE CALL_RESULT.Sequence_Id = CALL_RECORD.Call_Sequence_Id
         )
      GROUP BY AGENT.Id
     ORDER BY AGENT.Id
 </select>
 
 <!-- WEBCALL通话时长 -->
 <select id="getCallTime" parameterType="java.util.Map" resultMap="statWebcallTotal">
      SELECT AGENT.Id Agent_User_Id
          ,SUM(CALL_RESULT.Called_Duration) Tmp_Total_Count
       FROM Dp_Call_Record CALL_RECORD 
    INNER JOIN Du_Agent_Detail AGENT ON AGENT.Mobilephone = CALL_RECORD.Called_Phone_Number
    INNER JOIN Sm_Call_Result CALL_RESULT ON CALL_RECORD.Call_Sequence_Id = CALL_RESULT.Sequence_Id
       WHERE CALL_RECORD.Delete_Flag = '0'
    AND  CALL_RECORD.Called_Phone_Number &lt;&gt; CALL_RECORD.Caller_Phone_Number 
         AND CALL_RECORD.Create_Time &gt; #{startMonthTime}
         AND CALL_RECORD.Create_Time &lt; #{endMonthTime}
         AND CALL_RESULT.Call_Result = #{callResultType}
     GROUP BY AGENT.Id
     ORDER BY AGENT.Id
 </select>
 
 <!-- 重新计算总计数据 -->
 <select id="calStatedWebcall" parameterType="java.util.Map" resultMap="calStatedWebcall">
     SELECT STAT.Agent_User_Id Agent_User_Id
         ,SUM(Call_User_Count) Call_User_Count
         ,SUM(Total_Count) Total_Count
         ,SUM(Success_Count) Success_Count
         ,CASE SUM(Success_Count)
          WHEN 0 THEN
           0
          ELSE
           SUM(Avg_Call_time * Success_Count) / SUM(Success_Count)
         END Avg_Call_time
         ,SUM(Failed_Count) Failed_Count
         ,SUM(Caller_Failed_Count) Caller_Failed_Count
         ,SUM(Called_Cutoff_Count) Called_Cutoff_Count
         ,SUM(Called_Failed_Count) Called_Failed_Count
         ,SUM(Called_Calling_Count) Called_Calling_Count
         ,SUM(Failed_Other_Count) Failed_Other_Count
       FROM Stat_Webcall STAT
      WHERE STAT.Delete_Flag = '0'
        AND STAT.Stat_Type = #{statType}
   GROUP BY STAT.Agent_User_Id 
    ORDER BY STAT.Agent_User_Id
 </select>
 
 
 
 <!-- 获取已经统计的数据 -->
 <select id="findStatDataByType" parameterType="java.util.Map" resultMap="statWebcall">
     SELECT *
       FROM Stat_Webcall STAT
      WHERE STAT.Delete_Flag = '0'
  <if test="year != null">
        AND STAT.Year = #{year}
  </if>
  <if test="month != null">
        AND STAT.Month = #{month}
  </if>
  <if test="week != null">
        AND STAT.Week = #{week}
  </if>
        AND STAT.Stat_Type = #{statType}
    ORDER BY STAT.Agent_User_Id
 </select>

 <insert id="insert" parameterType="com.djb.domain.stat.StatWebcall">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO
   Stat_Webcall(
    Agent_User_Id
    ,Stat_Agent_Base_Id
    ,Year
    ,Month
    ,Week
    ,Stat_Type
    ,Call_User_Count
    ,Total_Count
    ,Success_Count
    ,Avg_Call_time
    ,Failed_Count
    ,Caller_Failed_Count
    ,Called_Cutoff_Count
    ,Called_Failed_Count
    ,Called_Calling_Count
    ,Failed_Other_Count
    ,Create_Time
    ,Create_User_Id
    ,Update_Time
    ,Update_User_Id
    ,Delete_Flag
  )
  VALUES(
    #{agentUserId}
    ,#{statAgentBase.id}
    ,#{year}
    ,#{month}
    ,#{week}
    ,#{statType}
    ,#{callUserCount}
    ,#{totalCount}
    ,#{successCount}
    ,#{avgCalltime}
    ,#{failedCount}
    ,#{callerFailedCount}
    ,#{calledCutoffCount}
    ,#{calledFailedCount}
    ,#{calledCallingCount}
    ,#{failedOtherCount}
    ,#{createDateTime}
    ,#{createUserId}
    ,#{updateDateTime}
    ,#{updateUserId}
    ,#{deleteFlag}
  )
   
  
 </insert>
 
 <update id="update" parameterType="com.djb.domain.stat.StatWebcall">
  UPDATE
   Stat_Webcall
  SET
     Call_User_Count=#{callUserCount}
     ,Total_Count=#{totalCount}
     ,Success_Count=#{successCount}
     ,Avg_Call_time=#{avgCalltime}
     ,Failed_Count=#{failedCount}
     ,Caller_Failed_Count=#{callerFailedCount}
     ,Called_Cutoff_Count=#{calledCutoffCount}
     ,Called_Failed_Count=#{calledFailedCount}
     ,Called_Calling_Count=#{calledCallingCount}
     ,Failed_Other_Count=#{failedOtherCount}
     ,Update_Time=#{updateDateTime}
     ,Update_User_Id=#{updateUserId}
     ,Delete_Flag=#{deleteFlag}
  WHERE
   id = #{id}
 </update>
 
</mapper>
==================================== END stat/StatWebcall.xml =========================


==================================== BEGIN stat/StatAgentBase.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:06:01 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="StatAgentBase">

  <resultMap id="statAgentBase" type="com.djb.domain.stat.StatAgentBase" extends="DomainObject.domainObject">
   <result property="agentId" column="Agent_User_Id"/>
   <result property="agentName" column="Agent_User_Name"/>
   <result property="agentProvinceName" column="Agent_Province_Name"/>
   <result property="agentCityName" column="Agent_City_Name"/>
   <result property="agentCompanyId" column="Agent_Company_Id"/>
   <result property="agentCompanyName" column="Agent_Company_Name"/>
   <result property="year" column="Year"/>
   <result property="month" column="Month"/>
   <result property="payDates" column="Pay_Dates"/>
   <result property="packageType" column="Package_Type"/>
   <result property="contractOpenStatus" column="Contract_Open_Status"/>
   <result property="contractOpenType" column="Contract_Open_Type"/>
   <result property="contractOpenDatetime" column="Contract_Open_Datetime"/>
   <result property="contractExpiredStatus" column="Contract_Expired_Status"/>
   <result property="contractExpiredDatetime" column="Contract_Expired_Datetime"/>
   <result property="contractId" column="Contract_Id"/>
  </resultMap>
 
 <insert id="insert" parameterType="com.djb.domain.stat.StatAgentBase">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
   INSERT INTO 
    Stat_Agent_Base(
     Agent_User_Id
     ,Agent_User_Name
     ,Agent_Province_Name
     ,Agent_City_Name
     ,Agent_Company_Id
     ,Agent_Company_Name
     ,Year
     ,Month
     ,Pay_Dates
     ,Package_Type
     ,Contract_Open_Status
     ,Contract_Open_Type
     ,Contract_Open_Datetime
     ,Contract_Expired_Status
     ,Contract_Expired_Datetime
     ,Contract_Id
     ,Create_Time
     ,Create_User_Id
     ,Update_Time
     ,Update_User_Id
     ,Delete_Flag
    )
   VALUES(
    #{agentId}
    ,#{agentName}
    ,#{agentProvinceName}
    ,#{agentCityName}
    ,#{agentCompanyId}
    ,#{agentCompanyName}
    ,#{year}
    ,#{month}
    ,#{payDates}
    ,#{packageType}
    ,#{contractOpenStatus}
    ,#{contractOpenType}
    ,#{contractOpenDatetime}
    ,#{contractExpiredStatus}
    ,#{contractExpiredDatetime}
    ,#{contractId}
    ,#{createDateTime}
    ,#{createUserId}
    ,#{updateDateTime}
    ,#{updateUserId}
    ,#{deleteFlag}
   )
   
  
 </insert>
 
 <update id="update" parameterType="com.djb.domain.stat.StatAgentBase">
  UPDATE
   Stat_Agent_Base
  SET
     Pay_Dates=#{payDates}
     ,Package_Type=#{packageType}
     ,Contract_Open_Status=#{contractOpenStatus}
     ,Contract_Open_Type=#{contractOpenType}
     ,Contract_Open_Datetime=#{contractOpenDatetime}
     ,Contract_Expired_Status=#{contractExpiredStatus}
     ,Contract_Expired_Datetime=#{contractExpiredDatetime}
     ,Contract_Id=#{contractId}
     ,Update_Time=#{updateDateTime}
     ,Update_User_Id=#{updateUserId}
     ,Delete_Flag=#{deleteFlag}
  WHERE
   id = #{id}
 </update>
 
 <delete id="deleteByPrimaryKey">
  DELETE FROM Stat_Agent_Base WHERE Id = #{Id}
 </delete>
 

</mapper>
==================================== END stat/StatAgentBase.xml =========================


==================================== BEGIN stat/StatRmdFeature.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:06:02 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="StatRmdFeature">

  <resultMap id="statRmdFeature" type="com.djb.domain.stat.StatRmdFeature" extends="DomainObject.domainObject">
   <result property="agentUserId" column="agent_User_Id"/>
   <result property="packageType" column="Package_Type"/>
   <result property="agentUserName" column="Agent_User_Name"/>
   <result property="agentProvinceName" column="Agent_Province_Name"/>
   <result property="agentCityName" column="Agent_City_Name"/>
   <result property="agentCompanyId" column="Agent_Company_Id"/>
   <result property="agentCompanyName" column="Agent_Company_Name"/>
   <result property="sex" column="Sex"/>
   <result property="mobilephone" column="Mobilephone"/>
   <result property="serviceArea" column="Service_Area"/>
   <result property="serviceSpecialty" column="Service_Specialty"/>
   <result property="payDates" column="Pay_Dates"/>
   <result property="cosineAvgRmd" column="Cosine_Avg_Rmd"/>
   <result property="rmdTotalCount" column="Rmd_Total_Count"/>
   <result property="phoneTotalCount" column="Phone_Total_Count"/>
   <result property="mailTotalCount" column="Mail_Total_Count"/>
   <result property="totalCount" column="Total_Count"/>
   <result property="successCount" column="Success_Count"/>
   <result property="phoneCurDateCount" column="Phone_CurDate_Count"/>
   <result property="mailCurDateCount" column="Mail_CurDate_Count"/>
   <result property="isAvg" column="Is_Avg"/>
  </resultMap>
  
  <resultMap id="calStatRmdFeature" type="com.djb.domain.stat.StatRmdFeature">
   <result property="agentUserId" column="agent_User_Id"/>
   <result property="packageType" column="Package_Type"/>
   <result property="agentUserName" column="Agent_User_Name"/>
   <result property="agentProvinceName" column="Agent_Province_Name"/>
   <result property="agentCityName" column="Agent_City_Name"/>
   <result property="agentCompanyId" column="Agent_Company_Id"/>
   <result property="agentCompanyName" column="Agent_Company_Name"/>
   <result property="payDates" column="Pay_Dates"/>
   <result property="sex" column="Sex"/>
   <result property="mobilephone" column="Mobilephone"/>
   <result property="serviceArea" column="Service_Area"/>
   <result property="serviceSpecialty" column="Service_Specialty"/>
   <result property="rmdTotalCount" column="Rmd_Total_Count"/>
   <result property="phoneTotalCount" column="Phone_Total_Count"/>
   <result property="mailTotalCount" column="Mail_Total_Count"/>
   <result property="totalCount" column="Total_Count"/>
   <result property="successCount" column="Success_Count"/>
  </resultMap>
  
  <select id="findAvgStatRmdFeature" resultMap="statRmdFeature">
   SELECT *
     FROM Stat_Rmd_Feature
    WHERE Is_Avg = 1
      AND Delete_Flag = 0
  </select>
  
  <select id="findByAgentId" parameterType="long" resultMap="statRmdFeature">
   SELECT *
     FROM Stat_Rmd_Feature
    WHERE agent_User_Id = #{agentId}
      AND Delete_Flag = 0
      ORDER BY update_time DESC
      LIMIT 1
  </select>
  
  <select id="findDispatchAgent" parameterType="com.djb.domain.stat.StatRmdFeatureQueryBean" resultMap="AgentUser.agentUser">
   SELECT dUser.*,agentUser.*
     FROM Du_Agent_Detail agentUser
     JOIN Du_User dUser ON  dUser.id = agentUser.id
     LEFT JOIN Stat_Rmd_Feature rmdFeature ON agentUser.id = rmdFeature.agent_User_Id
     
    WHERE agentUser.Delete_Flag = 0
   AND dUser.Province = #{agentProvinceId}
   AND agentUser.Fee_Status = 1
   AND agentUser.Verify_Status = 1
   AND agentUser.Mobile_Phone_Status = 1
   AND agentUser.Image_Status = 1
   
      <if test="agentCompanyId != null">
      AND agentUser.Company = #{agentCompanyId}
      </if>
      <if test="serviceArea != null">
      AND agentUser.Service_Area like '%${serviceArea}%'
      </if>
      <if test="serviceSpecialty != null">
      AND agentUser.Service_Specialty like '%${serviceSpecialty}%'
      </if>
      <if test="agentUserName != null">
      AND agentUser.True_Name = #{agentUserName}
      </if>
      <if test="mobilephone != null">
      AND agentUser.Mobilephone = #{mobilephone}
      </if>
      <if test="agentUserId != null">
      AND agentUser.id = #{agentUserId}
      </if>
      
  </select>
  
  <!-- 计算上个月的指标数据 -->
  <select id="calAgentData" parameterType="java.util.Map" resultMap="calStatRmdFeature">
    SELECT  AGENT_STAT.Agent_User_Id
    ,AGENT.Package_Type
          ,AGENT.True_Name Agent_User_Name
          ,PROVINCE.City_Name Agent_Province_Name
          ,CITY.City_Name Agent_City_Name
          ,COMPANY.Id Agent_Company_Id
          ,COMPANY.Company_Nick_Name Agent_Company_Name
    ,AGENT_STAT.Pay_Dates          
             ,AGENT.Sex
    ,AGENT.Mobilephone
    ,AGENT.Service_Area
    ,AGENT.Service_Specialty
    ,AGENT_STAT.Rmd_Total_Count
    ,AGENT_STAT.Phone_Total_Count
    ,AGENT_STAT.Mail_Total_Count
    ,AGENT_STAT.Total_Count
    ,AGENT_STAT.Success_Count
  FROM (
   SELECT STAT_AGENT.Agent_Id Agent_User_Id
     ,COUNT(STAT_AGENT.Id) Pay_Dates
     ,SUM(STAT_AGENT.Recommend_Program_Count + STAT_AGENT.Recommend_Agent_Count) Rmd_Total_Count
        ,SUM(STAT_AGENT.Phonetender_Get_Count) Phone_Total_Count
        ,SUM(STAT_AGENT.Mailtender_Get_Count) Mail_Total_Count
        ,SUM(STAT_AGENT.Unique_Count) Total_Count
        ,SUM(STAT_AGENT.Unique_Success_Count) Success_Count
    FROM Stat_Agent_Detail STAT_AGENT
    INNER JOIN(
        SELECT CON.Customer_Id
          ,MAX(CON.Package_End_Time) End_Date
          FROM Sm_Contract_Agent CON
         WHERE CON.Delete_Flag = '0'
         GROUP BY Customer_Id
        ) LAST_CONTRACT ON LAST_CONTRACT.End_Date &gt; #{curDate} AND LAST_CONTRACT.Customer_Id = STAT_AGENT.Agent_Id
   WHERE STAT_AGENT.Stat_Date &lt; #{curDate}
     AND STAT_AGENT.Stat_Date &gt; #{startDate}
     AND   STAT_AGENT.Fee_Status=#{feeStatus}     
     AND STAT_AGENT.Delete_Flag = 0
   GROUP BY   STAT_AGENT.Agent_Id
  )  AGENT_STAT
    ,Du_Agent_Detail AGENT
    ,Du_User DUUSER
    ,Sm_City PROVINCE
    ,Sm_City CITY
    ,Sm_Company COMPANY
   WHERE AGENT_STAT.Agent_User_Id = AGENT.Id
   AND AGENT.Id = DUUSER.Id
  AND DUUSER.Province = PROVINCE.Id
  AND DUUSER.City = CITY.Id
  AND AGENT.Company = COMPANY.Id
  </select>
 
 <insert id="insert" parameterType="com.djb.domain.stat.StatRmdFeature">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
   INSERT INTO 
    Stat_Rmd_Feature(
    Agent_User_Id
    ,Package_Type
    ,Agent_User_Name
    ,Agent_Province_Name
    ,Agent_City_Name
    ,Agent_Company_Id
    ,Agent_Company_Name
    ,Sex
    ,Mobilephone
    ,Service_Area
    ,Service_Specialty
    ,Pay_Dates
    ,Cosine_Avg_Rmd
    ,Rmd_Total_Count
    ,Phone_Total_Count
    ,Mail_Total_Count
    ,Total_Count
    ,Success_Count
    ,Is_Avg
    ,Create_Time
    ,Create_User_Id
    ,Update_Time
    ,Update_User_Id
    ,Delete_Flag
    )
 VALUES(
    #{agentUserId}
    ,#{packageType}
    ,#{agentUserName}
    ,#{agentProvinceName}
    ,#{agentCityName}
    ,#{agentCompanyId}
    ,#{agentCompanyName}
    ,#{sex}
    ,#{mobilephone}
    ,#{serviceArea}
    ,#{serviceSpecialty}
    ,#{payDates}
    ,#{cosineAvgRmd}
    ,#{rmdTotalCount}
    ,#{phoneTotalCount}
    ,#{mailTotalCount}
    ,#{totalCount}
    ,#{successCount}
    ,#{isAvg}
    ,#{createDateTime}
    ,#{createUserId}
    ,#{updateDateTime}
    ,#{updateUserId}
    ,#{deleteFlag}
   )
 
  
 </insert>
 
 <update id="updateAgentRmdCount">
  UPDATE Stat_Rmd_Feature
     SET Rmd_Total_Count = Rmd_Total_Count + 1
   WHERE Agent_User_Id = #{agentUserId}
     AND Is_Avg = '0' 
 </update>
 
 <update id="updatePgmRmdCount">
  UPDATE Stat_Rmd_Feature
     SET Rmd_Total_Count = Rmd_Total_Count + 1
   WHERE Agent_User_Id = (
      SELECT User_Id 
        FROM Dp_Program
       WHERE id=#{pgmId} 
   )
     AND Is_Avg = '0' 
 </update>
 
 
 <update id="updateWebcallCount">
  UPDATE Stat_Rmd_Feature
     SET Total_Count = Total_Count + 1
   WHERE Agent_User_Id = #{id}
     AND Is_Avg = '0' 
 </update>
 
 <update id="updateSuccessWebcallCount">
  UPDATE Stat_Rmd_Feature
     SET Success_Count = Success_Count + 1
   WHERE Agent_User_Id = (
      SELECT Called_Id
        FROM Sm_Call_Result CALL_RESULT 
     INNER JOIN Dp_Call_Record CALL_RECORD ON CALL_RECORD.Call_Sequence_Id = CALL_RESULT.Sequence_Id
       WHERE CALL_RESULT.Sequence_Id = #{sequenceId}
     )
     AND Is_Avg = '0'
 </update>
 
 <update id="updatePhoneTenderCount">
  UPDATE Stat_Rmd_Feature
     SET Phone_Total_Count = Phone_Total_Count + 1
       ,Phone_CurDate_Count = Phone_CurDate_Count + 1
       ,Update_Time= now()
       ,Update_User_Id=1
   WHERE Agent_User_Id = #{id}
     AND Is_Avg = '0'
 </update>
 
 <update id="updateMailTenderCount">
  UPDATE Stat_Rmd_Feature
     SET Mail_Total_Count = Mail_Total_Count + 1
       ,Mail_CurDate_Count = Mail_CurDate_Count + 1
       ,Update_Time= now()
       ,Update_User_Id=1
   WHERE Agent_User_Id = #{id}
     AND Is_Avg = '0'
 </update>
 
 <update id="update" parameterType="com.djb.domain.stat.StatRmdFeature">
  UPDATE
     Stat_Rmd_Feature
   SET
     Package_Type=#{packageType}
     ,Agent_Province_Name=#{agentProvinceName}
     ,Agent_City_Name=#{agentCityName}
     ,Agent_Company_Id=#{agentCompanyId}
     ,Agent_Company_Name=#{agentCompanyName}
     ,Sex=#{sex}
     ,Mobilephone=#{mobilephone}
     ,Service_Area=#{serviceArea}
     ,Service_Specialty=#{serviceSpecialty}
     ,Pay_Dates=#{payDates}
     ,Cosine_Avg_Rmd=#{cosineAvgRmd}
     ,Rmd_Total_Count=#{rmdTotalCount}
     ,Phone_Total_Count=#{phoneTotalCount}
     ,Mail_Total_Count=#{mailTotalCount}
     ,Total_Count=#{totalCount}
     ,Success_Count=#{successCount}
     ,Update_Time=#{updateDateTime}
     ,Update_User_Id=#{updateUserId}
     ,Delete_Flag=#{deleteFlag}
  WHERE
   id = #{id}
 </update>
 
 <delete id="deleteByPrimaryKey">
  DELETE FROM Stat_Rmd_Feature WHERE Id = #{id}
 </delete>
 
 <delete id="removeAll">
  DELETE FROM Stat_Rmd_Feature
 </delete>
 
</mapper>
==================================== END stat/StatRmdFeature.xml =========================


==================================== BEGIN stat/StatTenderDispatch.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:06:02 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="StatTenderDispatch">

 <resultMap id="statTenderDispatch" type="com.djb.domain.stat.StatTenderDispatch" extends="DomainObject.domainObject">
  <result property="statAgentBase.id" column="Stat_Agent_Base_Id"/>
  <result property="AgentUserId" column="Agent_User_Id"/>
  <result property="year" column="Year"/>
  <result property="month" column="Month"/>
  <result property="statType" column="Stat_Type"/>
  <result property="phoneTotalCount" column="Phone_Total_Count"/>
  <result property="mailTotalCount" column="Mail_Total_Count"/>
  <result property="mailAVGHandleTime" column="Mail_AVG_Handle_Time"/>
  <result property="mailHandleCount" column="Mail_Handle_Count"/>
  <result property="mailRecycledCount" column="Mail_Recycled_Count"/>
  <result property="mailRecycledRate" column="Mail_Recycled_Rate"/>
  <result property="edmOpenCount" column="Edm_Open_Count"/>
  <result property="edmWebcallCount" column="Edm_Webcall_Count"/>
  <result property="edmSuccessCount" column="Edm_Success_Count"/>
  <result property="mailSuccessRate" column="Mail_Success_Rate"/>
 </resultMap>
 
 <resultMap id="statTotally" type="com.djb.domain.stat.StatTenderDispatch">
  <result property="AgentUserId" column="Agent_User_Id"/>
  <result property="phoneTotalCount" column="Phone_Total_Count"/>
  <result property="mailTotalCount" column="Mail_Total_Count"/>
  <result property="mailAVGHandleTime" column="Mail_AVG_Handle_Time"/>
  <result property="mailHandleCount" column="Mail_Handle_Count"/>
  <result property="mailRecycledCount" column="Mail_Recycled_Count"/>
  <result property="mailRecycledRate" column="Mail_Recycled_Rate"/>
  <result property="edmOpenCount" column="Edm_Open_Count"/>
  <result property="edmWebcallCount" column="Edm_Webcall_Count"/>
  <result property="edmSuccessCount" column="Edm_Success_Count"/>
  <result property="mailSuccessRate" column="Mail_Success_Rate"/>
 </resultMap>
 
 <resultMap id="totalDispatch" type="com.djb.domain.stat.StatTenderDispatch">
  <result property="AgentUserId" column="Agent_User_Id"/>
  <result property="tmpTotalCount" column="Tmp_Total_Count"/>
 </resultMap>
 
 <!-- 电话标得标数, 邮件标得标数 -->
 <select id="getTenderTotalCount" parameterType="java.util.Map" resultMap="totalDispatch">
   SELECT SUB_QUERY.Agent_User_Id Agent_User_Id
       ,COUNT(*) Tmp_Total_Count
    FROM (
        SELECT DISTINCT Tender_Id
                        ,Agent_Id Agent_User_Id
             FROM Dp_Tender_Dispatch_Record TD_RECORD
              WHERE TD_RECORD.Delete_Flag = '0'
                AND TD_RECORD.TYPE = #{tenderType}
               AND TD_RECORD.Create_Time &gt; #{startMonthTime}
               AND TD_RECORD.Create_Time &lt; #{endMonthTime}
       ) SUB_QUERY
  GROUP BY SUB_QUERY.Agent_User_Id
  ORDER BY SUB_QUERY.Agent_User_Id
 </select>
 
 <!-- 获取标书分配时间与方案的发布时间 -->
 <select id="getDispatchTimeAndSubmitTime" parameterType="java.util.Map" resultMap="totalDispatch">
      SELECT TD_RECORD.Agent_Id Agent_User_Id
          ,SUM(TIMESTAMPDIFF(HOUR, TD_RECORD.Create_Time, PROGRAM.Create_Time)) Tmp_Total_Count
       FROM Dp_Tender_Dispatch_Record TD_RECORD
    INNER JOIN Dp_Program PROGRAM ON TD_RECORD.Program_Id = PROGRAM.Id
       WHERE TD_RECORD.Delete_Flag = '0'
         AND TD_RECORD.TYPE = #{tenderType}
         AND TD_RECORD.Create_Time &gt; #{startMonthTime}
         AND TD_RECORD.Create_Time &lt; #{endMonthTime}
         AND TD_RECORD.Status &gt; #{agentSubmitStatus}
     AND TD_RECORD.Status &lt;&gt; #{recycledStatus}  
     GROUP BY  Agent_Id
     ORDER BY Agent_Id
 </select>
 
 <!-- 邮件标处理数 -->
 <select id="getMailHandledCount" parameterType="java.util.Map" resultMap="totalDispatch">
      SELECT TD_RECORD.Agent_Id Agent_User_Id
          ,COUNT(*) Tmp_Total_Count
       FROM Dp_Tender_Dispatch_Record TD_RECORD
       WHERE TD_RECORD.Delete_Flag = '0'
         AND TD_RECORD.TYPE =#{tenderType}
         AND TD_RECORD.Create_Time &gt; #{startMonthTime}
         AND TD_RECORD.Create_Time &lt; #{endMonthTime}
     AND TD_RECORD.Status &gt;= #{startStatus}  
     AND TD_RECORD.Status &lt;&gt; #{recycledStatus}  
     GROUP BY Agent_Id
     ORDER BY Agent_Id
 </select>
 
 <!-- 邮件标被回收数 -->
 <select id="getMailTenderRecycleCount" parameterType="java.util.Map" resultMap="totalDispatch">
      SELECT TD_RECORD.Agent_Id Agent_User_Id
          ,COUNT(*) Tmp_Total_Count
       FROM Dp_Tender_Dispatch_Record TD_RECORD
       WHERE TD_RECORD.Delete_Flag = '0'
         AND TD_RECORD.TYPE = #{tenderType}
         AND TD_RECORD.Create_Time &gt; #{startMonthTime}
         AND TD_RECORD.Create_Time &lt; #{endMonthTime}
         AND TD_RECORD.Status = #{recycledStatus}
         AND NOT EXISTS(
            SELECT 1
             FROM Dp_Tender_Dispatch_Record TD_RECORD2
             WHERE TD_RECORD2.Tender_Id = TD_RECORD.Tender_Id
               AND TD_RECORD2.Agent_Id = TD_RECORD.Agent_Id
        AND TD_RECORD2.Status &lt;&gt; #{recycledStatus}    
         )
     GROUP BY Agent_Id
     ORDER BY Agent_Id
 </select>
 
 <!-- EDM被打开数 -->
 <select id="getEdmOpenCount" parameterType="java.util.Map" resultMap="totalDispatch">
      SELECT TD_RECORD.Agent_Id Agent_User_Id
          ,COUNT(*) Tmp_Total_Count
       FROM Dp_Tender_Dispatch_Record TD_RECORD
       WHERE TD_RECORD.Delete_Flag = '0'
         AND TD_RECORD.TYPE =#{tenderType}
         AND TD_RECORD.Create_Time &gt; #{startMonthTime}
         AND TD_RECORD.Create_Time &lt; #{endMonthTime}
     AND TD_RECORD.Status &gt;= #{edmOpenStatus}  
     AND TD_RECORD.Status &lt;= #{userCalledStatus}  
     GROUP BY Agent_Id
     ORDER BY Agent_Id
 </select>
 
 <!-- EDM WEBCALL数 -->
 <select id="getEdmWebcallCount" parameterType="java.util.Map" resultMap="totalDispatch">
      SELECT TD_RECORD.Agent_Id Agent_User_Id
          ,COUNT(*) Tmp_Total_Count
       FROM Dp_Call_Record CALL_RECORD 
    INNER JOIN Dp_Tender_Dispatch_Record TD_RECORD ON CALL_RECORD.Related_Id1 = TD_RECORD.Tender_Id
       WHERE TD_RECORD.Delete_Flag = '0'
         AND TD_RECORD.TYPE =#{tenderType}
         AND TD_RECORD.Create_Time &gt; #{startMonthTime}
         AND TD_RECORD.Create_Time &lt; #{endMonthTime}
         AND TD_RECORD.Status = #{userCalledStatus}
         AND CALL_RECORD.Call_Position = #{edmCallPosition}
    AND  CALL_RECORD.Called_Phone_Number &lt;&gt; CALL_RECORD.Caller_Phone_Number 
     GROUP BY Agent_Id
     ORDER BY Agent_Id
 </select>
 
 <!-- EDM 通话成功数 -->
 <select id="getEdmSuccessCount" parameterType="java.util.Map" resultMap="totalDispatch">
      SELECT TD_RECORD.Agent_Id Agent_User_Id
          ,COUNT(*) Tmp_Total_Count
       FROM Dp_Call_Record CALL_RECORD 
    INNER JOIN Dp_Tender_Dispatch_Record TD_RECORD ON CALL_RECORD.Related_Id1 = TD_RECORD.Tender_Id
       WHERE TD_RECORD.Delete_Flag = '0'
         AND TD_RECORD.TYPE = #{tenderType}
         AND TD_RECORD.Create_Time &gt; #{startMonthTime}
         AND TD_RECORD.Create_Time &lt; #{endMonthTime}
         AND TD_RECORD.Status = #{userCalledStatus}
         AND CALL_RECORD.Call_Position = #{edmCallPosition}
    AND  CALL_RECORD.Called_Phone_Number &lt;&gt; CALL_RECORD.Caller_Phone_Number 
         AND EXISTS(
            SELECT 1
             FROM Sm_Call_Result CALL_RESULT
             WHERE CALL_RESULT.Sequence_Id = CALL_RECORD.Call_Sequence_Id
               AND CALL_RESULT.Call_Result = 1
         )
     GROUP BY Agent_Id
     ORDER BY Agent_Id
 </select>
 
 
 <select id="findStatedTenderDispatch" parameterType="java.util.Map" resultMap="statTenderDispatch">
     SELECT *
       FROM Stat_Tender_Dispatch STAT
      WHERE STAT.Delete_Flag = '0'
 <if test="month != null">     
        AND STAT.Year = #{year}
 </if>
 <if test="month != null">
        AND STAT.Month = #{month}
 </if>
        AND STAT.Stat_Type = #{statType}
    ORDER BY STAT.Agent_User_Id
 </select>
 
 <select id="calTotallyTenderDispatch" parameterType="java.util.Map" resultMap="statTotally">
     SELECT STAT.Agent_User_Id Agent_User_Id
         ,SUM(Phone_Total_Count) Phone_Total_Count
         ,SUM(Mail_Total_Count) Mail_Total_Count
         ,CASE SUM(Mail_Total_Count)
          WHEN 0 THEN
           0
          ELSE
           SUM(Mail_AVG_Handle_Time * Mail_Total_Count) / SUM(Mail_Total_Count)
         END Mail_AVG_Handle_Time
         ,SUM(Mail_Handle_Count) Mail_Handle_Count
         ,SUM(Mail_Recycled_Count) Mail_Recycled_Count
         ,CASE SUM(Mail_Total_Count)
          WHEN 0 THEN
           0
          ELSE
           SUM(Mail_Recycled_Count) / SUM(Mail_Total_Count)
         END Mail_Recycled_Rate
         ,SUM(Edm_Open_Count) Edm_Open_Count
         ,SUM(Edm_Webcall_Count) Edm_Webcall_Count
         ,SUM(Edm_Success_Count) Edm_Success_Count
         ,CASE SUM(Mail_Total_Count)
          WHEN 0 THEN
           0
          ELSE
           SUM(Edm_Success_Count) / SUM(Mail_Total_Count)
         END Mail_Success_Rate
       FROM Stat_Tender_Dispatch STAT
      WHERE STAT.Stat_Type = #{statType}
        AND STAT.Delete_Flag = '0'
   GROUP BY STAT.Agent_User_Id 
    ORDER BY STAT.Agent_User_Id
 </select>

 <insert id="insert" parameterType="com.djb.domain.stat.StatTenderDispatch">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO
   Stat_Tender_Dispatch(
    Agent_User_Id
    ,Stat_Agent_Base_Id
    ,Year
    ,Month
    ,Stat_Type
    ,Phone_Total_Count
    ,Mail_Total_Count
    ,Mail_AVG_Handle_Time
    ,Mail_Handle_Count
    ,Mail_Recycled_Count
    ,Mail_Recycled_Rate
    ,Edm_Open_Count
    ,Edm_Webcall_Count
    ,Edm_Success_Count
    ,Mail_Success_Rate
    ,Create_Time
    ,Create_User_Id
    ,Update_Time
    ,Update_User_Id
    ,Delete_Flag
  )
  VALUES(
    #{AgentUserId}
    ,#{statAgentBase.id}
    ,#{year}
    ,#{month}
    ,#{statType}
    ,#{phoneTotalCount}
    ,#{mailTotalCount}
    ,#{mailAVGHandleTime}
    ,#{mailHandleCount}
    ,#{mailRecycledCount}
    ,#{mailRecycledRate}
    ,#{edmOpenCount}
    ,#{edmWebcallCount}
    ,#{edmSuccessCount}
    ,#{mailSuccessRate}
    ,#{createDateTime}
    ,#{createUserId}
    ,#{updateDateTime}
    ,#{updateUserId}
    ,#{deleteFlag}
  )
   
  
 </insert>
 
 <update id="update" parameterType="com.djb.domain.stat.StatTenderDispatch">
  UPDATE
   Stat_Tender_Dispatch
  SET
     Year=#{year}
     ,Month=#{month}
     ,Stat_Type=#{statType}
     ,Phone_Total_Count=#{phoneTotalCount}
     ,Mail_Total_Count=#{mailTotalCount}
     ,Mail_AVG_Handle_Time=#{mailAVGHandleTime}
     ,Mail_Handle_Count=#{mailHandleCount}
     ,Mail_Recycled_Count=#{mailRecycledCount}
     ,Mail_Recycled_Rate=#{mailRecycledRate}
     ,Edm_Open_Count=#{edmOpenCount}
     ,Edm_Webcall_Count=#{edmWebcallCount}
     ,Edm_Success_Count=#{edmSuccessCount}
     ,Mail_Success_Rate=#{mailSuccessRate}
     ,Update_Time=#{updateDateTime}
     ,Update_User_Id=#{updateUserId}
     ,Delete_Flag=#{deleteFlag}
  WHERE
   id = #{id}
 </update>
 
</mapper>
==================================== END stat/StatTenderDispatch.xml =========================


==================================== BEGIN article/ArticleCategor.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="ArticleCategor">

 <resultMap id="articleCategor" type="com.djb.domain.article.ArticleCategor"
  extends="DomainObject.domainObject">
  <result property="categoryName" column="Category_Name" />
 </resultMap>

 <select id="load" resultMap="articleCategor">
  SELECT *
  FROM Sm_Article_Categor
  WHERE id = #{id}
  AND delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.article.ArticleCategor">
  UPDATE Sm_Article_Categor
  SET
  Category_Name=#{categoryName}
  ,Delete_Flag=#{deleteFlag}
  ,Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime}
  WHERE id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.article.ArticleCategor">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO Sm_Article_Categor(
  Category_Name
  ,Delete_Flag
  ,Create_User_Id
  ,Create_Time
  ,Update_User_Id
  ,Update_Time
  )
  VALUES(
  #{categoryName}
  ,#{deleteFlag}
  ,#{createUserId}
  ,#{createDateTime}
  ,#{updateUserId}
  ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey">
  DELETE FROM Sm_Article_Categor
  WHERE id = #{id}
 </delete>

 <select id="findArticleCategorCountByQueryBean" parameterType="com.djb.domain.article.ArticleCategorQueryBean"
  resultType="int">
  SELECT COUNT(*)
  FROM Sm_Article_Categor categor
  WHERE categor.Delete_Flag=0
  <if test="createUserId">
   and Create_User_Id=#{createUserId}
  </if>
 </select>

 <select id="findArticleCategorByQueryBean" parameterType="com.djb.domain.article.ArticleCategorQueryBean"
  resultMap="articleCategor">
  SELECT *
  FROM Sm_Article_Categor categor
  WHERE categor.Delete_Flag=0
  <if test="createUserId">
   and Create_User_Id=#{createUserId}
  </if>
  ORDER BY categor.Create_Time DESC
  LIMIT ${startIndex}, ${pageSize}
 </select>

 <select id="findArticleByCreateUserId" parameterType="long"
  resultMap="articleCategor">
  SELECT * FROM Sm_Article_Categor categor
  WHERE categor.Create_User_Id=#{createUserId}
  and categor.Delete_Flag=0
 </select>

 <select id="findArticleCategorByArticleCategor" parameterType="com.djb.domain.article.ArticleCategor"
  resultMap="articleCategor">
  SELECT * FROM Sm_Article_Categor categor
  WHERE categor.Delete_Flag=0
  <if test="createUserId!=null">
   and categor.Create_User_Id=#{createUserId}
  </if>
  <if test="categoryName!=null">
   and Category_Name=#{categoryName}
  </if>

 </select>
</mapper>
==================================== END article/ArticleCategor.xml =========================


==================================== BEGIN article/AgentArticle.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="AgentArticle" >

 <resultMap id="agentArticle" type="com.djb.domain.article.AgentArticle" extends="DomainObject.domainObject" >
  <result property="articleTitle" column="Article_Title" />
  <result property="articleContent" column="Article_Content" />
  <result property="isDraft" column="Is_Draft" />
  <result property="isRecyle" column="Is_Recyle" />
 </resultMap>

 <select id="load" resultMap="agentArticle" >
  SELECT  *
    FROM  Sm_Agent_Article
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.article.AgentArticle" >
  UPDATE  Sm_Agent_Article
     SET  
   Article_Title=#{articleTitle}
   ,Article_Content=#{articleContent}
   ,Is_Draft=#{isDraft}
   ,Is_Recyle=#{isRecyle}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   WHERE  id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.article.AgentArticle" >
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Sm_Agent_Article(
   Article_Title
   ,Article_Content
   ,Is_Draft
   ,Is_Recyle
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{articleTitle}
   ,#{articleContent}
   ,#{isDraft}
   ,#{isRecyle}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey" >
  DELETE FROM  Sm_Agent_Article
        WHERE  id = #{id}
 </delete>
 
 <sql id="findAgentArticleByQueryBeanRef">
  FROM Sm_Agent_Article article
  WHERE article.Delete_Flag=0
  <if test="isDraft!=null">
  and article.Is_Draft=#{isDraft}
  </if>
  <if test="isRecyle!=null">
  and article.Is_Recyle=#{isRecyle}
  </if>
  <if test="createUserId!=null">
  and Create_User_Id=#{createUserId}
  </if>
 </sql>
 
 <select id="findAgentArticleCountByQueryBean" parameterType="com.djb.domain.article.AgentArticleQueryBean" resultType="int">
  SELECT COUNT(*) <include refid="findAgentArticleByQueryBeanRef"/>
 </select>
 
 <select id="findAgentArticleByQueryBean" parameterType="com.djb.domain.article.AgentArticleQueryBean" resultMap="agentArticle">
  SELECT * <include refid="findAgentArticleByQueryBeanRef"/>
  ORDER BY article.Create_Time DESC
  LIMIT ${startIndex}, ${pageSize}
 </select>
 
 <select id="findArticleCountByAgentArticle" parameterType="com.djb.domain.article.AgentArticle" resultType="int">
  SELECT COUNT(1) FROM Sm_Agent_Article
  WHERE Delete_Flag=0
  <if test="isDraft!=null">
  and Is_Draft=#{isDraft}
  </if>
  <if test="isRecyle!=null">
  and Is_Recyle=#{isRecyle}
  </if>
  <if test="createUserId!=null">
  and Create_User_Id=#{createUserId}
  </if>
 </select>
 
 <select id="findAgentArticleByAgentArticle" parameterType="com.djb.domain.article.AgentArticle" resultMap="agentArticle">
  SELECT  *
  FROM  Sm_Agent_Article
  WHERE  delete_flag='0'
  and Create_User_Id=#{createUserId}
 </select>
 
 <select id="findTopAgentArticleByQueryBean" parameterType="com.djb.domain.article.AgentArticleQueryBean" resultMap="agentArticle">
  SELECT *
  FROM  Sm_Agent_Article
  WHERE  delete_flag='0'
  and Create_User_Id=#{createUserId}
  and Is_Draft!=1
  and Is_Recyle!=1
  ORDER BY Create_Time DESC
  LIMIT ${topLen}
 </select>
</mapper>
==================================== END article/AgentArticle.xml =========================


==================================== BEGIN article/AgentArticleCategory.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="AgentArticleCategory" >

 <resultMap id="agentArticleCategory" type="com.djb.domain.article.AgentArticleCategory" extends="DomainObject.domainObject" >
  <result property="articleId" column="Article_Id" />
  <result property="categoryId" column="Category_Id" />
 </resultMap>

 <select id="load" resultMap="agentArticleCategory" >
  SELECT  *
    FROM  Sm_Agent_Article_Category
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.article.AgentArticleCategory" >
  UPDATE  Sm_Agent_Article_Category
     SET  
   Article_Id=#{articleId}
   ,Category_Id=#{categoryId}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   WHERE  id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.article.AgentArticleCategory" >
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Sm_Agent_Article_Category(
   Article_Id
   ,Category_Id
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{articleId}
   ,#{categoryId}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey" >
  DELETE FROM  Sm_Agent_Article_Category
        WHERE  id = #{id}
 </delete>
 
 <update id="deleteByArticleId" parameterType="long">
  UPDATE  Sm_Agent_Article_Category
     SET  
   Delete_Flag=1
   WHERE  Article_Id=#{articleId}
 </update>
 
 <update id="deleteByCategoryId" parameterType="long">
  UPDATE  Sm_Agent_Article_Category
     SET  
   Delete_Flag=1
   WHERE  Category_Id=#{categoryId}
 </update>
 
 <select id="findByArticleId" parameterType="long" resultMap="agentArticleCategory">
  SELECT * FROM Sm_Agent_Article_Category
  WHERE Article_Id=#{articleId}
  and Delete_Flag=0
 </select>
 
 <select id="findCountByCategoryId" parameterType="long" resultType="int">
  SELECT COUNT(*) FROM Sm_Agent_Article_Category 
  WHERE Delete_Flag=0
  and Category_Id=#{categoryId}
 
 </select>
</mapper>
==================================== END article/AgentArticleCategory.xml =========================


==================================== BEGIN guide/AppUsageGuide.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 15:34:33 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="AppUsageGuide">
  <resultMap id="appUsageGuide" type="com.djb.domain.guide.AppUsageGuide">
 <result property="id" column="id"/> 
 <result property="agent.id" column="Agent_Id"/>
 <result property="appId" column="App_Id"/>
 <result property="status" column="Status"/>
 <result property="remark" column="Remark"/>
 <result property="deleteFlag" column="delete_flag"/>
 <result property="createUserId" column="create_user_id"/>
   <result property="createDateTime" column="create_time"/>
   <result property="updateUserId" column="update_user_id"/>
   <result property="updateDateTime" column="update_time"/>
  </resultMap>
  
  <select id="findGuideByApp" parameterType="map" resultMap="appUsageGuide">
   SELECT *
     FROM Sm_Agent_App_Guide
    WHERE Agent_Id=#{agentId}
    AND App_Id=#{appId}
    AND Delete_Flag = 0
  LIMIT  1
  </select>
  
  <update id="update" parameterType="com.djb.domain.guide.AppUsageGuide">
  UPDATE 
    Sm_Agent_App_Guide
        SET 
    Agent_Id=#{agent.id}
    ,App_Id=#{appId}
    ,Remark=#{remark}
    ,Status=#{status}
    ,Delete_Flag=#{deleteFlag}
    ,Create_User_Id=#{createUserId}
    ,Create_Time=#{createDateTime}
    ,Update_User_Id=#{updateUserId}
    ,Update_Time=#{updateDateTime}
      WHERE
    id = #{id}
 </update>

  <insert id="insert" parameterType="com.djb.domain.guide.AppUsageGuide">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
    INSERT INTO Sm_Agent_App_Guide (
   Agent_Id
   ,App_Id
   ,Remark
   ,Status
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
    ) VALUES (
      #{agent.id}
      ,#{appId}
      ,#{remark}
      ,#{status}
      ,#{deleteFlag}
      ,#{createUserId}
      ,#{createDateTime}
      ,#{updateUserId}
      ,#{updateDateTime}
    )
  </insert>
</mapper>
==================================== END guide/AppUsageGuide.xml =========================


==================================== BEGIN permission/RoleResource.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:15:44 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="RoleResource">

 <resultMap id="roleResource" type="com.djb.domain.permission.RoleResource" extends="DomainObject.domainObject">
  <result property="roleId" column="Role_Id"/>
  <result property="resourceId" column="Resource_Id"/>
 </resultMap>

 <select id="load" resultMap="roleResource">
  SELECT  *
    FROM  Sm_Role_Resource
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.permission.RoleResource">
  UPDATE  Sm_Role_Resource
     SET  
   Role_Id=#{roleId}
   ,Resource_Id=#{resourceId}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   WHERE  id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.permission.RoleResource">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Sm_Role_Resource(
   Role_Id
   ,Resource_Id
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{roleId}
   ,#{resourceId}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
  
  
 </insert>

 <delete id="deleteByPrimaryKey">
  DELETE FROM  Sm_Role_Resource
        WHERE  id = #{id}
 </delete>
 
 <delete id="deleteByRole" parameterType="long">
  DELETE FROM Sm_Role_Resource
   WHERE Role_Id=#{roleId}
 </delete>
 
 <delete id="deleteByResource" parameterType="long">
  DELETE FROM Sm_Role_Resource
   WHERE Resource_Id=#{resourceId}
 </delete>
 
</mapper>
==================================== END permission/RoleResource.xml =========================


==================================== BEGIN permission/UserRoleOrganization.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:15:45 
	CST 2013 -->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="UserRoleOrganization">

	<resultMap id="userRoleOrganization"
		type="com.djb.domain.permission.UserRoleOrganization" extends="DomainObject.domainObject">
		<result property="referUserId" column="Refer_User_Id" />
		<result property="referUserType" column="Refer_User_Type" />
		<result property="organization.id" column="Organization_Id" />
		<result property="role.id" column="Role_Id" />
	</resultMap>

	<select id="load" resultMap="userRoleOrganization">
		SELECT *
		FROM Sm_User_Role_Organization
		WHERE id = #{id}
		AND delete_flag='0'
	</select>

	<update id="update" parameterType="com.djb.domain.permission.UserRoleOrganization">
		UPDATE Sm_User_Role_Organization
		SET
		Refer_User_Id=#{referUserId}
		,Refer_User_Type=#{referUserType}
		,Organization_Id=#{organization.id}
		,Role_Id=#{role.id}
		,Delete_Flag=#{deleteFlag}
		,Update_User_Id=#{updateUserId}
		,Update_Time=#{updateDateTime}
		WHERE id=#{id}
	</update>

	<insert id="insert" parameterType="com.djb.domain.permission.UserRoleOrganization">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
		INSERT INTO Sm_User_Role_Organization(
		Refer_User_Id
		,Refer_User_Type
		,Organization_Id
		,Role_Id
		,Delete_Flag
		,Create_User_Id
		,Create_Time
		,Update_User_Id
		,Update_Time
		)
		VALUES(
		#{referUserId}
		,#{referUserType}
		,#{organizationId}
		,#{roleId}
		,#{deleteFlag}
		,#{createUserId}
		,#{createDateTime}
		,#{updateUserId}
		,#{updateDateTime}
		)


	</insert>

	<delete id="deleteByPrimaryKey">
		DELETE FROM Sm_User_Role_Organization
		WHERE id = #{id}
	</delete>

	<select id="loadUserRoleOrgByUser" parameterType="map"
		resultMap="userRoleOrganization">
		SELECT *
		FROM Sm_User_Role_Organization userRoleOrg,Sm_Employee employee
		WHERE userRoleOrg.Refer_User_Type=#{userType}
		AND userRoleOrg.Refer_User_Id=employee.Id
		<if test="userName != null and userName != ''">AND
			employee.Employee_Name=#{userName}
		</if>
		<if test="userId != null and userId != ''">AND
			employee.Id=#{userId}
		</if>
		AND employee.delete_flag='0'
		AND userRoleOrg.delete_flag='0'
	</select>

	<delete id="deleteByRole" parameterType="long">
		DELETE FROM Sm_User_Role_Organization
		WHERE Role_Id=#{roleId}
	</delete>

	<delete id="deleteByUser" parameterType="map">
		DELETE FROM Sm_User_Role_Organization
		WHERE Refer_User_Type=#{userType}
		AND Refer_User_Id=#{userId}
	</delete>
</mapper>
==================================== END permission/UserRoleOrganization.xml =========================


==================================== BEGIN permission/Role.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:15:44 
 CST 2013 -->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="Role">

 <resultMap id="role" type="com.djb.domain.permission.Role"
  extends="DomainObject.domainObject">
  <result property="name" column="Name" />
  <result property="description" column="Description" />
  <result property="module" column="Module" />
 </resultMap>

 <select id="load" resultMap="role">
  SELECT *
  FROM Sm_Role
  WHERE id = #{id}
  AND delete_flag='0'
 </select>

 <select id="getAll" resultMap="role">
  SELECT *
  FROM Sm_Role
  WHERE delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.permission.Role">
  UPDATE Sm_Role
  SET
  Name=#{name}
  ,Description=#{description}
  ,Module=#{module}
  ,Delete_Flag=#{deleteFlag}
  ,Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime}
  WHERE id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.permission.Role">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO Sm_Role(
  Name
  ,Description
  ,Module
  ,Delete_Flag
  ,Create_User_Id
  ,Create_Time
  ,Update_User_Id
  ,Update_Time
  )
  VALUES(
  #{name}
  ,#{description}
  ,#{module}
  ,#{deleteFlag}
  ,#{createUserId}
  ,#{createDateTime}
  ,#{updateUserId}
  ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey">
  DELETE FROM Sm_Role
  WHERE id = #{id}
 </delete>

 <delete id="logicDelete">
  DELETE FROM Sm_Role
  WHERE id=#{id}
 </delete>

 <select id="getRolesByEmployee" parameterType="map" resultMap="role">
  SELECT DISTINCT role.*
  FROM Sm_Role role,Sm_User_Role_Organization userRole,Sm_Employee employee
  WHERE employee.id=userRole.Refer_User_Id
  AND employee.Id=#{employeeId}
  AND userRole.Refer_User_Type=#{userType}
  AND userRole.role_Id=role.Id
  AND role.Delete_Flag=0
  AND userRole.Delete_Flag=0
  AND employee.Delete_Flag=0
  AND employee.Id=#{employeeId}
 </select>

 <sql id="findRoleByQueryBeanRef">
  FROM Sm_Role role
  WHERE role.Delete_Flag = 0

  <if test="roleName != null and roleName != ''">
   AND role.Name like '%${roleName}%'
  </if>
 </sql>
 <select id="findRoleCountByQueryBean" parameterType="com.djb.domain.permission.RoleQueryBean"
  resultType="int">
  SELECT count(*)
  <include refid="findRoleByQueryBeanRef" />
 </select>

 <select id="findRoleByQueryBean" parameterType="com.djb.domain.permission.RoleQueryBean"
  resultMap="role">
  SELECT *
  <include refid="findRoleByQueryBeanRef" />
  ORDER BY role.create_time DESC LIMIT ${startIndex}, ${pageSize}
 </select>
</mapper>
==================================== END permission/Role.xml =========================


==================================== BEGIN permission/Organization.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:15:42 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="Organization">

 <resultMap id="organization" type="com.djb.domain.permission.Organization" extends="DomainObject.domainObject">
  <result property="parentId" column="Parent_Id"/>
  <result property="level" column="Level"/>
  <result property="name" column="Name"/>
  <result property="description" column="Description"/>
 </resultMap>

 <select id="load" resultMap="organization">
  SELECT  *
    FROM  Sm_Organization
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.permission.Organization">
  UPDATE  Sm_Organization
     SET  
   Parent_Id=#{parentId}
   ,Level=#{level}
   ,Name=#{name}
   ,Description=#{description}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   WHERE  id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.permission.Organization">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Sm_Organization(
   Parent_Id
   ,Level
   ,Name
   ,Description
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{parentId}
   ,#{level}
   ,#{name}
   ,#{description}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
  
  
 </insert>

 <delete id="deleteByPrimaryKey">
  DELETE FROM  Sm_Organization
        WHERE  id = #{id}
 </delete>
</mapper>
==================================== END permission/Organization.xml =========================


==================================== BEGIN permission/Resource.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:15:43 
 CST 2013 -->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="Resource">

 <resultMap id="resource" type="com.djb.domain.permission.Resource"
  extends="DomainObject.domainObject">
  <result property="name" column="Name" />
  <result property="kind" column="Kind" />
  <result property="type" column="Type" />
  <result property="value" column="Value" />
  <result property="module" column="Module" />
  <result property="description" column="Description" />
 </resultMap>

 <select id="load" resultMap="resource">
  SELECT *
  FROM Sm_Resource
  WHERE id = #{id}
  AND delete_flag='0'
 </select>

 <select id="getAll" resultMap="resource">
  SELECT *
  FROM Sm_Resource
  WHERE delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.permission.Resource">
  UPDATE Sm_Resource
  SET
  Name=#{name}
  ,Kind=#{kind}
  ,Type=#{type}
  ,Value=#{value}
  ,Module=#{module}
  ,Description=#{description}
  ,Delete_Flag=#{deleteFlag}
  ,Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime}
  WHERE id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.permission.Resource">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO Sm_Resource(
  Name
  ,Kind
  ,Type
  ,Value
  ,Module
  ,Description
  ,Delete_Flag
  ,Create_User_Id
  ,Create_Time
  ,Update_User_Id
  ,Update_Time
  )
  VALUES(
  #{name}
  ,#{kind}
  ,#{type}
  ,#{value}
  ,#{module}
  ,#{description}
  ,#{deleteFlag}
  ,#{createUserId}
  ,#{createDateTime}
  ,#{updateUserId}
  ,#{updateDateTime}
  )


 </insert>

 <delete id="deleteByPrimaryKey">
  DELETE FROM Sm_Resource
  WHERE id = #{id}
 </delete>

 <select id="loadResourceByRole" parameterType="map" resultMap="resource">
  SELECT DISTINCT resource.*
  FROM Sm_Resource resource,Sm_Role_Resource roleResource
  WHERE resource.Id=roleResource.Resource_Id
  AND roleResource.Role_Id IN
  <foreach collection="roleIdList" item="item" separator=","
   close=")" open="(">
   #{item}
  </foreach>
  AND resource.Delete_flag='0'
  AND roleResource.Delete_flag='0'
 </select>

 <sql id="findResourceByQueryBeanRef">
  FROM Sm_Resource resource
  WHERE resource.Delete_Flag = 0

  <if test="resourceName != null and resourceName != ''">
   AND resource.Name like '%${resourceName}%'
  </if>
 </sql>
 <select id="findResourceCountByQueryBean" parameterType="com.djb.domain.permission.ResourceQueryBean"
  resultType="int">
  SELECT count(*)
  <include refid="findResourceByQueryBeanRef" />
 </select>

 <select id="findResourceByQueryBean" parameterType="com.djb.domain.permission.ResourceQueryBean"
  resultMap="resource">
  SELECT *
  <include refid="findResourceByQueryBeanRef" />
  ORDER BY resource.create_time DESC 
  LIMIT ${startIndex}, ${pageSize}
 </select>
</mapper>
==================================== END permission/Resource.xml =========================


==================================== BEGIN DjbKey.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="DjbKey" >

 <resultMap id="djbKey" type="com.djb.domain.DjbKey" extends="DomainObject.domainObject" >
  <result property="djbKey" column="Djb_Key" />
  <result property="status" column="Status" />
  <result property="type" column="Type" />
  <result property="cardNo" column="Card_No" />
  <result property="batchId" column="Batch_Id" />
  <result property="companyId" column="Company_Id" />
  <result property="empId" column="Emp_Id" />
  <result property="expiredDate" column="Expired_Date" />
  <result property="orderNo" column="Order_No" />
 </resultMap>
 
 <resultMap type="java.util.HashMap" id="cardUsedDetail">
  <result property="cardName" column="Card_Name" javaType="string"/>
  <result property="orderNo" column="Order_No" javaType="string"/>
  <result property="userName" column="User_Name" javaType="string"/>
  <result property="province" column="Province" javaType="string"/>
  <result property="city" column="City" javaType="string"/>
  <result property="phone" column="Phone" javaType="string"/>
  <result property="orderDate" column="Order_Date" javaType="date"/>
  <result property="company" column="Company" javaType="string"/>
 </resultMap>
 
 <select id="cardDetailStat" resultMap="cardUsedDetail" >
  SELECT  type.Name AS Card_Name
      ,card.Order_No
      ,agent.True_Name AS User_Name
      ,province.City_Name As Province
      ,city.City_Name AS City
      ,agent.Mobilephone AS Phone
      ,card.Update_Time AS Order_Date
      ,cmp.Company_Nick_Name AS Company
    FROM  Sm_Djb_Key card
       LEFT JOIN Dx_Card_Type type ON card.Type = type.Id
       LEFT JOIN Du_Agent_Detail agent ON card.Update_User_Id = agent.Id
       LEFT JOIN Du_User djbuser On agent.Id = djbuser.Id
       LEFT JOIN Sm_City province on djbuser.Province = province.Id
       LEFT JOIN Sm_City city on djbuser.City = city.Id
       LEFT JOIN Sm_Company cmp on agent.Company = cmp.Id
     WHERE card.Company_Id = #{companyId}
       AND card.delete_flag=0
       AND card.Update_Time &gt;= #{startTime}
       AND card.Update_Time &lt;= #{endTime}
       AND card.Status = 2
 </select>

 <select id="load" resultMap="djbKey" >
  SELECT  *
    FROM  Sm_Djb_Key
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>
 
 <select id="loadDjbKey" resultMap="djbKey">
  SELECT  *
    FROM  Sm_Djb_Key
   WHERE  Djb_Key = #{djbKey}
     AND  delete_flag='0'
     <if test="status != null">
     AND Status = #{status}
     </if>
     <if test="type != null">
     AND Type = #{type}
     </if>
 </select>

 <update id="update" parameterType="com.djb.domain.DjbKey" >
  UPDATE  Sm_Djb_Key
     SET  
   Djb_Key=#{djbKey}
   ,Status=#{status}
   ,Type=#{type}
   ,Card_No=#{cardNo}
   ,Batch_Id=#{batchId}
   ,Company_Id=#{companyId}
   ,Emp_Id=#{empId}
   ,Expired_Date=#{expiredDate}
   ,Order_No=#{orderNo}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   WHERE  id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.DjbKey" >
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Sm_Djb_Key(
   Djb_Key
   ,Status
   ,Type
   ,Card_No
   ,Batch_Id
   ,Company_Id
   ,Emp_Id
   ,Expired_Date
   ,Order_No
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{djbKey}
   ,#{status}
   ,#{type}
   ,#{cardNo}
   ,#{batchId}
   ,#{companyId}
   ,#{empId}
   ,#{expiredDate}
   ,#{orderNo}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey" >
  DELETE FROM  Sm_Djb_Key
        WHERE  id = #{id}
 </delete>
</mapper>
==================================== END DjbKey.xml =========================


==================================== BEGIN ga/GaEventAction.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="GaEventAction" >

 <resultMap id="gaEventAction" type="com.djb.domain.ga.GaEventAction" extends="DomainObject.domainObject" >
  <result property="date" column="Date" />
  <result property="customVarValue" column="Custom_Var_Value" />
  <result property="country" column="Country" />
  <result property="region" column="Region" />
  <result property="city" column="City" />
  <result property="medium" column="Medium" />
  <result property="source" column="Source" />
  <result property="eventCategory" column="Event_Category" />
  <result property="eventAction" column="Event_Action" />
  <result property="totalEvents" column="Total_Events" />
  <result property="uniqueEvents" column="Unique_Events" />
 </resultMap>

 <select id="load" resultMap="gaEventAction" >
  SELECT  *
    FROM  Ga_Event_Action
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.ga.GaEventAction" >
  UPDATE  Ga_Event_Action
     SET  
   Date=#{date}
   ,Custom_Var_Value=#{customVarValue}
   ,Country=#{country}
   ,Region=#{region}
   ,City=#{city}
   ,Medium=#{medium}
   ,Source=#{source}
   ,Event_Category=#{eventCategory}
   ,Event_Action=#{eventAction}
   ,Total_Events=#{totalEvents}
   ,Unique_Events=#{uniqueEvents}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   WHERE  id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.ga.GaEventAction" >
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Ga_Event_Action(
   Date
   ,Custom_Var_Value
   ,Country
   ,Region
   ,City
   ,Medium
   ,Source
   ,Event_Category
   ,Event_Action
   ,Total_Events
   ,Unique_Events
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{date}
   ,#{customVarValue}
   ,#{country}
   ,#{region}
   ,#{city}
   ,#{medium}
   ,#{source}
   ,#{eventCategory}
   ,#{eventAction}
   ,#{totalEvents}
   ,#{uniqueEvents}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey" >
  DELETE FROM  Ga_Event_Action
        WHERE  id = #{id}
 </delete>
</mapper>
==================================== END ga/GaEventAction.xml =========================


==================================== BEGIN ga/GaEventLabelRegion.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="GaEventLabelRegion" >

 <resultMap id="gaEventLabelRegion" type="com.djb.domain.ga.GaEventLabelRegion" extends="DomainObject.domainObject" >
  <result property="date" column="Date" />
  <result property="customVarValue" column="Custom_Var_Value" />
  <result property="region" column="Region" />
  <result property="city" column="City" />
  <result property="eventCategory" column="Event_Category" />
  <result property="eventAction" column="Event_Action" />
  <result property="eventLabel" column="Event_Label" />
  <result property="totalEvents" column="Total_Events" />
  <result property="uniqueEvents" column="Unique_Events" />
 </resultMap>

 <select id="load" resultMap="gaEventLabelRegion" >
  SELECT  *
    FROM  Ga_Event_LabelRegion
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.ga.GaEventLabelRegion" >
  UPDATE  Ga_Event_LabelRegion
     SET  
   Date=#{date}
   ,Custom_Var_Value=#{customVarValue}
   ,Region=#{region}
   ,City=#{city}
   ,Event_Category=#{eventCategory}
   ,Event_Action=#{eventAction}
   ,Event_Label=#{eventLabel}
   ,Total_Events=#{totalEvents}
   ,Unique_Events=#{uniqueEvents}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   WHERE  id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.ga.GaEventLabelRegion" >
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Ga_Event_LabelRegion(
   Date
   ,Custom_Var_Value
   ,Region
   ,City
   ,Event_Category
   ,Event_Action
   ,Event_Label
   ,Total_Events
   ,Unique_Events
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{date}
   ,#{customVarValue}
   ,#{region}
   ,#{city}
   ,#{eventCategory}
   ,#{eventAction}
   ,#{eventLabel}
   ,#{totalEvents}
   ,#{uniqueEvents}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey" >
  DELETE FROM  Ga_Event_LabelRegion
        WHERE  id = #{id}
 </delete>
</mapper>
==================================== END ga/GaEventLabelRegion.xml =========================


==================================== BEGIN ga/GaEventCategory.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="GaEventCategory" >

 <resultMap id="gaEventCategory" type="com.djb.domain.ga.GaEventCategory" extends="DomainObject.domainObject" >
  <result property="date" column="Date" />
  <result property="customVarValue" column="Custom_Var_Value" />
  <result property="country" column="Country" />
  <result property="region" column="Region" />
  <result property="city" column="City" />
  <result property="medium" column="Medium" />
  <result property="source" column="Source" />
  <result property="eventCategory" column="Event_Category" />
  <result property="totalEvents" column="Total_Events" />
  <result property="uniqueEvents" column="Unique_Events" />
 </resultMap>

 <select id="load" resultMap="gaEventCategory" >
  SELECT  *
    FROM  Ga_Event_Category
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.ga.GaEventCategory" >
  UPDATE  Ga_Event_Category
     SET  
   Date=#{date}
   ,Custom_Var_Value=#{customVarValue}
   ,Country=#{country}
   ,Region=#{region}
   ,City=#{city}
   ,Medium=#{medium}
   ,Source=#{source}
   ,Event_Category=#{eventCategory}
   ,Total_Events=#{totalEvents}
   ,Unique_Events=#{uniqueEvents}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   WHERE  id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.ga.GaEventCategory" >
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Ga_Event_Category(
   Date
   ,Custom_Var_Value
   ,Country
   ,Region
   ,City
   ,Medium
   ,Source
   ,Event_Category
   ,Total_Events
   ,Unique_Events
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{date}
   ,#{customVarValue}
   ,#{country}
   ,#{region}
   ,#{city}
   ,#{medium}
   ,#{source}
   ,#{eventCategory}
   ,#{totalEvents}
   ,#{uniqueEvents}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey" >
  DELETE FROM  Ga_Event_Category
        WHERE  id = #{id}
 </delete>
</mapper>
==================================== END ga/GaEventCategory.xml =========================


==================================== BEGIN ga/GaPage.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="GaPage" >

 <resultMap id="gaPage" type="com.djb.domain.ga.GaPage" extends="DomainObject.domainObject" >
  <result property="date" column="Date" />
  <result property="customVarValue" column="Custom_Var_Value" />
  <result property="region" column="Region" />
  <result property="city" column="City" />
  <result property="medium" column="Medium" />
  <result property="source" column="Source" />
  <result property="campaign" column="Campaign" />
  <result property="visits" column="Visits" />
  <result property="visitors" column="Visitors" />
  <result property="page" column="Page" />
 </resultMap>

 <select id="load" resultMap="gaPage" >
  SELECT  *
    FROM  Ga_Page
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.ga.GaPage" >
  UPDATE  Ga_Page
     SET  
   Date=#{date}
   ,Custom_Var_Value=#{customVarValue}
   ,Region=#{region}
   ,City=#{city}
   ,Medium=#{medium}
   ,Source=#{source}
   ,Campaign=#{campaign}
   ,Visits=#{visits}
   ,Page=#{page}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   WHERE  id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.ga.GaPage" >
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Ga_Page(
   Date
   ,Custom_Var_Value
   ,Region
   ,City
   ,Medium
   ,Source
   ,Campaign
   ,Visits
   ,Visitors
   ,Page
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{date}
   ,#{customVarValue}
   ,#{region}
   ,#{city}
   ,#{medium}
   ,#{source}
   ,#{campaign}
   ,#{visits}
   ,#{visitors}
   ,#{page}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey" >
  DELETE FROM  Ga_Page
        WHERE  id = #{id}
 </delete>
</mapper>
==================================== END ga/GaPage.xml =========================


==================================== BEGIN ga/GaEventLabel.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="GaEventLabel" >

 <resultMap id="gaEventLabel" type="com.djb.domain.ga.GaEventLabel" extends="DomainObject.domainObject" >
  <result property="date" column="Date" />
  <result property="customVarValue" column="Custom_Var_Value" />
  <result property="country" column="Country" />
  <result property="region" column="Region" />
  <result property="city" column="City" />
  <result property="medium" column="Medium" />
  <result property="source" column="Source" />
  <result property="eventCategory" column="Event_Category" />
  <result property="eventAction" column="Event_Action" />
  <result property="eventLabel" column="Event_Label" />
  <result property="totalEvents" column="Total_Events" />
  <result property="uniqueEvents" column="Unique_Events" />
 </resultMap>

 <select id="load" resultMap="gaEventLabel" >
  SELECT  *
    FROM  Ga_Event_Label
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.ga.GaEventLabel" >
  UPDATE  Ga_Event_Label
     SET  
   Date=#{date}
   ,Custom_Var_Value=#{customVarValue}
   ,Country=#{country}
   ,Region=#{region}
   ,City=#{city}
   ,Medium=#{medium}
   ,Source=#{source}
   ,Event_Category=#{eventCategory}
   ,Event_Action=#{eventAction}
   ,Event_Label=#{eventLabel}
   ,Total_Events=#{totalEvents}
   ,Unique_Events=#{uniqueEvents}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   WHERE  id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.ga.GaEventLabel" >
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Ga_Event_Label(
   Date
   ,Custom_Var_Value
   ,Country
   ,Region
   ,City
   ,Medium
   ,Source
   ,Event_Category
   ,Event_Action
   ,Event_Label
   ,Total_Events
   ,Unique_Events
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{date}
   ,#{customVarValue}
   ,#{country}
   ,#{region}
   ,#{city}
   ,#{medium}
   ,#{source}
   ,#{eventCategory}
   ,#{eventAction}
   ,#{eventLabel}
   ,#{totalEvents}
   ,#{uniqueEvents}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey" >
  DELETE FROM  Ga_Event_Label
        WHERE  id = #{id}
 </delete>
</mapper>
==================================== END ga/GaEventLabel.xml =========================


==================================== BEGIN ga/GaEventLabelMedium.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="GaEventLabelMedium" >

 <resultMap id="gaEventLabelMedium" type="com.djb.domain.ga.GaEventLabelMedium" extends="DomainObject.domainObject" >
  <result property="date" column="Date" />
  <result property="customVarValue" column="Custom_Var_Value" />
  <result property="medium" column="Medium" />
  <result property="source" column="Source" />
  <result property="eventCategory" column="Event_Category" />
  <result property="eventAction" column="Event_Action" />
  <result property="eventLabel" column="Event_Label" />
  <result property="totalEvents" column="Total_Events" />
  <result property="uniqueEvents" column="Unique_Events" />
 </resultMap>

 <select id="load" resultMap="gaEventLabelMedium" >
  SELECT  *
    FROM  Ga_Event_LabelMedium
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.ga.GaEventLabelMedium" >
  UPDATE  Ga_Event_LabelMedium
     SET  
   Date=#{date}
   ,Custom_Var_Value=#{customVarValue}
   ,Medium=#{medium}
   ,Source=#{source}
   ,Event_Category=#{eventCategory}
   ,Event_Action=#{eventAction}
   ,Event_Label=#{eventLabel}
   ,Total_Events=#{totalEvents}
   ,Unique_Events=#{uniqueEvents}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   WHERE  id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.ga.GaEventLabelMedium" >
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Ga_Event_LabelMedium(
   Date
   ,Custom_Var_Value
   ,Medium
   ,Source
   ,Event_Category
   ,Event_Action
   ,Event_Label
   ,Total_Events
   ,Unique_Events
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{date}
   ,#{customVarValue}
   ,#{medium}
   ,#{source}
   ,#{eventCategory}
   ,#{eventAction}
   ,#{eventLabel}
   ,#{totalEvents}
   ,#{uniqueEvents}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey" >
  DELETE FROM  Ga_Event_LabelMedium
        WHERE  id = #{id}
 </delete>
</mapper>
==================================== END ga/GaEventLabelMedium.xml =========================


==================================== BEGIN ga/GaEventActionRegion.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="GaEventActionRegion" >

 <resultMap id="gaEventActionRegion" type="com.djb.domain.ga.GaEventActionRegion" extends="DomainObject.domainObject" >
  <result property="date" column="Date" />
  <result property="customVarValue" column="Custom_Var_Value" />
  <result property="region" column="Region" />
  <result property="city" column="City" />
  <result property="eventCategory" column="Event_Category" />
  <result property="eventAction" column="Event_Action" />
  <result property="totalEvents" column="Total_Events" />
  <result property="uniqueEvents" column="Unique_Events" />
 </resultMap>

 <select id="load" resultMap="gaEventActionRegion" >
  SELECT  *
    FROM  Ga_Event_ActionRegion
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.ga.GaEventActionRegion" >
  UPDATE  Ga_Event_ActionRegion
     SET  
   Date=#{date}
   ,Custom_Var_Value=#{customVarValue}
   ,Region=#{region}
   ,City=#{city}
   ,Event_Category=#{eventCategory}
   ,Event_Action=#{eventAction}
   ,Total_Events=#{totalEvents}
   ,Unique_Events=#{uniqueEvents}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   WHERE  id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.ga.GaEventActionRegion" >
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Ga_Event_ActionRegion(
   Date
   ,Custom_Var_Value
   ,Region
   ,City
   ,Event_Category
   ,Event_Action
   ,Total_Events
   ,Unique_Events
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{date}
   ,#{customVarValue}
   ,#{region}
   ,#{city}
   ,#{eventCategory}
   ,#{eventAction}
   ,#{totalEvents}
   ,#{uniqueEvents}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey" >
  DELETE FROM  Ga_Event_ActionRegion
        WHERE  id = #{id}
 </delete>
</mapper>
==================================== END ga/GaEventActionRegion.xml =========================


==================================== BEGIN ga/GaEventActionMedium.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="GaEventActionMedium" >

 <resultMap id="gaEventActionMedium" type="com.djb.domain.ga.GaEventActionMedium" extends="DomainObject.domainObject" >
  <result property="date" column="Date" />
  <result property="customVarValue" column="Custom_Var_Value" />
  <result property="medium" column="Medium" />
  <result property="source" column="Source" />
  <result property="campaign" column="Campaign" />
  <result property="eventCategory" column="Event_Category" />
  <result property="eventAction" column="Event_Action" />
  <result property="totalEvents" column="Total_Events" />
  <result property="uniqueEvents" column="Unique_Events" />
 </resultMap>

 <select id="load" resultMap="gaEventActionMedium" >
  SELECT  *
    FROM  Ga_Event_ActionMedium
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.ga.GaEventActionMedium" >
  UPDATE  Ga_Event_ActionMedium
     SET  
   Date=#{date}
   ,Custom_Var_Value=#{customVarValue}
   ,Medium=#{medium}
   ,Source=#{source}
   ,Campaign=#{campaign}
   ,Event_Category=#{eventCategory}
   ,Event_Action=#{eventAction}
   ,Total_Events=#{totalEvents}
   ,Unique_Events=#{uniqueEvents}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   WHERE  id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.ga.GaEventActionMedium" >
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Ga_Event_ActionMedium(
   Date
   ,Custom_Var_Value
   ,Medium
   ,Source
   ,Campaign
   ,Event_Category
   ,Event_Action
   ,Total_Events
   ,Unique_Events
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{date}
   ,#{customVarValue}
   ,#{medium}
   ,#{source}
   ,#{campaign}
   ,#{eventCategory}
   ,#{eventAction}
   ,#{totalEvents}
   ,#{uniqueEvents}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey" >
  DELETE FROM  Ga_Event_ActionMedium
        WHERE  id = #{id}
 </delete>
</mapper>
==================================== END ga/GaEventActionMedium.xml =========================


==================================== BEGIN tender/TenderLifecycle.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:04:02 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="TenderLifecycle">
 <resultMap id="tenderLifecycle" type="com.djb.domain.tender.TenderLifecycle" extends="DomainObject.domainObject">
  <result property="tender.id" column="Tender_Id"/>
  <result property="type" column="Tender_Type"/>
  <result property="oldStatus" column="Old_Tender_Status"/>
  <result property="curStatus" column="Cur_Tender_Status"/>
  <result property="remark" column="Remark"/>
 </resultMap>
 
 <select id="load" resultMap="tenderLifecycle">
  SELECT *
   FROM Dp_Tender_Lifecycle
  WHERE id = #{id} 
    AND delete_flag = '0'
 </select>
 
 <select id="getAll" resultMap="tenderLifecycle">
  SELECT *
   FROM Dp_Tender_Lifecycle
  WHERE delete_flag = '0'
   ORDER BY Tender_Id
 </select>
 
 <select id="isExist" parameterType="map" resultType="int">
 SELECT COUNT(1)
   FROM Dp_Tender_Lifecycle
  WHERE delete_flag = 0
    AND Tender_Id = #{tenderId}
    AND Old_Tender_Status = #{oldStatus}
    AND Cur_Tender_Status = #{curStatus}
    AND  Tender_Type = #{tenderType}
 </select>
 
 <select id="statusChangePoint" parameterType="map" resultType="date">
 SELECT create_time
   FROM Dp_Tender_Lifecycle
  WHERE delete_flag = 0
    AND Tender_Id = #{tenderId}
    AND Cur_Tender_Status = #{status}
 </select>
 
 <update id="update" parameterType="com.djb.domain.tender.TenderLifecycle">
  UPDATE Dp_Tender_Lifecycle
      SET
         Tender_Id = #{tender.id},
         Tender_Type = #{type.value},
         Old_Tender_Status = #{oldStatus.value},
         Cur_Tender_Status = #{curStatus.value},
         Remark = #{remark},
         update_time = #{updateDateTime},
         update_user_id = #{updateUserId},
         delete_flag = #{deleteFlag}
   WHERE id = #{id}
 </update>
 
 <insert id="insert" parameterType="com.djb.domain.tender.TenderLifecycle">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO 
   Dp_Tender_Lifecycle(
    Tender_Id,
    Tender_Type,
    Old_Tender_Status,
    Cur_Tender_Status,
    Remark,
    create_time,
    create_user_id,
    update_time,
    update_user_id,
    delete_flag
   )
  VALUES(
   #{tender.id},
   #{type.value},
   #{oldStatus.value},
   #{curStatus.value},
   #{remark},
   #{createDateTime},
   #{createUserId},
   #{updateDateTime},
   #{updateUserId},
   #{deleteFlag}
  )
  
  
 </insert>
 
 <delete id="deleteByPrimaryKey">
  DELETE FROM 
   Dp_Tender_Lifecycle
  WHERE
   id = #{id}
 </delete>
 
</mapper>
==================================== END tender/TenderLifecycle.xml =========================


==================================== BEGIN tender/EdmMail.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:03:57 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="EdmMail">
 <resultMap id="emdMail" type="com.djb.domain.tender.EdmMail" extends="DomainObject.domainObject">
  <result property="tenderId" column="Tender_Id"/>
  <result property="tenderType" column="Tender_Type"/>
  <result property="tenderUserId" column="Tender_User_Id"/>
  <result property="tenderUserEmail" column="Tender_User_Mail"/>
  <result property="containPlanIds" column="Contain_Plan_Ids"/>
  <result property="edmStatus" column="Edm_Status"/>
  <result property="planCount" column="Plan_Count"/>
  <result property="edmConsumeTime" column="Edm_Consume_Time"/>
  <result property="edmMailGuid" column="Edm_Mail_Guid"/>
 </resultMap>
 
 <select id="load" resultMap="emdMail">
  SELECT *
    FROM Dp_Edm_Mail
   WHERE id = #{id}
    AND delete_flag='0'
 </select>
 
 <select id="findEdmMailByTender" parameterType="long" resultMap="emdMail">
  SELECT *
    FROM Dp_Edm_Mail
   WHERE tender_Id = #{tenderId}
     AND delete_flag='0'
 </select>

 <insert id="insert" parameterType="com.djb.domain.tender.EdmMail">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO
   Dp_Edm_Mail(
    Tender_Id
    ,Tender_Type
    ,Tender_User_Id
    ,Tender_User_Mail
    ,Contain_Plan_Ids
    ,Edm_Status
    ,Plan_Count
    ,Edm_Consume_Time
    ,Edm_Mail_Guid
    ,Delete_Flag
    ,Create_User_Id
    ,Create_Time
    ,Update_User_Id
    ,Update_Time
  )
  VALUES(
    #{tenderId}
    ,#{tenderType}
    ,#{tenderUserId}
    ,#{tenderUserEmail}
    ,#{containPlanIds}
    ,#{edmStatus}
    ,#{planCount}
    ,#{edmConsumeTime}
    ,#{edmMailGuid}
    ,#{deleteFlag}
    ,#{createUserId}
    ,#{createDateTime}
    ,#{updateUserId}
    ,#{updateDateTime}
  )
  
  
 </insert>
 
 <update id="update" parameterType="com.djb.domain.tender.EdmMail">
   UPDATE Dp_Edm_Mail
     SET
      Edm_Status=#{edmStatus}
      ,Plan_Count=#{planCount}
      ,Edm_Consume_Time=#{edmConsumeTime}
      ,Delete_Flag=#{deleteFlag}
      ,Update_User_Id=#{updateUserId}
      ,Update_Time=#{updateDateTime}
    WHERE
      Id=#{id}
 </update>
 
</mapper>
==================================== END tender/EdmMail.xml =========================


==================================== BEGIN tender/BackTender.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="BackTender" >

 <resultMap id="backTender" type="com.djb.domain.tender.BackTender" extends="DomainObject.domainObject" >
  <result property="agentId" column="Agent_Id" />
  <result property="tenderId" column="Tender_Id" />
  <result property="customerId" column="Customer_Id"/>
  <result property="feedbackReason" column="Feedback_Reason" />
  <result property="whetherTender" column="Whether_Tender" />
  <result property="backTenderReason" column="Back_Tender_Reason" />
 </resultMap>

 <select id="load" resultMap="backTender" >
  SELECT  *
    FROM  Dp_Back_Tender
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>
 
 <select id="findBackResult" parameterType="com.djb.domain.tender.BackTender" resultMap="backTender">
  SELECT  *
     FROM  Dp_Back_Tender
     WHERE  delete_flag='0'
     <if test="agentId != null">
     AND Agent_Id=#{agentId}
     </if>
     <if test="tenderId != null">
     AND Tender_Id=#{tenderId}
     </if>
     <if test="customerId != null">
     AND Customer_Id=#{customerId}
     </if>
 </select>

 <update id="update" parameterType="com.djb.domain.tender.BackTender" >
  UPDATE  Dp_Back_Tender
     SET  
   Agent_Id=#{agentId}
   ,Tender_Id=#{tenderId}
   ,Customer_Id=#{customerId}
   ,Feedback_Reason=#{feedbackReason}
   ,Whether_Tender=#{whetherTender}
   ,Back_Tender_Reason=#{backTenderReason}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   WHERE  id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.tender.BackTender" >
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Dp_Back_Tender(
   Agent_Id
   ,Tender_Id
   ,Customer_Id
   ,Feedback_Reason
   ,Whether_Tender
   ,Back_Tender_Reason
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{agentId}
   ,#{tenderId}
   ,#{customerId}
   ,#{feedbackReason}
   ,#{whetherTender}
   ,#{backTenderReason}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey" >
  DELETE FROM  Dp_Back_Tender
        WHERE  id = #{id}
 </delete>
</mapper>
==================================== END tender/BackTender.xml =========================


==================================== BEGIN tender/Tender.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:03:59 
	CST 2013 -->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="Tender">

	<resultMap id="tender" type="com.djb.domain.tender.Tender">
		<result property="id" column="Id" />
		<result property="userId" column="User_Id" />
		<result property="contactName" column="Contact_Name" />
		<result property="email" column="Email" />
		<result property="mobilePhone" column="Mobilephone" />
		<result property="isOpenPhone" column="Is_Open_Phone" />
		<result property="expectedReplyNumber" column="Expected_Reply_Number" />
		<result property="status" column="Status" />
		<result property="totalPrice.id" column="Total_Price" />
		<result property="createDateTime" column="create_time" />
		<result property="type" column="Tender_Type" />
		<result property="phoneValidFlag" column="Phone_Valid_Flag" />
		<result property="createUserId" column="Create_User_Id" />
		<result property="province.id" column="Applicant_Province" />
		<result property="city.id" column="Applicant_City" />
		<result property="district.id" column="Applicant_District" />
		<result property="companyWhiteList" column="Company_White_List" />
		<result property="companyBlackList" column="Company_Black_List" />
		<result property="tenderReturnTime" column="Tender_Return_Time" />
		<result property="tenderLevel.id" column="Tender_Level_Id"/>
		<association property="insuranceDemandDetail"
			select="InsuranceFeature.findFeatureByTender" column="id" />
	</resultMap>

	<resultMap id="dispatchedTender" type="com.djb.domain.tender.Tender">
		<result property="id" column="Id" />
		<result property="province.id" column="Province" />
		<result property="contactName" column="Contact_Name" />
		<result property="remark" column="Insured_Relative" />
		<result property="createDateTime" column="create_time" />
		<result property="updateDateTime" column="Update_Time" />
		<result property="email" column="Email" />
		<result property="mobilePhone" column="Mobilephone" />
		<result property="dispatchStatus" column="Status" />
		<result property="status" column="Tender_Status" />
		<result property="type" column="Tender_Type" />
		<result property="dispatchId" column="Dispatch_Id" />
		<result property="tenderType" column="Type" />
		<result property="totalPrice.id" column="totalPrice" />
		<result property="dispatchTime" column="Dispatch_Time" />
		<result property="companyWhiteList" column="Company_White_List" />
		<result property="companyBlackList" column="Company_Black_List" />
		<result property="expectedReplyNumber" column="Expected_Reply_Number" />
		<result property="dispatchRemark" column="Dispatch_Remark" />
	</resultMap>

	<sql id=""></sql>

	<select id="getMyTenderCount" parameterType="com.djb.domain.tender.MyTenderQueryBean"
		resultType="int">
		SELECT count(1)
		FROM Dp_Tender_Dispatch_Record
		WHERE delete_flag = 0
		and Agent_Id = #{agentId}

		<if test="stage == 'untreated'">

			and status &lt; (case when type = 1 then 10 when type = 2 then 20 end)
		</if>
		<if test="stage == 'treated'">

			and status &gt;= (case when type = 1 then 10 when type = 2 then 20 end)
			and status &lt;= 100
		</if>
		<if test="stage == 'expired'">
			and status = 110
		</if>

	</select>

	<select id="findMyTenderByQueryBean" parameterType="com.djb.domain.tender.MyTenderQueryBean"
		resultMap="dispatchedTender">
		SELECT *
		FROM (
		SELECT tender.Id
		,tender.Applicant_Province as Province
		,tender.Contact_Name
		,tender.Insured_Relative
		,record.Create_Time
		,tender.Create_Time as Update_Time
		,tender.Email
		,tender.Mobilephone
		,record.Status
		,tender.Status as Tender_Status
		,1 as Tender_Type
		,record.id as Dispatch_Id
		,record.Type
		,record.Remark as Dispatch_Remark
		,tender.Total_Price as totalPrice
		,record.Create_Time as Dispatch_Time
		,tender.Company_White_List
		,tender.Company_Black_List
		,tender.Expected_Reply_Number
		FROM Dp_Tender_Dispatch_Record record
		LEFT JOIN Dp_Personal_Tender tender ON record.Tender_Id = tender.Id
		WHERE record.Agent_Id = #{agentId}
		AND record.delete_flag = 0

		<if test="stage == 'untreated'">

			AND record.status &lt; (case when record.type = 1 then 10 when
			record.type = 2 then 20 end)
		</if>
		<if test="stage == 'treated'">

			AND record.status &gt;= (case when record.type = 1 then 10 when
			record.type = 2 then 20 end)
			AND record.status &lt;= 100
		</if>
		<if test="stage == 'expired'">
			AND record.status = 110
		</if>

		UNION
		SELECT tender.Id
		,tender.Province as Province
		,tender.Contact_Name
		,tender.Company_Name as Insured_Relative
		,record.Create_Time
		,tender.Create_Time as Update_Time
		,tender.Email
		,tender.Mobilephone
		,record.Status
		,tender.Status as Tender_Status
		,2 as Tender_Type
		,record.id as Dispatch_Id
		,record.Type
		,record.Remark
		,tender.Total_Price as totalPrice
		,record.Create_Time as Dispatch_Time
		,tender.Company_White_List
		,tender.Company_Black_List
		,Expected_Reply_Number
		FROM Dp_Tender_Dispatch_Record record
		LEFT JOIN Dp_Group_Tender tender ON record.Tender_Id = tender.Id
		WHERE record.Agent_Id = #{agentId}
		AND record.delete_flag = 0

		<if test="stage == 'untreated'">

			AND record.status &lt; (case when record.type = 1 then 10 when
			record.type = 2 then 20 end)
		</if>
		<if test="stage == 'treated'">

			AND record.status &gt;= (case when record.type = 1 then 10 when
			record.type = 2 then 20 end)
			AND record.status &lt;= 100
		</if>
		<if test="stage == 'expired'">
			AND record.status = 110
		</if>

		) SUB_QUERY1
		WHERE id is not null
		<if test="orderByProperties != null"> ORDER BY ${orderByFiled} </if>
		LIMIT ${startIndex}, ${pageSize}
	</select>

	<select id="findTenderByDispatchRecord" parameterType="java.util.Map"
		resultMap="dispatchedTender">
		SELECT tender.Id

		<if test="tenderType == 1">
			,tender.Applicant_Province as Province
		</if>
		<if test="tenderType == 2">
			,tender.Province as Province
		</if>

		,tender.Contact_Name

		<if test="tenderType == 1">
			,tender.Insured_Relative
		</if>
		<if test="tenderType == 2">
			,tender.Company_Name as Insured_Relative
		</if>

		,record.Create_Time
		,tender.Create_Time as Update_Time
		,tender.Email
		,tender.Mobilephone
		,record.Status
		,tender.Status as Tender_Status
		,#{tenderType} as Tender_Type
		,record.id as Dispatch_Id
		,record.Type
		,record.Remark as Dispatch_Remark
		,tender.Total_Price as totalPrice
		,record.Create_Time as Dispatch_Time
		,tender.Company_White_List
		,tender.Company_Black_List
		,tender.Expected_Reply_Number
		FROM Dp_Tender_Dispatch_Record record

		<if test="tenderType == 1">
			LEFT JOIN Dp_Personal_Tender tender
		</if>
		<if test="tenderType == 2">
			LEFT JOIN Dp_Group_Tender tender
		</if>

		on record.Tender_Id = tender.Id
		WHERE record.id = #{dispatchId}
		and record.agent_id = #{agentId}
		and record.tender_id = #{tenderId}
	</select>

	<!-- 找到待发送EDM的标书 -->
	<select id="findPendingEdmTenders" parameterType="java.util.Map"
		resultMap="tender">
		SELECT personal.Id
		,personal.User_Id
		,personal.Contact_Name
		,personal.Email
		,personal.Mobilephone
		,personal.Is_Open_Phone
		,personal.Expected_Reply_Number
		,personal.Status
		,personal.Total_Price
		,personal.create_time
		,1 Tender_Type
		,personal.Phone_Valid_Flag
		,personal.Create_User_Id
		,personal.Applicant_Province
		,personal.Applicant_City
		,personal.Applicant_District
		,personal.Company_White_List
		,personal.Company_Black_List
		FROM Dp_Personal_Tender personal
		JOIN Dp_Tender_Lifecycle life ON life.tender_ID=personal.Id AND
		Tender_Type = 1 AND life.Cur_Tender_Status = #{tenderStatus}
		WHERE personal.Email IS NOT NULL
		AND Is_Open_Phone = 0
		AND personal.delete_flag = '0'
		AND personal.Status = #{tenderStatus}
		AND personal.delete_flag = '0'
		AND life.Create_Time &gt;= date_add(now(), interval -${handleHours} hour)
		AND personal.Create_Time &gt; '2012-12-26'
		AND personal.Create_Time &gt; date_add(now(), interval -${dealDays} day)
		UNION ALL

		SELECT groupTender.Id
		,groupTender.User_Id
		,groupTender.Contact_Name
		,groupTender.Email
		,groupTender.Mobilephone
		,groupTender.Is_Open_Phone
		,groupTender.Expected_Reply_Number
		,groupTender.Status
		,groupTender.Total_Price
		,groupTender.create_time
		,2 Tender_Type
		,groupTender.Phone_Valid_Flag
		,groupTender.Create_User_Id
		,groupTender.Province as Applicant_Province
		,groupTender.City as Applicant_City
		,groupTender.District as Applicant_District
		,groupTender.Company_White_List
		,groupTender.Company_Black_List
		FROM Dp_Group_Tender groupTender
		JOIN Dp_Tender_Lifecycle life ON life.tender_ID=groupTender.Id AND
		Tender_Type = 2 AND life.Cur_Tender_Status = #{tenderStatus}
		WHERE groupTender.Email IS NOT NULL
		AND Is_Open_Phone = 0
		AND groupTender.Status = #{tenderStatus}
		AND groupTender.delete_flag = '0'
		AND life.Create_Time &gt;= date_add(now(), interval -${handleHours} hour)
		AND personal.Create_Time &gt; '2012-12-26' AND personal.Create_Time
		&gt; date_add(now(), interval -${dealDays} day)
	</select>

	<sql id="findBackingTenderListRef">
	FROM (
		SELECT Id
		,User_Id
		,Contact_Name
		,Email
		,Mobilephone
		,Is_Open_Phone
		,Expected_Reply_Number
		,Status
		,Total_Price
		,create_time
		,1 Tender_Type
		,Phone_Valid_Flag
		,Create_User_Id
		,Applicant_Province
		,Applicant_City
		,Applicant_District
		,Company_White_List
		,Company_Black_List
		FROM Dp_Personal_Tender personal
		WHERE (1 = 1)
		<if test="verifyTime != null">
			AND personal.Verify_Time &lt;= now()
		</if>
		<if test="provinceList != null">
			AND (personal.Applicant_Province is null or
			personal.Applicant_Province in
			<foreach collection="provinceList" item="item" separator=","
				close=")" open="(">
				#{item}
			</foreach>
			)
		</if>
		<if test="sourceList != null">
			AND (personal.From_Tag in
			<foreach collection="sourceList" item="item" separator=","
				close=")" open="(">
				#{item}
			</foreach>
			)
		</if>
		<if test="reason != null">
			AND personal.Invalid_Reason is null
		</if>
		<if test="province != null and province != ''">
			AND personal.Applicant_Province = #{province.id}
		</if>
		<if test="city != null and city != ''">
			AND personal.Applicant_City = #{city.id}
		</if>
		<if test="district != null and district != ''">
			AND personal.Applicant_District = #{district.id}
		</if>
		<if test="startTime != null and startTime != ''">
			AND personal.create_time &gt;= #{startTime}
		</if>
		<if test="endTime != null and endTime != ''">
			AND personal.create_time &lt;= #{endTime}
		</if>
		<if test="type != null">
			AND personal.Is_Open_Phone = #{type}
		</if>
		<if test="status != null and status != ''">
			AND personal.Status = #{status}
		</if>
		<if test="statusList != null and statusList != ''">
			AND personal.Status IN
			<foreach collection="statusList" item="item" separator=","
				close=")" open="(">
				#{item}
			</foreach>
		</if>
		<if test="mobilePhone != null and mobilePhone != ''">
			AND personal.Mobilephone = #{mobilePhone}
		</if>
		<if test="email != null and email != ''">
			AND personal.Email = #{email}
		</if>
		<if test="tenderId != null and tenderId != ''">
			AND personal.Id = #{tenderId}
		</if>
		<if test="null != locationProvince">
			AND ((personal.Ip_Province is not null and personal.Ip_Province like
			concat('%',#{locationProvince.cityName},'%'))
			or
			(personal.Mobile_Province is not null and #{locationProvince.cityName} like
			concat('%',personal.Mobile_Province,'%')))
		</if>
		<if test="null != locationCity">
			AND ((personal.Ip_City is not null and #{locationCity.cityName} like
			concat('%',personal.Ip_City,'%'))
			or
			(personal.Mobile_City is not null and #{locationCity.cityName} like concat('%',
			personal.Mobile_City,'%')))
		</if>

		AND personal.delete_flag = 0

		UNION ALL

		SELECT Id
		,User_Id
		,Contact_Name
		,Email
		,Mobilephone
		,Is_Open_Phone
		,Expected_Reply_Number
		,Status
		,Total_Price
		,create_time
		,2 Tender_Type
		,Phone_Valid_Flag
		,Create_User_Id
		,Province as Applicant_Province
		,City as Applicant_City
		,District as Applicant_District
		,Company_White_List
		,Company_Black_List
		FROM Dp_Group_Tender groupTender
		WHERE (1 = 1)

		<if test="verifyTime != null">
			AND groupTender.Verify_Time &lt;= now()
		</if>
		<if test="provinceList != null">
			AND (groupTender.Province is null or groupTender.Province in
			<foreach collection="provinceList" item="item" separator=","
				close=")" open="(">
				#{item}
			</foreach>
			)
		</if>
		<if test="sourceList != null">
			AND (groupTender.From_Tag in
			<foreach collection="sourceList" item="item" separator=","
				close=")" open="(">
				#{item}
			</foreach>
			)
		</if>
		<if test="reason != null">
			AND groupTender.Invalid_Reason is null
		</if>
		<if test="province != null and province != ''">
			AND groupTender.Province = #{province.id}
		</if>
		<if test="city != null and city != ''">
			AND groupTender.City = #{city.id}
		</if>
		<if test="startTime != null and startTime != ''">
			AND groupTender.create_time &gt;= #{startTime}
		</if>
		<if test="endTime != null and endTime != ''">
			AND groupTender.create_time &lt;= #{endTime}
		</if>
		<if test="type != null ">
			AND groupTender.Is_Open_Phone = #{type}
		</if>
		<if test="status != null and status != ''">
			AND groupTender.Status = #{status}
		</if>
		<if test="statusList != null and statusList != ''">
			AND groupTender.Status IN
			<foreach collection="statusList" item="item" separator=","
				close=")" open="(">
				#{item}
			</foreach>
		</if>
		<if test="mobilePhone != null and mobilePhone != ''">
			AND groupTender.Mobilephone = #{mobilePhone}
		</if>
		<if test="email != null and email != ''">
			AND groupTender.Email = #{email}
		</if>
		<if test="tenderId != null and tenderId != ''">
			AND groupTender.Id = #{tenderId}
		</if>
		<if test="null != locationProvince">
			AND ((groupTender.Ip_Province is not null and groupTender.Ip_Province
			like concat('%',#{locationProvince.cityName},'%'))
			or
			(groupTender.Mobile_Province is not null and #{locationProvince.cityName} like
			concat('%',groupTender.Mobile_Province,'%')))
		</if>
		<if test="null != locationCity">
			AND ((groupTender.Ip_City is not null and #{locationCity.cityName} like
			concat('%',groupTender.Ip_City,'%'))
			or
			(groupTender.Mobile_City is not null and #{locationCity.cityName} like
			concat('%',groupTender.Mobile_City,'%')))
		</if>
		AND groupTender.delete_flag = 0
	) p
	</sql>

	<!-- 管理后台标书查询-分页 -->
	<select id="findBackingTenderList" parameterType="com.djb.domain.tender.TenderQueryBean"
		resultMap="tender">
		SELECT *
		<include refid="findBackingTenderListRef" />
		ORDER BY ${orderByFiled}
		LIMIT ${startIndex}, ${pageSize}
	</select>

	<!-- 管理后台标书查询-总数 -->
	<select id="findBackingTenderCount" parameterType="com.djb.domain.tender.TenderQueryBean"
		resultType="int">
		SELECT COUNT(*)
		<include refid="findBackingTenderListRef" />
	</select>

	<select id="findRelatedTender" parameterType="java.util.Map"
		resultMap="tender">
		SELECT Id
		,User_Id
		,Contact_Name
		,Email
		,Mobilephone
		,Is_Open_Phone
		,Expected_Reply_Number
		,Status
		,Total_Price
		,create_time
		,1 Tender_Type
		,Phone_Valid_Flag
		,Create_User_Id
		,Applicant_Province
		,Applicant_City
		,Applicant_District
		,Company_White_List
		,Company_Black_List
		FROM Dp_Personal_Tender personal
		WHERE personal.delete_flag = '0'
		AND personal.Id &lt;&gt; #{id}
		AND (
		(personal.Mobilephone = #{mobilePhone} and #{mobilePhone} &lt;&gt; '')
		or
		(personal.Email = #{email} and #{email} &lt;&gt; '')
		)

		<if test="statusList != null and statusList != ''">
			AND personal.Status IN
			<foreach collection="statusList" item="item" separator=","
				close=")" open="(">
				#{item}
			</foreach>
		</if>


		UNION ALL

		SELECT Id
		,User_Id
		,Contact_Name
		,Email
		,Mobilephone
		,Is_Open_Phone
		,Expected_Reply_Number
		,Status
		,Total_Price
		,create_time
		,2 Tender_Type
		,Phone_Valid_Flag
		,Create_User_Id
		,Province as Applicant_Province
		,City as Applicant_City
		,District as Applicant_District
		,Company_White_List
		,Company_Black_List
		FROM Dp_Group_Tender groupTender
		WHERE groupTender.delete_flag = '0'
		AND groupTender.Id &lt;&gt; #{id}
		AND (
		(groupTender.Mobilephone = #{mobilePhone} and #{mobilePhone} &lt;&gt; '')
		or
		(groupTender.Email = #{email} and #{email} &lt;&gt; '')
		)

		<if test="statusList != null and statusList != ''">
			AND groupTender.Status IN
			<foreach collection="statusList" item="item" separator=","
				close=")" open="(">
				#{item}
			</foreach>
		</if>

	</select>

	<select id="findById" parameterType="long" resultMap="tender">
		SELECT Id
		,User_Id
		,Contact_Name
		,Email
		,Mobilephone
		,Is_Open_Phone
		,Expected_Reply_Number
		,Status
		,Total_Price
		,create_time
		,1 Tender_Type
		,Phone_Valid_Flag
		,Create_User_Id
		,Applicant_Province
		,Applicant_City
		,Applicant_District
		,Company_White_List
		,Company_Black_List
		FROM Dp_Personal_Tender personal
		WHERE (1 = 1)
		AND personal.Id = #{id}
		AND personal.delete_flag = 0
		UNION ALL
		SELECT Id
		,User_Id
		,Contact_Name
		,Email
		,Mobilephone
		,Is_Open_Phone
		,Expected_Reply_Number
		,Status
		,Total_Price
		,create_time
		,2 Tender_Type
		,Phone_Valid_Flag
		,Create_User_Id
		,Province as Applicant_Province
		,City as Applicant_City
		,District as Applicant_District
		,Company_White_List
		,Company_Black_List
		FROM Dp_Group_Tender groupTender
		WHERE (1 = 1)
		AND groupTender.Id = #{id}
		AND groupTender.delete_flag = 0
	</select>
	
	<sql id="findTrackTenderListRef">
		from(
				SELECT
				Id
				,Expected_Reply_Number
				,Applicant_Province
				,Applicant_City
				,Applicant_District
				,Is_Open_Phone
				,1 as Tender_Type
				,Status
				FROM Dp_Personal_Tender pt
				WHERE pt.Delete_Flag = 0
				<if test="type!=null">
					AND pt.Is_Open_Phone=#{type}
				</if>
				<if test="province != null and province != ''">
					AND pt.Applicant_Province = #{province.id}
				</if>
				<if test="city != null and city != ''">
					AND pt.Applicant_City = #{city.id}
				</if>
				<if test="district != null and district != ''">
					AND pt.Applicant_District = #{district.id}
				</if>
				<if test="tenderId!=null and tenderId!=''">
					AND pt.Id=#{tenderId}
				</if>
			union all
				SELECT
				Id
				,Expected_Reply_Number
				,Province as Applicant_Province
				,City as Applicant_City
				,District as Applicant_District
				,Is_Open_Phone
				,2 as Tender_Type
				,Status
				FROM Dp_Group_Tender gt
				WHERE gt.Delete_Flag = 0
				<if test="type!=null">
					AND gt.Is_Open_Phone=#{type}
				</if>
				<if test="province != null and province != ''">
					AND gt.Province = #{province.id}
				</if>
				<if test="city != null and city != ''">
					AND gt.City = #{city.id}
				</if>
				<if test="district != null and district != ''">
					AND gt.District = #{district.id}
				</if>
				<if test="tenderId!=null and tenderId!=''">
					AND gt.Id=#{tenderId}
				</if>
	
			) as t
			
			WHERE
			exists(
				SELECT 1 FROM
				Dp_Tender_Lifecycle WHERE Cur_Tender_Status in (20,21)
				and Delete_Flag = 0
				and Tender_Id = t.Id
				and Create_Time &gt;= '2013-11-01 00:00:00'
				<if test="startTime!=null">
					and Create_Time &gt;= #{startTime}
				</if>
				<if test="endTime!=null">
					and Create_Time &lt;= #{endTime}
				</if>
			)
			<if test="progess != null">
			and exists(
				SELECT 1 FROM Dp_Tender_Dispatch_Record
				WHERE Delete_Flag = 0
				and Tender_Id = t.Id
				<if test="progess ==1">
					and Status =0
				</if>
				<if test="progess ==2">
					and (Status=10 and t.Is_Open_Phone=0)
				</if>
				<if test="progess ==3">
					and ((Status in (20,30,40,50,60,70,80,90,100) and t.Is_Open_Phone=0) or
					(Status in (10,20,30,40,50,60,70,80,90,100) and t.Is_Open_Phone=1))
				</if>
				)
			</if>
	</sql>

	<select id="findTrackTenderList" parameterType="com.djb.domain.tender.TenderQueryBean"
		resultMap="tender">
		SELECT * <include refid="findTrackTenderListRef"/>
		ORDER BY t.Id DESC
		LIMIT ${startIndex}, ${pageSize}
	</select>

	<select id="findTrackTenderListCount" parameterType="com.djb.domain.tender.TenderQueryBean"
		resultType="int">
		SELECT count(*) <include refid="findTrackTenderListRef"/>
	</select>

	<select id="findLastTimeFromTenderLifecycleByTenderId"
		parameterType="long" resultType="string">
		SELECT Create_Time
		FROM Dp_Tender_Lifecycle
		WHERE Tender_Id=#{tenderId}
		and Cur_Tender_Status in (20,21)
		ORDER BY Create_Time DESC
		LIMIT 1
	</select>
	
	<sql id="findTenderReturnListRef">
	from(
		SELECT
		Id
		,Is_Open_Phone
		,Status
		,create_time
		,1 Tender_Type
		,Applicant_Province
		,Applicant_City
		,Applicant_District
		,Tender_Return_Time
		FROM Dp_Personal_Tender pt
		WHERE pt.Delete_Flag = 0
		AND pt.Tender_Return_Time is not null
		<if test="province != null and province != ''">
			AND pt.Applicant_Province = #{province.id}
		</if>
		<if test="city != null and city != ''">
			AND pt.Applicant_City = #{city.id}
		</if>
		<if test="district != null and district != ''">
			AND pt.Applicant_District = #{district.id}
		</if>
		<if test="tenderId!=null and tenderId!=''">
			AND pt.Id=#{tenderId}
		</if>
		<if test="startTime!=null">
			AND pt.Tender_Return_Time &gt;= #{startTime}
		</if>
		<if test="endTime!=null">
			AND pt.Tender_Return_Time &lt;= #{endTime}
		</if>
		union all
		SELECT
		Id
		,Is_Open_Phone
		,Status
		,create_time
		,2 Tender_Type
		,Province as Applicant_Province
		,City as Applicant_City
		,District as Applicant_District
		,Tender_Return_Time
		FROM Dp_Group_Tender gt
		WHERE gt.Delete_Flag = 0
		AND gt.Tender_Return_Time is not null
		<if test="province != null and province != ''">
			AND gt.Province = #{province.id}
		</if>
		<if test="city != null and city != ''">
			AND gt.City = #{city.id}
		</if>
		<if test="district != null and district != ''">
			AND gt.District = #{district.id}
		</if>
		<if test="tenderId!=null and tenderId!=''">
			AND gt.Id=#{tenderId}
		</if>
		<if test="startTime!=null">
			AND gt.Tender_Return_Time &gt;= #{startTime}
		</if>
		<if test="endTime!=null">
			AND gt.Tender_Return_Time &lt;= #{endTime}
		</if>
		) p
	</sql>

	<select id="findTenderReturnListCount" parameterType="com.djb.domain.tender.TenderQueryBean"
		resultType="int">
		SELECT count(*) <include refid="findTenderReturnListRef"/>
	</select>
	<select id="findTenderReturnList" parameterType="com.djb.domain.tender.TenderQueryBean"
		resultMap="tender">
		SELECT * <include refid="findTenderReturnListRef"/>
		ORDER BY p.Id DESC
		LIMIT ${startIndex}, ${pageSize}
	</select>

	<select id="getTenderAddCount" parameterType="com.djb.domain.tender.TenderQueryBean"
		resultType="int">
		SELECT COUNT(Id)
		FROM (
		SELECT Id
		FROM Dp_Personal_Tender personal
		WHERE (1 = 1)

		AND personal.delete_flag = 0
		<if test="city != null and city != ''">
			AND personal.Applicant_City = #{city.id}
		</if>

		and datediff(personal.Create_Time,now()) &lt;7
		UNION ALL

		SELECT Id
		FROM Dp_Group_Tender groupTender
		WHERE (1 = 1)
		AND groupTender.delete_flag = 0
		<if test="city != null and city != ''">
			AND groupTender.City = #{city.id}
		</if>
		and datediff(personal.Create_Time,now()) &lt;7
		) SUB_QUERY
	</select>
</mapper>
==================================== END tender/Tender.xml =========================


==================================== BEGIN tender/TenderUse.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:04:03 
 CST 2013 -->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="TenderUse">

 <resultMap id="tenderUse" type="com.djb.domain.tender.TenderUse"
  extends="DomainObject.domainObject">
  <result property="avatar" column="avatar" />
  <result property="username" column="username" />
  <result property="weiboLink" column="Weibo_Link" />
  <result property="insuredRelative.id" column="Insured_Relative" />
  <result property="tenderUseStatus" column="Tender_Use_Status" />
 </resultMap>

 <select id="load" resultMap="tenderUse">
  SELECT *
  FROM Dp_Tender_Use
  WHERE id = #{id}
  AND delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.tender.TenderUse">
  UPDATE Dp_Tender_Use
  SET
  avatar=#{avatar}
  ,username=#{username}
  ,Weibo_Link=#{weiboLink}
  ,Tender_Use_Status=#{tenderUseStatus}
  ,Insured_Relative=#{insuredRelative.id}
  ,Delete_Flag=#{deleteFlag}
  ,Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime}
  WHERE id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.tender.TenderUse">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO Dp_Tender_Use(
  avatar
  ,username
  ,Weibo_Link
  ,Insured_Relative
  ,Tender_Use_Status
  ,Delete_Flag
  ,Create_User_Id
  ,Create_Time
  ,Update_User_Id
  ,Update_Time
  )
  VALUES(
  #{avatar}
  ,#{username}
  ,#{weiboLink}
  ,#{insuredRelative.id}
  ,#{tenderUseStatus}
  ,#{deleteFlag}
  ,#{createUserId}
  ,#{createDateTime}
  ,#{updateUserId}
  ,#{updateDateTime}
  )


 </insert>

 <delete id="deleteByPrimaryKey">
  DELETE FROM Dp_Tender_Use
  WHERE id = #{id}
 </delete>

 <sql id="findTenderUseByQueryBeanRef">
  FROM Dp_Tender_Use
  WHERE delete_flag=0
  AND Tender_Use_Status &gt; 1
  <if test="avatar != null and avatar != ''">
   AND avatar IS NOT NULL
   AND avatar != ''
   AND avatar != #{avatar}
  </if>
 </sql>
 <!-- 根据queryBean查找类别的数量 -->
 <select id="getCountByQueryBean" parameterType="com.djb.domain.tender.TenderUseQueryBean"
  resultType="int">
  SELECT count(*) <include refid="findTenderUseByQueryBeanRef"/>
 </select>

 <!-- 根据queryBean查找所有符合条件的类别 -->
 <select id="findTenderUseByQueryBean" parameterType="com.djb.domain.tender.TenderUseQueryBean"
  resultMap="tenderUse">
  SELECT * <include refid="findTenderUseByQueryBeanRef"/>
  <if test="orderByProperties != null">
   ORDER BY ${orderByFiled}
  </if>
  <if test="orderByProperties == null">
   ORDER BY create_time DESC
  </if>
  LIMIT ${startIndex}, ${pageSize}
 </select>
</mapper>
==================================== END tender/TenderUse.xml =========================


==================================== BEGIN tender/TenderDispatchRecord.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:04:00 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="TenderDispatchRecord">
 <resultMap id="tenderDispatchRecord" type="com.djb.domain.tender.TenderDispatchRecord" extends="DomainObject.domainObject">
  <result property="tender.id" column="Tender_Id"/>
  <result property="type" column="Tender_Type"/>
  <result property="agent.id" column="Agent_Id"/>
  <result property="status" column="Status"/>
  <result property="program.id" column="Program_Id"/>
  <result property="tenderType" column="Type"/>
  <result property="remark" column="Remark"/>
  <result property="agentRemark" column="Agent_Remark"/>
  <result property="dispatchType" column="Dispatch_Type"/>
  <result property="position" column="Tender_Draw_Position"/>
 </resultMap>
 
 <select id="load" resultMap="tenderDispatchRecord">
  SELECT *
   FROM Dp_Tender_Dispatch_Record
   WHERE id = #{id} 
    AND delete_flag = '0'
 </select>
 
 <select id="getAll" resultMap="tenderDispatchRecord">
  SELECT *
   FROM Dp_Tender_Dispatch_Record
  WHERE delete_flag = '0'
  ORDER BY Tender_Id
 </select>
 
 <!-- old version no. is 1541 -->
 <select id="getAgentSubmitedRecordByTender" parameterType="java.util.Map" resultMap="tenderDispatchRecord">
  SELECT *
    FROM Dp_Tender_Dispatch_Record
   WHERE Status = #{status}
     AND Tender_Id = #{tenderId}
     AND delete_flag = '0'
 </select>
 
 <!-- 查找所有带回收的标书列表 -->
 <select id="findRecycleRecords" parameterType="java.util.Map" resultMap="tenderDispatchRecord">
  SELECT *
   FROM Dp_Tender_Dispatch_Record
   WHERE Tender_Id = #{tenderId}
     AND Status = #{status}
     AND delete_flag = '0'
 </select>
 
 <update id="update" parameterType="com.djb.domain.tender.TenderDispatchRecord">
  UPDATE Dp_Tender_Dispatch_Record
      SET
         Tender_Id = #{tender.id},
         Tender_Type = #{type.value},
         Agent_Id = #{agent.id},
         Status = #{status.value},
         Program_Id = #{programId},
         Type=#{tenderType},
         Remark = #{remark},
         Agent_Remark = #{agentRemark},
         Dispatch_Type = #{dispatchType},
         update_time = #{updateDateTime},
         update_user_id = #{updateUserId},
         delete_flag = #{deleteFlag}
   WHERE id = #{id}
 </update>
 
 <update id="unsatisfied" parameterType="string">
  UPDATE Dp_Tender_Dispatch_Record
     SET Status=100
   WHERE id in (${value})
 </update>
 
 <insert id="insert" parameterType="com.djb.domain.tender.TenderDispatchRecord">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO 
   Dp_Tender_Dispatch_Record(
    Tender_Id,
    Tender_Type,
    Agent_Id,
    Status,
    Program_Id,
    Type,
    Remark,
    Agent_Remark,
    Dispatch_Type,
    Tender_Draw_Position,
    create_time,
    create_user_id,
    update_time,
    update_user_id,
    delete_flag
   )
  VALUES(
   #{tender.id},
   #{type.value},
   #{agent.id},
   #{status.value},
   #{programId},
   #{tenderType},
   #{remark},
   #{agentRemark},
   #{dispatchType},
   #{position},
   #{createDateTime},
   #{createUserId},
   #{updateDateTime},
   #{updateUserId},
   #{deleteFlag}
  )
 </insert>
 
 <delete id="deleteByPrimaryKey">
  DELETE FROM 
   Dp_Tender_Dispatch_Record
  WHERE
   id = #{id}
 </delete>
 
 <delete id="deleteTenderDispatch" parameterType="com.djb.domain.tender.TenderDispatchRecord">
  DELETE FROM 
   Dp_Tender_Dispatch_Record
  WHERE
      Agent_Id = #{agent.id}
  AND Tender_Id=#{tender.id}    
 </delete>
 
 <select id="findDispatchRecordByAgent" resultMap="tenderDispatchRecord">
  SELECT *
    FROM Dp_Tender_Dispatch_Record
   WHERE Agent_Id = #{agentId}
     and delete_flag = 0
 </select>
 
 <select id="findDispatchByProgram" resultMap="tenderDispatchRecord">
  SELECT * 
    FROM Dp_Tender_Dispatch_Record 
   WHERE Program_Id = #{programId}
     AND Agent_Id = (SELECT User_Id FROM Dp_Program WHERE Id = #{programId})
     AND delete_flag = 0
     <if test="tenderId != null">AND
       tender_id = #{tenderId}
     </if>
     <if test="tenderType != null">AND
       tender_type = #{tenderType}
     </if>
 </select>
 
 <select id="findTenderDispatchRecord" resultMap="tenderDispatchRecord">
  SELECT *
    FROM Dp_Tender_Dispatch_Record
   WHERE Tender_Id = #{tenderId}
     <if test="agentId != null">
     and agent_id = #{agentId}
     </if>
     and delete_flag = 0
 </select>
 
 <select id="fingTenderAgentDispatch" resultMap="tenderDispatchRecord">
 SELECT * 
   FROM Dp_Tender_Dispatch_Record
   WHERE Tender_Id=#{tender.id}
   and agent_id=#{agent.id}
   and delete_flag = 0
 </select>
 
 <select id="getUntreatedCount" parameterType="long" resultType="int">
  SELECT count(1)
    FROM Dp_Tender_Dispatch_Record
   WHERE delete_flag = 0
     and agent_id = #{agentId}
     and status = 0
 </select>
 
 <select id="findAppTenderDispatchList" parameterType="java.util.Map" resultMap="tenderDispatchRecord">
 SELECT *
   FROM Dp_Tender_Dispatch_Record record
  WHERE (1 = 1)
    AND record.delete_flag = 0
    <if test="type == 'archive'">
    AND record.Agent_Remark is not null
    </if>
    <if test="type != 'archive'">
    AND record.Agent_Remark is null
    </if>
    AND record.Agent_Id = #{agentId} 
    AND record.status != 110
  ORDER BY Create_Time DESC
 </select>
 
 <select id="getWeeklyDispatchedCount" parameterType="map" resultType="int">
  SELECT count(1)
    FROM Dp_Tender_Dispatch_Record
   WHERE delete_flag = 0
     and agent_id = #{agentId}
     and Type = #{type}
     and create_time &gt;= #{weekStart}
     and Dispatch_Type = 2
 </select>
 
 <select id="getUnArchiveTenderList" resultMap="tenderDispatchRecord">
  SELECT *
    FROM Dp_Tender_Dispatch_Record
   WHERE Delete_Flag = 0
     AND Agent_Remark is null
     AND Create_Time &lt;= date_add(now(), interval -30 day)
 </select>
 
 <update id="deleteByTenderAgent" parameterType="map">
  UPDATE Dp_Tender_Dispatch_Record
    SET delete_flag = 1,
      update_time = #{updateDateTime},
    update_user_id = #{updateUserId}
  WHERE agent_id = #{agentId}
    AND delete_flag = 0
 </update>
 
 <select id="getTrackByTenderId"  parameterType="long" resultMap="tenderDispatchRecord">
   SELECT * FROM Dp_Tender_Dispatch_Record
   WHERE Delete_Flag =0
   and Tender_Id=#{tenderId}
   ORDER BY Id
 
 </select>
 
 <select id="getTrackCountByTenderId" parameterType="long" resultType="int">
  SELECT count(*) FROM Dp_Tender_Dispatch_Record
  WHERE Delete_Flag =0
  and Tender_Id=#{tenderId}
 </select>
</mapper>
==================================== END tender/TenderDispatchRecord.xml =========================


==================================== BEGIN tender/TmpTenderNum.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:04:04 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="TmpTenderNum">
 <resultMap id="tmpTenderNum" type="com.djb.domain.tender.TmpTenderNum" extends="DomainObject.domainObject">
  <result property="paramName" column="Param_Name"/>
  <result property="paramValue" column="Param_Value"/>
 </resultMap>
 
 
 <select id="getAll" resultMap="tmpTenderNum">
  SELECT *
  FROM
    Tmp_Tender_Num
  WHERE
    delete_flag='0'
 </select>
 
</mapper>
==================================== END tender/TmpTenderNum.xml =========================


==================================== BEGIN tender/PersonalTender.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:03:59 
	CST 2013 -->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="PersonalTender">

	<resultMap id="personalTender" type="com.djb.domain.tender.PersonalTender"
		extends="DomainObject.domainObject">
		<result property="userId" column="User_Id" />
		<result property="userType" column="User_Type" />
		<result property="insuredRelative.id" column="Insured_Relative" />
		<result property="insuredSex" column="Insured_Sex" />
		<result property="insuredBirthday" column="Insured_Birthday" />
		<result property="province.id" column="Applicant_Province" />
		<result property="city.id" column="Applicant_City" />
		<result property="district.id" column="Applicant_District" />
		<result property="hasSocialInsurance" column="Has_Social_Insurance" />
		<result property="ageOfDrawPension.id" column="Age_Of_Draw_Pension" />
		<result property="totalPrice.id" column="Total_Price" />
		<result property="requirementDescription" column="Requirement_Description" />
		<result property="contactName" column="Contact_Name" />
		<result property="email" column="Email" />
		<result property="mobilePhone" column="Mobilephone" />
		<result property="isOpenPhone" column="Is_Open_Phone" />
		<result property="ipAddress" column="Ip_Address" />
		<result property="fromUrl" column="From_Url" />
		<result property="expectedReplyNumber" column="Expected_Reply_Number" />
		<result property="status" column="Status" />
		<result property="remark" column="Remark" />
		<result property="ipLocation" column="Ip_Location" />
		<result property="mobilePhoneLocation" column="Mobilephone_Location" />
		<result property="fromTag" column="From_Tag" />
		<result property="phoneValidFlag" column="Phone_Valid_Flag" />
		<result property="dajiabaoUrl" column="Dajiabao_Url" />
		<result property="verifyTime" column="Verify_Time" />
		<result property="invalidReason" column="Invalid_Reason" />
		<result property="companyWhiteList" column="Company_White_List" />
		<result property="companyBlackList" column="Company_Black_List" />
		<result property="tenderVersion" column="Tender_Version" />
		<result property="requireService" column="Require_Service" />
		<result property="tenderUseId" column="Tender_Use_Id" />
		<result property="phoneValidUser" column="Phone_Valid_User" />
		<result property="dispatchTime" column="Dispatch_Time" />
		<result property="utmTerm" column="Utm_Term" />
		<result property="utmContent" column="Utm_Content" />
		<result property="os" column="OS" />
		<result property="browser" column="Browser" />
		<result property="ipProvince" column="Ip_Province" />
		<result property="ipCity" column="Ip_City" />
		<result property="ipDistrict" column="Ip_District" />
		<result property="mobileProvince" column="Mobile_Province" />
		<result property="mobileCity" column="Mobile_City" />
		<result property="tips" column="Tips" />
		<result property="guarantee" column="Guarantee" />
		<result property="expectProductId" column="Expect_Product_Id" />
		<result property="tenderReturnTime" column="Tender_Return_Time" />
		<result property="tenderLevel.id" column="Tender_Level_Id" />
		<result property="tenderReturn" column="Tender_Return"/>
		<result property="tenderPool" column="Tender_Pool"/>
		<association property="insuranceDemandDetail"
			select="InsuranceFeature.findFeatureByTender" column="id" />
	</resultMap>

	<select id="findParseList" resultMap="personalTender"> SELECT * FROM
		Dp_Personal_Tender WHERE delete_flag = 0 AND Mobilephone is not null
		AND LTRIM(RTRIM(Mobilephone)) &lt;> '' AND Ip_Address is not null AND
		LTRIM(RTRIM(Ip_Address)) &lt;> '127.0.0.1' AND
		LTRIM(RTRIM(Ip_Address)) &lt;> '' AND (Ip_Province is null OR
		Mobile_Province is null) AND Id > 1188734 AND Status not in
		(80,90,100,110) AND Ip_Location &lt;> '未分配或者内网IP' AND
		LEFT(LTRIM(RTRIM(Mobilephone)),1) = '1' AND
		LEN(LTRIM(RTRIM(Mobilephone))) = 11 ORDER BY Id DESC LIMIT 20
	</select>

	<select id="load" resultMap="personalTender">
		SELECT *
		FROM Dp_Personal_Tender
		WHERE id = #{id}
		AND delete_flag = '0'
	</select>

	<select id="findNewDemand" resultMap="personalTender">
		SELECT *
		FROM Dp_Personal_Tender
		WHERE delete_flag = '0'
		<if test="city != null">AND
			Applicant_City = #{city}
		</if>
		AND Insured_Sex is not Null AND Insured_Birthday is not Null AND
		Has_Social_Insurance is not Null ORDER BY Create_Time DESC LIMIT
		${size}
	</select>

	<delete id="deleteByPrimaryKey">
		DELETE FROM
		Dp_Personal_Tender
		WHERE id = #{id}
	</delete>

	<insert id="insert" parameterType="com.djb.domain.tender.PersonalTender">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
		INSERT INTO
		Dp_Personal_Tender(
		User_Type
		,User_Id
		,Insured_Relative
		,Insured_Sex
		,Insured_Birthday
		,Applicant_Province
		,Applicant_City
		,Applicant_District
		,Has_Social_Insurance
		,Age_Of_Draw_Pension
		,Total_Price
		,Requirement_Description
		,Contact_Name
		,Email
		,Mobilephone
		,Is_Open_Phone
		,Ip_Address
		,Ip_Location
		,Mobilephone_Location
		,From_Tag
		,From_Url
		,Utm_Source
		,Utm_Medium
		,Utm_Campaign
		,Admin_Flag
		,Expected_Reply_Number
		,Status
		,Remark
		,Phone_Valid_Flag
		,Dajiabao_Url
		,Verify_Time
		,Invalid_Reason
		,Delete_Flag
		,Create_User_Id
		,Create_Time
		,Update_User_Id
		,Update_Time
		,Company_White_List
		,Tender_Version
		,Require_Service
		,Tender_Use_Id ,Phone_Valid_User ,Utm_Term ,Utm_Content ,OS ,Browser ,Ip_Province
		,Ip_City ,Ip_District ,Mobile_Province ,Mobile_City ,Tips ,Guarantee
		,Expect_Product_Id ,Tender_Return_Time ,Tender_Level_Id
		,Tender_Return
		,Tender_Pool
		)
		VALUES(
		#{userType}
		,#{userId}
		,#{insuredRelativeId}
		,#{insuredSexValue}
		,#{insuredBirthday}
		,#{provinceId}
		,#{cityId}
		,#{districtId}
		,#{hasSocialInsurance}
		,#{ageOfDrawPensionId}
		,#{totalPriceId}
		,#{requirementDescription}
		,#{contactName}
		,#{email}
		,#{mobilePhone}
		,#{isOpenPhone}
		,#{ipAddress}
		,#{ipLocation}
		,#{mobilePhoneLocation}
		,#{fromTag}
		,#{fromUrl}
		,#{utmSource}
		,#{utmMedium}
		,#{utmCampaign}
		,#{adminFlag}
		,#{expectedReplyNumber}
		,#{statusValue}
		,#{remark}
		,#{phoneValidFlag}
		,#{dajiabaoUrl}
		,#{verifyTime}
		,#{invalidReason}
		,#{deleteFlag}
		,#{createUserId}
		,#{createDateTime}
		,#{updateUserId}
		,#{updateDateTime}
		,#{companyWhiteList}
		,#{tenderVersion}
		,#{requireService}
		,#{tenderUseId} ,#{phoneValidUser} ,#{utmTerm} ,#{utmContent} ,#{os} ,#{browser}
		,#{ipProvince} ,#{ipCity} ,#{ipDistrict} ,#{mobileProvince}
		,#{mobileCity} ,#{tips} ,#{guarantee} ,#{expectProductId}
		,#{tenderReturnTime} ,#{tenderLevelId}
		,#{tenderReturn}
		,#{tenderPool}
		)
	</insert>

	<update id="update" parameterType="com.djb.domain.tender.PersonalTender">
		UPDATE Dp_Personal_Tender
		SET
		User_Id=#{userId}
		,User_Type=#{userType}
		,Insured_Relative=#{insuredRelativeId}
		,Insured_Sex=#{insuredSexValue}
		,Insured_Birthday=#{insuredBirthday}
		,Applicant_Province=#{provinceId}
		,Applicant_City=#{cityId}
		,Applicant_District=#{districtId}
		,Has_Social_Insurance=#{hasSocialInsurance}
		,Age_Of_Draw_Pension=#{ageOfDrawPensionId}
		,Total_Price=#{totalPriceId}
		,Requirement_Description=#{requirementDescription}
		,Contact_Name=#{contactName}
		,Email=#{email}
		,Mobilephone=#{mobilePhone}
		,Is_Open_Phone=#{isOpenPhone}
		,Ip_Address=#{ipAddress}
		,From_Url=#{fromUrl}
		,Expected_Reply_Number=#{expectedReplyNumber}
		,Status=#{statusValue}
		,Remark=#{remark}
		,Phone_Valid_Flag=#{phoneValidFlag}
		,Dajiabao_Url=#{dajiabaoUrl}
		,Ip_Location=#{ipLocation}
		,Mobilephone_Location=#{mobilePhoneLocation}
		,From_Tag=#{fromTag}
		,Verify_Time=#{verifyTime}
		,Company_White_List=#{companyWhiteList}
		,Company_Black_List=#{companyBlackList}
		,Invalid_Reason=#{invalidReason}
		,Delete_Flag=#{deleteFlag}
		,Update_User_Id=#{updateUserId}
		,Update_Time=#{updateDateTime} ,Phone_Valid_User=#{phoneValidUser} ,Dispatch_Time=#{dispatchTime}
		,Ip_Province=#{ipProvince} ,Ip_City=#{ipCity}
		,Ip_District=#{ipDistrict} ,Mobile_Province=#{mobileProvince}
		,Mobile_City=#{mobileCity} ,Tips=#{tips} ,Guarantee=#{guarantee}
		,Expect_Product_Id=#{expectProductId}
		,Tender_Return_Time=#{tenderReturnTime}
		,Tender_Level_Id=#{tenderLevelId}
		,Tender_Return=#{tenderReturn}
		,Tender_Pool=#{tenderPool}
		WHERE id=#{id}
	</update>

	<update id="updateStatus" parameterType="com.djb.domain.tender.PersonalTender">
		UPDATE Dp_Personal_Tender
		SET
		Status=#{statusValue},
		Update_User_Id=#{updateUserId},
		Update_Time=#{updateDateTime}
		WHERE id=#{id}
	</update>

	<select id="getCountByQueryBean" parameterType="com.djb.domain.tender.TenderQueryBean"
		resultType="int">
		SELECT COUNT(*)
		FROM Dp_Personal_Tender
		WHERE Delete_Flag='0'

		<if test="status != null">
			AND Status=#{status.value}
		</if>

	</select>

	<select id="getTenderByQueryBean" parameterType="com.djb.domain.tender.TenderQueryBean"
		resultMap="personalTender">
		SELECT * FROM Dp_Personal_Tender WHERE Delete_Flag='0'
		<if test="status != null">
			AND Status=#{status.value}
		</if>
		LIMIT ${startIndex}, ${pageSize}
	</select>

	<select id="getCountService" parameterType="map" resultType="int">
		SELECT count(*) FROM Dp_Personal_Tender
		WHERE Require_Service = 1
	</select>

	<select id="findAgentDrawList" parameterType="com.djb.domain.City"
		resultMap="personalTender">
		SELECT *
		FROM (
		SELECT (SELECT COUNT(1) FROM Dp_Tender_Dispatch_Record WHERE Delete_Flag = 0
		and Tender_Id = pt.Id) as dispatchNum
		,pt.*
		FROM Dp_Personal_Tender pt
		WHERE pt.Status in (21,28,62)
		and pt.Delete_Flag = 0
		and pt.Is_Open_Phone = 1
		and pt.Applicant_Province = #{id}
		ORDER BY pt.Create_Time DESC LIMIT 30) t
		ORDER BY t.Status,t.dispatchNum,t.Create_Time
	</select>

	<select id="findListByStatus" parameterType="map" resultMap="personalTender">
		SELECT pt.*
		FROM Dp_Personal_Tender pt
		WHERE pt.Status = #{status.value}
		AND pt.Applicant_City = #{city.id}
		AND pt.Delete_Flag = 0
		<if test="tenderPool!=null">
			<if test="tenderPool==1">
				AND pt.Tender_Pool=#{tenderPool}
			</if>
			<if test="tenderPool==3">
				AND (pt.Tender_Pool=#{tenderPool} or pt.Tender_Pool is null)
			</if>
		</if>
		<if test="isOpenPhone!=null">
			AND pt.Is_Open_Phone=#{isOpenPhone}
		</if>
		AND (pt.Dispatch_Time is Null OR pt.Dispatch_Time &lt;= now())
		AND (pt.Expect_Product_Id IS NULL OR exists(
		SELECT 1 FROM Dp_Product p WHERE p.Id=pt.Expect_Product_Id
		and p.Delete_Flag = 0 and p.Company_Id=#{company.id}
		))
		<if test="isOldCustomer!=null">
			<if test="isOldCustomer">
				and( exists(
					select 1 from Dp_Personal_Tender dpt
					where (dpt.Mobilephone=t.Mobilephone or dpt.Email=t.Email)
					and dpt.id !=t.id
					AND	dpt.Delete_Flag = 0
				) or t.Tender_Return=1
			)
			</if>
			<if test="!isOldCustomer">
				and (not exists(
					select 1 from Dp_Personal_Tender dpt
					where (dpt.Mobilephone=t.Mobilephone or dpt.Email=t.Email)
					and dpt.id !=t.id
					AND	dpt.Delete_Flag = 0
				) and t.Tender_Return is null
				)
			</if>
		</if>
		ORDER BY pt.update_time ASC
	</select>

	<select id="findListByStatusList" parameterType="map" resultMap="personalTender">
		SELECT pt.*
		FROM Dp_Personal_Tender pt
		WHERE pt.Status in (28,62)
		AND pt.Applicant_City = #{city.id}
		AND pt.Delete_Flag = 0
		AND (pt.Expect_Product_Id IS NULL OR exists(
		SELECT 1 FROM Dp_Product p WHERE p.Id=pt.Expect_Product_Id
		and p.Delete_Flag = 0 and p.Company_Id=#{company.id}
		))
		<if test="isOldCustomer!=null">
			<if test="isOldCustomer">
				and (exists(
					select 1 from Dp_Personal_Tender dpt
					where (dpt.Mobilephone=pt.Mobilephone or dpt.Email=pt.Email)
					and dpt.id !=pt.id
					AND	dpt.Delete_Flag = 0
					)
					or pt.Tender_Return=1
				)
			
			</if>
			<if test="!isOldCustomer">
				and (not exists(
					select 1 from Dp_Personal_Tender dpt
					where (dpt.Mobilephone=pt.Mobilephone or dpt.Email=pt.Email)
					and dpt.id !=pt.id
					AND	dpt.Delete_Flag = 0
					)
					and pt.Tender_Return is null
				)
			</if>
		</if>
		ORDER BY pt.update_time DESC
		LIMIT 30
	</select>

	<select id="findUnWithdrawList" resultMap="personalTender">
		SELECT *
		FROM (
		SELECT t.*,(SELECT COUNT (1) FROM Dp_Tender_Dispatch_Record WHERE
		Delete_Flag = 0 and Tender_Id = t.Id) as dispatchNum
		FROM Dp_Personal_Tender t
		WHERE t.Delete_Flag = 0
		and t.Update_Time &lt; date_add(now(),interval case when
		t.Is_Open_Phone=1 then -1 else -2 end day)
		and t.Status = 21
		AND t.dispatch_Time is NULL

		UNION

		SELECT t.*,(SELECT COUNT (1) FROM Dp_Tender_Dispatch_Record WHERE
		Delete_Flag = 0 and Tender_Id = t.Id) as dispatchNum
		FROM Dp_Personal_Tender t
		WHERE t.Delete_Flag = 0
		and t.dispatch_Time &lt; date_add(now(),interval case when
		t.Is_Open_Phone=1 then -1 else -2 end day)
		and t.Status = 21
		AND t.dispatch_Time is NOT NULL

		) tmp
		WHERE tmp.Expected_Reply_Number > tmp.dispatchNum
	</select>

	<select id="findWithdrawList" parameterType="map" resultMap="personalTender"
		useCache="false">
		SELECT *
		FROM (
		SELECT *,(case when Dispatch_Time is not null then Dispatch_Time else
		Update_Time end) Entry_Time
		FROM Dp_Personal_Tender
		WHERE Delete_Flag = 0
		<if test="null != provinceId">
			AND Applicant_Province = #{provinceId}
		</if>
		<if test="null != cityId">
			AND Applicant_City = #{cityId}
		</if>
		<if test="null != tenderId">
			AND id = #{tenderId}
		</if>
		<if test="1 == type">
			AND Is_Open_Phone = 1
		</if>
		<if test="2 == type">
			AND Is_Open_Phone = 0
		</if>
		AND Status = 21) t
		WHERE 1 = 1
		<if test="null != startTime">
			AND t.Entry_Time &gt;= #{startTime}
		</if>
		<if test="null != endTime">
			AND t.Entry_Time &lt;= #{endTime}
		</if>
		ORDER BY t.Entry_Time
	</select>

	<sql id="findPersonalTenderRef">
		FROM (
			SELECT pt.Id Id,
			pt.Contact_Name Contact_Name,
			pt.Insured_Sex Insured_Sex,
			pt.Insured_Birthday Insured_Birthday,
			pt.Email Email,
			pt.Mobilephone Mobilephone,
			pt.Phone_Valid_Flag Phone_Valid_Flag,
			pt.Has_Social_Insurance Has_Social_Insurance,
			pt.Total_Price Total_Price,
			pt.Insured_Relative Insured_Relative,
			pt.From_Tag From_Tag,
			pt.Applicant_Province Applicant_Province,
			pt.Applicant_City Applicant_City,
			pt.Requirement_Description Requirement_Description,
			pt.Create_Time Create_Time,
			pt.Remark Remark,
			dr.Dispatch_Type dispatchType,
			dr.Create_Time drCreateTime,
			ad.True_Name adName,
			cy.Company_Nick_Name CyNickName,
			dr.Type drType
	
			FROM Dp_Personal_Tender pt
			LEFT JOIN Dp_Tender_Dispatch_Record dr
			on pt.Id = dr.Tender_Id
			LEFT JOIN Du_Agent_Detail ad
			on ad.Id = dr.Agent_Id
			LEFT JOIN Sm_Company cy
			on ad.Company=cy.Id
			WHERE pt.Delete_Flag = 0 and dr.Delete_Flag = 0 and ad.Delete_Flag = 0 and
			cy.Delete_Flag = 0
			<if test="null != province">
				and pt.Applicant_Province=#{province.id}
			</if>
			<if test="null != city">
				and pt.Applicant_City=#{city.id}
			</if>
			<if test="null != types">
				and dr.Type=#{types}
			</if>
			<if test="null != tenderTypeDate">
				<if test="tenderTypeDate == 1">
					<if test="null != tenderDateStart">
						and pt.Create_Time &gt;=#{tenderDateStart}
					</if>
					<if test="null != tenderDateEnd">
						and pt.Create_Time &lt;=#{tenderDateEnd}
					</if>
				</if>
				<if test="tenderTypeDate == 2">
					<if test="null != tenderDateStart">
						and dr.Create_Time &gt;=#{tenderDateStart}
					</if>
					<if test="null != tenderDateEnd">
						and dr.Create_Time &lt;=#{tenderDateEnd}
					</if>
	
				</if>
			</if>
	
			union
	
			SELECT gt.Id Id,
			gt.Contact_Name Contact_Name,
			-1 as Insured_Sex,
			null as Insured_Birthday,
			gt.Email Email,
			gt.Mobilephone Mobilephone,
			gt.Phone_Valid_Flag Phone_Valid_Flag,
			null as Has_Social_Insurance,
			gt.Total_Price Total_Price,
			null as Insured_Relative,
			gt.From_Tag From_Tag,
			gt.Province Applicant_Province,
			gt.City Applicant_City,
			gt.Requirement_Description Requirement_Description,
			gt.Create_Time Create_Time,
			gt.Remark Remark,
			dr.Dispatch_Type dispatchType,
			dr.Create_Time drCreateTime,
			ad.True_Name adName,
			cy.Company_Nick_Name CyNickName,
			dr.Type drType
	
			FROM Dp_Group_Tender gt
			LEFT JOIN Dp_Tender_Dispatch_Record dr
			on gt.Id = dr.Tender_Id
			LEFT JOIN Du_Agent_Detail ad
			on ad.Id = dr.Agent_Id
			LEFT JOIN Sm_Company cy
			on ad.Company=cy.Id
			WHERE gt.Delete_Flag = 0 and dr.Delete_Flag = 0 and ad.Delete_Flag = 0 and
			cy.Delete_Flag = 0
	
			<if test="null != province">
				and gt.Province=#{province.id}
			</if>
			<if test="null != city">
				and gt.City=#{city.id}
			</if>
			<if test="null != types">
				and dr.Type=#{types}
			</if>
			<if test="null != tenderTypeDate">
				<if test="tenderTypeDate == 1">
					<if test="null != tenderDateStart">
						and gt.Create_Time &gt;=#{tenderDateStart}
					</if>
					<if test="null != tenderDateEnd">
						and gt.Create_Time &lt;=#{tenderDateEnd}
					</if>
				</if>
				<if test="tenderTypeDate == 2">
					<if test="null != tenderDateStart">
						and dr.Create_Time &gt;=#{tenderDateStart}
					</if>
					<if test="null != tenderDateEnd">
						and dr.Create_Time &lt;=#{tenderDateEnd}
					</if>
	
				</if>
			</if>
		) p
	</sql>

	<select id="findPersonalTender" parameterType="com.djb.domain.tender.TenderQueryBean"
		resultType="java.util.Map">
		SELECT p.*
		<include refid="findPersonalTenderRef" />
		ORDER BY p.id DESC
		LIMIT ${startIndex}, ${pageSize}
	</select>

	<select id="countPersonalTender" parameterType="com.djb.domain.tender.TenderQueryBean"
		resultType="int">
		SELECT (
			SELECT count(*)
			FROM Dp_Personal_Tender pt
			LEFT JOIN Dp_Tender_Dispatch_Record dr
			on pt.Id = dr.Tender_Id
			LEFT JOIN Du_Agent_Detail ad
			on ad.Id = dr.Agent_Id
			LEFT JOIN Sm_Company cy
			on ad.Company=cy.Id
			WHERE pt.Delete_Flag = 0 and dr.Delete_Flag = 0 and ad.Delete_Flag = 0 and
			cy.Delete_Flag = 0
			<if test="null != province">
				and pt.Applicant_Province=#{province.id}
			</if>
			<if test="null != city">
				and pt.Applicant_City=#{city.id}
			</if>
			<if test="null != types">
				and dr.Type=#{types}
			</if>
			<if test="null != tenderTypeDate">
				<if test="tenderTypeDate == 1">
					<if test="null != tenderDateStart">
						and pt.Create_Time &gt;=#{tenderDateStart}
					</if>
					<if test="null != tenderDateEnd">
						and pt.Create_Time &lt;=#{tenderDateEnd}
					</if>
				</if>
				<if test="tenderTypeDate == 2">
					<if test="null != tenderDateStart">
						and dr.Create_Time &gt;=#{tenderDateStart}
					</if>
					<if test="null != tenderDateEnd">
						and dr.Create_Time &lt;=#{tenderDateEnd}
					</if>
				</if>
			</if>
			) + (
			SELECT count(*)
			FROM Dp_Group_Tender gt
			LEFT JOIN Dp_Tender_Dispatch_Record dr
			on gt.Id = dr.Tender_Id
			LEFT JOIN Du_Agent_Detail ad
			on ad.Id = dr.Agent_Id
			LEFT JOIN Sm_Company cy
			on ad.Company=cy.Id
			WHERE gt.Delete_Flag = 0 and dr.Delete_Flag = 0 and ad.Delete_Flag = 0 and
			cy.Delete_Flag = 0
	
			<if test="null != province">
				and gt.Province=#{province.id}
			</if>
			<if test="null != city">
				and gt.City=#{city.id}
			</if>
			<if test="null != types">
				and dr.Type=#{types}
			</if>
			<if test="null != tenderTypeDate">
				<if test="tenderTypeDate == 1">
					<if test="null != tenderDateStart">
						and gt.Create_Time &gt;=#{tenderDateStart}
					</if>
					<if test="null != tenderDateEnd">
						and gt.Create_Time &lt;=#{tenderDateEnd}
					</if>
				</if>
				<if test="tenderTypeDate == 2">
					<if test="null != tenderDateStart">
						and dr.Create_Time &gt;=#{tenderDateStart}
					</if>
					<if test="null != tenderDateEnd">
						and dr.Create_Time &lt;=#{tenderDateEnd}
					</if>
	
				</if>
			</if>
		)
	</select>

	<select id="exportPersonalTender" parameterType="com.djb.domain.tender.TenderQueryBean"
		resultType="java.util.Map">
		SELECT p.* from(
		SELECT pt.Id Id,
		pt.Contact_Name Contact_Name,
		pt.Insured_Sex Insured_Sex,
		pt.Insured_Birthday Insured_Birthday,
		pt.Email Email,
		pt.Mobilephone Mobilephone,
		pt.Phone_Valid_Flag Phone_Valid_Flag,
		pt.Has_Social_Insurance Has_Social_Insurance,
		pt.Total_Price Total_Price,
		pt.Insured_Relative Insured_Relative,
		pt.From_Tag From_Tag,
		pt.Applicant_Province Applicant_Province,
		pt.Applicant_City Applicant_City,
		pt.Requirement_Description Requirement_Description,
		pt.Create_Time Create_Time,
		pt.Remark Remark,
		dr.Dispatch_Type dispatchType,
		dr.Create_Time drCreateTime,
		ad.True_Name adName,
		cy.Company_Nick_Name CyNickName,
		dr.Type drType

		FROM Dp_Personal_Tender pt
		LEFT JOIN Dp_Tender_Dispatch_Record dr
		on pt.Id = dr.Tender_Id
		LEFT JOIN Du_Agent_Detail ad
		on ad.Id = dr.Agent_Id
		LEFT JOIN Sm_Company cy
		on ad.Company=cy.Id
		WHERE pt.Delete_Flag = 0 and dr.Delete_Flag = 0 and ad.Delete_Flag = 0 and
		cy.Delete_Flag = 0
		<if test="null != province">
			and pt.Applicant_Province=#{province.id}
		</if>
		<if test="null != city">
			and pt.Applicant_City=#{city.id}
		</if>
		<if test="null != types">
			and dr.Type=#{types}
		</if>
		<if test="null != tenderTypeDate">
			<if test="tenderTypeDate == 1">
				<if test="null != tenderDateStart">
					and pt.Create_Time &gt;=#{tenderDateStart}
				</if>
				<if test="null != tenderDateEnd">
					and pt.Create_Time &lt;=#{tenderDateEnd}
				</if>
			</if>
			<if test="tenderTypeDate == 2">
				<if test="null != tenderDateStart">
					and dr.Create_Time &gt;=#{tenderDateStart}
				</if>
				<if test="null != tenderDateEnd">
					and dr.Create_Time &lt;=#{tenderDateEnd}
				</if>

			</if>
		</if>

		union

		SELECT gt.Id Id,
		gt.Contact_Name Contact_Name,
		-1 as Insured_Sex,
		null as Insured_Birthday,
		gt.Email Email,
		gt.Mobilephone Mobilephone,
		gt.Phone_Valid_Flag Phone_Valid_Flag,
		null as Has_Social_Insurance,
		gt.Total_Price Total_Price,
		null as Insured_Relative,
		gt.From_Tag From_Tag,
		gt.Province Applicant_Province,
		gt.City Applicant_City,
		gt.Requirement_Description Requirement_Description,
		gt.Create_Time Create_Time,
		gt.Remark Remark,
		dr.Dispatch_Type dispatchType,
		dr.Create_Time drCreateTime,
		ad.True_Name adName,
		cy.Company_Nick_Name CyNickName,
		dr.Type drType

		FROM Dp_Group_Tender gt
		LEFT JOIN Dp_Tender_Dispatch_Record dr
		on gt.Id = dr.Tender_Id
		LEFT JOIN Du_Agent_Detail ad
		on ad.Id = dr.Agent_Id
		LEFT JOIN Sm_Company cy
		on ad.Company=cy.Id
		WHERE gt.Delete_Flag = 0 and dr.Delete_Flag = 0 and ad.Delete_Flag = 0 and
		cy.Delete_Flag = 0

		<if test="null != province">
			and gt.Province=#{province.id}
		</if>
		<if test="null != city">
			and gt.City=#{city.id}
		</if>
		<if test="null != types">
			and dr.Type=#{types}
		</if>
		<if test="null != tenderTypeDate">
			<if test="tenderTypeDate == 1">
				<if test="null != tenderDateStart">
					and gt.Create_Time &gt;=#{tenderDateStart}
				</if>
				<if test="null != tenderDateEnd">
					and gt.Create_Time &lt;=#{tenderDateEnd}
				</if>
			</if>
			<if test="tenderTypeDate == 2">
				<if test="null != tenderDateStart">
					and dr.Create_Time &gt;=#{tenderDateStart}
				</if>
				<if test="null != tenderDateEnd">
					and dr.Create_Time &lt;=#{tenderDateEnd}
				</if>

			</if>
		</if>
		)p
		ORDER BY p.id DESC
	</select>


	<select id="getEnumById" parameterType="long" resultType="string">
		SELECT Enum_value
		FROM Sm_Enum
		WHERE delete_flag = '0'
		and id=#{id}
	</select>

	<select id="findServiceCustomerCount" parameterType="com.djb.domain.tender.TenderQueryBean"
		resultType="int">
		SELECT COUNT(*)
		FROM Dp_Personal_Tender personal
		WHERE personal.delete_flag = 0
		<if test="city != null and city != ''">
			AND personal.Applicant_City = #{city.id}
		</if>
		<if test="insuranceClassifyValue!=null and insuranceClassifyValue!=''">
			and exists(
			SELECT 1 FROM Dp_Tender_Feature tf
			LEFT JOIN Dp_Insurance_Feature dif
			on tf.Insurance_Feature_Id=dif.Id
			LEFT JOIN Dp_Insurance_Classify ic
			on dif.Parent_Id=ic.Id
			WHERE tf.Delete_Flag=0
			and dif.Delete_Flag=0
			and ic.Delete_Flag=0
			and ic.Value=#{insuranceClassifyValue}
			and tf.Tender_Id=personal.Id
			)
		</if>
	</select>
	
	<select id="findTenderCountByCustomer" parameterType="com.djb.domain.tender.PersonalTender" resultType="int">
		select count(*) from Dp_Personal_Tender pt
		where (pt.Mobilephone=#{mobilePhone} or pt.Email=#{email})
		and pt.id !=#{id}
		AND	pt.Delete_Flag = 0
	</select>
</mapper>
==================================== END tender/PersonalTender.xml =========================


==================================== BEGIN tender/TenderFeature.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:04:01 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="TenderFeature">
 <resultMap id="tednerFeature" type="com.djb.domain.tender.TenderFeature" extends="DomainObject.domainObject">
  <result property="tender.id" column="Tender_Id"/>
  <result property="type" column="Tender_Type"/>
  <result property="feature.id" column="Insurance_Feature_Id"/>
 </resultMap>
 
 <select id="load" resultMap="tednerFeature">
  SELECT *
   FROM Dp_Tender_Feature
  WHERE id = #{id} 
    AND delete_flag = '0'
 </select>
 
 <select id="getAll" resultMap="tednerFeature">
  SELECT *
   FROM Dp_Tender_Feature
   WHERE delete_flag = '0'
   ORDER BY Tender_Id
 </select>
 
 <update id="update" parameterType="com.djb.domain.tender.TenderFeature">
  UPDATE Dp_Tender_Feature
      SET
         Tender_Id = #{tender.id},
         Tender_Type = #{typeValue},
         Insurance_Feature_Id = #{feature.id},
         update_time = #{updateDateTime},
         update_user_id = #{updateUserId},
         delete_flag = #{deleteFlag}
   WHERE id = #{id}
 </update>
 
 <insert id="insert" parameterType="com.djb.domain.tender.TenderFeature">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO 
   Dp_Tender_Feature(
    Tender_Id,
    Tender_Type,
    Insurance_Feature_Id,
    create_time,
    create_user_id,
    update_time,
    update_user_id,
    delete_flag
   )
  VALUES(
   #{tender.id},
   #{typeValue},
   #{feature.id},
   #{createDateTime},
   #{createUserId},
   #{updateDateTime},
   #{updateUserId},
   #{deleteFlag}
  )
  
  
 </insert>
 
 <delete id="removeByFKey">
  DELETE FROM 
   Dp_Tender_Feature
  WHERE
   Tender_Id = #{tender.id}
 </delete>
 
 <delete id="deleteByPrimaryKey">
  DELETE FROM 
   Dp_Tender_Feature
  WHERE
   id = #{id}
 </delete>
 
 <update id="logicDeleteByFKey">
  UPDATE Dp_Tender_Feature
       SET Delete_Flag='1'
   WHERE Tender_Id=#{tenderId}
 </update>
 
</mapper>
==================================== END tender/TenderFeature.xml =========================


==================================== BEGIN tender/TenderDispatchStat.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:04:00 
	CST 2013 -->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="TenderDispatchStat">

	<resultMap id="tenderDispatchStat" type="com.djb.domain.tender.TenderDispatchStat">
		<result property="agent.id" column="Agent_Id" />
		<result property="packageType" column="Package_Type" />
		<result property="contractStartTime" column="Contract_Start_Time" />
		<result property="contractEndTime" column="Contract_End_Time" />
		<result property="phoneTender" column="Phone_Tender" />
		<result property="mailTender" column="Mail_Tender" />
		<result property="feeDays" column="Fee_Days" />
		<result property="successCall" column="Webcall_Success_Count" />
		<result property="totalCall" column="Webcall_Total_Count" />
		<result property="effect" column="Effect" />
	</resultMap>

	<select id="getTenderDispatchStatCount" parameterType="com.djb.domain.tender.TenderStatQueryBean"
		resultType="int">
		SELECT count(1)
		FROM (
		SELECT stat_detail.Agent_Id
		FROM Stat_Agent_Detail stat_detail
		WHERE stat_detail.Delete_Flag = 0

		<if test="province != null">
			and stat_detail.Province = #{province.id}
		</if>
		<if test="city != null">
			and stat_detail.City = #{city.id}
		</if>
		<if test="startTime != null">
			and stat_detail.Stat_Date &gt;= #{startTime}
		</if>
		<if test="endTime != null">
			and stat_detail.Stat_Date &lt; #{endTime}
		</if>
		<if test="company != null">
			and stat_detail.Company = #{company.id}
		</if>
		<if test="username != null">
			and stat_detail.True_Name = #{username}
		</if>
		<if test="mobilePhone != null">
			and stat_detail.Mobilephone = #{mobilePhone}
		</if>

		and stat_detail.Fee_Status = 1
		GROUP BY stat_detail.Agent_Id
		) tmp
	</select>

	<select id="statistic" parameterType="com.djb.domain.tender.TenderStatQueryBean"
		resultMap="tenderDispatchStat">
		SELECT *, (case when Fee_Days = 0 then 0 else CAST(Phone_Tender AS DECIMAL(18,3))/Fee_Days end) Effect
		FROM (
			SELECT stat_detail.Agent_Id,
		 		(SELECT package.Package_Name
				FROM Stat_Agent_Detail stat,sm_Package package
				WHERE package.Delete_Flag = 0
				and package.Id = stat.Package_Type
		
				<if test="startTime != null">
					and stat.Stat_Date &gt;= #{startTime}
				</if>
				<if test="endTime != null">
					and stat.Stat_Date &lt; #{endTime}
				</if>
		
				and stat.Package_Type is not null
				and stat.Agent_Id = stat_detail.Agent_Id
				ORDER BY stat.id DESC LIMIT 1) Package_Type,
				
				(SELECT stat.Contract_Start_Time
				FROM Stat_Agent_Detail stat
				WHERE stat.Agent_Id = stat_detail.Agent_Id
				and stat.Contract_Start_Time is not null
		
				<if test="startTime != null">
					and stat.Stat_Date &gt;= #{startTime}
				</if>
				<if test="endTime != null">
					and stat.Stat_Date &lt; #{endTime}
				</if>
		
				ORDER BY stat.Id LIMIT 1) Contract_Start_Time,
				
				(SELECT stat.Contract_End_Time
				FROM Stat_Agent_Detail stat
				WHERE stat.Agent_Id = stat_detail.Agent_Id
				and stat.Contract_End_Time is not null
		
				<if test="startTime != null">
					and stat.Stat_Date &gt;= #{startTime}
				</if>
				<if test="endTime != null">
					and stat.Stat_Date &lt; #{endTime}
				</if>
		
				ORDER BY stat.Id DESC LIMIT 1) Contract_End_Time,
				COUNT(case when stat_detail.Fee_Status = 1 then stat_detail.Id end) Fee_Days,
				SUM(stat_detail.Phonetender_Get_Count) Phone_Tender,
				SUM(stat_detail.Mailtender_Get_Count) Mail_Tender,
				SUM(stat_detail.Unique_Success_Count) Webcall_Success_Count,
				SUM(stat_detail.Unique_Count) Webcall_Total_Count
			FROM Stat_Agent_Detail stat_detail
			WHERE stat_detail.Delete_Flag = 0	
			<if test="province != null">
				and stat_detail.Province = #{province.id}
			</if>
			<if test="city != null">
				and stat_detail.City = #{city.id}
			</if>
			<if test="startTime != null">
				and stat_detail.Stat_Date &gt;= #{startTime}
			</if>
			<if test="endTime != null">
				and stat_detail.Stat_Date &lt; #{endTime}
			</if>
			<if test="company != null">
				and stat_detail.Company = #{company.id}
			</if>
			<if test="username != null">
				and stat_detail.True_Name = #{username}
			</if>
			<if test="mobilePhone != null">
				and stat_detail.Mobilephone = #{mobilePhone}
			</if>
			and stat_detail.Fee_Status = 1
			GROUP BY stat_detail.Agent_Id
		) sub_query0 ORDER BY Contract_End_Time ${endTimeOrder}, Phone_Tender
		${phoneOrder}, Mail_Tender ${mailOrder}
	</select>
</mapper>
==================================== END tender/TenderDispatchStat.xml =========================


==================================== BEGIN tender/TenderLevel.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:27:19 
 CST 2013 -->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="TenderLevel">

 <resultMap id="tenderLevel" type="com.djb.domain.tender.TenderLevel"
  extends="DomainObject.domainObject">
  <result property="levelName" column="Level_Name" />
  <result property="levelDesc" column="Level_Desc" />
  <result property="consumGoldSeed" column="Consum_Gold_Seed" />
  <result property="consumSilverSeed" column="Consum_Silver_Seed" />
 </resultMap>


 <select id="load" resultMap="tenderLevel"> SELECT * FROM
  Dp_Tender_Level WHERE id = #{id} AND delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.tender.TenderLevel">
  UPDATE Dp_Tender_Level
  SET
  Level_Name=#{levelName}
  ,Level_Desc=#{levelDesc}
  ,Consum_Gold_Seed=#{consumGoldSeed}
  ,Consum_Silver_Seed=#{consumSilverSeed}
  ,Delete_Flag=#{deleteFlag}
  ,Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime}
  WHERE id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.tender.TenderLevel">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO Dp_Tender_Level(
  Level_Name
  ,Level_Desc
  ,Consum_Gold_Seed
  ,Consum_Silver_Seed
  ,Delete_Flag
  ,Create_User_Id
  ,Create_Time
  ,Update_User_Id
  ,Update_Time
  )
  VALUES(
  #{levelName}
  ,#{levelDesc}
  ,#{consumGoldSeed}
  ,#{consumSilverSeed}
  ,#{deleteFlag}
  ,#{createUserId}
  ,#{createDateTime}
  ,#{updateUserId}
  ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey">
  DELETE FROM Dp_Tender_Level
  WHERE id = #{id}

 </delete>

 <select id="findTenderLevelCount" parameterType="com.djb.domain.tender.TenderLevelQueryBean"
  resultType="int">
  SELECT count(*) 
  FROM Dp_Tender_Level
  WHERE delete_flag='0'
 </select>

 <select id="findTenderLevel" parameterType="com.djb.domain.tender.TenderLevelQueryBean"
  resultMap="tenderLevel"> SELECT *
  FROM Dp_Tender_Level tenderLevel
  WHERE tenderLevel.delete_flag='0' 
  ORDER BY tenderLevel.Create_Time DESC
  LIMIT ${startIndex}, ${pageSize}
 </select>

 <select id="findTenderLevelById" resultMap="tenderLevel">

  SELECT *
  FROM
  Dp_Tender_Level
  WHERE
  Id=#{id}
  AND delete_flag='0'
 </select>

 <select id="findTenderLevelAll" resultMap="tenderLevel">
  SELECT *
  FROM
  Dp_Tender_Level
  WHERE delete_flag='0'
 </select>
</mapper>
==================================== END tender/TenderLevel.xml =========================


==================================== BEGIN tender/TenderReturnLog.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="TenderReturnLog" >

 <resultMap id="tenderReturnLog" type="com.djb.domain.tender.TenderReturnLog" extends="DomainObject.domainObject" >
  <result property="tenderId" column="Tender_Id" />
  <result property="records" column="records" />
 </resultMap>

 <select id="load" resultMap="tenderReturnLog" >
  SELECT  *
    FROM  Dp_Tender_Return_Log
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.tender.TenderReturnLog" >
  UPDATE  Dp_Tender_Return_Log
     SET  
   Tender_Id=#{tenderId}
   ,records=#{records}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   WHERE  id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.tender.TenderReturnLog" >
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Dp_Tender_Return_Log(
   Tender_Id
   ,records
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{tenderId}
   ,#{records}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey" >
  DELETE FROM  Dp_Tender_Return_Log
        WHERE  id = #{id}
 </delete>
 
 <select id="findTenderReturnLogByTenderId" parameterType="long" resultMap="tenderReturnLog">
  SELECT  *
    FROM  Dp_Tender_Return_Log
   WHERE  Tender_Id = #{tenderId}
     AND  delete_flag='0'
   ORDER BY Create_Time DESC
 </select>
</mapper>
==================================== END tender/TenderReturnLog.xml =========================


==================================== BEGIN tender/GroupTender.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:03:58 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="GroupTender">
 
 <resultMap id="groupTender" type="com.djb.domain.tender.GroupTender" extends="DomainObject.domainObject">
  <result property="userId" column="User_Id"/>
  <result property="userType" column="User_Type"/>
  <result property="province.id" column="Province"/>
  <result property="city.id" column="City"/>
  <result property="district.id" column="District"/>
  <result property="totalPrice.id" column="Total_Price"/>
  <result property="requirementDescription" column="Requirement_Description"/>
  <result property="contactName" column="Contact_Name"/>
  <result property="email" column="Email"/>
  <result property="mobilePhone" column="Mobilephone"/>
  <result property="isOpenPhone" column="Is_Open_Phone"/>
  <result property="ipAddress" column="Ip_Address"/>
  <result property="fromUrl" column="From_Url"/>
  <result property="expectedReplyNumber" column="Expected_Reply_Number"/>
  <result property="status" column="Status"/>
  <result property="remark" column="Remark"/>
  <result property="ipLocation" column="Ip_Location"/>
  <result property="mobilePhoneLocation" column="Mobilephone_Location"/>
  <result property="fromTag" column="From_Tag"/>
  <result property="insuredPeopleNumber" column="Insured_People_Number"/>
  <result property="companyName" column="Company_Name"/>
  <result property="companyType.id" column="Company_Type"/>
  <result property="industryType.id" column="Industry_Type"/>
  <result property="landlinePhone" column="Landline_Phone"/>
  <result property="phoneValidFlag" column="Phone_Valid_Flag"/>
  <result property="dajiabaoUrl" column="Dajiabao_Url"/>
  <result property="verifyTime" column="Verify_Time"/>
  <result property="invalidReason" column="Invalid_Reason"/>
  <result property="companyWhiteList" column="Company_White_List"/>
  <result property="companyBlackList" column="Company_Black_List"/>
  <result property="utmTerm" column="Utm_Term"/>
  <result property="utmContent" column="Utm_Content"/>
  <result property="os" column="OS"/>
  <result property="browser" column="Browser"/>
  <result property="ipProvince" column="Ip_Province"/>
  <result property="ipCity" column="Ip_City"/>
  <result property="ipDistrict" column="Ip_District"/>
  <result property="mobileProvince" column="Mobile_Province"/>
  <result property="mobileCity" column="Mobile_City"/>
  <result property="tips" column="Tips"/>
  <association property="insuranceDemandDetail" select="InsuranceFeature.findFeatureByTender" column="id"/>
 </resultMap>
 
 <select id="findParseList" resultMap="groupTender">
  SELECT *
    FROM  Dp_Group_Tender
   WHERE delete_flag = 0
     AND Mobilephone is not null
     AND LTRIM(RTRIM(Mobilephone)) &lt;> ''
     AND Ip_Address is not null
     AND LTRIM(RTRIM(Ip_Address)) &lt;> '127.0.0.1'
     AND LTRIM(RTRIM(Ip_Address)) &lt;> ''
     AND (Ip_Province is null
      OR Mobile_Province is null)
     AND  Id > 1188785
     AND Status not in (80,90,100,110)
     AND Ip_Location &lt;> '未分配或者内网IP'
     AND LEFT(LTRIM(RTRIM(Mobilephone)),1) = '1'
     AND LEN(LTRIM(RTRIM(Mobilephone))) = 11 
   ORDER BY Id DESC
   LIMIT 20
 </select>
 
 <select id="load" resultMap="groupTender">
  SELECT *
   FROM Dp_Group_Tender
  WHERE id = #{id} 
    AND delete_flag = '0'
 </select>
 
 <delete id="deleteByPrimaryKey">
  DELETE FROM
   Dp_Group_Tender
  WHERE
   id = #{id}
 </delete>
 
 <insert id="insert" parameterType="com.djb.domain.tender.GroupTender">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO 
   Dp_Group_Tender(
   User_Type
    ,User_Id
          ,Province
          ,City
          ,District
          ,Insured_People_Number
          ,Company_Name
          ,Company_Type
          ,Industry_Type
          ,Total_Price
          ,Requirement_Description
          ,Contact_Name
          ,Email
          ,Mobilephone
          ,Landline_Phone
          ,Is_Open_Phone
          ,Ip_Address
          ,Ip_Location
          ,Mobilephone_Location
          ,From_Tag
          ,From_Url
          ,Utm_Source
    ,Utm_Medium
    ,Utm_Campaign
    ,Admin_Flag
          ,Expected_Reply_Number
          ,Remark
    ,Phone_Valid_Flag
    ,Dajiabao_Url
          ,Status
          ,Verify_Time  
    ,Invalid_Reason 
          ,Delete_Flag
          ,Create_User_Id
          ,Create_Time
          ,Update_User_Id
          ,Update_Time
          ,Utm_Term
    ,Utm_Content
    ,OS
    ,Browser
    ,Ip_Province
    ,Ip_City
    ,Ip_District
    ,Mobile_Province
    ,Mobile_City
    ,Tips
   )
  VALUES(
    #{userType}
    ,#{userId}
    ,#{provinceId}
    ,#{cityId}
    ,#{districtId}
    ,#{insuredPeopleNumber}
    ,#{companyName}
    ,#{companyType.id}
    ,#{industryType.id}
    ,#{totalPriceId}
    ,#{requirementDescription}
    ,#{contactName}
    ,#{email}
    ,#{mobilePhone}
    ,#{landlinePhone}
    ,#{isOpenPhone}
    ,#{ipAddress}
    ,#{ipLocation}
    ,#{mobilePhoneLocation}
    ,#{fromTag}
    ,#{fromUrl}
    ,#{utmSource}
    ,#{utmMedium}
    ,#{utmCampaign}
    ,#{adminFlag}
    ,#{expectedReplyNumber}
    ,#{remark}
    ,#{phoneValidFlag}
    ,#{dajiabaoUrl}
    ,#{statusValue}
    ,#{verifyTime}
    ,#{invalidReason}
    ,#{deleteFlag}
    ,#{createUserId}
    ,#{createDateTime}
    ,#{updateUserId}
    ,#{updateDateTime}
    ,#{utmTerm}
    ,#{utmContent}
    ,#{os}
    ,#{browser}
    ,#{ipProvince}
    ,#{ipCity}
    ,#{ipDistrict}
    ,#{mobileProvince}
    ,#{mobileCity}
    ,#{tips}
  )
  </insert>
  
  <update id="update" parameterType="com.djb.domain.tender.GroupTender">
  UPDATE Dp_Group_Tender
      SET 
      User_Id=#{userId},
               User_Type=#{userType},
               Province=#{provinceId},
               City=#{cityId},
               District=#{districtId},
               Total_Price=#{totalPriceId},
               Requirement_Description=#{requirementDescription},
               Contact_Name=#{contactName},
               Email=#{email},
               Mobilephone=#{mobilePhone},
               Is_Open_Phone=#{isOpenPhone},
               Ip_Address=#{ipAddress},
               From_Url=#{fromUrl},
               Expected_Reply_Number=#{expectedReplyNumber},
               Status=#{statusValue},
               Remark=#{remark},
               Phone_Valid_Flag=#{phoneValidFlag},
      Dajiabao_Url=#{dajiabaoUrl},
               Ip_Location=#{ipLocation},
               Mobilephone_Location=#{mobilePhoneLocation},
               From_Tag=#{fromTag},
               Verify_Time=#{verifyTime},       
      Company_White_List=#{companyWhiteList},       
      Company_Black_List=#{companyBlackList},
      Invalid_Reason=#{invalidReason}, 
               Delete_Flag=#{deleteFlag},
               Create_User_Id=#{createUserId},
               Create_Time=#{createDateTime},
               Update_User_Id=#{updateUserId},
               Update_Time=#{updateDateTime},
               Insured_People_Number=#{insuredPeopleNumber},
      Company_Name=#{companyName},
      Company_Type=#{companyType.id},
      Industry_Type=#{industryType.id},
      Landline_Phone=#{landlinePhone},
      Ip_Province=#{ipProvince}
      ,Ip_City=#{ipCity}
      ,Ip_District=#{ipDistrict}
      ,Mobile_Province=#{mobileProvince}
      ,Mobile_City=#{mobileCity}
      ,Tips=#{tips}
   WHERE  id=#{id}
  </update>
  
  <update id="updateStatus" parameterType="com.djb.domain.tender.GroupTender">
   UPDATE Dp_Group_Tender
       SET 
      Status=#{statusValue},
      Update_User_Id=#{updateUserId},
               Update_Time=#{updateDateTime}
   WHERE  id=#{id}
  </update>
  
  <select id="findServiceCustomerCount"  parameterType="com.djb.domain.tender.TenderQueryBean" resultType="int">
 SELECT count(1)
  FROM Dp_Group_Tender 
  WHERE (1 = 1)
  
   AND delete_flag = 0
    <if test="city != null and city != ''">
    AND  City= #{city.id}
  </if>
  </select>
</mapper>
==================================== END tender/GroupTender.xml =========================


==================================== BEGIN tender/TenderStat.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:04:02 
	CST 2013 -->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="TenderStat">

	<resultMap id="tenderStat" type="com.djb.domain.tender.TenderStat">
		<result property="day" column="date" />
		<result property="province.id" column="provinceId" />
		<result property="provinceName" column="provinceName" />
		<result property="type" column="type" />
		<result property="total" column="total" />
		<result property="validPhone" column="validPhone" />
		<result property="phoneTender" column="phoneTender" />
		<result property="mailTender" column="mailTender" />
		<result property="notNeeded" column="notNeeded" />
		<result property="notSatisfied" column="notSatisfied" />
		<result property="notUserSelf" column="notUserSelf" />
		<result property="notConnect" column="notConnect" />
		<result property="others" column="others" />
		<result property="approving" column="approving" />
		<result property="delay" column="delay" />
		<result property="tenderHasPhone" column="tenderHasPhone" />
	</resultMap>

	<select id="statistic" parameterType="java.util.HashMap"
		resultMap="tenderStat">
		SELECT *
		FROM (

		<if test="tenderType == 1">
			SELECT date_format(personalTender.Create_Time,'%Y-%m-%d') `date`,
			City.Id `provinceId`,
			City.City_Name `provinceName`,
			'个人标' `type`,
			COUNT(DISTINCT personalTender.User_Id) `total`,
			COUNT(DISTINCT (CASE WHEN personalTender.Mobilephone is not null AND
			personalTender.Mobilephone != '' THEN personalTender.User_Id END))
			`tenderHasPhone`,
			COUNT(DISTINCT (CASE WHEN personalTender.Phone_Valid_Flag = 1 OR
			(personalTender.Phone_Valid_Flag = 0 AND
			personalTender.Invalid_Reason in (5,6)) THEN personalTender.User_Id
			END)) `validPhone`,
			COUNT(DISTINCT (CASE WHEN personalTender.Phone_Valid_Flag = 1 AND
			personalTender.Is_Open_Phone = 1 AND personalTender.Status NOT IN
			(10,15,90) THEN personalTender.User_Id END)) `phoneTender`,
			COUNT(DISTINCT (CASE WHEN personalTender.Phone_Valid_Flag = 1 AND
			personalTender.Is_Open_Phone = 0 AND personalTender.Status NOT IN
			(10,15,90) THEN personalTender.User_Id END)) `mailTender`,
			COUNT(DISTINCT (CASE WHEN personalTender.Invalid_Reason = 5 AND
			personalTender.Phone_Valid_Flag = 0 THEN personalTender.User_Id END))
			`notNeeded`,
			COUNT(DISTINCT (CASE WHEN personalTender.Invalid_Reason = 6 AND
			personalTender.Phone_Valid_Flag = 0 THEN personalTender.User_Id END))
			`notSatisfied`,
			COUNT(DISTINCT (CASE WHEN personalTender.Invalid_Reason = 4 AND
			personalTender.Phone_Valid_Flag = 0 THEN personalTender.User_Id END))
			`notUserSelf`,
			COUNT(DISTINCT (CASE WHEN personalTender.Invalid_Reason IN (1,2,3,7) AND
			personalTender.Phone_Valid_Flag = 0 THEN personalTender.User_Id END))
			`notConnect`,
			COUNT(DISTINCT (CASE WHEN personalTender.Invalid_Reason IN (8,9,10,11) AND
			personalTender.Phone_Valid_Flag = 0 THEN personalTender.User_Id END))
			`others`,
			COUNT(DISTINCT (CASE WHEN personalTender.Phone_Valid_Flag = 1 AND
			personalTender.Status = 90 THEN personalTender.User_Id END))
			`cancellation`, COUNT(DISTINCT (CASE WHEN personalTender.Status =
			'10' THEN personalTender.User_Id END)) `approving`,
			COUNT(DISTINCT (CASE WHEN personalTender.Status = '15' THEN personalTender.User_Id
			END)) `delay`
			FROM Dp_Personal_Tender personalTender,
			Sm_City City
			WHERE personalTender.Admin_Flag = '0' AND personalTender.User_Type=1 AND
			personalTender.Delete_Flag=0 AND (personalTender.From_Url &lt;&gt;
			'dajiabao' OR personalTender.From_Url IS NULL) AND
			(personalTender.Invalid_Reason NOT IN (9,11) OR
			personalTender.Invalid_Reason is NULL) AND personalTender.Mobilephone
			&lt;&gt; ''
			AND personalTender.Applicant_Province = City.Id
			AND personalTender.Applicant_Province IN ('1','2','4','15')
			<if test="startTime != null">
				AND personalTender.Create_Time &gt;= #{startTime}
			</if>
			<if test="endTime != null">
				AND personalTender.Create_Time &lt; #{endTime}
			</if>
			<if test="province != null">
				AND personalTender.Applicant_Province = #{province.id}
			</if>
			GROUP BY `date`,City.City_Name,City.Id
		</if>
		<if test="tenderType == 2">
			SELECT date_format(groupTender.Create_Time,'%Y-%m-%d') `date`,
			City.Id `provinceId`,
			City.City_Name `provinceName`,
			'团体标' `type`,
			COUNT(DISTINCT groupTender.User_Id) `total`,
			COUNT(DISTINCT (CASE WHEN groupTender.Mobilephone is not null AND
			groupTender.Mobilephone != '' THEN groupTender.User_Id END))
			`tenderHasPhone`,
			COUNT(DISTINCT (CASE WHEN groupTender.Phone_Valid_Flag = 1 OR
			(groupTender.Phone_Valid_Flag = 0 AND groupTender.Invalid_Reason in
			(5,6)) THEN groupTender.User_Id END)) `validPhone`,
			COUNT(DISTINCT (CASE WHEN groupTender.Phone_Valid_Flag = 1 AND
			groupTender.Is_Open_Phone = 1 AND groupTender.Status NOT IN
			(10,15,90) THEN groupTender.User_Id END)) `phoneTender`,
			COUNT(DISTINCT (CASE WHEN groupTender.Phone_Valid_Flag = 1 AND
			groupTender.Is_Open_Phone = 0 AND groupTender.Status NOT IN
			(10,15,90) THEN groupTender.User_Id END)) `mailTender`,
			COUNT(DISTINCT (CASE WHEN groupTender.Invalid_Reason = 5 AND
			groupTender.Phone_Valid_Flag = 0 THEN groupTender.User_Id END))
			`notNeeded`,
			COUNT(DISTINCT (CASE WHEN groupTender.Invalid_Reason = 6 AND
			groupTender.Phone_Valid_Flag = 0 THEN groupTender.User_Id END))
			`notSatisfied`,
			COUNT(DISTINCT (CASE WHEN groupTender.Invalid_Reason = 4 AND
			groupTender.Phone_Valid_Flag = 0 THEN groupTender.User_Id END))
			`notUserSelf`,
			COUNT(DISTINCT (CASE WHEN groupTender.Invalid_Reason IN (1,2,3,7) AND
			groupTender.Phone_Valid_Flag = 0 THEN groupTender.User_Id END))
			`notConnect`,
			COUNT(DISTINCT (CASE WHEN groupTender.Invalid_Reason IN (8,9,10,11) AND
			groupTender.Phone_Valid_Flag = 0 THEN groupTender.User_Id END))
			`others`,
			COUNT(DISTINCT (CASE WHEN groupTender.Phone_Valid_Flag = 1 AND groupTender.Status =
			90 THEN groupTender.User_Id END)) `cancellation`, COUNT(DISTINCT
			(CASE WHEN groupTender.Status = '10' THEN groupTender.User_Id END))
			`approving`,
			COUNT(DISTINCT (CASE WHEN groupTender.Status = '15' THEN groupTender.User_Id END))
			`delay`
			FROM Dp_Group_Tender groupTender,
			Sm_City City
			WHERE groupTender.Admin_Flag = '0' AND groupTender.User_Type=1 AND
			groupTender.Delete_Flag=0 AND (groupTender.From_Url &lt;&gt;
			'dajiabao' OR groupTender.From_Url IS NULL) AND
			(groupTender.Invalid_Reason NOT IN (9,11) OR
			groupTender.Invalid_Reason is NULL) AND groupTender.Mobilephone
			&lt;&gt; ''
			AND groupTender.Province = City.Id
			AND groupTender.Province IN ('1','2','4','15')
			<if test="startTime != null">
				AND groupTender.Create_Time &gt;= #{startTime}
			</if>
			<if test="endTime != null">
				AND groupTender.Create_Time &lt; #{endTime}
			</if>
			<if test="province != null">
				AND groupTender.Province = #{province.id}
			</if>
			GROUP BY `date`,City.City_Name,City.Id
		</if>

		) rs
		ORDER BY `provinceId` ASC,`date` DESC
	</select>
</mapper>
==================================== END tender/TenderStat.xml =========================


==================================== BEGIN tender/TenderBalanceChangeLog.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="TenderBalanceChangeLog">
 <resultMap id="tenderBalanceChangeLog" type="com.djb.domain.tender.TenderBalanceChangeLog"
  extends="DomainObject.domainObject">
  <result property="agent.id" column="Agent_Id" />
  <result property="tenderType" column="Tender_Type" />
  <result property="source" column="Source" />
  <result property="tenderId" column="Tender_Id" />
  <result property="changeValue" column="Change_Value" />
  <result property="balance" column="Balance" />
 </resultMap>

 <select id="load" resultMap="tenderBalanceChangeLog">
  SELECT *
  FROM App_Tender_Balance_Change_Log
  WHERE id = #{id}
  AND delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.tender.TenderBalanceChangeLog">
  UPDATE App_Tender_Balance_Change_Log
  SET
  Agent_Id=#{agent.id}
  ,Tender_Type=#{tenderType}
  ,Source=#{source}
  ,Tender_Id=#{tenderId}
  ,Change_Value=#{changeValue}
  ,Balance=#{balance}
  ,Delete_Flag=#{deleteFlag}
  ,Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime}
  WHERE id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.tender.TenderBalanceChangeLog">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO App_Tender_Balance_Change_Log(
  Agent_Id
  ,Tender_Type
  ,Source
  ,Tender_Id
  ,Change_Value
  ,Balance
  ,Delete_Flag
  ,Create_User_Id
  ,Create_Time
  ,Update_User_Id
  ,Update_Time
  )
  VALUES(
  #{agent.id}
  ,#{tenderType}
  ,#{source}
  ,#{tenderId}
  ,#{changeValue}
  ,#{balance}
  ,#{deleteFlag}
  ,#{createUserId}
  ,#{createDateTime}
  ,#{updateUserId}
  ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey">
  DELETE FROM
  App_Tender_Balance_Change_Log
  WHERE id = #{id}
 </delete>

 <delete id="deleteTenderBalance" parameterType="com.djb.domain.tender.TenderBalanceChangeLog">
  DELETE FROM App_Tender_Balance_Change_Log
  WHERE Agent_Id = #{agent.id}
  AND Tender_Id=#{tenderId}
 </delete>

 <sql id="getChangeLogListRef">
  FROM App_Tender_Balance_Change_Log
  WHERE Delete_Flag = 0
  <if test="startDate != null">
   AND Create_Time &gt;= #{startDate}
  </if>
  <if test="endDate != null">
   AND Create_Time &lt; #{endDate}
  </if>
  <if test="tenderType != null">
   AND Tender_Type = #{tenderType}
  </if>
  <if test="source != null">
   AND Source = #{source}
  </if>
  AND Agent_Id = #{agent.id}

 </sql>


 <select id="getChangeLogCount" resultType="int"
  parameterType="com.djb.domain.tender.TenderBalanceChangeLogQueryBean">
  SELECT COUNT(1)
  <include refid="getChangeLogListRef" />
 </select>

 <select id="getChangeLogList" resultMap="tenderBalanceChangeLog"
  parameterType="com.djb.domain.tender.TenderBalanceChangeLogQueryBean">
  SELECT *
  <include refid="getChangeLogListRef" />
  ORDER BY Id DESC
  LIMIT ${startIndex}, ${pageSize}
 </select>
</mapper>
==================================== END tender/TenderBalanceChangeLog.xml =========================


==================================== BEGIN feedback/Feedback.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:21:43 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="Feedback">

 <resultMap id="feedback" type="com.djb.domain.feedback.Feedback" extends="DomainObject.domainObject">
  <result property="status" column="Status"/>
  <result property="content" column="Content"/>
  <result property="mobilephone" column="Mobilephone"/>
  <result property="email" column="Email"/>
  <result property="ipAddress" column="Ip_Address"/>
  <result property="feedbackFromUrl" column="Feedback_From_Url"/>
 </resultMap>

 <select id="load" resultMap="feedback">
  SELECT  *
    FROM  Sm_Feedback
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.feedback.Feedback">
  UPDATE  Sm_Feedback
     SET  
   Status=#{status}
   ,Content=#{content}
   ,Mobilephone=#{mobilephone}
   ,Email=#{email}
   ,Ip_Address=#{ipAddress}
   ,Feedback_From_Url=#{feedbackFromUrl}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
  WHERE Id = #{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.feedback.Feedback">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Sm_Feedback(
   Status
   ,Content
   ,Mobilephone
   ,Email
   ,Ip_Address
   ,Feedback_From_Url
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{status}
   ,#{content}
   ,#{mobilephone}
   ,#{email}
   ,#{ipAddress}
   ,#{feedbackFromUrl}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
  
  
 </insert>

 <delete id="deleteByPrimaryKey">
  DELETE FROM  Sm_Feedback
        WHERE  id = #{id}
 </delete>
 
 <sql id="findFeedbackByQueryBeanRef">
 	FROM Sm_Feedback
     WHERE Delete_flag=0 
      <if test="content != null and content != ''">AND
          Content like '%${content}%'
      </if>
      <if test="mobilePhone != null and mobilePhone != ''">AND
         Mobilephone = #{mobilePhone}
      </if>
      <if test="ipAddress != null and ipAddress != ''">AND
         Ip_Address = #{ipAddress}
      </if>
      <if test="email != null and email != ''">AND
         Email = #{email}
      </if>
 </sql>
 
 <select id="findFeedbackCountByQueryBean" parameterType="com.djb.domain.feedback.FeedbackQueryBean" resultType="int">
  SELECT COUNT(*) <include refid="findFeedbackByQueryBeanRef"/>
 </select>
 
 <select id="findFeedbackByQueryBean" parameterType="com.djb.domain.feedback.FeedbackQueryBean" resultMap="feedback">
    SELECT * <include refid="findFeedbackByQueryBeanRef"/>
    ORDER BY create_time DESC
    LIMIT ${startIndex}, ${pageSize}
 </select>
</mapper>
==================================== END feedback/Feedback.xml =========================


==================================== BEGIN feedback/OperationFeedback.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:21:44 
	CST 2013 -->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="OperationFeedback">

	<resultMap id="operationFeedback" type="com.djb.domain.feedback.OperationFeedback"
		extends="DomainObject.domainObject">
		<result property="fromChannel" column="From_Channel" />
		<result property="feedbackType" column="Feedback_Type" />
		<result property="classify" column="Classify" />
		<result property="subClassify" column="Sub_Classify" />
		<result property="status" column="Status" />
		<result property="statusRemark" column="Status_Remark" />
		<result property="customerId" column="Customer_Id" />
		<result property="customerName" column="Customer_Name" />
		<result property="mobilephone" column="Mobilephone" />
		<result property="provinceId" column="Province_Id" />
		<result property="cityId" column="City_Id" />
		<result property="companyId" column="Company_Id" />
		<result property="coompanyName" column="Coompany_Name" />
		<result property="description" column="Description" />
	</resultMap>

	<select id="load" parameterType="java.lang.Long" resultMap="operationFeedback">
		SELECT *
		FROM Sm_Operation_Feedback
		WHERE id = #{id}
		AND delete_flag='0'
	</select>

	<update id="update" parameterType="com.djb.domain.feedback.OperationFeedback">
		UPDATE Sm_Operation_Feedback
		SET
		From_Channel=#{fromChannel}
		,Feedback_Type=#{feedbackType}
		,Classify=#{classify}
		,Sub_Classify=#{subClassify}
		,Status=#{status}
		,Status_Remark=#{statusRemark}
		,Customer_Id=#{customerId}
		,Customer_Name=#{customerName}
		,Mobilephone=#{mobilephone}
		,Province_Id=#{provinceId}
		,City_Id=#{cityId}
		,Company_Id=#{companyId}
		,Coompany_Name=#{coompanyName}
		,Description=#{description}
		,Delete_Flag=#{deleteFlag}
		,Update_User_Id=#{updateUserId}
		,Update_Time=#{updateDateTime}
		WHERE id=#{id}
	</update>

	<insert id="insert" parameterType="com.djb.domain.feedback.OperationFeedback">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
		INSERT INTO Sm_Operation_Feedback(
		From_Channel
		,Feedback_Type
		,Classify
		,Sub_Classify
		,Status
		,Status_Remark
		,Customer_Id
		,Customer_Name
		,Mobilephone
		,Province_Id
		,City_Id
		,Company_Id
		,Coompany_Name
		,Description
		,Delete_Flag
		,Create_User_Id
		,Create_Time
		,Update_User_Id
		,Update_Time
		)
		VALUES(
		#{fromChannel}
		,#{feedbackType}
		,#{classify}
		,#{subClassify}
		,#{status}
		,#{statusRemark}
		,#{customerId}
		,#{customerName}
		,#{mobilephone}
		,#{provinceId}
		,#{cityId}
		,#{companyId}
		,#{coompanyName}
		,#{description}
		,#{deleteFlag}
		,#{createUserId}
		,#{createDateTime}
		,#{updateUserId}
		,#{updateDateTime}
		)


	</insert>

	<delete id="deleteByPrimaryKey">
		DELETE FROM Sm_Operation_Feedback
		WHERE id = #{id}
	</delete>

	<sql id="findOperationFeedbackByQueryBeanRef">
		FROM Sm_Operation_Feedback
		WHERE delete_flag = 0

		<if test="feedbackType != null and feedbackType != ''">AND
			Feedback_Type = #{feedbackType}
		</if>
		<if test="classify != null and classify != ''">AND
			Classify like '%${classify}%'
		</if>
		<if test="subClassify != null and subClassify != ''">AND
			Sub_Classify like '%${subClassify}%'
		</if>
		<if test="status != null and status != ''">AND
			Status = #{status}
		</if>
		<if test="statusRemark != null and statusRemark != ''">AND
			Status_Remark like '%${statusRemark}%'
		</if>
		<if test="startTime != null and startTime != ''">AND
			Create_Time &gt;= #{startTime}
		</if>
		<if test="endTime != null and endTime != ''">AND
			Create_Time &lt;= #{endTime}
		</if>
	</sql>

	<select id="findOperationFeedbackCountByQueryBean"
		parameterType="com.djb.domain.feedback.OperationFeedbackQueryBean"
		resultType="int">
		SELECT COUNT(*)
		<include refid="findOperationFeedbackByQueryBeanRef" />
	</select>

	<select id="findOperationFeedbackByQueryBean" parameterType="com.djb.domain.feedback.OperationFeedbackQueryBean"
		resultMap="operationFeedback">
		SELECT *
		<include refid="findOperationFeedbackByQueryBeanRef" />
		ORDER BY create_time DESC
		LIMIT ${startIndex}, ${pageSize}
	</select>
</mapper>
==================================== END feedback/OperationFeedback.xml =========================


==================================== BEGIN Code.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:27:18 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="Code">

 <cache type="com.djb.cache.MemcachedCache">
  <property name="timeout" value="7200"/>
 </cache>
 
 <resultMap id="code" type="com.djb.domain.Code" extends="DomainObject.domainObject">
  <result property="enumType" column="Enum_Type"/>
  <result property="enumName" column="Enum_Name"/>
  <result property="enumValue" column="Enum_Value"/>
  <result property="maxValue" column="Max_Value"/>
  <result property="minValue" column="Min_Value"/>
  <result property="parentCode.id" column="Parent_Id"/>
  <result property="order" column="Order_Num"/>
  <result property="remark" column="Remark"/>
 </resultMap>
 
 
 <select id="load" resultMap="code">
  SELECT  *
   FROM Sm_Enum
   WHERE id = #{id} 
    AND delete_flag = '0'
 </select>
 
 <select id="findByName" resultMap="code">
  SELECT  *
   FROM Sm_Enum
   WHERE Enum_Name = #{enumName} 
    AND delete_flag = '0'
 ORDER BY Order_Num
 </select>
 
 <select id="findByName2" resultMap="code">
  SELECT  *
   FROM Sm_Enum
   WHERE (Enum_Name = #{enumName} or Enum_Name='Insured_Group_All')
    AND Enum_Value != '其他'
       AND delete_flag = '0'      
  ORDER BY Order_Num
 </select>
 
 <select id="getAll" resultMap="code">
  SELECT *
  FROM
    Sm_Enum
  WHERE
    delete_flag='0'
 </select>
 
 <insert id="insert" parameterType="com.djb.domain.Code">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO 
   Sm_Enum(
    Id       
    ,Enum_Type       
    ,Enum_Name    
    ,Enum_Value
    ,Min_Value
    ,Max_Value
    ,Parent_Id
    ,Order_Num
    ,Remark
    ,Delete_Flag       
    ,Create_User_Id       
    ,Create_Time       
    ,Update_User_Id       
    ,Update_Time
  )VALUES(
    #{id}
    ,#{enumType}
    ,#{enumName}
    ,#{enumValue}
    ,#{minValue}
    ,#{maxValue}
    ,#{parentCode.id}
    ,#{order}
    ,#{remark}
    ,#{deleteFlag}
    ,#{createUserId}
    ,#{createDateTime}
    ,#{updateUserId}
    ,#{updateDateTime}
  )
 </insert>
 
 <update id="update" parameterType="com.djb.domain.Code">
  UPDATE
   Sm_Enum
  SET
   Id=#{id}
   ,Enum_Type=#{enumType}       
   ,Enum_Name=#{enumName}
   ,Enum_Value=#{enumValue}
   ,Min_Value=#{minValue}
   ,Max_Value=#{maxValue}
   ,Parent_Id=#{parentCode.id}
   ,Order_Num=#{order}       
   ,Remark=#{remark}              
   ,Delete_Flag=#{deleteFlag}
   ,Create_User_Id=#{createUserId}
   ,Create_Time=#{createDateTime}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
 </update>
 
 <delete id="deleteByPrimaryKey">
  DELETE FROM
   Sm_Enum
  WHERE
   id = #{id}
 </delete>

</mapper>
==================================== END Code.xml =========================


==================================== BEGIN City.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:27:17 
 CST 2013 -->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="City">

 <cache type="com.djb.cache.MemcachedCache">
  <property name="timeout" value="72000" />
 </cache>

 <resultMap id="city" type="com.djb.domain.City" extends="DomainObject.domainObject">
  <result property="cityName" column="City_Name" />
  <result property="cityLevel" column="City_Level" javaType="com.djb.enums.CityLevel"
   jdbcType="INTEGER" />
  <result property="namePinyin" column="Name_Pinyin" />
  <result property="parentCity.id" column="Parent_City_Id" />
 </resultMap>

 <select id="load" resultMap="city">
  SELECT *
  FROM Sm_City
  WHERE id = #{id}
  AND delete_flag = '0'
 </select>

 <select id="findByName" resultMap="city">
  SELECT *
  FROM Sm_City
  WHERE City_Name = #{cityName}
  AND delete_flag = '0'
 </select>

 <select id="findByNameAndParent" parameterType="map" resultMap="city">
  SELECT *
  FROM Sm_City
  WHERE City_Name = #{name}
  AND delete_flag = '0'
  AND Parent_City_Id = #{parentId}
 </select>

 <select id="getAll" resultMap="city">
  SELECT *
  FROM Sm_City
  WHERE delete_flag='0'
  ORDER BY Order_Id
 </select>

 <select id="findValidProvince" parameterType="map" resultMap="city"
  useCache="false">
  SELECT city.*
                FROM Sm_City city, 
                (SELECT DISTINCT agentUser.Province_Id FROM Du_Agent_Detail agentUser 
                WHERE id IN(SELECT DISTINCT User_Id FROM Dp_Program program WHERE program.Delete_Flag = '0')
   AND agentUser.Verify_Status = #{verifyStatus}
   AND agentUser.Rmd_Status = '0'
   AND agentUser.Delete_Flag = '0'
   AND agentUser.Fee_Status = 1) u
  WHERE city.City_Level = 1
  AND city.id = u.Province_Id
  ORDER BY city.Order_ID;
 </select>

 <select id="findValidCityByProvince" parameterType="map"
  resultMap="city" useCache="false">
  SELECT city.*
  FROM Sm_City city
  WHERE city.City_Level=#{cityLevel}
  AND city.Parent_City_Id=#{province}
  AND EXISTS(
  SELECT 1
  FROM Du_Agent_Detail agentUser
  INNER JOIN Dp_Program program ON program.User_Id = agentUser.Id
  WHERE city.id = agentUser.City_Id
  AND agentUser.Verify_Status =#{verifyStatus}
  AND agentUser.Rmd_Status = '0'
  AND agentUser.Delete_Flag = '0'
  AND agentUser.Fee_Status = 1
  AND program.Delete_Flag = '0'
  )
  ORDER BY city.Order_ID
 </select>

 <select id="findValidProvinceForAgent" parameterType="map"
  resultMap="city" useCache="false">
  SELECT city.*
  FROM Sm_City city
  WHERE city.City_Level in (1,2) ORDER BY city.Order_ID
 </select>

 <select id="findValidCityByProvinceForAgent" parameterType="map"
  resultMap="city" useCache="false">
  SELECT city.*
  FROM Sm_City city
  WHERE city.City_Level=#{cityLevel}
  AND city.Parent_City_Id=#{province}
  ORDER BY city.Order_ID
 </select>

 <insert id="insert" parameterType="com.djb.domain.City">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO
  Sm_City(
  Id
  ,City_Name
  ,City_Level
  ,Parent_City_Id
  ,Status
  ,Delete_Flag
  ,Create_User_Id
  ,Create_Time
  ,Update_User_Id
  ,Update_Time
  )VALUES(
  #{id}
  ,#{cityName}
  ,#{cityLevel}
  ,#{parentCity.id}
  ,'0'
  ,#{deleteFlag}
  ,#{createUserId}
  ,#{createDateTime}
  ,#{updateUserId}
  ,#{updateDateTime}
  )
 </insert>

 <update id="update" parameterType="com.djb.domain.City">
  UPDATE
  Sm_City
  SET
  City_Name=#{cityName}
  ,City_Level=#{cityLevel}
  ,Parent_City_Id=#{parentCity.id}
  ,Delete_Flag=#{deleteFlag}
  ,Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime}
  ,Name_Pinyin=#{namePinyin}
  WHERE
  id = #{id}
 </update>

 <delete id="deleteByPrimaryKey">
  DELETE FROM
  Sm_City
  WHERE
  id = #{id}
 </delete>

 <select id="findCityByPinyin" parameterType="string" resultMap="city">
  SELECT *
  FROM Sm_City
  WHERE Name_Pinyin = #{namePinyin}
  AND Delete_flag = '0'
 </select>

 <select id="getProvinceTenderCount" resultType="map" useCache="false">
  SELECT t.provinceCount,city.id,city.City_Name as cityName FROM (

  SELECT count(Province)as provinceCount,Province FROM
  (
  SELECT Applicant_Province as Province FROM
  Dp_Personal_Tender

  UNION ALL

  SELECT Province FROM
  Dp_Group_Tender
  )as tmp
  GROUP BY Province
  ) as t,Sm_City city

  WHERE t.province is not null
  AND city.id=t.Province

  ORDER BY t.provinceCount DESC

 </select>

 <select id="getCityList" parameterType="map" resultMap="city">
  SELECT *
  FROM Sm_City city
  WHERE Delete_Flag=0
  <if test="cityLevel">
   AND city.City_Level=#{cityLevel}
  </if>
  <if test="area">
   AND city.area=#{area}
  </if>
 </select>

</mapper>
==================================== END City.xml =========================


==================================== BEGIN PageTitleDescription.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:27:21 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="PageTitleDescription">

 <resultMap id="pageTitleDescription" type="com.djb.domain.PageTitleDescription" extends="DomainObject.domainObject">
  <result property="pageUrl" column="Page_Url"/>
  <result property="pageName" column="Page_Name"/>
  <result property="keyword" column="Keyword"/>
  <result property="pageTitle" column="Page_Title"/>
  <result property="description" column="Description"/>
  <result property="module" column="Module"/>
 </resultMap>

 <select id="load" resultMap="pageTitleDescription">
  SELECT  *
    FROM  Sm_Title_Description
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>
 
 <select id="getAll" resultMap="pageTitleDescription">
  SELECT  *
    FROM  Sm_Title_Description
   WHERE  delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.PageTitleDescription">
  UPDATE  Sm_Title_Description
     SET  
   Page_Url=#{pageUrl}
   ,Page_Name=#{pageName}
   ,Keyword=#{keyword}
   ,Page_Title=#{pageTitle}
   ,Description=#{description}
   ,Module=#{module}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   WHERE  id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.PageTitleDescription">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Sm_Title_Description(
   Page_Url
   ,Page_Name
   ,Keyword
   ,Page_Title
   ,Description
   ,Module
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{pageUrl}
   ,#{pageName}
   ,#{keyword}
   ,#{pageTitle}
   ,#{description}
   ,#{module}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
  
  
 </insert>

 <delete id="deleteByPrimaryKey">
  DELETE FROM  Sm_Title_Description
        WHERE  id = #{id}
 </delete>
</mapper>
==================================== END PageTitleDescription.xml =========================


==================================== BEGIN train/AgentBeginnerTrain.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="AgentBeginnerTrain" >

 <resultMap id="agentBeginnerTrain" type="com.djb.domain.train.AgentBeginnerTrain" extends="DomainObject.domainObject" >
  <result property="title" column="Title" />
  <result property="introduce" column="Introduce" />
  <result property="content" column="Content" />
  <result property="creditPoint" column="Credit_Point" />
  <result property="questionTitle" column="Question_Title" />
  <result property="questionOptions" column="Question_Options" />
  <result property="questionAnswer" column="Question_Answer" />
 </resultMap>

 <select id="load" resultMap="agentBeginnerTrain" >
  SELECT  *
    FROM  Sm_Agent_Beginner_Train
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.train.AgentBeginnerTrain" >
  UPDATE  Sm_Agent_Beginner_Train
     SET  
   Title=#{title}
   ,Introduce=#{introduce}
   ,Content=#{content}
   ,Credit_Point=#{creditPoint}
   ,Question_Title=#{questionTitle}
   ,Question_Options=#{questionOptions}
   ,Question_Answer=#{questionAnswer}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   WHERE  id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.train.AgentBeginnerTrain" >
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Sm_Agent_Beginner_Train(
   Title
   ,Introduce
   ,Content
   ,Credit_Point
   ,Question_Title
   ,Question_Options
   ,Question_Answer
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{title}
   ,#{introduce}
   ,#{content}
   ,#{creditPoint}
   ,#{questionTitle}
   ,#{questionOptions}
   ,#{questionAnswer}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey" >
  DELETE FROM  Sm_Agent_Beginner_Train
        WHERE  id = #{id}
 </delete>
 
 <select id="findByAgentBeginnerTrain" parameterType="com.djb.domain.train.AgentBeginnerTrain" resultMap="agentBeginnerTrain">
  SELECT  *
    FROM  Sm_Agent_Beginner_Train
   WHERE  delete_flag='0'
 
 </select>
</mapper>
==================================== END train/AgentBeginnerTrain.xml =========================


==================================== BEGIN train/AgentBeginnerSubmit.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="AgentBeginnerSubmit" >

 <resultMap id="agentBeginnerSubmit" type="com.djb.domain.train.AgentBeginnerSubmit" extends="DomainObject.domainObject" >
  <result property="trainId" column="Train_Id" />
  <result property="agentId" column="Agent_Id" />
 </resultMap>

 <select id="load" resultMap="agentBeginnerSubmit" >
  SELECT  *
    FROM  Sm_Agent_Beginner_Submit
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.train.AgentBeginnerSubmit" >
  UPDATE  Sm_Agent_Beginner_Submit
     SET  
   Train_Id=#{trainId}
   ,Agent_Id=#{agentId}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   WHERE  id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.train.AgentBeginnerSubmit" >
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Sm_Agent_Beginner_Submit(
   Train_Id
   ,Agent_Id
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{trainId}
   ,#{agentId}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey" >
  DELETE FROM  Sm_Agent_Beginner_Submit
        WHERE  id = #{id}
 </delete>
 
 <select id="findByAgentBeginnerSubmit" parameterType="com.djb.domain.train.AgentBeginnerSubmit" resultMap="agentBeginnerSubmit">
  SELECT  *
    FROM  Sm_Agent_Beginner_Submit
   WHERE  delete_flag='0'
    AND Train_Id=#{trainId} 
   AND Agent_Id=#{agentId}
 </select>
</mapper>
==================================== END train/AgentBeginnerSubmit.xml =========================


==================================== BEGIN customer/DuAgentCustomer.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:22:45 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="DuAgentCustomer">

 <resultMap id="duAgentCustomer" type="com.djb.domain.customer.DuAgentCustomer" extends="DomainObject.domainObject">
  <result property="userid" column="user_id"/>
  <result property="callerPhone" column="Caller_Phone_Number"/>
  <result property="remark" column="remark"/>
  <result property="callsum" column="call_sum"/>
  <result property="callremain" column="call_remain"/>
 </resultMap>

 <resultMap id="callRecord-map" type="callRecord">
  <result property="calledId" column="Called_Id"/>
  <result property="relatedId1" column="Related_Id1"/>
  <result property="callType" column="Call_Type"/>
  <result property="position" column="Call_Position"/>
  <result property="callSequenceId" column="Call_Sequence_Id"/>
  <result property="callerPhoneNumber" column="Caller_Phone_Number"/>
  <result property="calledPhoneNumber" column="Called_Phone_Number"/>
  <result property="createDateTime" column="create_time"/>
 </resultMap>

 <resultMap id="customer-map" type="com.djb.domain.customer.DuAgentCustomer">
  <result property="id" column="id"/>
  <result property="userid" column="user_id"/>
  <result property="callerPhone" column="callerNumber"/>
  <result property="remark" column="remark"/>
  <result property="callsum" column="call_sum"/>
  <result property="callremain" column="call_remain"/>
  <collection property="callRecords" resultMap="DuAgentCustomer.callRecord-map"/>
 </resultMap>

 <select id="load" resultMap="duAgentCustomer">
  SELECT *
  FROM Du_Agent_Customer
  WHERE
  id = #{id}
  AND delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.customer.DuAgentCustomer">
  UPDATE Du_Agent_Customer
  SET
  user_id=#{userid}
  ,Caller_Phone_Number=#{callerPhone}
  ,remark=#{remark}
  ,call_sum=#{callsum}
  ,call_remain=#{callremain}
  WHERE id = #{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.customer.DuAgentCustomer">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
   INSERT INTO 
   Du_Agent_Customer(
    user_id
    ,Caller_Phone_Number
    ,remark
    ,call_sum
    ,call_remain
    ,delete_flag
    ,create_user_id
    ,create_time
    ,update_user_id
    ,update_time )
   VALUES(
    #{userid}
    ,#{callerPhone}
    ,#{remark}
    ,#{callsum}
    ,#{callremain}
    ,#{deleteFlag}
    ,#{createUserId}
    ,#{createDateTime}
    ,#{updateUserId}
    ,#{updateDateTime}
   )
   SELECT
   SCOPE_IDENTITY() Id
  
 </insert>

 <delete id="deleteByPrimaryKey">
  DELETE FROM Du_Agent_Customer
  WHERE id = #{id}
 </delete>

 <select id="getAgentCustomerCount" parameterType="com.djb.domain.customer.MyCustomerQueryBean" resultType="int">
  SELECT 
    count(*) 
  from( 
   SELECT 
     Caller_Phone_Number 
   from(
     SELECT 
       customer.call_remain,
       record.Caller_Phone_Number 
     from
      (
       SELECT 
         callrecord.Caller_Phone_Number,
         callrecord.Called_Id
       FROM 
         Dp_Call_Record callrecord,
         Sm_Call_Result callresult 
       WHERE 
         callrecord.Called_Id =#{agentId}
         and callrecord.Delete_Flag ='0' 
         and callrecord.Call_Type=1 
         and callrecord.Create_Time&gt;='2012-11-15'
         and callrecord.Call_Sequence_Id = callresult.Sequence_Id
         and callresult.Call_Result in(1,3)
         and callresult.Delete_Flag ='0'
      ) record
      LEFT JOIN Du_Agent_Customer customer
      on customer.user_id = record.Called_Id
      and customer.Delete_Flag = '0'
      and customer.Caller_Phone_Number = record.Caller_Phone_Number 
    )subquery WHERE 
    
     <if test="tab == 'untreated'">
     
      (subquery.call_remain is null or subquery.call_remain!=0)
     </if>
     <if test="tab == 'treated'">
     
     (subquery.call_remain is not null and subquery.call_remain=0)
     </if>
     
    GROUP BY Caller_Phone_Number 
   )subquery1  
 </select>
 
 <select id="getAgentCustomers" parameterType="com.djb.domain.customer.MyCustomerQueryBean" resultMap="DuAgentCustomer.customer-map">
   SELECT * 
     FROM (
     SELECT customer.id,
       customer.USER_ID,
       customer.remark,
       customer.call_sum,
       customer.call_remain,          
       record.Caller_Phone_Number as callerNumber,
       record.Called_Id,
       record.Related_Id1,
       record.Call_Type,
       record.Call_Position,
       record.Call_Sequence_Id,
       record.Caller_Phone_Number,
       record.Called_Phone_Number,
       record.Create_Time
     FROM(
       SELECT callrecord.* 
       FROM Dp_Call_Record callrecord
         ,Sm_Call_Result callresult 
       WHERE callrecord.Called_Id =#{agentId}
          AND callrecord.Delete_Flag ='0' 
          AND callrecord.Call_Type=1 
          AND callrecord.Create_Time&gt;='2012-11-15'
             AND callrecord.Call_Sequence_Id = callresult.Sequence_Id
          AND callresult.Call_Result in(1,3)
          AND  callresult.Delete_Flag ='0' 
      )record
        LEFT JOIN  Du_Agent_Customer customer ON customer.user_id = record.Called_Id
       AND customer.Delete_Flag = '0'
       AND customer.Caller_Phone_Number = record.Caller_Phone_Number
     )subquery 
     WHERE
      
       <if test="tab == 'untreated'">
        
         (subquery.call_remain is null or subquery.call_remain!=0)
       </if>
       <if test="tab == 'treated'">
        
         (subquery.call_remain is not null and subquery.call_remain=0)
       </if>
      
    <if test="orderByProperties != null">
      ORDER BY ${orderByFiled} 
    </if>
 </select> 
  
 <select id="getDuAgentCustomer" parameterType="map" resultMap="duAgentCustomer">
  SELECT 
   * 
  FROM 
  Du_Agent_Customer 
  WHERE USER_ID=#{userId}
  and  Caller_Phone_Number=#{callerPhone}
  and Delete_Flag='0'
 </select>
</mapper>
==================================== END customer/DuAgentCustomer.xml =========================


==================================== BEGIN Category.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="Category" >

 <resultMap id="category" type="com.djb.domain.Category" extends="DomainObject.domainObject" >
  <result property="name" column="name" />
  <result property="referId" column="Refer_Id" />
  <result property="description" column="Description" />
  <result property="type" column="Type" />
  <result property="orderId" column="Order_Id" />
 </resultMap>

 <select id="load" resultMap="category" >
  SELECT  *
    FROM  Dp_Category
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.Category" >
  UPDATE  Dp_Category
     SET  
   name=#{name}
   ,Refer_Id=#{referId}
   ,Description=#{description}
   ,Type=#{type}
   ,Order_Id=#{orderId}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   WHERE  id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.Category" >
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Dp_Category(
   name
   ,Refer_Id
   ,Description
   ,Type
   ,Order_Id
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{name}
   ,#{referId}
   ,#{description}
   ,#{type}
   ,#{orderId}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey" >
  DELETE FROM  Dp_Category
        WHERE  id = #{id}
 </delete>
 
 <sql id="findCategoryListRef">
     FROM Dp_Category  category
     WHERE delete_flag=0
     <if test="name != null and name != ''">AND
      category.name like concat('%', #{name}, '%') 
     </if>
     <if test="id != null">AND
      category.id = #{id}
     </if>
     <if test="referId != null">AND
      category.referId = #{referId}
     </if>
     <if test="type != null">AND
      category.type = #{type}
     </if>
     <if test="isFront">
      AND EXISTS(
      SELECT 1 FROM Dp_App_Product product
      WHERE product.Delete_flag = '0'
       AND product.status = 1
       AND (product.Categorys LIKE concat('%,',category.Id,',%') OR product.Categorys LIKE concat(category.Id, ',%'))
       )
     </if>
 </sql>
 
 <!-- 根据queryBean查找类别的数量 -->
 <select id="getCountByQueryBean" parameterType="com.djb.domain.help.CategoryQueryBean" resultType="int">
  SELECT count(*) <include refid="findCategoryListRef"/>
 </select>
 
 <!-- 根据queryBean查找所有符合条件的类别 -->
 <select id="findCategoryList" parameterType="com.djb.domain.help.CategoryQueryBean" resultMap="category">
  SELECT * <include refid="findCategoryListRef"/>
  <if test="orderByProperties != null">
   ORDER BY ${orderByFiled} 
  </if>
  <if test="orderByProperties == null">
   ORDER BY category.Order_Id,category.create_time DESC
  </if>
  LIMIT ${startIndex}, ${pageSize}
 </select>
</mapper>
==================================== END Category.xml =========================


==================================== BEGIN DBAgent.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:27:18 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="DBAgent">

	<resultMap type="java.util.HashMap" id="contractInfo">
		<result column="contract_id" property="contractId"/>
		<result column="contract_agent_id" property="contractAgentId"/>
		<result column="customer_id" property="customerId"/>
		<result column="package_id" property="packageId"/>
	</resultMap>

	<!-- 重置计划推荐数量 -->
	<update id="updateAgentRecommondNum" >
		update Du_Agent_Detail set Recommond_Num = 0
	</update>
	<update id="updateProgramRecommondStatus" >
		update Dp_Program set Is_Recommond = 0
	</update>
	
	<!-- 更新一些***数量 -->
	<update id="resetSubmitPeopleCount" parameterType="java.util.HashMap">
		update tmp_tender_num set Param_Value = 0,update_time = #{updateTime} where Param_Name = 'Submit_People_Count';
	</update>
	<update id="resetSubmitCompanyCount" parameterType="java.util.HashMap">
		update tmp_tender_num set Param_Value = 0,update_time = #{updateTime} where Param_Name = 'Submit_Company_Count';
	</update>
	<update id="resetSelectTenderCount" parameterType="java.util.HashMap">
		update tmp_tender_num set Param_Value = 0,update_time = #{updateTime} where Param_Name = 'Select_Tender_Count';
	</update>
	<update id="updateSuccessPeopleCount" parameterType="java.util.HashMap">
		update tmp_tender_num
		set Param_Value = Param_Value + #{rnd},update_time = #{updateTime}
		where Param_Name = 'Success_People_Count';
	</update>
	<update id="updateSuccessCompanyCount" parameterType="java.util.HashMap">
		update tmp_tender_num
		set Param_Value = Param_Value +  #{rnd},update_time = #{updateTime}
		where Param_Name = 'Success_Company_Count';
	</update>
	<update id="updateSubmitPeopleCount" parameterType="java.util.HashMap">
		update tmp_tender_num
		set Param_Value = Param_Value +  #{rnd},update_time = #{updateTime}
		where Param_Name = 'Submit_People_Count';
	</update>
	<update id="updateSubmitCompanyCount" parameterType="java.util.HashMap">
		update tmp_tender_num
		set Param_Value = Param_Value +  #{rnd},update_time = #{updateTime}
		where Param_Name = 'Submit_Company_Count';
	</update>
	<update id="updateSelectTenderCount" parameterType="java.util.HashMap">
		update tmp_tender_num
		set Param_Value = Param_Value +  #{rnd},update_time = #{updateTime}
		where Param_Name = 'Select_Tender_Count';
	</update>
	<update id="updateQuestionCount" parameterType="java.util.HashMap">
		update tmp_tender_num
		set Param_Value = Param_Value +  #{rnd},update_time = #{updateTime}
		where Param_Name = 'Question_Count';
	</update>
	
	<!-- 代理人详细信息统计 -->
	<insert id="insertAgentDailyDetail" parameterType="java.util.HashMap">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
		INSERT INTO Stat_Agent_Detail
		(Stat_Date, Agent_Id, True_Name, Mobilephone, Email, Fee_Status,
		 Province, City, Company, Department, Service_Area, Agent_Type, Verify_Status,
		 Online_Program_Count,Online_Recommend_Program_Count,Recycle_Program_Count,Increase_Program_Count,
		 Program_Refresh_Count,Recommend_Program_Count,Recommend_Agent_Count,Click_Agent_Count,Click_Program_Count,
		 Webcall_Total_Count,Webcall_Success_Count,Caller_Failed_Count,Called_Failed_Count,Unique_Count,Unique_Caller_Failed_Count,
		 Unique_Called_Failed_Count,Unique_Success_Count,Phonetender_Get_Count,Phonetender_Handle_Count,Mailtender_Get_Count,Mailtender_Handle_Count,
		 Land_Count,Get_Question_Count,Answer_Question_Count,Increase_Email_Program_Count,
		 Delete_Flag, Create_User_Id, Create_Time, Update_User_Id, Update_Time)
		SELECT #{statStartDateStr},AgentDetail.Id,AgentDetail.True_Name,AgentDetail.Mobilephone,AgentDetail.Email,AgentDetail.Fee_Status,
		Agent.Province,Agent.City,AgentDetail.Company,AgentDetail.Department,AgentDetail.Service_Area,
		CASE WHEN AgentDetail.Create_Time&gt;=#{statStartDate} THEN 1 ELSE 0 END Agent_Type,
		AgentDetail.Verify_Status,
		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
		0,#{systemUser},#{createDate},#{systemUser},#{createDate}
		FROM Du_Agent_Detail AgentDetail,Du_User Agent
		WHERE AgentDetail.Id = Agent.Id
		and AgentDetail.Delete_Flag = 0
	</insert>
	<update id="updateAgentDailyDetailContract" parameterType="java.util.HashMap">
		update Stat_Agent_Detail
		set Package_Type = b.Package_Id,
		Contract_Id = b.Contract_Id,
		Contract_Start_Time = b.Package_Start_Time,
		Contract_End_Time= b.Package_End_Time,
		Contract_Renewal_Type = b.Contract_Renewal_Type
		from Stat_Agent_Detail a,(
		select c.Customer_Id,c.Contract_Id,c.Package_Start_Time,c.Package_End_Time,c.Package_Id,
		(case when c.Package_Start_Time &gt;= #{statStartDate} and c.Package_Start_Time &lt; #{statEndDate} then d.Contract_Renewal_Type 
		else 3 end) Contract_Renewal_Type
		from Sm_Contract_Agent c,Sm_Contract d
		where c.Delete_Flag = 0
		and c.Status = 30 
		and c.Contract_Id = d.Id
		) b
		where a.Agent_Id = b.Customer_Id
		and a.Stat_Date = #{statStartDateStr}
	</update>
	<update id="updateAgentDailyDetailProgram" parameterType="java.util.HashMap">
		update Stat_Agent_Detail
		set Increase_Program_Count = b.new,
		Online_Program_Count = b.total,
		Online_Recommend_Program_Count = b.Recommond,
		Recycle_Program_Count = b.recycle,
		Program_Refresh_Count = b.Refresh_Count
		from Stat_Agent_Detail a,(
		select create_user_id,sum(case Status when 1 then 1 else 0 end) as total,
		sum(case when Is_Recommond=1 and Status = 1 then 1 else 0 end) as Recommond,
		sum(case when create_time &gt;= #{statStartDate} and Status = 1 then 1 else 0 end) as new,
		SUM(case Status when 0 then 1 else 0 end) as recycle,
		SUM(case Status when 1 then Refreshed_Times else 0 end) as Refresh_Count
		from Dp_Program 
		where delete_flag = 0
		group by create_user_id
		) b
		where a.agent_id = b.Create_User_Id
		and a.Stat_Date = #{statStartDateStr}
	</update>
	<update id="updateAgentDailyDetailMailTender" parameterType="java.util.HashMap">
		update Stat_Agent_Detail
		set Increase_Email_Program_Count = b.num
		from Stat_Agent_Detail a,(
		select Agent_Id,COUNT(distinct b.Id) as num
		from Dp_Tender_Dispatch_Record a,Dp_Program b
		where b.Create_Time &gt;= #{statStartDate}
		and b.Create_Time &lt; #{statEndDate}
		and b.Delete_Flag = 0
		and a.Type = 2
		and a.Program_Id = b.Id
		group by Agent_Id
		)b 
		where a.agent_id = b.Agent_Id
		and a.Stat_Date = #{statStartDateStr}
	</update>
	<update id="updateAgentDailyDetailTenderRecommend" parameterType="java.util.HashMap">
		update Stat_Agent_Detail
		set Recommend_Program_Count = b.total
		from Stat_Agent_Detail a,(
		select b.Create_User_Id,COUNT(a.id) as total
		from Dp_Tender_Recommend_Record a,Dp_Program b
		where a.Create_Time &gt;= #{statStartDate}
		and a.Create_Time &lt; #{statEndDate}
		and a.Tender_Recommed_Type = 1
		and a.Refer_Id = b.Id
		and a.Delete_Flag = 0
		group by b.Create_User_Id
		) b
		where a.agent_id = b.Create_User_Id
		and a.Stat_Date = #{statStartDateStr}
	</update>
	<update id="updateAgentDailyDetailStoreRecommend" parameterType="java.util.HashMap">
		update Stat_Agent_Detail
		set Recommend_agent_Count = b.total
		from Stat_Agent_Detail a,(
		select Refer_Id,COUNT(id) as total
		from Dp_Tender_Recommend_Record
		where Create_Time &gt;= #{statStartDate}
		and Create_Time &lt; #{statEndDate}
		and Tender_Recommed_Type = 2
		and Delete_Flag = 0
		group by Refer_Id
		) b
		where a.agent_id = b.Refer_Id
		and a.Stat_Date = #{statStartDateStr}
	</update>
	<update id="updateAgentDailyDetailPlanClick" parameterType="java.util.HashMap">
		update Stat_Agent_Detail
		set Click_Program_Count = b.total
		from Stat_Agent_Detail a,(
		select Agent_Id,COUNT(id) as total
		from dbo.Dp_Program_Click
		where Create_Time &gt;= #{statStartDate}
		and Create_Time &lt; #{statEndDate}
		and Delete_Flag = 0
		group by Agent_Id
		) b
		where a.agent_id = b.Agent_Id
		and a.Stat_Date = #{statStartDateStr}
	</update>
	<update id="updateAgentDailyDetailStoreClick" parameterType="java.util.HashMap">
		update Stat_Agent_Detail
		set Click_Agent_Count = b.total
		from Stat_Agent_Detail a,(
		select Agent_Id,COUNT(id) as total
		from dbo.Dp_Agent_Click
		where Create_Time &gt;= #{statStartDate}
		and Create_Time &lt; #{statEndDate}
		and Delete_Flag = 0
		group by Agent_Id
		) b
		where a.agent_id = b.Agent_Id
		and a.Stat_Date = #{statStartDateStr}
	</update>
	<update id="updateAgentDailyDetailLogin" parameterType="java.util.HashMap">
		update Stat_Agent_Detail
		set Land_Count = b.Land_Count
		from Stat_Agent_Detail a,(
		select User_Id,1 as Land_Count
		from dbo.Du_User_Login_Log
		where Create_Time &gt;= #{statStartDate}
		and Create_Time &lt; #{statEndDate}
		and Delete_Flag = 0
		group by User_Id
		) b
		where a.agent_id = b.User_Id
		and a.Stat_Date = #{statStartDateStr}
	</update>
	<update id="updateAgentDailyDetailWebcall" parameterType="java.util.HashMap">
		update Stat_Agent_Detail
		set Webcall_Total_Count = b.total,
		Webcall_Success_Count = b.chenggongshu,
		Caller_Failed_Count = b.yonghuweitong,
		Called_Failed_Count = b.dlrweitong,
		Unique_Count = b.weiyihaoma,
		Unique_Caller_Failed_Count = b.yonghuweiyi,
		Unique_Called_Failed_Count = b.dlrweiyi,
		Unique_Success_Count = b.chenggongweiyi
		from Stat_Agent_Detail a,(
		select a.Called_Id,COUNT(a.id) as total,
		sum(case when b.Call_Result = 1 then 1 else 0 end) as chenggongshu,
		sum(case when b.Id IS null then 1 else 0 end) as yonghuweitong,
		sum(case when b.Call_Result =3 then 1 else 0 end) as dlrweitong,
		COUNT(distinct a.Caller_Phone_Number) as weiyihaoma,
		COUNT(distinct (case when b.id IS null then a.Caller_Phone_Number end)) as yonghuweiyi,
		COUNT(distinct (case when b.Call_Result =3 then a.Caller_Phone_Number end)) as dlrweiyi,
		COUNT(distinct (case when b.Call_Result = 1 then a.Caller_Phone_Number end)) as chenggongweiyi
		from Dp_Call_Record a
		left join Sm_Call_Result b on a.Call_Sequence_Id = b.Sequence_Id
		where a.Create_Time &gt;= #{statStartDate}
		and a.Create_Time &lt; #{statEndDate}
		and a.Called_Phone_Number &lt;&gt; a.Caller_Phone_Number
		and a.Call_Type = 1
		and a.Delete_Flag = 0
		group by a.Called_Id
		) b
		where a.agent_id = b.Called_Id
		and a.Stat_Date = #{statStartDateStr};
	</update>
	<update id="updateAgentDailyDetailTenderDispatch" parameterType="java.util.HashMap">
		update Stat_Agent_Detail
		set Phonetender_Get_Count = b.dianhua,
		Mailtender_GET_Count = b.youjian
		from Stat_Agent_Detail a,(
		select Agent_Id,SUM(case when Type = 1 then 1 else 0 end) as dianhua,
		SUM(case when Type = 2 then 1 else 0 end) as youjian
		from Dp_Tender_Dispatch_Record
		where Create_Time &gt;= #{statStartDate}
		and Create_Time &lt; #{statEndDate}
		and Delete_Flag = 0
		group by Agent_Id
		) b
		where a.agent_id = b.agent_id
		and a.Stat_Date = #{statStartDateStr}
	</update>
	<update id="updateAgentDailyDetailQuestion" parameterType="java.util.HashMap">
		update Stat_Agent_Detail
		set Get_Question_Count = b.question_num
		from Stat_Agent_Detail a,(
		select t_question.agent_id,SUM(num) as question_num
		from (
		select Refer_Id as agent_id,COUNT(ID) as num
		from Dq_Question
		where Create_Time&gt;= #{statStartDate}
		and Create_Time &lt; #{statEndDate}
		and Type = 2
		and Status  in (11,20,30,40)
		and Delete_Flag = 0
		group by  Refer_Id 
		union
		select d.[User_Id] as agent_id,COUNT(c.ID) as num
		from Dq_Question c,Dp_Program d
		where c.Create_Time&gt;= #{statStartDate}
		and c.Create_Time &lt; #{statEndDate}
		and c.Type = 1
		and c.Status  in (11,20,30,40)
		and c.Delete_Flag = 0
		and c.Refer_Id = d.Id
		and d.Delete_Flag = 0
		group by  d.[User_Id] 
		) t_question
		group by t_question.agent_id
		) b
		where a.agent_id = b.agent_id
		and a.Stat_Date = #{lastDay}
	</update>
	<update id="updateAgentDailyDetailAnswer" parameterType="java.util.HashMap">
		update Stat_Agent_Detail
		set Answer_Question_Count = b.wenti
		from Stat_Agent_Detail a,(
		select Create_User_Id,COUNT(id) as wenti
		from Dq_Answer
		where Create_Time&gt;= #{statStartDate}
		and Create_Time &lt; #{statEndDate}
		and Admin_Answer = 0
		and Delete_Flag = 0
		group by  Create_User_Id 
		) b
		where a.agent_id = b.Create_User_Id
		and a.Stat_Date = #{lastDay}
	</update>
	
	<!-- 代理人付费信息变更 -->
	<select id="findExpiredContract" parameterType="java.util.HashMap" resultMap="contractInfo">
		select a.Id as contract_agent_id,a.Contract_Id as contract_id,a.Customer_Id as customer_id
		from Sm_Contract_Agent a
		where a.Package_End_Time &gt;= #{yesterday}
		and a.Package_End_Time &lt; #{today}
		and a.Status = 30
		and a.delete_flag = 0
	</select>
	<update id="updateAgentFree" parameterType="java.util.HashMap">
		update du_agent_detail
		set fee_status = 2,
		Package_Type = null,
		update_time = #{updateTime},
		Update_User_Id = 1
		where Id=#{customerId};	
	</update>
	<update id="updateContractAgentFree" parameterType="java.util.HashMap">
		update Sm_Contract_Agent
		set status = 40,
		Remark = '已过期',
		update_time = #{updateTime},
		Update_User_Id = 1
		where id = #{contractAgentId};
	</update>
	<update id="updateContractFree" parameterType="java.util.HashMap">
		update sm_Contract
		set contract_status = 40,
		update_time = #{updateTime},
		Update_User_Id = 1
		where id = #{contractId};
	</update>
	<select id="findTodayTakeEffectContract" parameterType="java.util.HashMap" resultMap="contractInfo">
		select a.Id as contract_agent_id,a.Contract_Id as contract_id,a.Customer_Id as customer_id,a.package_id as package_id
		from Sm_Contract_Agent a
		where a.Package_Start_Time &gt;= #{today}
		and a.Package_Start_Time &lt; #{tomorrow}
		and a.Status = 20
		and a.delete_flag = 0
	</select>
	<update id="updateAgentPaid" parameterType="java.util.HashMap">
		update du_agent_detail
		set fee_status = 1,
		Package_Type = #{packageId},
		update_time = #{updateTime},
		Update_User_Id = 1
		where Id=#{customerId};	
	</update>
	<update id="updateContractAgentPaid" parameterType="java.util.HashMap">
		update Sm_Contract_Agent
		set [status] = 30,
		update_time = #{updateTime},
		Update_User_Id = 1
		where [id] = #{contractAgentId};
	</update>
	<update id="updateContractPaid" parameterType="java.util.HashMap">
		update sm_Contract
		set contract_status = 30,
		update_time = #{updateTime},
		Update_User_Id = 1
		where id = #{contractId};
	</update>
	<update id="updateAgentFeeTime">
		update Du_Agent_Detail set fee_time= b.create_time
		from Du_Agent_Detail a,
		(
		SELECT max(Create_Time) as Create_Time,Customer_Id as Customer_Id 
		from Sm_Contract_Agent 
		GROUP BY Customer_Id
		)  b
		where a.id = b.Customer_Id
		and a.Fee_Status = 1;
	</update>
	<update id="updateContractAgentStatus" parameterType="java.util.HashMap">
		update Sm_Contract_Agent
		set Status = 70,
		Remark = '7天未付款',
		Update_User_Id = 2,
		Update_Time = #{updateTime}
		where Delete_Flag = 0
		and Status = 10
		and Create_Time &lt; #{limit}
	</update>
	<update id="updateOrderStatus" parameterType="java.util.HashMap">
		update Sm_Order
		set Status = 3,
		Update_User_Id = 2,
		Update_Time = #{updateTime}
		where Delete_Flag = 0
		and Status = 1
		and Sign_Time is null
		and Create_Time &lt; #{limit}
	</update>
	<insert id="insertRenewalSMS7Day" parameterType="java.util.HashMap">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
		insert into Sm_Sms_Send
		(Mobile_phone,Sms_Content,Sms_Type,Sms_Status,Plan_Send_Time,Send_User_Id,Sms_Platform,Remark,Delete_Flag,Create_User_Id,Create_Time,Update_User_Id,Update_Time)
		select b.Mobilephone,'尊敬的'+b.True_Name+'，你的VIP会员还有7天就要到期，请及时联系你的销售代表或拨打4001114567进行续费。',
		'34','0',#{sendTime},2,7,'续约短信提醒,7天',0,2,#{createTime},2,#{createTime}
		from Sm_Contract_Agent a, Du_Agent_Detail b
		where a.Delete_Flag = 0
		and a.Customer_Id = b.Id
		and b.Fee_Status = 1
		and b.Delete_Flag = 0
		and a.Status = 30
		and a.Package_End_Time&gt;=#{startTime}
		and a.Package_End_Time&lt;#{endTime}
		and a.Customer_Id not in (
		select distinct Customer_Id
		from Sm_Contract_Agent
		where Delete_Flag = 0
		and Status = 20 
		and Package_End_Time &gt;= #{endTime}
		)
	</insert>
	<insert id="insertRenewalSMS3Day" parameterType="java.util.HashMap">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
		insert into Sm_Sms_Send
		(Mobile_phone,Sms_Content,Sms_Type,Sms_Status,Plan_Send_Time,Send_User_Id,Sms_Platform,Remark,Delete_Flag,Create_User_Id,Create_Time,Update_User_Id,Update_Time)
		select b.Mobilephone,'尊敬的'+b.True_Name+'，你的VIP会员还有3天就要到期，请及时联系你的销售代表或拨打4001114567进行续费。',
		'34','0',#{sendTime},2,7,'续约短信提醒,3天',0,2,#{createTime},2,#{createTime}
		from Sm_Contract_Agent a, Du_Agent_Detail b
		where a.Delete_Flag = 0
		and a.Customer_Id = b.Id
		and b.Fee_Status = 1
		and b.Delete_Flag = 0
		and a.Status = 30
		and a.Package_End_Time &gt;=#{startTime}
		and a.Package_End_Time &lt;#{endTime}
		and a.Customer_Id not in (
		select distinct Customer_Id
		from Sm_Contract_Agent
		where Delete_Flag = 0
		and Status = 20 
		and Package_End_Time &gt;= #{endTime}
		)
	</insert>
</mapper>
==================================== END DBAgent.xml =========================


==================================== BEGIN activity/TmpActivityXmas.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="TmpActivityXmas" >

 <resultMap id="ActivityXmas" type="com.djb.domain.activity.TmpActivityXmas" extends="DomainObject.domainObject" >
  <result property="agent.id" column="User_Id" />
  <result property="type" column="Type" />
  <result property="amount" column="Amount" />
  <result property="lottery" column="Lottery" />
 </resultMap>
 
 <resultMap id="tmpActivityXmas" type="com.djb.domain.activity.TmpActivityXmas" extends="DomainObject.domainObject" >
  <result property="agent.id" column="User_Id" />
  <result property="amount" column="Amount" />
 </resultMap>

 <select id="load" resultMap="ActivityXmas" >
  SELECT  *
    FROM  Tmp_Activity_Xmas
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>
 
 <select id="getConsumeAmount" resultType="int">
  SELECT sum(Amount) Amount
    FROM Tmp_Activity_Xmas
   WHERE Delete_Flag = 0
     AND User_Id = #{userId}
     AND Type = 1
 </select>
 
 <select id="getLotteryAmount" resultType="int">
  SELECT count(1) Amount
    FROM Tmp_Activity_Xmas
   WHERE Delete_Flag = 0
     AND User_Id = #{userId}
     AND Type = 2
 </select>
 
 <select id="findLottery" resultMap="ActivityXmas">
  SELECT *
    FROM Tmp_Activity_Xmas
   WHERE Delete_Flag = 0
     AND User_Id = #{userId}
     AND Type = 2
 </select>
 
 <select id="findRanKingList" resultMap="tmpActivityXmas">
  SELECT User_Id
    ,SUM(Amount) Amount
    FROM Tmp_Activity_Xmas
   WHERE Type = 1
     AND Delete_Flag = 0
   GROUP BY User_Id
   LIMIT 9
 </select>

 <update id="update" parameterType="com.djb.domain.activity.TmpActivityXmas" >
  UPDATE  Tmp_Activity_Xmas
     SET  
   User_Id=#{agent.id}
   ,Type=#{type}
   ,Amount=#{amount}
   ,Lottery=#{lottery}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   WHERE  id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.activity.TmpActivityXmas" >
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Tmp_Activity_Xmas(
   User_Id
   ,Type
   ,Amount
   ,Lottery
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{agent.id}
   ,#{type}
   ,#{amount}
   ,#{lottery}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey" >
  DELETE FROM  Tmp_Activity_Xmas
        WHERE  id = #{id}
 </delete>
</mapper>
==================================== END activity/TmpActivityXmas.xml =========================


==================================== BEGIN img/ImageGallery.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="ImageGallery" >

 <resultMap id="imageGallery" type="com.djb.domain.img.ImageGallery" extends="DomainObject.domainObject" >
  <result property="name" column="Name" />
  <result property="type" column="Type" />
  <result property="imageUrl" column="Image_Url" />
  <result property="smallImageUrl" column="Small_Image_Url" />
  <result property="parentId" column="Parent_Id" />
 </resultMap>

 <select id="load" resultMap="imageGallery" >
  SELECT  *
    FROM  Sm_Image_Gallery
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.img.ImageGallery" >
  UPDATE  Sm_Image_Gallery
     SET  
   Name=#{name}
   ,Type=#{type}
   ,Image_Url=#{imageUrl}
   ,Small_Image_Url=#{smallImageUrl}
   ,Parent_Id=#{parentId}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   WHERE  id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.img.ImageGallery" >
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Sm_Image_Gallery(
   Name
   ,Type
   ,Image_Url
   ,Small_Image_Url
   ,Parent_Id
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{name}
   ,#{type}
   ,#{imageUrl}
   ,#{smallImageUrl}
   ,#{parentId}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey" >
  DELETE FROM  Sm_Image_Gallery
        WHERE  id = #{id}
 </delete>
 
 <sql id="findImageGalleryByQueryBeanRef">
  FROM Sm_Image_Gallery gallery
  WHERE gallery.Delete_Flag=0
  <if test="type!=null">
  <if test="type==1">
  and gallery.Type=#{type}
  </if>
  <if test="type==0">
  and gallery.Type in (0,2)
  </if>
  </if>
  <if test="createUserId">
  and Create_User_Id=#{createUserId}
  </if>
  <if test="parentId!=null">
  and gallery.Parent_Id=#{parentId}
  </if>
 </sql>
 
 <select id="findImageGalleryCountByQueryBean" parameterType="com.djb.domain.img.ImageGalleryQueryBean" resultType="int">
  SELECT COUNT(*) <include refid="findImageGalleryByQueryBeanRef"/>
 </select>
 
 <select id="findImageGalleryByQueryBean" parameterType="com.djb.domain.img.ImageGalleryQueryBean" resultMap="imageGallery">
  SELECT * <include refid="findImageGalleryByQueryBeanRef"/>
  ORDER BY gallery.Create_Time DESC
  LIMIT ${startIndex}, ${pageSize}
 </select>
 
 <select id="findImageGalleryCountByImageGallery" parameterType="com.djb.domain.img.ImageGallery" resultType="int">
  SELECT COUNT(*) FROM Sm_Image_Gallery
  WHERE Delete_Flag=0
  <if test="type!=null">
  <if test="type==1">
  and Type=#{type}
  </if>
  <if test="type==0">
  and Type in (0,2)
  </if>
  </if>
  <if test="createUserId!=null">
  and Create_User_Id=#{createUserId}
  </if>
  <if test="parentId!=null">
  and Parent_Id=#{parentId}
  </if>
 </select>
 
 <select id="findImageGalleryByImageGallery" parameterType="com.djb.domain.img.ImageGallery" resultMap="imageGallery">
  SELECT * FROM Sm_Image_Gallery
  WHERE Delete_Flag=0
  <if test="type!=null">
  <if test="type==1">
  and Type=#{type}
  </if>
  <if test="type==0">
  and Type in (0,2)
  </if>
  </if>
  <if test="createUserId!=null">
  and Create_User_Id=#{createUserId}
  </if>
  <if test="parentId!=null">
  and Parent_Id=#{parentId}
  </if>
  ORDER BY Create_Time DESC
 </select>
 
 <update id="deleteByParentId" parameterType="long">
  UPDATE Sm_Image_Gallery
  SET Delete_Flag=1
  WHERE Parent_Id=#{parentId}
 </update>
 
 <select id="findImageUrlOneByParentId" parameterType="long" resultMap="imageGallery">
  SELECT *
  FROM Sm_Image_Gallery 
  WHERE Parent_Id=#{parentId}
  and Delete_Flag=0
  ORDER BY Create_Time DESC
  LIMIT 1
 </select>
 
 <select id="findTopImageGalleryByQueryBean" parameterType="com.djb.domain.img.ImageGalleryQueryBean" resultMap="imageGallery">
  SELECT * FROM Sm_Image_Gallery
  WHERE delete_flag=0
  and Create_User_Id=#{createUserId}
  and Type=1
  ORDER BY Create_Time desc
  LIMIT ${topLen}
 </select>
</mapper>
==================================== END img/ImageGallery.xml =========================


==================================== BEGIN sell/SellerRevenue.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="SellerRevenue">

	<resultMap id="sellerRevenue" type="com.djb.domain.sell.SellerRevenue"
		extends="DomainObject.domainObject">
		<result property="agentSeller.id" column="Seller_Id" />
		<result property="agentUser.id" column="User_Id" />
		<result property="dealType" column="Deal_Type" />
		<result property="subLevel" column="Sub_Level" />
		<result property="consumeTime" column="Consume_Time" />
		<result property="consumeAmount" column="Consume_Amount" />
		<result property="percentage" column="Percentage" />
		<result property="status" column="Status" />
		<result property="consumeMonth" column="Consume_Month" />
	</resultMap>

	<select id="load" resultMap="sellerRevenue">
		SELECT *
		FROM Du_Seller_Revenue
		WHERE id = #{id}
		AND delete_flag='0'
	</select>

	<update id="update" parameterType="com.djb.domain.sell.SellerRevenue">
		UPDATE Du_Seller_Revenue
		SET
		Seller_Id=#{agentSeller.id}
		,User_Id=#{agentUser.id}
		,Deal_Type=#{dealType}
		,Sub_Level=#{subLevel}
		,Consume_Time=#{consumeTime}
		,Consume_Amount=#{consumeAmount}
		,Percentage=#{percentage}
		,Status=#{status}
		,Delete_Flag=#{deleteFlag}
		,Update_User_Id=#{updateUserId}
		,Update_Time=#{updateDateTime}
		WHERE id=#{id}
	</update>

	<insert id="insert" parameterType="com.djb.domain.sell.SellerRevenue">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
		INSERT INTO Du_Seller_Revenue(
		Seller_Id
		,User_Id
		,Deal_Type
		,Sub_Level
		,Consume_Time
		,Consume_Amount
		,Percentage
		,Status
		,Delete_Flag
		,Create_User_Id
		,Create_Time
		,Update_User_Id
		,Update_Time
		)
		VALUES(
		#{agentSeller.id}
		,#{agentUser.id}
		,#{dealType}
		,#{subLevel}
		,#{consumeTime}
		,#{consumeAmount}
		,#{percentage}
		,#{status}
		,#{deleteFlag}
		,#{createUserId}
		,#{createDateTime}
		,#{updateUserId}
		,#{updateDateTime}
		)
	</insert>

	<delete id="deleteByPrimaryKey">
		DELETE FROM Du_Seller_Revenue
		WHERE id = #{id}
	</delete>

	<sql id="findRevenueByQueryBeanRef">
		FROM Du_Seller_Revenue revenue
		WHERE delete_flag=0
		<if test="sellerId != null">AND
			Seller_Id = #{sellerId}
		</if>
		<if test="dealType != null">AND
			Deal_Type = #{dealType}
		</if>
		<if test="startTime != null">
			AND Consume_Time &gt;= #{startTime}
		</if>
		<if test="endTime != null">
			AND Consume_Time &lt;= #{endTime}
		</if>
		<if test="status != null">
			AND Status = #{status}
		</if>
		<if test="minPrice != null">
			AND Percentage &gt;= #{minPrice}
		</if>
		<if test="maxPrice != null">
			AND Percentage &lt;= #{maxPrice}
		</if>
		<if test="consumeMonth != null">
			AND date_format(consume_time, '%Y%m%d')=#{consumeMonth}
		</if>
		<if test="provinceId != null || cityId != null || mobilephone != null">
			AND
			EXISTS(
			SELECT 1
			FROM Du_User duUser
			WHERE duUser.Delete_Flag = 0
			AND duUser.Id = revenue.User_Id
			<if test="provinceId != null">
				AND duUser.Province = #{provinceId}
			</if>
			<if test="cityId != null">
				AND duUser.City = #{cityId}
			</if>
			<if test="mobilephone != null">
				AND duUser.User_Name = #{mobilephone}
			</if>
			)
		</if>
	</sql>

	<select id="findRevenueByQueryBean" parameterType="com.djb.domain.sell.RevenueQueryBean"
		resultMap="sellerRevenue">
		SELECT revenue.* 
		<include refid="findRevenueByQueryBeanRef" />
		<if test="orderByProperties != null">
			ORDER BY ${orderByFiled}
		</if>
		<if test="orderByProperties == null">
			ORDER BY revenue.create_time DESC
		</if>
		LIMIT ${startIndex}, ${pageSize}
	</select>

	<select id="getCountByQueryBean" parameterType="com.djb.domain.sell.RevenueQueryBean"
		resultType="int">
		SELECT count(*)
		<include refid="findRevenueByQueryBeanRef" />
	</select>

	<select id="findChartsByQueryBean" parameterType="com.djb.domain.sell.RevenueQueryBean"
		resultMap="sellerRevenue">
		SELECT groupTime as consume_time,SUM(percentage) as percentage
		FROM(
		SELECT date(consume_time) as groupTime,percentage
		FROM Du_Seller_Revenue
		WHERE Consume_Time &gt;= #{startTime}
		AND Consume_Time &lt;= #{endTime}
		AND seller_id = #{sellerId}
		) AS t
		GROUP BY groupTime
	</select>

	<sql id="findSettlementByQueryBeanRef">
		FROM
		(SELECT Consume_MONTH, seller_Id,sum(consume_Amount)as consume_Amount,
		SUM(percentage) as percentage,status
		FROM (
		SELECT date_format(consume_time, '%Y%m%d') as
		Consume_MONTH,seller_Id,consume_Amount,percentage,status
		FROM Du_Seller_Revenue
		) as t
		GROUP BY Consume_MONTH,seller_Id,status) as t2

		WHERE Consume_MONTH=#{consumeMonth}
		<if test="status != null">
			AND status=#{status}
		</if>
		<if test="trueName != null || mobilephone != null">
			AND EXISTS(
			SELECT 1
			FROM Du_Agent_Seller seller
			WHERE seller.Delete_Flag=0
			<if test="trueName != null">
				AND seller.True_Name like '%${trueName}%'
			</if>
			<if test="mobilephone != null">
				AND seller.mobilephone=#{mobilephone}
			</if>
			AND seller.id=t2.seller_Id
			)
		</if>

	</sql>

	<select id="findSettlementByQueryBean" parameterType="com.djb.domain.sell.RevenueQueryBean"
		resultMap="sellerRevenue">
		SELECT t2.*
		<include refid="findSettlementByQueryBeanRef" />
		<if test="orderByProperties != null">
			ORDER BY ${orderByFiled}
		</if>
		<if test="orderByProperties == null">
			ORDER BY t2.Consume_Month DESC
		</if>
		LIMIT ${startIndex}, ${pageSize}
	</select>

	<select id="getSettlementCountByQueryBean" parameterType="com.djb.domain.sell.RevenueQueryBean"
		resultType="int">
		SELECT count(*)
		<include refid="findSettlementByQueryBeanRef" />
	</select>
</mapper>
==================================== END sell/SellerRevenue.xml =========================


==================================== BEGIN sell/SellerWithdrawal.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="SellerWithdrawal">

 <resultMap id="sellerWithdrawal" type="com.djb.domain.sell.SellerWithdrawal"
  extends="DomainObject.domainObject">
  <result property="agentSeller.id" column="Seller_Id" />
  <result property="drawalAmount" column="Drawal_Amount" />
  <result property="commission" column="Commission" />
  <result property="applyTime" column="Apply_Time" />
  <result property="status" column="Status" />
  <result property="remittanceTime" column="Remittance_Time" />
  <result property="payVoucher" column="Pay_Voucher" />
  <result property="bankAccounts" column="Bank_Accounts" />
 </resultMap>

 <select id="load" resultMap="sellerWithdrawal">
  SELECT *
  FROM Du_Seller_Withdrawal
  WHERE id = #{id}
  AND delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.sell.SellerWithdrawal">
  UPDATE Du_Seller_Withdrawal
  SET
  Seller_Id=#{agentSeller.id}
  ,Drawal_Amount=#{drawalAmount}
  ,Commission=#{commission}
  ,Apply_Time=#{applyTime}
  ,Status=#{status}
  ,Remittance_Time=#{remittanceTime}
  ,Pay_Voucher=#{payVoucher}
  ,Bank_Accounts=#{bankAccounts}
  ,Delete_Flag=#{deleteFlag}
  ,Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime}
  WHERE id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.sell.SellerWithdrawal">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO Du_Seller_Withdrawal(
  Seller_Id
  ,Drawal_Amount
  ,Commission
  ,Apply_Time
  ,Status
  ,Remittance_Time
  ,Pay_Voucher
  ,Bank_Accounts
  ,Delete_Flag
  ,Create_User_Id
  ,Create_Time
  ,Update_User_Id
  ,Update_Time
  )
  VALUES(
  #{agentSeller.id}
  ,#{drawalAmount}
  ,#{commission}
  ,#{applyTime}
  ,#{status}
  ,#{remittanceTime}
  ,#{payVoucher}
  ,#{bankAccounts}
  ,#{deleteFlag}
  ,#{createUserId}
  ,#{createDateTime}
  ,#{updateUserId}
  ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey">
  DELETE FROM Du_Seller_Withdrawal
  WHERE id = #{id}
 </delete>

 <sql id="findWithdrawalByQueryBeanRef">
  FROM Du_Seller_Withdrawal withdrawal
  WHERE withdrawal.delete_flag=0
  <if test="sellerId != null">
   AND withdrawal.seller_Id=#{sellerId}
  </if>
  <if test="startTime != null">
   AND withdrawal.Apply_Time &gt;= #{startTime}
  </if>
  <if test="endTime != null">
   AND withdrawal.Apply_Time &lt;= #{endTime}
  </if>
  <if test="bankAccounts != null">
   AND withdrawal.Bank_Accounts like '%${bankAccounts}%'
  </if>
  <if test="status != null">
   AND withdrawal.status= #{status}
  </if>
  <if test="provinceId != null || trueName != null || mobilephone != null">
   AND
   EXISTS(
   SELECT 1
   FROM Du_Agent_Seller seller
   WHERE seller.Delete_Flag = 0
   AND seller.Id = withdrawal.Seller_Id
   <if test="provinceId != null">
    AND seller.Province = #{provinceId}
   </if>
   <if test="trueName != null">
    AND seller.True_Name = #{trueName}
   </if>
   <if test="mobilephone != null">
    AND seller.mobilephone = #{mobilephone}
   </if>
   )
  </if>

 </sql>

 <select id="findWithdrawalByQueryBean" parameterType="com.djb.domain.sell.WithdrawalQueryBean"
  resultMap="sellerWithdrawal">
  SELECT withdrawal.*
  <include refid="findWithdrawalByQueryBeanRef" />
  <if test="orderByProperties != null">
   ORDER BY ${orderByFiled}
  </if>
  <if test="orderByProperties == null">
   ORDER BY withdrawal.create_time DESC
  </if>
  LIMIT ${startIndex}, ${pageSize}
 </select>

 <select id="getCountByQueryBean" parameterType="com.djb.domain.sell.WithdrawalQueryBean"
  resultType="int">
  SELECT count(*)
  <include refid="findWithdrawalByQueryBeanRef" />
 </select>
</mapper>
==================================== END sell/SellerWithdrawal.xml =========================


==================================== BEGIN weixin/WeixinTender.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Fri Apr 26 16:03:22 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="WeixinTender">
 <resultMap id="tenderDetail" type="com.djb.domain.weixin.WeixinTender">
  <result property="id" column="Id"/>
  <result property="contactName" column="Contact_Name"/>
  <result property="totalPrice.id" column="Total_Price"/>
  <result property="province.id" column="Applicant_Province"/>
  <result property="city.id" column="Applicant_City"/>
  <result property="district.id" column="Applicant_District"/>
  <result property="insuredSex" column="Insured_Sex"/>
  <result property="insuredBirthday" column="Insured_Birthday"/>
  <result property="hasSocialInsurance" column="Has_Social_Insurance"/>
  <result property="remark" column="Remark"/>
  <result property="totalPriceName" column="totalPriceName"/>
  <result property="insuredRelName" column="insuredRelName"/>
  <result property="provinceName" column="provinceName"/>
  <result property="cityName" column="cityName"/>
  <result property="districtName" column="districtName"/>
  <result property="isOpenPhone" column="Is_Open_Phone"/>
  <association property="tenderFeatures" select="WeixinTender.findTenderFeatures" column="Id"/>
 </resultMap>
 
 <select id="findMyTender" parameterType="map"  resultMap="tenderDetail">
  SELECT tender.Id,
         tender.Contact_Name,
         tender.Insured_Relative,
         tender.Total_Price,
         tender.Applicant_Province,
         tender.Applicant_City,
         tender.Applicant_District,
         tender.Insured_Sex,
         tender.Insured_Birthday,
         tender.Has_Social_Insurance,
         tender.Remark,
         tender.Mobilephone,
         tender.Is_Open_Phone,
         smEnum.Enum_Value as totalPriceName,
         smEnum2.Enum_Value as insuredRelName,
         Province.city_Name as provinceName,
         City.city_Name as cityName,
         District.city_Name as districtName
     FROM  Dp_Tender_Dispatch_Record record
     LEFT  JOIN Dp_Personal_Tender tender ON record.Tender_Id = tender.Id
     LEFT  JOIN Sm_Enum smEnum ON smEnum.Id=tender.Total_Price AND smEnum.Delete_Flag = 0
   LEFT  JOIN Sm_Enum smEnum2 ON smEnum2.Id=tender.Insured_Relative AND smEnum.Delete_Flag = 0
   LEFT  JOIN Sm_City Province ON Province.Id=tender.Applicant_Province AND Province.Delete_Flag = 0
   LEFT  JOIN Sm_City City ON City.Id=tender.Applicant_City AND City.Delete_Flag = 0
   LEFT  JOIN Sm_City District ON District.Id=tender.Applicant_District AND District.Delete_Flag = 0
       WHERE record.Agent_Id = #{agentId}
         AND record.delete_flag = 0
      AND record.status &lt; (case when record.type = 1 then 10 when record.type = 2 then 20 end)
        AND  record.type = 1
        AND  tender.Id Is Not Null
        ORDER BY record.Create_Time DESC
        LIMIT ${startIndex}, ${pageSize}
 </select>
 
 <select id="findTenderById" parameterType="map" resultMap="tenderDetail">
  SELECT tender.Id,
         tender.Contact_Name,
         tender.Insured_Relative,
         tender.Total_Price,
         tender.Applicant_Province,
         tender.Applicant_City,
         tender.Applicant_District,
         tender.Insured_Sex,
         tender.Insured_Birthday,
         tender.Has_Social_Insurance,
         tender.Remark,
         tender.Mobilephone,
         tender.Is_Open_Phone,
         smEnum.Enum_Value as totalPriceName,
         smEnum2.Enum_Value as insuredRelName,
         Province.city_Name as provinceName,
         City.city_Name as cityName,
         District.city_Name as districtName
    FROM Dp_Personal_Tender tender
  LEFT JOIN Sm_Enum smEnum ON smEnum.Id=tender.Total_Price AND smEnum.Delete_Flag = 0
  LEFT JOIN Sm_Enum smEnum2 ON smEnum2.Id=tender.Insured_Relative AND smEnum.Delete_Flag = 0
  LEFT JOIN Sm_City Province ON Province.Id=tender.Applicant_Province AND Province.Delete_Flag = 0
  LEFT JOIN Sm_City City ON City.Id=tender.Applicant_City AND City.Delete_Flag = 0
  LEFT JOIN Sm_City District ON District.Id=tender.Applicant_District AND District.Delete_Flag = 0
      WHERE tender.Id=#{tenderId}
        AND EXISTS(
          SELECT 1 
            FROM Dp_Tender_Dispatch_Record record
            WHERE tender.Id=record.Tender_Id
             AND record.Agent_Id=#{agentId}
        )
 </select>
 
 <select id="findTenderFeatures" parameterType="string" resultType="com.djb.domain.weixin.InsuranceFeature">
  SELECT  DP_IF.Id,DP_IF.name,DP_IF.parent_Id,Classify.name as parentName
    FROM Dp_Insurance_Feature DP_IF 
   INNER JOIN  Dp_Tender_Feature TF ON DP_IF.id = TF.Insurance_Feature_Id 
    LEFT JOIN  Dp_Insurance_Classify Classify ON DP_IF.Parent_Id = Classify.Id AND Classify.Delete_flag=0
   WHERE TF.Tender_Id = #{tenderId} 
     AND TF.delete_flag = '0' 
 </select>
 
</mapper>
==================================== END weixin/WeixinTender.xml =========================


==================================== BEGIN weixin/AgentWeixin.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Fri Apr 26 16:03:14 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="AgentWeixin">

 <resultMap id="agentWeixin" type="com.djb.domain.weixin.AgentWeixin">
  <result property="id" column="id"/> 
  <result property="userId" column="User_Id"/>
  <result property="openId" column="Open_Id"/>
  <result property="createUserId" column="create_user_id"/>
    <result property="createDateTime" column="create_time"/>
    <result property="updateUserId" column="update_user_id"/>
    <result property="updateDateTime" column="update_time"/>
    <result property="deleteFlag" column="delete_flag"/>
 </resultMap>

 <select id="load" resultMap="agentWeixin">
  SELECT  *
    FROM  Du_Agent_Weixin
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>
 
 <select id="loadByOpenId" parameterType="map" resultMap="agentWeixin">
  SELECT  *
    FROM  Du_Agent_Weixin
   WHERE  delete_flag='0' 
    <if test="openId != null and openId != ''">
    AND Open_Id=#{openId}
    </if>
 </select>

 <select id="loadByUserId" parameterType="map" resultMap="agentWeixin">
  SELECT  *
    FROM  Du_Agent_Weixin
   WHERE  delete_flag='0' 
    <if test="userId != null and userId != ''">
    AND User_Id=#{userId}
    </if>
 </select>
 
 <update id="update" parameterType="com.djb.domain.weixin.AgentWeixin">
  UPDATE  Du_Agent_Weixin
     SET  
   User_Id=#{userId}
   ,Open_Id=#{openId}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   WHERE  id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.weixin.AgentWeixin">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Du_Agent_Weixin(
   User_Id
   ,Open_Id
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{userId}
   ,#{openId}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey">
  DELETE FROM  Du_Agent_Weixin
        WHERE  id = #{id}
 </delete>
</mapper>
==================================== END weixin/AgentWeixin.xml =========================


==================================== BEGIN contract/Package.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:23:23 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="Package">
 <resultMap id="contractPackage" type="com.djb.domain.contract.Package" extends="DomainObject.domainObject">
  <result property="packageName" column="Package_Name"/>
  <result property="packagePrice" column="Package_price"/>
  <result property="packageStatus" column="Package_status"/>
  <result property="policyNum" column="Policy_Num"/>
  <result property="policyRecommendNum" column="Policy_Recommend_Num"/>
  <result property="policyRefreshNum" column="Policy_Refresh_Num"/>
  <result property="agentServiceAreaNum" column="Agent_Service_Area_Num"/>
  <result property="agentSpecialtyNum" column="Agent_Specialty_Num"/>
  <result property="phoneTenderNum" column="Phone_Tender_Num"/>
  <result property="emailTenderNum" column="Email_Tender_Num"/>
  <result property="availableForAgent" column="Available_For_Agent"/>
  <result property="serviceMonths" column="Service_Months"/>
  <result property="remark" column="Remark"/>
  <result property="chargeType" column="Charge_Type"/>
  <result property="unit" column="Unit"/>
 </resultMap>
 
 <select id="load" resultMap="contractPackage">
  SELECT *
    FROM sm_Package
   WHERE id = #{id} 
    AND delete_flag = '0'
 </select>
 
 <select id="getAll" resultMap="contractPackage">
  SELECT *
    FROM sm_Package
   WHERE delete_flag = '0'
 ORDER BY Id
 </select>
 
 <delete id="deleteByPrimaryKey">
  DELETE FROM
      sm_Package
   WHERE
      id = #{id}
 </delete>
 
 <select id="findPackageByScenario" parameterType="java.util.HashMap" resultMap="contractPackage">
   SELECT pkg.*
    FROM Sm_Package_Area area
    LEFT JOIN sm_Package pkg ON area.Package_Id = pkg.id
   WHERE pkg.delete_flag = 0
     AND area.delete_flag = 0
   
     AND pkg.Available_For_Agent in 
     <foreach collection="scenarioList" item="item" separator="," close=")" open="(">
      #{item}
    </foreach>
     AND area.Service_Province = #{province.id}
    <if test="scenario == 1">
     AND pkg.id != 6
    </if>
   
 </select>
 
 <select id="findBackingPack" parameterType="java.util.HashMap" resultMap="contractPackage">
  SELECT pkg.*
    FROM Sm_Package_Area area
    LEFT JOIN sm_Package pkg ON area.Package_Id = pkg.id
   WHERE pkg.delete_flag = 0
   <if test="province != null">
     AND area.Service_Province = #{province.id}
   </if>
 </select>
</mapper>
==================================== END contract/Package.xml =========================


==================================== BEGIN contract/ContractAgent.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:23:23 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="ContractAgent">
 <resultMap id="contractAgent" type="com.djb.domain.contract.ContractAgent" extends="DomainObject.domainObject">
  <result property="contract.id" column="Contract_Id"/>
  <result property="status" column="Status"/>
  <result property="customer.id" column="Customer_Id"/>
  <result property="contractPackage.id" column="Package_Id"/>
  <result property="packageStartTime" column="Package_Start_Time"/>
  <result property="packageEndTime" column="Package_End_Time"/>
  <result property="remark" column="Remark"/>
  <result property="mark" column="Mark"/>
 </resultMap>
 
 <select id="load" resultMap="contractAgent">
  SELECT *
    FROM Sm_Contract_Agent
   WHERE id = #{id} 
    AND delete_flag = '0'
 </select>
 
 <select id="findCurrentContractByAgent" parameterType="long" resultMap="contractAgent">
  SELECT ca.*
    FROM Sm_Contract_Agent ca
 LEFT JOIN sm_Package pack on ca.Package_Id = pack.Id and pack.delete_flag = 0
   WHERE ca.Customer_Id = #{agentId} 
     AND ca.Status = 30
    AND ca.delete_flag = 0
 </select>
 
 <select id="findByContract" parameterType="long" resultMap="contractAgent">
  SELECT *
    FROM Sm_Contract_Agent
   WHERE delete_flag = 0
     AND contract_id = #{contractId}
 </select>
 
 <select id="findByAgentAndStatus" parameterType="java.util.HashMap" resultMap="contractAgent">
  SELECT *
    FROM Sm_Contract_Agent
   WHERE delete_flag = 0
     AND Customer_Id = #{agentId} 
     
     AND Status in
      <foreach collection="statusList" item="item" separator="," close=")" open="(">
      #{item}
    </foreach>
     
 </select>
 
 <select id="findLatestContract" parameterType="long" resultMap="contractAgent">
  SELECT *
    FROM Sm_Contract_Agent
   WHERE delete_flag = 0
     AND Package_End_Time IS NOT NULL
     AND Customer_Id = #{agentId}
     AND Status = 40
   ORDER BY Package_End_Time DESC
   LIMIT  1
 </select>
 
 <select id="getAll" resultMap="contractAgent">
  SELECT *
    FROM Sm_Contract_Agent
   WHERE delete_flag = '0'
 ORDER BY Id
 </select>
 
 <select id="findUnmarkList" parameterType="com.djb.domain.contract.ContractQueryBean" resultMap="contractAgent">
  SELECT *
    FROM Sm_Contract_Agent SCA
    LEFT JOIN Sm_Contract CTR ON SCA.Contract_Id = CTR.Id
    LEFT JOIN Du_Agent_Detail AGENT ON SCA.Customer_Id = AGENT.Id
   WHERE SCA.delete_flag = 0
     AND  CTR.delete_flag = 0
     AND  AGENT.delete_flag = 0
     AND SCA.status = 30
     AND SCA.Mark is null
     AND SCA.Package_Start_Time &gt; '2013-02-28'
     
      <if test="status != null and status != ''">
    AND SCA.Status = ${status}
   </if>
   <if test="customizedKey != null and customizedKey != ''">
    <if test="customizedKey == 1">
     AND CTR.Contract_No = '${customizedValue}'
    </if>
    <if test="customizedKey == 2">
     AND AGENT.Mobilephone = '${customizedValue}'
    </if>
    <if test="customizedKey == 3">
     AND AGENT.True_Name = '${customizedValue}'
    </if>
   </if>
      <if test="provinceId != null">AND
    CTR.Province_Id = #{provinceId}
   </if>
   <if test="cityId != null">AND
    CTR.City_Id = #{cityId}
   </if>
   <if test="districtId != null">AND
    CTR.District_Id = #{districtId}
   </if>
     
   ORDER BY SCA.Package_Start_Time
 </select>
 
 <insert id="insert" parameterType="com.djb.domain.contract.ContractAgent">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO
   Sm_Contract_Agent(
    Contract_Id       
    ,Customer_Id       
    ,Status       
    ,Package_Id       
    ,Package_Start_Time       
    ,Package_End_Time       
    ,Remark   
    ,Mark    
    ,Delete_Flag       
    ,Create_User_Id       
    ,Create_Time       
    ,Update_User_Id       
    ,Update_Time       
   ) VALUES (
    #{contract.id}
    ,#{customer.id}
    ,#{status}
    ,#{contractPackage.id}
    ,#{packageStartTime}
    ,#{packageEndTime}
    ,#{remark}
    ,#{mark}
    ,#{deleteFlag}
    ,#{createUserId}
    ,#{createDateTime}
    ,#{updateUserId}
    ,#{updateDateTime}
   )
   
  
 </insert>
 
 <update id="update" parameterType="com.djb.domain.contract.ContractAgent">
  UPDATE Sm_Contract_Agent
     SET
        Contract_Id = #{contract.id}
      ,Customer_Id = #{customer.id}
      ,Status = #{status}
      ,Package_Id = #{contractPackage.id}
      ,Package_Start_Time = #{packageStartTime}
      ,Package_End_Time = #{packageEndTime}
      ,Remark = #{remark}
      ,Mark = #{mark}
      ,Delete_Flag = #{deleteFlag}
      ,Create_User_Id = #{createUserId}
      ,Create_Time = #{createDateTime}
      ,Update_User_Id = #{updateUserId}
      ,Update_Time = #{updateDateTime}
   WHERE Id = #{id}
 </update>
 
 <update id="updatePack" parameterType="java.util.HashMap">
  UPDATE Sm_Contract_Agent
     SET
        Package_Id = #{packageId}
        ,Update_User_Id = #{updateUserId}
      ,Update_Time = now()
   WHERE Contract_Id = #{contractId}
 </update>
 
 <select id="getContractCount" parameterType="com.djb.domain.contract.ContractQueryBean" resultType="int">
  SELECT count(SCA.id)
    FROM Sm_Contract_Agent SCA
    LEFT JOIN Sm_Contract CTR ON SCA.Contract_Id = CTR.Id
    LEFT JOIN Du_Agent_Detail AGENT ON SCA.Customer_Id = AGENT.Id
    WHERE SCA.Delete_Flag = 0
    AND CTR.Delete_Flag = 0
    AND AGENT.Delete_Flag = 0 
    
   <if test="status != null and status != ''">
    AND SCA.Status = ${status}
   </if>
   <if test="customizedKey != null and customizedKey != ''">
    <if test="customizedKey == 1">
     AND CTR.Contract_No = '${customizedValue}'
    </if>
    <if test="customizedKey == 2">
     AND AGENT.Mobilephone = '${customizedValue}'
    </if>
    <if test="customizedKey == 3">
     AND AGENT.True_Name = '${customizedValue}'
    </if>
   </if>
   <if test="provinceId != null">AND
    CTR.Province_Id = #{provinceId}
   </if>
   <if test="cityId != null">AND
    CTR.City_Id = #{cityId}
   </if>
   <if test="districtId != null">AND
    CTR.District_Id = #{districtId}
   </if>
  
 </select>
 
 <select id="queryContractCount" parameterType="com.djb.domain.contract.ContractQueryBean" resultType="int">
  SELECT count(distinct(SCA.id))
    FROM Sm_Contract_Agent SCA
    LEFT JOIN Sm_Contract CTR ON SCA.Contract_Id = CTR.Id
    LEFT JOIN Du_Agent_Detail AGENT ON SCA.Customer_Id = AGENT.Id
    LEFT JOIN Sm_Pay_Record PAY on SCA.Id = PAY.Order_Id
    WHERE SCA.Delete_Flag = 0
    AND CTR.Delete_Flag = 0
    AND AGENT.Delete_Flag = 0 
    
   <if test="status != null and status != ''">
    <if test="status == 1">
     AND SCA.Status = 10
    </if>
    <if test="status == 2">
     AND SCA.Status in (20,30)
    </if>
   </if>
   <if test="customizedKey != null and customizedKey != ''">
    <if test="customizedKey == 1">
     AND CTR.Contract_No = '${customizedValue}'
    </if>
    <if test="customizedKey == 2">
     AND AGENT.Mobilephone = '${customizedValue}'
    </if>
    <if test="customizedKey == 3">
     AND PAY.Pay_Sequence = '${customizedValue}'
    </if>
   </if>
  
 </select>
 
 <select id="getContracts" parameterType="com.djb.domain.contract.ContractQueryBean" resultMap="contractAgent">
  SELECT SCA.*
        FROM Sm_Contract_Agent SCA
        LEFT JOIN Sm_Contract CTR ON SCA.Contract_Id = CTR.Id
        LEFT JOIN Du_Agent_Detail AGENT ON SCA.Customer_Id = AGENT.Id
       WHERE SCA.Delete_Flag = 0
        AND CTR.Delete_Flag = 0
        AND AGENT.Delete_Flag = 0
       
     <if test="status != null and status != ''">
      AND SCA.Status = ${status}
     </if>
     <if test="customizedKey != null and customizedKey != ''">
      <if test="customizedKey == 1">
       AND CTR.Contract_No = '${customizedValue}'
      </if>
      <if test="customizedKey == 2">
       AND AGENT.Mobilephone = '${customizedValue}'
      </if>
      <if test="customizedKey == 3">
       AND AGENT.True_Name = '${customizedValue}'
      </if>
     </if>
     <if test="provinceId != null">AND
      CTR.Province_Id = #{provinceId}
     </if>
     <if test="cityId != null">AND
      CTR.City_Id = #{cityId}
     </if>
     <if test="districtId != null">AND
      CTR.District_Id = #{districtId}
     </if> 
      ORDER BY SCA.Create_Time DESC
      LIMIT ${startIndex}, ${pageSize}
 </select>
 
 <select id="queryContracts" parameterType="com.djb.domain.contract.ContractQueryBean" resultMap="contractAgent">
   SELECT distinct SCA.*
        FROM Sm_Contract_Agent SCA
        LEFT JOIN Sm_Contract CTR ON SCA.Contract_Id = CTR.Id
        LEFT JOIN Du_Agent_Detail AGENT ON SCA.Customer_Id = AGENT.Id
        LEFT JOIN Sm_Pay_Record PAY on SCA.Id = PAY.Order_Id
       WHERE SCA.Delete_Flag = 0
        AND CTR.Delete_Flag = 0
        AND AGENT.Delete_Flag = 0
       
     <if test="status != null and status != ''">
      <if test="status == 1">
      AND SCA.Status = 10
     </if>
     <if test="status == 2">
      AND SCA.Status in (20,30)
     </if>
     </if>
     <if test="customizedKey != null and customizedKey != ''">
      <if test="customizedKey == 1">
       AND CTR.Contract_No = '${customizedValue}'
      </if>
      <if test="customizedKey == 2">
       AND AGENT.Mobilephone = '${customizedValue}'
      </if>
      <if test="customizedKey == 3">
       AND PAY.Pay_Sequence = '${customizedValue}'
      </if>
     </if>
      ORDER BY SCA.Create_Time DESC
      LIMIT ${startIndex}, ${pageSize}
 </select>
 
 <select id="getValidateContractAgent" resultMap="contractAgent">
  SELECT *
    FROM Sm_Contract_Agent
   WHERE contract_id in (SELECT  id FROM Sm_Contract
WHERE Contract_No=#{contarctNo})
    AND  delete_flag = '0'
    AND status &lt;=30
    AND status &gt;=20
 </select>
</mapper>
==================================== END contract/ContractAgent.xml =========================


==================================== BEGIN contract/Contract.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:23:22 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="Contract">
 <resultMap id="contract" type="com.djb.domain.contract.Contract" extends="DomainObject.domainObject">
  <result property="contractNo" column="Contract_No"/>
  <result property="contractPackage.id" column="Package_Id"/>
  <result property="contractType" column="Contract_Type"/>
  <result property="status" column="Contract_Status"/>
  <result property="createType" column="Create_Type"/>
  <result property="payType" column="Pay_Type"/>
  <result property="customer.id" column="Customer_Id"/>
  <result property="seller.id" column="Sign_User_Id"/>
  <result property="signTime" column="Sign_Time"/>
  <result property="contractStartTime" column="Contract_Start_Time"/>
  <result property="contractEndTime" column="Contract_End_Time"/>
  <result property="agentNum" column="Agent_Num"/>
  <result property="contractPrice" column="Contract_Price"/>
  <result property="contractOpenType" column="Contract_Renewal_Type"/>
  <result property="serviceMonth" column="Service_Month"/>
  <result property="remark" column="Remark"/>
  <result property="province.id" column="Province_Id"/>
  <result property="city.id" column="City_Id"/>
  <result property="district.id" column="District_Id"/>
  <result property="largess" column="Largess"/>
 </resultMap>
 
 <select id="load" resultMap="contract">
  SELECT *
    FROM Sm_Contract
   WHERE id = #{id} 
    AND delete_flag = '0'
 </select>
 
 <select id="getAll" resultMap="contract">
  SELECT *
    FROM Sm_Contract
   WHERE delete_flag = '0'
 ORDER BY Id
 </select>
 
 <insert id="insert" parameterType="com.djb.domain.contract.Contract">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO
   Sm_Contract(
    Contract_No       
    ,Package_Id       
    ,Contract_Type       
    ,Contract_Status       
    ,Create_Type       
    ,Pay_Type       
    ,Customer_Id
    ,Sign_User_Id       
    ,Sign_Time       
    ,Contract_Start_Time       
    ,Contract_End_Time   
    ,Service_Month 
    ,Agent_Num       
    ,Contract_Price
    ,Contract_Renewal_Type
    ,Province_Id
    ,City_Id
    ,District_Id
    ,Remark
    ,Largess
    ,Delete_Flag       
    ,Create_User_Id       
    ,Create_Time       
    ,Update_User_Id       
    ,Update_Time       
   ) VALUES (
    #{contractNo}
    ,#{contractPackage.id}
    ,#{contractType}
    ,#{status}
    ,#{createType}
    ,#{payType}
    ,#{customer.id}
    ,#{seller.id}
    ,#{signTime}
    ,#{contractStartTime}
    ,#{contractEndTime}
    ,#{serviceMonth}
    ,#{agentNum}
    ,#{contractPrice}
    ,#{contractOpenType}
    ,#{province.id}
    ,#{city.id}
    ,#{district.id}
    ,#{remark}
    ,#{largess}
    ,#{deleteFlag}
    ,#{createUserId}
    ,#{createDateTime}
    ,#{updateUserId}
    ,#{updateDateTime}
   )
 </insert>
 
 <update id="update" parameterType="com.djb.domain.contract.Contract">
  UPDATE Sm_Contract
     SET
        Contract_No = #{contractNo}
      ,Package_Id = #{contractPackage.id}
      ,Contract_Type = #{contractType}
      ,Contract_Status = #{status}
      ,Create_Type = #{createType}
      ,Pay_Type = #{payType}
      ,Customer_Id = #{customer.id}
      ,Sign_User_Id = #{seller.id}
      ,Sign_Time = #{signTime}
      ,Contract_Start_Time = #{contractStartTime}
      ,Contract_End_Time = #{contractEndTime}
      ,Service_Month = #{serviceMonth}
      ,Agent_Num = #{agentNum}
      ,Contract_Price = #{contractPrice}
      ,Contract_Renewal_Type = #{contractOpenType}
      ,Province_Id=#{province.id}
      ,City_Id=#{city.id}
      ,District_Id=#{district.id}
      ,Remark = #{remark}
      ,Largess = #{largess}
      ,Delete_Flag = #{deleteFlag}
      ,Create_User_Id = #{createUserId}
      ,Create_Time = #{createDateTime}
      ,Update_User_Id = #{updateUserId}
      ,Update_Time = #{updateDateTime}
   WHERE Id = #{id}
 </update>
</mapper>
==================================== END contract/Contract.xml =========================


==================================== BEGIN InsuranceClassify.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:27:21 
 CST 2013 -->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="InsuranceClassify">

 <cache type="com.djb.cache.MemcachedCache">
  <property name="timeout" value="7200" />
 </cache>
 <resultMap id="insuranceClassify" type="com.djb.domain.InsuranceClassify"
  extends="DomainObject.domainObject">
  <result property="name" column="name" />
  <result property="value" column="value" />
  <result property="parentClassifyId" column="parent_id" />
  <result property="insuranceClassifyType" column="type" />
 </resultMap>

 <select id="load" resultMap="insuranceClassify">
  SELECT *
  FROM
  Dp_Insurance_Classify
  WHERE
  id=#{id}
  AND delete_flag='0'
 </select>

 <select id="getAll" resultMap="insuranceClassify">
  SELECT *
  FROM
  Dp_Insurance_Classify
  WHERE
  delete_flag='0'
 </select>

 <select id="loadByValue" resultMap="insuranceClassify">
  SELECT *
  FROM
  Dp_Insurance_Classify
  WHERE
  value=#{value}
  AND delete_flag='0'
 </select>

 <select id="loadRoot" resultMap="insuranceClassify">
  SELECT *
  FROM
  Dp_Insurance_Classify
  WHERE
  type=#{type}
  AND delete_flag = '0'
 </select>

 <select id="loadAllSubNote" resultMap="insuranceClassify">
  SELECT *
  FROM
  Dp_Insurance_Classify
  WHERE
  parent_id = #{parentClassifyId}
  AND delete_flag = '0'
 </select>

 <select id="findClassifyByTender" resultMap="insuranceClassify">
  SELECT * from
  Dp_Insurance_Classify
  WHERE Id in
  (SELECT Parent_Id FROM Dp_Insurance_Feature WHERE Id in
  (SELECT Insurance_Feature_Id FROM Dp_Tender_Feature WHERE Tender_Id =
  #{tenderId}))
 </select>

 <update id="update" parameterType="com.djb.domain.InsuranceClassify">
  UPDATE Dp_Insurance_Classify
  set
  name=#{name},
  value=#{value},
  type=#{insuranceClassifyType}

  <if test="parentClassifyId != null">,parent_id=#{parentClassifyId}</if>
  ,
  update_user_id=#{updateUserId},
  update_time=#{updateDateTime},
  delete_flag=#{deleteFlag}
  WHERE id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.InsuranceClassify">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO
  Dp_Insurance_Classify(
  id,
  name,
  value,
  type

  <if test="parentClassifyId != null">,parent_id</if>
  ,
  create_user_id,
  create_time,
  update_user_id,
  update_time,
  delete_flag
  )
  VALUES(
  #{id},
  #{name},
  #{value},
  #{insuranceClassifyType}

  <if test="parentClassifyId != null">,#{parentClassifyId}</if>
  ,
  #{createUserId},
  #{createDateTime},
  #{updateUserId},
  #{updateDateTime},
  #{deleteFlag}
  )
 </insert>

 <delete id="removeAll">
  DELETE FROM Dp_Insurance_Classify
 </delete>

 <delete id="deleteAll">
  UPDATE Dp_Insurance_Classify
  SET
  delete_flag='1',
  update_time=#{updateDatetime},
  update_user_id=#{updateUserId}
 </delete>

 <delete id="deleteByPrimaryKey">
  DELETE FROM Dp_Insurance_Classify
  WHERE id=#{id}
 </delete>
 <select id="findClassifyByProgram" parameterType="map"
  resultMap="insuranceClassify">
  SELECT dpic.* FROM Dp_Insurance_Classify
  dpic,Dp_Program_Product dpp,Dp_Product dp
  WHERE dp.id=dpp.product_id
  AND dpic.id=dp.insurance_classify_id
  AND dpp.program_id=#{programId}
  AND dpp.Delete_Flag = 0
  AND dp.Delete_Flag = 0
  AND dpic.Delete_Flag=0
 </select>

</mapper>
==================================== END InsuranceClassify.xml =========================


==================================== BEGIN pay/PayRecord.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:16:30 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="PayRecord">
 <resultMap id="payRecord" type="com.djb.domain.pay.PayRecord" extends="DomainObject.domainObject">
  <result property="orderId" column="Order_Id"/>
  <result property="orderNo" column="Order_No"/>
  <result property="subject" column="Subject"/>
  <result property="body" column="Body"/>
  <result property="extraCommonParam" column="Extra_Common_Param"/>
  <result property="returnUrl" column="Return_Url"/>
  <result property="notifyUrl" column="Notify_Url"/>
  <result property="orderRemark" column="Order_Remark"/>
  <result property="payAmount" column="Pay_Amount"/>
  <result property="payStatus" column="Pay_Status"/>
  <result property="payType" column="Pay_Type"/>
  <result property="payFailedReason" column="Pay_Failed_Reason"/>
  <result property="payRemark" column="Pay_Remark"/>
  <result property="payChannel" column="Pay_Channel"/>
  <result property="payPlatform" column="Pay_Platform"/>
  <result property="paySequence" column="Pay_Sequence"/>
  <result property="payplatformSequence" column="Pay_Platform_Sequence"/>
  <result property="payBankSequence" column="Bank_Sequence"/>
  <result property="payPlatformRemark" column="Pay_Platform_Remark"/>
 </resultMap>
 
 <select id="load" resultMap="payRecord">
  SELECT *
    FROM Sm_Pay_Record
   WHERE id = #{id} 
    AND delete_flag = 0
 </select>
 
 <select id="getAll" resultMap="payRecord">
  SELECT *
    FROM Sm_Pay_Record
   WHERE delete_flag = 0
 ORDER BY Id desc
 </select>
 
 <select id="findByPaySequence" parameterType="string" resultMap="payRecord">
  SELECT *
    FROM Sm_Pay_Record
   WHERE Pay_Sequence = #{paySequence} 
     AND delete_flag = 0
 </select>
 
 <select id="getPayRecordByOrderId" parameterType="long" resultMap="payRecord">
  SELECT *
    FROM Sm_Pay_Record
   WHERE Order_Id = #{orderId} 
     AND delete_flag = 0
 </select>
 
 <select id="getPayRecordByOrderNo" parameterType="string" resultMap="payRecord">
  SELECT *
    FROM Sm_Pay_Record
   WHERE Order_No = #{orderNo} 
     AND delete_flag = 0
 </select>
 
 <insert id="insert" parameterType="com.djb.domain.pay.PayRecord">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO
   Sm_Pay_Record(
    Pay_Type       
    ,Order_Id
    ,Order_No
    ,Subject       
    ,Body       
    ,Extra_Common_Param       
    ,Return_Url       
    ,Notify_Url              
    ,Order_Remark       
    ,Pay_Amount       
    ,Pay_Status       
    ,Pay_Failed_Reason       
    ,Pay_Remark       
    ,Pay_Channel       
    ,Pay_Platform       
    ,Pay_Sequence       
    ,Pay_Platform_Sequence       
    ,Bank_Sequence       
    ,Pay_Platform_Remark       
    ,Delete_Flag       
    ,Create_User_Id       
    ,Create_Time       
    ,Update_User_Id       
    ,Update_Time       
   ) VALUES (
    #{payType}
    ,#{orderId}
    ,#{orderNo}
    ,#{subject}
    ,#{body}
    ,#{extraCommonParam}
    ,#{returnUrl}
    ,#{notifyUrl}
    ,#{orderRemark}
    ,#{payAmount}
    ,#{payStatus}
    ,#{payFailedReason}
    ,#{payRemark}
    ,#{payChannel}
    ,#{payPlatform}
    ,#{paySequence}
    ,#{payplatformSequence}
    ,#{payBankSequence}
    ,#{payPlatformRemark}
    ,#{deleteFlag}
    ,#{createUserId}
    ,#{createDateTime}
    ,#{updateUserId}
    ,#{updateDateTime}
   )
   
 </insert>
 
 <update id="update" parameterType="com.djb.domain.pay.PayRecord">
  UPDATE Sm_Pay_Record
     SET
        Pay_Type = #{payType}
      ,Order_Id = #{orderId}
      ,Order_No = #{orderNo}
      ,Subject = #{subject}
      ,Body = #{body}
      ,Extra_Common_Param = #{extraCommonParam}
      ,Return_Url = #{returnUrl}
      ,Notify_Url = #{notifyUrl}
      ,Order_Remark = #{orderRemark}
      ,Pay_Amount = #{payAmount}
      ,Pay_Status = #{payStatus}
      ,Pay_Failed_Reason = #{payFailedReason}
      ,Pay_Remark = #{payRemark}
      ,Pay_Channel = #{payChannel}
      ,Pay_Platform = #{payPlatform}
      ,Pay_Sequence = #{paySequence}
      ,Pay_Platform_Sequence = #{payplatformSequence}
      ,Bank_Sequence = #{payBankSequence}
      ,Pay_Platform_Remark = #{payPlatformRemark}
      ,Delete_Flag = #{deleteFlag}
      ,Create_User_Id = #{createUserId}
      ,Create_Time = #{createDateTime}
      ,Update_User_Id = #{updateUserId}
      ,Update_Time = #{updateDateTime}
   WHERE Id = #{id}
 </update>
</mapper>
==================================== END pay/PayRecord.xml =========================


==================================== BEGIN log/EmployeeOperation.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:19:25 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="EmployeeOperation">

 <resultMap id="employeeOperation" type="com.djb.domain.log.EmployeeOperation" extends="DomainObject.domainObject">
  <result property="employee.id" column="Employee_Id"/>
  <result property="operation" column="Operation"/>
  <result property="target" column="Target"/>
  <result property="targetId" column="Target_Id"/>
  <result property="memo" column="Memo"/>
 </resultMap>

 <select id="load" resultMap="employeeOperation">
  SELECT  *
    FROM  LG_EMP_OPERATION
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>
 
 <select id="findOperationLogByTarget" parameterType="com.djb.domain.log.EmployeeOperation" resultMap="employeeOperation">
  SELECT *
    FROM LG_EMP_OPERATION
   WHERE delete_flag = 0
   
   <if test="employee != null">
     AND Employee_Id = #{employee.id}
   </if>
   <if test="targetId != null">
     AND Target_Id = #{targetId}
   </if>
   <if test="operation != null">
     AND Operation = #{operation}
   </if>
   <if test="target != null">
     AND Target = #{target}
   </if>
   
 </select>

 <update id="update" parameterType="com.djb.domain.log.EmployeeOperation">
  UPDATE  LG_EMP_OPERATION
     SET  
   Employee_Id=#{employee.id}
   ,Operation=#{operation}
   ,Target=#{target}
   ,Target_Id=#{targetId}
   ,Memo=#{memo}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
  WHERE Id = #{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.log.EmployeeOperation">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  LG_EMP_OPERATION(
   Employee_Id
   ,Operation
   ,Target
   ,Target_Id
   ,Memo
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{employee.id}
   ,#{operation}
   ,#{target}
   ,#{targetId}
   ,#{memo}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
  
  
 </insert>

 <delete id="deleteByPrimaryKey">
  DELETE FROM  LG_EMP_OPERATION
        WHERE  id = #{id}
 </delete>
</mapper>
==================================== END log/EmployeeOperation.xml =========================


==================================== BEGIN help/HelpArticle.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:20:08 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="HelpArticle">
 <resultMap id="article" type="com.djb.domain.help.HelpArticle" extends="DomainObject.domainObject">
  <result property="orderId" column="Order_Id"/>
  <result property="category.id" column="Category_Id"/>
  <result property="viewStatus" column="View_Status"/>
  <result property="viewPosition" column="View_Position"/>
  <result property="foreignUrl" column="Foreign_Url"/>
  <result property="contentFile" column="Content_File"/>
  <result property="title" column="Article_Name"/>
  <result property="keyword" column="Keyword"/>
  <result property="summary" column="Summary"/>
 </resultMap>
 
 <select id="load" resultMap="article">
  SELECT * FROM Dp_Article
  WHERE id = #{id}
  AND delete_flag = '0'  
 </select>
 
 <select id="findAllarticle" resultMap="article">
  SELECT * FROM Dp_Article
  WHERE delete_flag = '0'  
 </select>
 
 <insert id="insert" parameterType="com.djb.domain.help.HelpArticle">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
   INSERT INTO 
    Dp_Article(
    order_id,
    category_id,
    view_status,
    view_position,
    Foreign_Url,       
    Content_File,       
    Article_Name,       
    Keyword,       
    Summary,       
    delete_flag,
    create_user_id,
    create_time,
    update_user_id,
    update_time
   )
   VALUES(
    #{orderId},
    #{category.id},
    #{viewStatus},
    #{viewPosition},
    #{foreignUrl},
    #{contentFile},
    #{title},
    #{keyword},
    #{summary},
    #{deleteFlag},
    #{createUserId},
    #{createDateTime},
    #{updateUserId},
    #{updateDateTime}
   )
   
      
 </insert>
 <update id="update" parameterType="com.djb.domain.help.HelpArticle">
 UPDATE
   Dp_Article
  SET
   order_id=#{orderId},
   category_id=#{category.id},
   view_status=#{viewStatus},
   view_position=#{viewPosition},
   Foreign_Url=#{foreignUrl},       
   Content_File=#{contentFile},       
   Article_Name=#{title},       
   Keyword=#{keyword},       
   Summary=#{summary},  
   Delete_Flag=#{deleteFlag},
   Create_User_Id=#{createUserId},
   Create_Time=#{createDateTime},
   Update_User_Id=#{updateUserId},
   Update_Time=#{updateDateTime}
 WHERE
   id = #{id}
 </update>
 
 <sql id="getArticlePageDataRef">
  FROM Dp_Article
  WHERE delete_flag = 0
  <if test="title != null and title != ''">
     AND Article_Name like '%${title}%'
  </if>
  <if test="category != null">
     AND Category_Id = #{category.id}
  </if>
 </sql>
 
 <select id="getArticleTotalCount" parameterType="com.djb.domain.help.ArticleQueryBean" resultType="int">
  SELECT COUNT(*) <include refid="getArticlePageDataRef"/>
 </select>
 
 <select id="getArticlePageData" parameterType="com.djb.domain.help.ArticleQueryBean" resultMap="article">
  SELECT * <include refid="getArticlePageDataRef"/>
  <if test="orderByProperties != null">
     ORDER BY ${orderByFiled} 
     </if>
 </select>
 
 <select id="getArticleAndCategory" parameterType="map" resultMap="article">
  SELECT query1.* 
   FROM (SELECT * 
    FROM Dp_Article as article
    WHERE article.Delete_Flag='0' 
    and article.View_Status=1
    and article.View_Position like '%${viewPosition}%') as query1
  LEFT JOIN (
    SELECT * 
    FROM Dp_Article_Category as category
    WHERE category.Delete_Flag='0'
    and category.View_Position like '%${viewPosition}%') as query2
    on query1.Category_Id=query2.Id
  ORDER BY query2.Order_Id,query1.Order_Id,query2.Create_Time desc,query1.Create_Time desc
 </select>
</mapper>
==================================== END help/HelpArticle.xml =========================


==================================== BEGIN help/ArticleCategory.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:20:08 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="ArticleCategory">
 <resultMap id="articleCategory" type="com.djb.domain.help.ArticleCategory" extends="DomainObject.domainObject">
  <result property="orderId" column="Order_Id"/>
  <result property="categoryName" column="Category_Name"/>
  <result property="viewStatus" column="View_Status"/>
  <result property="viewPosition" column="View_Position"/>
  <result property="level" column="Level"/>
  <result property="parent.id" column="Parent_Id"/>
 </resultMap>
 
 <select id="load" resultMap="articleCategory">
  SELECT * FROM Dp_Article_Category articleCategory 
  WHERE id = #{id}
  AND delete_flag = '0'  
 </select>
 
 <select id="getAllarticleCategory" resultMap="articleCategory">
  SELECT * FROM Dp_Article_Category articleCategory
  WHERE delete_flag = '0'
 </select>
  
 <insert id="insert" parameterType="com.djb.domain.help.ArticleCategory">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
   INSERT INTO 
    Dp_Article_Category(
    order_id,
    category_name,
    view_status,
    view_position,
    level,
    parent_id,
    delete_flag,
    create_user_id,
    create_time,
    update_user_id,
    update_time
   )
   VALUES(
    #{orderId},
    #{categoryName},
    #{viewStatus},
    #{viewPosition},
    #{level},
    #{parent.id},
    #{deleteFlag},
    #{createUserId},
    #{createDateTime},
    #{updateUserId},
    #{updateDateTime}
   )  
    
   
 </insert>
 
 <update id="update" parameterType="com.djb.domain.help.ArticleCategory">
 UPDATE
   Dp_Article_Category
  SET
   order_id=#{orderId},
   category_name=#{categoryName},
   view_status=#{viewStatus},
   view_position=#{viewPosition},
   level=#{level},
   parent_id=#{parent.id},
   Delete_Flag=#{deleteFlag},
   Create_User_Id=#{createUserId},
   Create_Time=#{createDateTime},
   Update_User_Id=#{updateUserId},
   Update_Time=#{updateDateTime}
 WHERE
   id = #{id}
 </update>
 
 <!-- 根据queryBean查找类别的数量 -->
 <select id="getCountByBean" parameterType="com.djb.domain.help.CategoryQueryBean" resultType="int">
  SELECT count(*) FROM Dp_Article_Category
  WHERE delete_flag = '0'
 </select>
 <!-- 根据queryBean查找所有符合条件的类别 -->
 <select id="findAllarticleCategory" parameterType="com.djb.domain.help.CategoryQueryBean" resultMap="articleCategory">
  SELECT * 
  FROM Dp_Article_Category
  WHERE delete_flag = '0' 
  ORDER BY Create_Time desc
  LIMIT ${startIndex}, ${pageSize}
 </select>
</mapper>
==================================== END help/ArticleCategory.xml =========================


==================================== BEGIN Company.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:27:19 
 CST 2013 -->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="Company">

 <cache type="com.djb.cache.MemcachedCache">
  <property name="timeout" value="7200" />
 </cache>
 <resultMap id="company" type="com.djb.domain.Company"
  extends="DomainObject.domainObject">
  <result property="companyName" column="Company_Name" />
  <result property="companyNickName" column="Company_Nick_Name" />
  <result property="companyNamePinyin" column="Company_Name_Pinyin" />
  <result property="companyLevel" column="Company_Level" />
  <result property="parentCompanyId" column="Parent_Company_Id" />
  <result property="status" column="Status" />
  <result property="displayOrder" column="Display_Order" />
  <result property="type" column="Company_Type" />
  <result property="servicePhoneNumber" column="Service_Phone_Number" />
  <result property="salesPhoneNumber" column="Sales_Phone_Number" />
  <result property="companyWebsite" column="Company_Website" />
  <result property="companyLogoPath" column="Company_Logo_Path" />
  <result property="companyClassify" column="Company_Classify" />
 </resultMap>


 <select id="load" resultMap="company">
  SELECT *
  FROM Sm_Company
  WHERE id = #{uuid}
  AND delete_flag = '0'
 </select>

 <select id="getAll" resultMap="company">
  SELECT *
  FROM
  Sm_Company
  WHERE
  delete_flag='0'
 </select>

 <select id="getTotalCount" resultType="int">
  SELECT count(*)
  FROM
  Sm_Company
  WHERE
  delete_flag='0'
 </select>

 <select id="findCompanyByName" resultMap="company">
  SELECT *
  FROM Sm_Company
  WHERE Company_Name = #{name}
  AND delete_flag = '0'
 </select>

 <select id="findCompanyByNickName" resultMap="company">
  SELECT *
  FROM Sm_Company
  WHERE Company_Nick_Name = #{name}
  AND delete_flag = '0'
 </select>

 <select id="findCompanyByPinyin" resultMap="company">
  SELECT *
  FROM Sm_Company
  WHERE Company_Name_Pinyin = #{companyPinyin}
  AND delete_flag = '0'
 </select>

 <select id="findByTypeAndName" resultMap="company">
  SELECT *
  FROM Sm_Company
  WHERE Company_Name like '%${companyName}%'
  AND Company_Type = #{type}
  AND delete_flag = '0'
 </select>

 <select id="findByType" resultMap="company">
  SELECT *
  FROM Sm_Company
  WHERE Company_Type = #{type}
  AND delete_flag = '0'
 </select>

 <insert id="insert" parameterType="com.djb.domain.Company">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO
  Sm_Company( Company_Name
  ,Company_Nick_Name
  ,Company_Name_Pinyin
  ,Company_Level
  ,Parent_Company_Id
  ,Status
  ,Display_Order
  ,Company_Type
  ,Service_Phone_Number
  ,Sales_Phone_Number
  ,Company_Website
  ,Company_Logo_Path
  ,Delete_Flag
  ,Create_User_Id
  ,Create_Time
  ,Update_User_Id
  ,Update_Time ,Company_Classify
  )VALUES( #{companyName}
  ,#{companyNickName}
  ,#{companyNamePinyin}
  ,#{companyLevel}
  ,#{parentCompanyId}
  ,#{status}
  ,#{displayOrder}
  ,#{type}
  ,#{servicePhoneNumber}
  ,#{salesPhoneNumber}
  ,#{companyWebsite}
  ,#{companyLogoPath}
  ,#{deleteFlag}
  ,#{createUserId}
  ,#{createDateTime}
  ,#{updateUserId}
  ,#{updateDateTime} ,#{companyClassify}
  )
 </insert>

 <update id="update" parameterType="com.djb.domain.Company">
  UPDATE
  Sm_Company
  SET
  Company_Name=#{companyName}
  ,Company_Nick_Name=#{companyNickName}
  ,Company_Name_Pinyin=#{companyNamePinyin}
  ,Company_Level=#{companyLevel}
  ,Parent_Company_Id=#{parentCompanyId}
  ,Status=#{status}
  ,Display_Order=#{displayOrder}
  ,Company_Type=#{type}
  ,Service_Phone_Number=#{servicePhoneNumber}
  ,Sales_Phone_Number=#{salesPhoneNumber}
  ,Company_Website=#{companyWebsite}
  ,Company_Logo_Path=#{companyLogoPath}
  ,Delete_Flag=#{deleteFlag}
  ,Create_User_Id=#{createUserId}
  ,Create_Time=#{createDateTime}
  ,Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime} ,Company_Classify=#{companyClassify} WHERE id=#{id}
 </update>

 <delete id="deleteByPrimaryKey">
  DELETE FROM
  Sm_Company
  WHERE
  id = #{id}
 </delete>

 <select id="getAgencyCompany" parameterType="map" resultMap="company">
  SELECT *
  FROM Sm_Company company
  WHERE EXISTS(
  SELECT 1
  FROM Du_Agent_Detail agent
  INNER JOIN Du_User u ON u.Id=agent.Id
  WHERE company.Id=agent.company
  <if test="city != null">
   AND u.city=#{city}
  </if>
  AND agent.Delete_Flag = 0
  AND agent.Verify_Status = 1
  )
  AND company.Delete_Flag=0
  ORDER BY Display_Order
 </select>
 
 <sql id="findCompanyByQueryBeanRef">
  FROM Sm_Company company
  WHERE company.Delete_Flag = 0
  <if test="companyname != null and companyname != ''">
   AND (company.Company_Name like '%${companyname}%'
   OR company.Company_Nick_Name like '%${companyname}%'
   )
  </if>
  <if test="type != null and type != ''">
   AND company.Company_Type = ${type}
  </if>
  <if test="companyclassify != null and companyclassify != ''">
   AND company.Company_Classify like '%${companyclassify}%'
  </if>
 </sql>

 <select id="findCompanyCountByQueryBean" parameterType="com.djb.domain.CompanyQueryBean"
  resultType="int">
  SELECT count(*) <include refid="findCompanyByQueryBeanRef"/>
 </select>

 <select id="findCompanyByQueryBean" parameterType="com.djb.domain.CompanyQueryBean"
  resultMap="company">
  SELECT * <include refid="findCompanyByQueryBeanRef"/>
  ORDER BY company.Create_Time DESC
  LIMIT ${startIndex}, ${pageSize}
 </select>
</mapper>
==================================== END Company.xml =========================


==================================== BEGIN cms/PageAreaContent.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:24:12 
 CST 2013 -->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="PageAreaContent">

 <cache type="com.djb.cache.MemcachedCache">
  <property name="timeout" value="7200" />
 </cache>

 <resultMap id="pageAreaContent" type="com.djb.domain.cms.PageAreaContent"
  extends="DomainObject.domainObject">
  <result property="areaKey" column="Area_Key" />
  <result property="orderId" column="Order_Id" />
  <result property="title" column="Title" />
  <result property="link" column="Link" />
  <result property="imageUrl" column="Image_Url" />
  <result property="imageLink" column="Image_Link" />
  <result property="summary" column="Summary" />
  <result property="sign" column="Sign" />
  <result property="imageDesc" column="Image_Desc" />
  <result property="agentMobile" column="Agent_Mobile" />
  <result property="programId" column="Program_Id" />
 </resultMap>

 <select id="load" resultMap="pageAreaContent">
  SELECT *
  FROM Dp_Page_Area_Content
  WHERE id = #{id}
  AND delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.cms.PageAreaContent">
  UPDATE Dp_Page_Area_Content
  SET
  Area_Key=#{areaKey}
  ,Order_Id=#{orderId}
  ,Title=#{title}
  ,Link=#{link}
  ,Image_Url=#{imageUrl}
  ,Image_Link=#{imageLink}
  ,Summary=#{summary}
  ,Sign=#{sign}
  ,Image_Desc=#{imageDesc}
  ,Agent_Mobile=#{agentMobile}
  ,Program_Id=#{programId}
  ,Delete_Flag=#{deleteFlag}
  ,Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime}
  WHERE id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.cms.PageAreaContent">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO Dp_Page_Area_Content(
  Area_Key
  ,Order_Id
  ,Title
  ,Link
  ,Image_Url
  ,Image_Link
  ,Summary
  ,Sign
  ,Image_Desc
  ,Agent_Mobile
  ,Program_Id
  ,Delete_Flag
  ,Create_User_Id
  ,Create_Time
  ,Update_User_Id
  ,Update_Time
  )
  VALUES(
  #{areaKey}
  ,#{orderId}
  ,#{title}
  ,#{link}
  ,#{imageUrl}
  ,#{imageLink}
  ,#{summary}
  ,#{sign}
  ,#{imageDesc}
  ,#{agentMobile}
  ,#{programId}
  ,#{deleteFlag}
  ,#{createUserId}
  ,#{createDateTime}
  ,#{updateUserId}
  ,#{updateDateTime}
  )


 </insert>

 <select id="findPageAreaContentByKey" parameterType="map"
  resultMap="pageAreaContent">
  SELECT * FROM Dp_Page_Area_Content
  WHERE delete_Flag = 0
  AND Area_Key =
  #{areaKey}
  ORDER BY order_ID ASC, Create_Time DESC
  <if test="size != null">
   LIMIT ${size}
  </if>
 </select>

 <select id="findTopicKeyword" resultMap="pageAreaContent">
  SELECT *
  FROM Dp_Page_Area_Content
  WHERE Area_Key = #{areaKey}
  AND Order_Id = #{orderId}
  AND delete_flag='0'
 </select>

 <delete id="deleteByPrimaryKey">
  DELETE FROM Dp_Page_Area_Content
  WHERE id = #{id}
 </delete>
</mapper>
==================================== END cms/PageAreaContent.xml =========================


==================================== BEGIN cms/CmsContentClassify.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:24:10 
	CST 2013 -->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="CmsContentClassify">

	<cache type="com.djb.cache.MemcachedCache">
		<property name="timeout" value="7200" />
	</cache>
	<resultMap id="cmsContentClassify" type="com.djb.domain.cms.CmsContentClassify"
		extends="DomainObject.domainObject">
		<result property="cmsContentId" column="Cms_Content_Id" />
		<result property="classifyId" column="Classify_Id" />
	</resultMap>

	<select id="load" resultMap="cmsContentClassify">
		SELECT *
		FROM Dp_Cms_Content_Classify
		WHERE id = #{id}
		AND delete_flag='0'
	</select>

	<update id="update" parameterType="com.djb.domain.cms.CmsContentClassify">
		UPDATE Dp_Cms_Content_Classify
		SET
		Cms_Content_Id=#{cmsContentId}
		,Classify_Id=#{classifyId}
		,Delete_Flag=#{deleteFlag}
		,Update_User_Id=#{updateUserId}
		,Update_Time=#{updateDateTime}
		WHERE id=#{id}
	</update>

	<insert id="insert" parameterType="com.djb.domain.cms.CmsContentClassify">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
		INSERT INTO Dp_Cms_Content_Classify(
		Cms_Content_Id
		,Classify_Id
		,Delete_Flag
		,Create_User_Id
		,Create_Time
		,Update_User_Id
		,Update_Time
		)
		VALUES(
		#{cmsContentId}
		,#{classifyId}
		,#{deleteFlag}
		,#{createUserId}
		,#{createDateTime}
		,#{updateUserId}
		,#{updateDateTime}
		)
	</insert>

	<delete id="deleteByPrimaryKey">
		DELETE FROM Dp_Cms_Content_Classify
		WHERE id = #{id}
	</delete>

	<update id="logicDeleteByFKey">
		UPDATE Dp_Cms_Content_Classify
		SET delete_flag=1
		WHERE cms_content_id=#{cmsContentId}
	</update>
</mapper>
==================================== END cms/CmsContentClassify.xml =========================


==================================== BEGIN cms/CmsBlock.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="CmsBlock" >

 <resultMap id="cmsBlock" type="com.djb.domain.cms.CmsBlock" extends="DomainObject.domainObject" >
  <result property="categoryId" column="Category_Id" />
  <result property="locationNo" column="Location_No" />
  <result property="viewStatus" column="View_Status" />
  <result property="type" column="Type" />
  <result property="secondType" column="Second_Type" />
  <result property="articleKeyWord" column="Article_KeyWord" />
  <result property="articleCategoryId" column="Article_Category_Id" />
  <result property="articleTitle" column="Article_Title" />
  <result property="articleUrl" column="Article_Url" />
  <result property="articleExcerpts" column="Article_Excerpts" />
  <result property="publishStatus" column="Publish_Status" />
  <result property="agentIds" column="Agent_Ids" />
 </resultMap>

 <select id="load" resultMap="cmsBlock" >
  SELECT  *
    FROM  Dp_Cms_Block
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.cms.CmsBlock" >
  UPDATE  Dp_Cms_Block
     SET  
   Category_Id=#{categoryId}
   ,Location_No=#{locationNo}
   ,View_Status=#{viewStatus}
   ,Type=#{type}
   ,Second_Type=#{secondType}
   ,Article_KeyWord=#{articleKeyWord}
   ,Article_Category_Id=#{articleCategoryId}
   ,Article_Title=#{articleTitle}
   ,Article_Url=#{articleUrl}
   ,Article_Excerpts=#{articleExcerpts}
   ,Publish_Status=#{publishStatus}
   ,Agent_Ids=#{agentIds}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   WHERE  id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.cms.CmsBlock" >
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Dp_Cms_Block(
   Category_Id
   ,Location_No
   ,View_Status
   ,Type
   ,Second_Type
   ,Article_KeyWord
   ,Article_Category_Id
   ,Article_Title
   ,Article_Url
   ,Article_Excerpts
   ,Publish_Status
   ,Agent_Ids
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{categoryId}
   ,#{locationNo}
   ,#{viewStatus}
   ,#{type}
   ,#{secondType}
   ,#{articleKeyWord}
   ,#{articleCategoryId}
   ,#{articleTitle}
   ,#{articleUrl}
   ,#{articleExcerpts}
   ,#{publishStatus}
   ,#{agentIds}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey" >
  DELETE FROM  Dp_Cms_Block
        WHERE  id = #{id}
 </delete>
 
 <select id="getCmsBlockByCategoryId" parameterType="long" resultMap="cmsBlock">
  SELECT  *
    FROM  Dp_Cms_Block
   WHERE  Category_id = #{categoryId}
     AND  delete_flag='0'
 </select>
 
 <update id="deleteCmsBlock" parameterType="map">
  UPDATE  Dp_Cms_Block
     SET  Delete_Flag=1
    ,Update_User_Id=#{updateUserId}
     ,Update_Time=#{updateTime}
  WHERE Category_id =#{categoryId}
  AND Publish_Status=#{pulishStatus}
 
 </update>
 
 <select id="getCmsBlockByCmsBlock" parameterType="com.djb.domain.cms.CmsBlock" resultMap="cmsBlock">
  SELECT  *
    FROM  Dp_Cms_Block
   WHERE  Category_id = #{categoryId}
   <if test="publishStatus!=null">
    AND Publish_Status=#{publishStatus}
   </if>
     AND  delete_flag='0'
 
 </select>
 
 <select id="getCmsBlockCountByCmsBlock" parameterType="com.djb.domain.cms.CmsBlock" resultType="int" >
  SELECT  count(*)
    FROM  Dp_Cms_Block
   WHERE  Category_id = #{categoryId}
   <if test="publishStatus!=null">
    AND Publish_Status=#{publishStatus}
   </if>
     AND  delete_flag='0'
 </select>
</mapper>
==================================== END cms/CmsBlock.xml =========================


==================================== BEGIN cms/HotKeyword.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:24:10 
 CST 2013 -->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="HotKeyword">

 <cache type="com.djb.cache.MemcachedCache">
  <property name="timeout" value="7200" />
 </cache>

 <resultMap id="hotKeyword" type="com.djb.domain.cms.HotKeyword"
  extends="DomainObject.domainObject">
  <result property="cmsCategory.id" column="Type" />
  <result property="title" column="Title" />
  <result property="link" column="Link" />
  <result property="state" column="State" />
 </resultMap>

 <select id="load" resultMap="hotKeyword">
  SELECT *
  FROM Dp_Hot_Keyword
  WHERE id = #{id}
  AND delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.cms.HotKeyword">
  UPDATE Dp_Hot_Keyword
  SET
  Type=#{cmsCategory.id}
  ,Title=#{title}
  ,Link=#{link}
  ,Delete_Flag=#{deleteFlag}
  ,Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime} ,State=#{state}
  WHERE id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.cms.HotKeyword">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO Dp_Hot_Keyword(
  Type
  ,Title
  ,Link
  ,Delete_Flag
  ,Create_User_Id
  ,Create_Time
  ,Update_User_Id
  ,Update_Time ,State
  )
  VALUES(
  #{cmsCategory.id}
  ,#{title}
  ,#{link}
  ,#{deleteFlag}
  ,#{createUserId}
  ,#{createDateTime}
  ,#{updateUserId}
  ,#{updateDateTime} ,#{state}
  )
 </insert>

 <delete id="deleteByPrimaryKey">
  DELETE FROM Dp_Hot_Keyword
  WHERE id = #{id}
 </delete>

 <sql id="findHotKeyWordByQueryBeanRef">
  FROM Dp_Hot_Keyword keyword
  WHERE delete_flag=0
  AND Module IS NULL
  <if test="title != null and title != ''">AND
   title like '%${title}%'
  </if>
  <if test="categoryId != null">AND
   Type = #{categoryId}
  </if>
  <if test="state == 1">AND State=#{state}</if>
  <if test="state == null">AND State IS Null</if>
 </sql>
 <select id="findHotKeyWordByQueryBean" parameterType="com.djb.domain.cms.HotKeywordQueryBean"
  resultMap="hotKeyword">
  SELECT *
  <include refid="findHotKeyWordByQueryBeanRef" />
  <if test="orderByProperties != null">
   ORDER BY ${orderByFiled}
  </if>
  <if test="orderByProperties == null">
   ORDER BY keyword.create_time DESC,keyword.id
  </if>
  LIMIT ${startIndex}, ${pageSize}
 </select>

 <select id="getCountByQueryBean" parameterType="com.djb.domain.cms.HotKeywordQueryBean"
  resultType="int">
  SELECT count(*)
  <include refid="findHotKeyWordByQueryBeanRef" />
 </select>

 <select id="findRelationKeyword" parameterType="com.djb.domain.cms.HotKeywordQueryBean"
  resultMap="hotKeyword">
  SELECT *
  FROM Dp_Hot_Keyword keyword
  WHERE keyword.Type = 0
  AND keyword.Delete_Flag = 0
  AND keyword.Module IS NULL
  <if test="contentId != null">UNION
   SELECT *
   FROM Dp_Hot_Keyword keyword
   WHERE EXISTS(
   SELECT 1
   FROM Dp_Cms_Content content
   WHERE content.Category_Id = keyword.Type
   AND content.id=#{contentId}
   AND keyword.Delete_Flag = 0
   )
   AND keyword.Module IS NULL
  </if>
  LIMIT ${pageSize}
 </select>

 <select id="findHotKeywordsByModule" resultMap="hotKeyword">
  SELECT *
  FROM Dp_Hot_Keyword keyword
  WHERE keyword.Delete_Flag = 0
  AND keyword.module=#{module}
 </select>

 <select id="findHotKeyType" parameterType="com.djb.domain.cms.CategoryLen"
  resultMap="hotKeyword">
  SELECT *
  FROM Dp_Hot_Keyword keyword
  WHERE keyword.Delete_Flag = 0
  <if test="orderId != null">
   <if test="orderId==8">
    AND keyword.Type in (0
    <if test="bxzxId!=null">
     ,#{bxzxId}
    </if>
    ,8)
   </if>

   <if test="orderId!=8">
    <if test="xqId!=null">
     AND keyword.Type in (#{orderId},#{xqId}
     <if test="bxzxId!=null">
      ,#{bxzxId}
     </if>
     ,0)
    </if>
    <if test="xqId==null">
     AND keyword.Type in (#{orderId},0)
    </if>
   </if>

  </if>

  <if test="orderId == null">
   AND keyword.Type in (0
   <if test="bxzxId!=null">
    ,#{bxzxId}
   </if>
   )
  </if>
  <if test="state == 1">AND State=#{state}</if>
  <if test="state == null">AND State IS Null</if>
  AND Module IS NULL
  <if test="size!=null">LIMIT ${size}</if>
 </select>
</mapper>

==================================== END cms/HotKeyword.xml =========================


==================================== BEGIN cms/CmsClick.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="CmsClick" >

 <resultMap id="cmsClick" type="com.djb.domain.cms.CmsClick" extends="DomainObject.domainObject" >
  <result property="userId" column="User_Id" />
  <result property="userType" column="User_Type" />
  <result property="ipAddress" column="Ip_Address" />
  <result property="visitTime" column="Visit_Time" />
  <result property="countClick" column="Count_Click" />
  <result property="cmsId" column="cms_Id" />
 </resultMap>

 <select id="load" resultMap="cmsClick" >
  SELECT  *
    FROM  Dp_Cms_Click
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.cms.CmsClick" >
  UPDATE  Dp_Cms_Click
     SET  
   User_Id=#{userId}
   ,User_Type=#{userType}
   ,Ip_Address=#{ipAddress}
   ,Visit_Time=#{visitTime}
   ,Count_Click=#{countClick}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   ,cms_Id=#{cmsId}
   WHERE  id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.cms.CmsClick" >
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Dp_Cms_Click(
   User_Id
   ,User_Type
   ,Ip_Address
   ,Visit_Time
   ,Count_Click
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
   ,cms_Id
  )
  VALUES(
   #{userId}
   ,#{userType}
   ,#{ipAddress}
   ,#{visitTime}
   ,#{countClick}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
   ,#{cmsId}
  )
 </insert>

 <delete id="deleteByPrimaryKey" >
  DELETE FROM  Dp_Cms_Click
        WHERE  id = #{id}
 </delete>
 
 
</mapper>
==================================== END cms/CmsClick.xml =========================


==================================== BEGIN cms/CmsCategory.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:24:09 
 CST 2013 -->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="CmsCategory">

 <cache type="com.djb.cache.MemcachedCache">
  <property name="timeout" value="7200" />
 </cache>
 <resultMap id="cmsCategory" type="com.djb.domain.cms.CmsCategory"
  extends="DomainObject.domainObject">
  <result property="orderId" column="Order_Id" />
  <result property="categoryName" column="Category_Name" />
  <result property="viewStatus" column="View_Status" />
  <result property="displayType" column="Display_Type" />
  <result property="parent.id" column="Parent_Id" />
 </resultMap>

 <select id="load" resultMap="cmsCategory">
  SELECT *
  FROM Dp_Cms_Category
  WHERE id = #{id}
  AND delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.cms.CmsCategory">
  UPDATE Dp_Cms_Category
  SET
  Order_Id=#{orderId}
  ,Category_Name=#{categoryName}
  ,View_Status=#{viewStatus} ,Display_Type=#{displayType}
  ,Parent_Id=#{parent.id}
  ,Delete_Flag=#{deleteFlag}
  ,Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime}
  WHERE id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.cms.CmsCategory">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO Dp_Cms_Category(
  Order_Id
  ,Category_Name
  ,View_Status
  ,Parent_Id ,Display_Type
  ,Delete_Flag
  ,Create_User_Id
  ,Create_Time
  ,Update_User_Id
  ,Update_Time
  )
  VALUES(
  #{orderId}
  ,#{categoryName}
  ,#{viewStatus}
  ,#{parent.id} ,#{displayType}
  ,#{deleteFlag}
  ,#{createUserId}
  ,#{createDateTime}
  ,#{updateUserId}
  ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey">
  DELETE FROM Dp_Cms_Category
  WHERE id = #{id}
 </delete>

 <select id="getAll" resultMap="cmsCategory">
  SELECT * FROM Dp_Cms_Category
  WHERE delete_flag = '0'
 </select>

 <sql id="findCmsCategoryByQueryBeanRef">
  FROM Dp_Cms_Category category
  WHERE delete_flag=0
  <if test="viewStatus != null">
   AND View_Status = #{viewStatus}
  </if>
  <if test="parentStatus!=null">
   AND (Parent_Id is null OR Parent_id='')
  </if>
 </sql>

 <!-- 根据queryBean查找类别的数量 -->
 <select id="getCountByQueryBean" parameterType="com.djb.domain.cms.CmsCategoryQueryBean"
  resultType="int">
  SELECT count(*) <include refid="findCmsCategoryByQueryBeanRef"/>
 </select>

 <!-- 根据queryBean查找所有符合条件的类别 -->
 <select id="findCmsCategoryByQueryBean" parameterType="com.djb.domain.cms.CmsCategoryQueryBean"
  resultMap="cmsCategory">
  SELECT * <include refid="findCmsCategoryByQueryBeanRef"/>
  <if test="orderByProperties != null">
   ORDER BY ${orderByFiled}
  </if>
  <if test="orderByProperties == null">
   ORDER BY category.create_time DESC,category.Order_Id
  </if>
  LIMIT ${startIndex}, ${pageSize}
 </select>

 <select id="getParentCmsCategoryList" resultMap="cmsCategory">
  SELECT * FROM
  Dp_Cms_Category
  WHERE delete_flag = '0'
  and (Parent_Id is null
  or Parent_Id=''
  )
 </select>

 <select id="getCmsCategoryByParentId" parameterType="com.djb.domain.cms.CmsCategoryQueryBean"
  resultMap="cmsCategory">
  SELECT * FROM Dp_Cms_Category
  WHERE delete_flag = '0'
  <if test="viewStatus != null">
   AND View_Status = #{viewStatus}
  </if>
  <if test="parent!= null">
   AND Parent_Id = #{parent.id}
  </if>
 </select>

</mapper>
==================================== END cms/CmsCategory.xml =========================


==================================== BEGIN cms/Topic.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="Topic" >

 <resultMap id="topic" type="com.djb.domain.cms.Topic" extends="DomainObject.domainObject" >
  <result property="name" column="Name" />
  <result property="isDisplay" column="Is_Display" />
  <result property="pageAreaID" column="Page_Area_ID" />
  <result property="pageAreaKey" column="Page_Area_Key" />
 </resultMap>
 
 <resultMap type="java.util.HashMap" id="jihuaChanpin">
  <result property="referId" column="Refer_Id" javaType="long"/>
  <result property="company" column="Company" javaType="long"/>
 </resultMap>
 
 <resultMap type="java.util.HashMap" id="agent">
  <result property="referId" column="Refer_Id" javaType="long"/>
  <result property="province" column="Province" javaType="long"/>
 </resultMap>
 
 <resultMap type="java.util.HashMap" id="wendZixun">
  <result property="referId" column="Refer_Id" javaType="long"/>
 </resultMap>

 <select id="load" resultMap="topic" >
  SELECT  *
    FROM  Dp_Page_Area_Zhuanti
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>
 
 <select id="findAgent" parameterType="map" resultMap="agent">
 SELECT du.Province Province,du.Id Refer_Id
   FROM Du_Agent_Detail detail
   LEFT JOIN Du_User du on detail.Id = du.Id
  WHERE du.Delete_Flag = 0
    and detail.Delete_Flag = 0
    and detail.Fee_Status = 1
    and detail.Verify_Status = 1
    and detail.Image_Status = 1
    <if test="null != excluding">
    and du.Id not in
    <foreach collection="excluding" item="item" separator="," close=")" open="(">
   #{item}
    </foreach>
    </if>
  ORDER BY rand()
  LIMIT 100
 </select>
 
 <select id="findWenzhang" parameterType="map" resultMap="wendZixun">
  SELECT Id Refer_Id
    FROM (
  SELECT  *
    FROM Dp_Cms_Content
   WHERE Delete_Flag = 0
     and (<foreach collection="keyword" item="item" separator="or" close=")" open="(">
       Name like concat('%',#{item},'%')
     </foreach>
      or <foreach collection="keyword" item="item" separator="or" close=")" open="(">
       Keyword like concat('%',#{item},'%')
     </foreach>)
     and Description is not null
     and LTRIM(RTRIM(Description)) &lt;&gt; ''
     and create_time &lt; date_add(now, interval -20 day)
   ORDER BY Update_Time DESC LIMIT 40) t
   ORDER BY rand()
   LIMIT 4
 </select>
 
 <select id="findZixun" parameterType="map" resultMap="wendZixun">
  SELECT Refer_Id
    FROM (
  SELECT *
    FROM Dp_Cms_Content
   WHERE Delete_Flag = 0
     and (<foreach collection="keyword" item="item" separator="or" close=")" open="(">
       Name like concat('%',#{item},'%')
     </foreach>
      or <foreach collection="keyword" item="item" separator="or" close=")" open="(">
       Keyword like concat('%',#{item},'%')
     </foreach>)
     and Description is not null
     and LTRIM(RTRIM(Description)) &lt;&gt; ''
   ORDER BY Update_Time DESC LIMIT 40) t
   ORDER BY rand()
   LIMIT 4
 </select>
 
 <select id="findZixunWithin" parameterType="map" resultMap="wendZixun">
  SELECT Id Refer_Id 
  FROM Dp_Cms_Content
  WHERE Delete_Flag=0
    and(<foreach collection="keyword" item="item" separator="or" close=")" open="(">
       Name like concat('%',#{item},'%')
     </foreach>)
  and Description is not null
  and LTRIM(RTRIM(Description)) &lt;&gt; ''
   and  create_time &lt; date_add(now(), interval -30 day)
  ORDER BY Create_Time desc
  LIMIT 4
 </select>
 
 <select id="findZixunOutside" parameterType="map" resultMap="wendZixun">
  SELECT Id Refer_Id
    FROM (
  SELECT  * FROM Dp_Cms_Content
  WHERE Delete_Flag=0
    and(<foreach collection="keyword" item="item" separator="or" close=")" open="(">
       Name like concat('%',#{item},'%')
     </foreach>)
  and Description is not null
  and LTRIM(RTRIM(Description)) &lt;&gt; ''
   and  create_time &lt; date_add(now, interval -30 day)
  ) t
  ORDER BY rand()
  LIMIT 8
 </select>
 
 
 <select id="findWenda" parameterType="map" resultMap="wendZixun">
  SELECT *
    FROM (
  SELECT Id Refer_Id
    FROM Dq_Question
   WHERE Delete_Flag = 0
     and (<foreach collection="keyword" item="item" separator="or" close=")" open="(">
       Content like concat('%',#{item},'%')
     </foreach>
      or <foreach collection="keyword" item="item" separator="or" close=")" open="(">
       Key_Word like concat('%',#{item},'%')
     </foreach>)
   ORDER BY Update_Time DESC LIMIT 50) t
   ORDER BY rand()
   LIMIT 5
 </select>
 
 <select id="findJihua" parameterType="map" resultMap="jihuaChanpin">
  SELECT cmp.id Company
    ,pgm.Id Refer_Id
    FROM Dp_Program pgm
    LEFT JOIN Du_Agent_Detail agent on pgm.User_Id = agent.Id
    LEFT JOIN Sm_Company cmp on agent.Company = cmp.Id
   WHERE pgm.Id in (
  SELECT Id
    FROM Dp_Program
   WHERE Delete_Flag = 0
     and 
     <foreach collection="keyword" item="item" separator="or" close=")" open="(">
       Program_Name like concat('%',#{item},'%')
     </foreach>
   union all
  SELECT Program_Id
    FROM Dp_Program_Feature
   WHERE Delete_Flag = 0
     and 
      <foreach collection="keyword" item="item" separator="or" close=")" open="(">
       Customize_Feature like concat('%',#{item},'%')
     </foreach>)
     and pgm.Program_Case is not null
     <![CDATA[
     and trim(pgm.Program_Case) <> ''
     and pgm.Program_Description is not null
     and Program_Description <> '<p>&nbsp;</p>'
     and Program_Description <> '<p><br /></p>'
     and Program_Description <> ''
     ]]>
     and pgm.Delete_Flag = 0
     <if test="null != excluding">
     and pgm.Id not in
     <foreach collection="excluding" item="item" separator="," close=")" open="(">
    #{item}
     </foreach>
     </if>
   ORDER BY rand()
   LIMIT 100
 </select>
 
 <select id="findChanpin" parameterType="map" resultMap="jihuaChanpin">
  SELECT prd.Id Refer_Id,
    prd.Company_Id Company
    FROM Dp_Product prd
   WHERE prd.Id in(
  SELECT product.Id
    FROM Dp_Product product
   WHERE product.Delete_Flag = 0
     and <foreach collection="keyword" item="item" separator="or" close=")" open="(">
       product.Title like concat('%',#{item},'%')
     </foreach>
   union all
  SELECT distinct(product.Product_Id)
    FROM Dp_Product_Feature product
    LEFT JOIN Dp_Insurance_Feature feature on product.Insurance_Feature_Id = feature.Id
   WHERE product.Delete_Flag = 0
     and feature.Delete_Flag = 0
     and <foreach collection="keyword" item="item" separator="or" close=")" open="(">
       feature.Name like concat('%',#{item},'%')
     </foreach>)
     and exists(
  SELECT 1
    FROM Dp_Program_Product
   WHERE Product_Id = prd.Id 
     )
     <if test="null != excluding">
     and prd.Id not in
     <foreach collection="excluding" item="item" separator="," close=")" open="(">
    #{item}
     </foreach>
     </if>
   ORDER BY rand()
   LIMIT 200
 </select>
 
 <select id="getAll" resultMap="topic" >
  SELECT  *
    FROM  Dp_Page_Area_Zhuanti
   WHERE  delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.cms.Topic" >
  UPDATE  Dp_Page_Area_Zhuanti
     SET  
   Name=#{name}
   ,Is_Display=#{isDisplay}
   ,Page_Area_ID=#{pageAreaID}
   ,Page_Area_Key=#{pageAreaKey}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   WHERE  id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.cms.Topic" >
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Dp_Page_Area_Zhuanti(
   Name
   ,Is_Display
   ,Page_Area_ID
   ,Page_Area_Key
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{name}
   ,#{isDisplay}
   ,#{pageAreaID}
   ,#{pageAreaKey}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey" >
  DELETE FROM  Dp_Page_Area_Zhuanti
        WHERE  id = #{id}
 </delete>
</mapper>
==================================== END cms/Topic.xml =========================


==================================== BEGIN cms/TopicContent.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="TopicContent" >

 <resultMap id="topicContent" type="com.djb.domain.cms.TopicContent" extends="DomainObject.domainObject" >
  <result property="topicId" column="Topic_Id" />
  <result property="type" column="Type" />
  <result property="referId" column="Refer_Id" />
  <result property="companyId" column="Company_Id" />
 </resultMap>

 <select id="load" resultMap="topicContent" >
  SELECT  *
    FROM  Dp_Zhuanti_Content
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>
 
 <select id="findByTopic" resultMap="topicContent" >
  SELECT  *
    FROM  Dp_Zhuanti_Content
   WHERE  Topic_Id = #{topicId}
     AND  delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.cms.TopicContent" >
  UPDATE  Dp_Zhuanti_Content
     SET  
   Topic_Id=#{topicId}
   ,Type=#{type}
   ,Refer_Id=#{referId}
   ,Company_Id=#{companyId}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   WHERE  id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.cms.TopicContent" >
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Dp_Zhuanti_Content(
   Topic_Id
   ,Type
   ,Refer_Id
   ,Company_Id
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{topicId}
   ,#{type}
   ,#{referId}
   ,#{companyId}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey" >
  DELETE FROM  Dp_Zhuanti_Content
        WHERE  id = #{id}
 </delete>
 
 <delete id="removeAll">
  DELETE FROM Dp_Zhuanti_Content
 </delete>
 
 <delete id="removeByTopic">
  DELETE FROM Dp_Zhuanti_Content WHERE Topic_Id = #{id}
 </delete>
</mapper>
==================================== END cms/TopicContent.xml =========================


==================================== BEGIN cms/CmsContent.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:24:09 
 CST 2013 -->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="CmsContent">

 <cache type="com.djb.cache.MemcachedCache">
  <property name="timeout" value="3600" />
  <property name="disFlushQuery" value="findRelatedContent" />
 </cache>
 <resultMap id="cmsContent" type="com.djb.domain.cms.CmsContent"
  extends="DomainObject.domainObject">
  <result property="orderId" column="Order_Id" />
  <result property="name" column="Name" />
  <result property="cmsCategory.id" column="Category_Id" />
  <result property="author" column="author" />
  <result property="source" column="source" />
  <result property="isRecommend" column="Is_Recommend" />
  <result property="catchTime" column="Catch_Time" />
  <result property="keyword" column="Keyword" />
  <result property="description" column="Description" />
  <result property="contentFile" column="Content_File" />
  <result property="viewStatus" column="View_Status" />
  <result property="recKeyword" column="Rec_Keyword" />
  <result property="solrjIndexStatus" column="Solrj_Index_Status" />
  <result property="updateIndexStatus" column="Update_Index_Status" />
  <result property="inTenderType" column="In_Tender_Type" />
  <association property="classifies" select="CmsContent.findCmsContentClassify"
   column="id" />
 </resultMap>

 <resultMap id="insuranceClassify" type="com.djb.domain.InsuranceClassify">
  <result property="name" column="name" />
  <result property="value" column="value" />
  <result property="insuranceClassifyType" column="type" />
 </resultMap>

 <select id="load" resultMap="cmsContent">
  SELECT *
  FROM Dp_Cms_Content
  WHERE id = #{id}
  AND delete_flag='0'
 </select>

 <select id="getAll" resultMap="cmsContent" useCache="false">
  SELECT *
  FROM Dp_Cms_Content
  WHERE delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.cms.CmsContent">
  UPDATE Dp_Cms_Content
  SET
  Order_Id=#{orderId}
  ,Name=#{name}
  ,Category_Id=#{cmsCategory.id}
  ,author=#{author}
  ,source=#{source}
  ,Is_Recommend=#{isRecommend} ,Rec_Keyword=#{recKeyword}
  ,Catch_Time=#{catchTime}
  ,Keyword=#{keyword}
  ,Description=#{description}
  ,Content_File=#{contentFile}
  ,View_Status=#{viewStatus}
  ,Delete_Flag=#{deleteFlag}
  ,Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime} ,Solrj_Index_Status=#{solrjIndexStatus}
  ,Update_Index_Status=#{updateIndexStatus}
  ,In_Tender_Type=#{inTenderType}
  WHERE id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.cms.CmsContent">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO Dp_Cms_Content(
  Order_Id
  ,Name
  ,Category_Id
  ,author
  ,source
  ,Is_Recommend ,Rec_Keyword
  ,Catch_Time
  ,Keyword
  ,Description
  ,Content_File
  ,View_Status
  ,Delete_Flag
  ,Create_User_Id
  ,Create_Time
  ,Update_User_Id
  ,Update_Time ,In_Tender_Type
  )
  VALUES(
  #{orderId}
  ,#{name}
  ,#{cmsCategory.id}
  ,#{author}
  ,#{source}
  ,#{isRecommend} ,#{recKeyword}
  ,#{catchTime}
  ,#{keyword}
  ,#{description}
  ,#{contentFile}
  ,#{viewStatus}
  ,#{deleteFlag}
  ,#{createUserId}
  ,#{createDateTime}
  ,#{updateUserId}
  ,#{updateDateTime} ,#{inTenderType}
  )


 </insert>

 <delete id="deleteByPrimaryKey">
  DELETE FROM Dp_Cms_Content
  WHERE id = #{id}
 </delete>


 <sql id="findCmsContentByQueryBeanRef">
  FROM Dp_Cms_Content content
  WHERE delete_flag=0
  <if test="excludeCategorys">
   AND
   content.Category_Id not in
   <foreach collection="excludeCategorys" item="item" separator=","
    close=")" open="(">
    #{item}
   </foreach>
  </if>
  <if test="preNext !=null">
   <if test="preNext == 'pre'">
    AND Id &gt; #{currentId}
   </if>
   <if test="preNext == 'next'">
    AND Id &lt; #{currentId}
   </if>
  </if>
  <if test="keywords">
   AND
   <foreach collection="keywords" item="item" separator=" OR "
    close=")" open="(">
    content.name like CONCAT('%',#{item},'%')
   </foreach>
  </if>
  <if test="name != null and name != ''">AND
   content.name like CONCAT('%',#{name},'%')
  </if>
  <if test="categoryId != null">AND
   content.Category_Id = #{categoryId}
  </if>
  <if test="isRecommend != null">AND
   content.Is_Recommend = #{isRecommend}
  </if>
  <if test="contentId != null">AND
   content.id != #{contentId}
  </if>
  <if test="viewStatus != null">AND
   content.View_Status = #{viewStatus}
  </if>
  <if test="isFront != null">AND
   EXISTS(
   SELECT 1
   FROM Dp_Cms_Category category
   WHERE
   category.id = content.Category_Id
   AND category.View_Status = 1
   AND
   category.Delete_Flag = 0
   )
  </if>
 </sql>

 <!-- 根据queryBean查找类别的数量 -->
 <select id="getCountByQueryBean" parameterType="com.djb.domain.cms.CmsContentQueryBean"
  resultType="int">
  SELECT count(*)
  <include refid="findCmsContentByQueryBeanRef" />
 </select>

 <!-- 根据queryBean查找所有符合条件的类别 -->
 <select id="findCmsContentByQueryBean" parameterType="com.djb.domain.cms.CmsContentQueryBean"
  resultMap="cmsContent">
  SELECT content.*
  <include refid="findCmsContentByQueryBeanRef" />
  <if test="orderByProperties != null">
   ORDER BY ${orderByFiled}
  </if>
  <if test="orderByProperties == null">
   ORDER BY content.create_time DESC, content.Order_Id
  </if>
  LIMIT ${startIndex}, ${pageSize}
 </select>

 <select id="findCmsContentClassify" resultMap="insuranceClassify">
  SELECT *
  FROM Dp_Insurance_Classify IC
  INNER JOIN Dp_Cms_Content_Classify AC ON IC.id = AC.classify_id
  INNER JOIN Dp_Cms_Content AS A ON A.id = AC.cms_content_id
  WHERE A.id = #{cmsContentId}
  AND AC.delete_flag = '0'
  AND IC.delete_flag = '0'
  AND A.delete_flag = '0'
 </select>

 <!-- 得到关联的cms -->
 <select id="findRelatedContent" parameterType="map" resultMap="cmsContent">
  SELECT DISTINCT
  content.*
  FROM Dp_Cms_Content content
  INNER JOIN Dp_Cms_Content_Classify Content_CLASSIFY ON content.id =
  content_CLASSIFY.cms_content_id
  WHERE content.delete_flag=0
  AND EXISTS (
  SELECT classify.Classify_Id
  FROM Dp_Cms_Content_Classify classify
  WHERE cms_content_id=#{contentId}
  AND classify.Classify_Id=content_CLASSIFY.classify_id
  AND classify.delete_Flag=0
  AND content_CLASSIFY.delete_Flag=0
  )
  AND content.id != #{contentId}
  ORDER BY content.create_time DESC
  LIMIT ${size}
 </select>


 <!-- 得到最新的cms -->
 <select id="findRecentContent" resultMap="cmsContent" useCache="false">
  SELECT content.*
  FROM Dp_Cms_Content content
  WHERE content.delete_flag=0
  ORDER BY content.create_time DESC
  LIMIT ${value}
 </select>

 <select id="getMaxOrderId" resultType="long" useCache="false">
  SELECT MAX(Order_Id)
  FROM Dp_Cms_Content
 </select>
  
  <!-- 该方法主要用于加载全文检索同步时的方案， 如果cms是新增cms那么需要将新增cms加入到全文检索中， 如果cms被删除，那么需要将该cms从全文检索中删除， 
  如果cms发生了变化，那么需要更新该全文检索 -->
 <select id="findFullText" resultMap="cmsContent" useCache="false">
  SELECT content.*
  FROM Dp_Cms_Content content
  WHERE content.Delete_flag = #{delete_flag}
  AND content.Solrj_Index_Status = #{solrjStatus}
  <if test="updateIndexStatus != null">
   AND content.Update_Index_Status = #{updateIndexStatus}
  </if>
  ORDER BY content.Update_Time DESC
 </select>

 <update id="solrUpdate" parameterType="com.djb.domain.cms.CmsContent"
  flushCache="false">
  UPDATE
  Dp_Cms_Content
  SET
  Solrj_Index_Status=#{solrjIndexStatus}
  ,Update_Index_Status=#{updateIndexStatus}
  ,Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime}
  WHERE
  id = #{id}
 </update>

 <select id="getRelateCmsContentList" parameterType="java.util.Map"
  resultMap="cmsContent">
  SELECT *
  FROM Dp_Cms_Content
  WHERE delete_flag = 0
  <if test="kw!=null">
   and (
   <foreach collection="kw" item="item" separator="or">
    Name like CONCAT('%',#{item},'%')
   </foreach>
   )
   or (
   <foreach collection="kw" item="item" separator="or">
    Keyword like CONCAT('%',#{item},'%')
   </foreach>
   )
  </if>
  ORDER BY Update_Time DESC
  LIMIT 5
 </select>

 <select id="findHotCms" parameterType="map" resultMap="cmsContent"
  useCache="false">
  SELECT a.Id,a.Name
  FROM Dp_Cms_Content a,
  (
  SELECT Cms_Id ,count(Cms_Id) as pids
  FROM Dp_Cms_Click
  WHERE Update_time > date_add(now(), interval -7 day)
  GROUP BY Cms_Id
  ) as b
  WHERE a.Delete_Flag=0
  AND a.id = b.Cms_Id
  AND a.id != #{cmsId}
  ORDER BY pids DESC
  LIMIT ${size}
 </select>

 <select id="getRandomCmsContentList" parameterType="map"
  resultMap="cmsContent">
  SELECT * FROM Dp_Cms_Content
  WHERE delete_flag = 0
  ORDER BY rand()
  LIMIT ${size}
 </select>

 <select id="findCityIndexCms" parameterType="java.util.Map"
  resultMap="cmsContent">
  SELECT *
  FROM Dp_Cms_Content
  WHERE delete_flag = 0
  <if test="kw!=null">
   and (
   <foreach collection="kw" item="item" separator="or">
    Name like CONCAT('%',#{item},'%')
   </foreach>
   )
   or (
   <foreach collection="kw" item="item" separator="or">
    Keyword like CONCAT('%',#{item},'%')
   </foreach>
   )
  </if>
  ORDER BY Create_Time DESC
  LIMIT 3
 </select>
</mapper>
==================================== END cms/CmsContent.xml =========================


==================================== BEGIN cms/PageArea.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:24:11 
 CST 2013 -->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="PageArea">

 <cache type="com.djb.cache.MemcachedCache">
  <property name="timeout" value="7200" />
 </cache>
 <resultMap id="pageArea" type="com.djb.domain.cms.PageArea"
  extends="DomainObject.domainObject">
  <result property="areaKey" column="Area_Key" />
  <result property="page" column="Page" />
  <result property="areaName" column="Area_Name" />
  <result property="areaNameLink" column="Area_Name_Link" />
  <result property="areaImage" column="Area_Image" />
  <result property="areaImageLink" column="Area_Image_Link" />
  <result property="areaImageNorm" column="Area_Image_Norm" />
  <result property="contentNums" column="Content_Nums" />
  <result property="hasImage" column="Has_Image" />
  <result property="hasSummary" column="Has_Summary" />
  <result property="hasSign" column="Has_Sign" />
  <result property="hasTitle" column="Has_Title" />
  <result property="hasLink" column="Has_Link" />
  <result property="hasAgent" column="Has_Agent" />
  <result property="hasProgram" column="Has_Program" />
 </resultMap>

 <select id="load" resultMap="pageArea">
  SELECT *
  FROM Dp_Page_Area
  WHERE id = #{id}
  AND delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.cms.PageArea">
  UPDATE Dp_Page_Area
  SET
  Area_Key=#{areaKey}
  ,Page=#{page}
  ,Area_Name=#{areaName}
  ,Area_Name_Link=#{areaNameLink}
  ,Area_Image=#{areaImage}
  ,Area_Image_Norm=#{areaImageNorm}
  ,Area_Image_Link=#{areaImageLink}
  ,Content_Nums=#{contentNums}
  ,Has_Image=#{hasImage}
  ,Has_Summary=#{hasSummary}
  ,Has_Sign=#{hasSign}
  ,Has_Title=#{hasTitle}
  ,Has_Link=#{hasLink}
  ,Has_Agent=#{hasAgent}
  ,Has_Program=#{hasProgram}
  ,Delete_Flag=#{deleteFlag}
  ,Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime}
  WHERE id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.cms.PageArea">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO Dp_Page_Area(
  Area_Key
  ,Page
  ,Area_Name
  ,Area_Name_Link
  ,Area_Image
  ,Area_Image_Norm
  ,Area_Image_Link
  ,Content_Nums
  ,Has_Image
  ,Has_Summary
  ,Has_Sign
  ,Has_Title
  ,Has_Link
  ,Has_Agent
  ,Has_Program
  ,Delete_Flag
  ,Create_User_Id
  ,Create_Time
  ,Update_User_Id
  ,Update_Time
  )
  VALUES(
  #{areaKey}
  ,#{page}
  ,#{areaName}
  ,#{areaNameLink}
  ,#{areaImage}
  ,#{areaImageNorm}
  ,#{areaImageLink}
  ,#{contentNums}
  ,#{hasImage}
  ,#{hasSummary}
  ,#{hasSign}
  ,#{hasTitle}
  ,#{hasLink}
  ,#{hasAgent}
  ,#{hasProgram}
  ,#{deleteFlag}
  ,#{createUserId}
  ,#{createDateTime}
  ,#{updateUserId}
  ,#{updateDateTime}
  )


 </insert>

 <delete id="deleteByPrimaryKey">
  DELETE FROM Dp_Page_Area
  WHERE id = #{id}
 </delete>

 <select id="getPageAreaByKey" parameterType="map" resultMap="pageArea">
  SELECT * FROM Dp_Page_Area
  WHERE Delete_Flag = 0
  AND Area_Key =
  #{areaKey}
 </select>

 <sql id="findPageAreaByQueryBeanRef">
  FROM Dp_Page_Area
  WHERE delete_flag=0
  <if test="title != null and title != ''">AND
   title like '%${title}%'
  </if>
  <if test="page != null and page != ''">AND
   page = #{page}
  </if>
 </sql>
 <select id="findPageAreaByQueryBean" parameterType="com.djb.domain.cms.PageAreaQueryBean"
  resultMap="pageArea">
  SELECT *
  <include refid="findPageAreaByQueryBeanRef" />
  <if test="orderByProperties != null">
   ORDER BY ${orderByFiled}
  </if>
  <if test="orderByProperties == null">
   ORDER BY create_time DESC,id DESC
  </if>
  LIMIT ${startIndex}, ${pageSize}
 </select>

 <select id="getCountByQueryBean" parameterType="com.djb.domain.cms.PageAreaQueryBean"
  resultType="int">
  SELECT count(*)
  <include refid="findPageAreaByQueryBeanRef" />
 </select>

 <select id="getZhuantiPage" resultMap="pageArea">
  SELECT *
  FROM Dp_Page_Area
  WHERE Delete_Flag = 0
  AND Area_Key like '%zhuanti-%'
 </select>
</mapper>
==================================== END cms/PageArea.xml =========================


==================================== BEGIN webcall/CallResult.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 11:51:12 
	CST 2013 -->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="CallResult">
	<resultMap id="callResult" type="com.djb.domain.webcall.CallResult"
		extends="DomainObject.domainObject">
		<result property="sequenceId" column="Sequence_Id" />
		<result property="callCenterNo" column="Call_Center_No" />
		<result property="caller" column="Caller" />
		<result property="called" column="Called" />
		<result property="resultType" column="Call_Result" />
		<result property="callerStartTime" column="Caller_Start_Time" />
		<result property="calledStartTime" column="Called_Start_Time" />
		<result property="callEndTime" column="Call_End_Time" />
		<result property="callerDuration" column="Caller_Duration" />
		<result property="calledDuration" column="Called_Duration" />
		<result property="recordName" column="Record_Name" />
		<result property="remark" column="Remark" />
		<result property="failReason" column="Fail_Reason" />
	</resultMap>

	<select id="load" resultMap="callResult">
		SELECT *
		FROM Sm_Call_Result
		WHERE id = #{id}
		AND delete_flag = '0'
	</select>

	<select id="findCallResultBySequenceId" parameterType="string"
		resultMap="callResult">
		SELECT *
		FROM Sm_Call_Result
		WHERE Sequence_Id = #{sequenceId}
		AND delete_flag = '0'
	</select>

	<select id="getAll" resultMap="callResult">
		SELECT *
		FROM Sm_Call_Result
		WHERE delete_flag = '0'
		ORDER BY Sequence_Id
	</select>

	<update id="update" parameterType="com.djb.domain.webcall.CallResult">
		UPDATE Sm_Call_Result
		SET
		Sequence_Id=#{sequenceId}
		,Call_Center_No=#{callCenterNo.value}
		,Caller=#{caller}
		,Called=#{called}
		,Call_Result=#{resultType.value}
		,Caller_Start_Time=#{callerStartTime}
		,Called_Start_Time=#{calledStartTime}
		,Call_End_Time=#{callEndTime}
		,Caller_Duration=#{callerDuration}
		,Called_Duration=#{calledDuration}
		,Record_Name=#{recordName}
		,Remark = #{remark}
		,update_time = #{updateDateTime}
		,update_user_id = #{updateUserId}
		,delete_flag = #{deleteFlag}
		,Fail_Reason = #{failReason}
		WHERE id = #{id}
	</update>

	<insert id="insert" parameterType="com.djb.domain.webcall.CallResult">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
		INSERT INTO
		Sm_Call_Result(
		Sequence_Id
		,Call_Center_No
		,Caller
		,Called
		,Call_Result
		,Caller_Start_Time
		,Called_Start_Time
		,Call_End_Time
		,Caller_Duration
		,Called_Duration
		,Record_Name
		,Remark
		,create_time
		,create_user_id
		,update_time
		,update_user_id
		,delete_flag
		,Fail_Reason
		)
		VALUES(
		#{sequenceId}
		,#{callCenterNo.value}
		,#{caller}
		,#{called}
		,#{resultType.value}
		,#{callerStartTime}
		,#{calledStartTime}
		,#{callEndTime}
		,#{callerDuration}
		,#{calledDuration}
		,#{recordName}
		,#{remark}
		,#{createDateTime}
		,#{createUserId}
		,#{updateDateTime}
		,#{updateUserId}
		,#{deleteFlag}
		,#{failReason}
		)


	</insert>

	<delete id="deleteByPrimaryKey">
		DELETE FROM
		Sm_Call_Result
		WHERE
		id = #{id}
	</delete>
	
	<sql id="findCallResultByQueryBeanRefRef">
		SELECT agentDetail.mobilePhone FROM Du_User dUser,Du_Agent_Detail agentDetail
			WHERE dUser.Id=agentDetail.Id
			AND agentDetail.Delete_Flag=0
			AND dUser.Delete_Flag=0
			<if test="province != null">
				AND dUser.province=#{province}
			</if>
			<if test="city != null">
				AND dUser.city=#{city}
			</if>
			<if test="trueName != null and trueName != ''">
				AND agentDetail.True_Name=#{trueName}
			</if>
			<if test="companyName != null">
				AND agentDetail.company IN(
					SELECT Id FROM Sm_Company
					WHERE Company_Name Like '%${companyName}%' AND Delete_Flag=0
				)
			</if>
	</sql>

	<sql id="findCallResultByQueryBeanRef">
		FROM Sm_Call_Result callResult
		WHERE callResult.Delete_flag=0
		<if test="resultType != null">
			AND callResult.Call_Result=#{resultType}
		</if>
		<if test="mobilePhone != null and mobilePhone != ''">
			AND (callResult.caller=#{mobilePhone} OR callResult.called=#{mobilePhone})
		</if>
		<if test="mobilePhone == null or mobilePhone == '' or companyName != null">
			AND (callResult.caller IN (<include refid="findCallResultByQueryBeanRefRef"/>) 
				OR callResult.called IN(<include refid="findCallResultByQueryBeanRefRef"/>))
		</if>
	</sql>

	<select id="findCallResultByQueryBean" parameterType="com.djb.domain.webcall.CallResultQueryBean"
		resultMap="callResult">
		SELECT callResult.*
		<include refid="findCallResultByQueryBeanRef" />
		<if test="orderByProperties != null">
			ORDER BY ${orderByFiled}
		</if>
		<if test="orderByProperties == null">
			ORDER BY callResult.Create_time DESC
		</if>
		LIMIT ${startIndex}, ${pageSize}
	</select>

	<select id="getCountByQueryBean" parameterType="com.djb.domain.webcall.CallResultQueryBean"
		resultType="int">
		SELECT count(*)
		<include refid="findCallResultByQueryBeanRef" />
	</select>
</mapper>
==================================== END webcall/CallResult.xml =========================


==================================== BEGIN webcall/CallRecord.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 11:51:11 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="CallRecord">
 <resultMap id="callRecord" type="com.djb.domain.webcall.CallRecord" extends="DomainObject.domainObject">
  <result property="calledId" column="Called_Id"/>
  <result property="relatedId1" column="Related_Id1"/>
  <result property="relatedId2" column="Related_Id2"/>
  <result property="callSequenceId" column="Call_Sequence_Id"/>
  <result property="callType" column="Call_Type"/>
  <result property="position" column="Call_Position"/>
  <result property="callCenterType" column="Call_Center_Type"/>
  <result property="callerPhoneNumber" column="Caller_Phone_Number"/>
  <result property="calledPhoneNumber" column="Called_Phone_Number"/>
  <result property="remark" column="Remark"/>
 </resultMap>
 
 <select id="load" resultMap="callRecord">
  SELECT *
   FROM Dp_Call_Record
  WHERE id = #{id} 
    AND delete_flag = '0'
 </select>
 
 <select id="findCallRecordBySequenceId" parameterType="string" resultMap="callRecord">
  SELECT *
   FROM Dp_Call_Record
  WHERE Call_Sequence_Id = #{callSequenceId} 
    AND delete_flag = '0'
 </select>
 
 <select id="getAll" resultMap="callRecord">
  SELECT *
   FROM Dp_Call_Record
  WHERE delete_flag = '0'
   ORDER BY Call_Sequence_Id
 </select>
 
 <select id="findByPhoneNo" parameterType="string" resultMap="callRecord">
  SELECT *
    FROM Dp_Call_Record
   WHERE delete_flag = 0
     AND (
        Caller_Phone_Number = #{phoneNo}
      OR Called_Phone_Number = #{phoneNo}
     )
 </select>
 
 <update id="update" parameterType="com.djb.domain.webcall.CallRecord">
  UPDATE Dp_Call_Record
      SET
          Called_Id=#{calledId}
          ,Related_Id1=#{relatedId1}
          ,Related_Id2=#{relatedId2}
          ,Call_Sequence_Id=#{callSequenceId}
          ,Call_Type=#{callTypeValue}
          ,Call_Position=#{positionValue}
         ,Call_Center_Type=#{callCenterTypeValue}
         ,Caller_Phone_Number=#{callerPhoneNumber}
         ,Called_Phone_Number=#{calledPhoneNumber}
         ,Remark = #{remark}
         ,update_time = #{updateDateTime}
         ,update_user_id = #{updateUserId}
         ,delete_flag = #{deleteFlag}
   WHERE id = #{id}
 </update>
 
 <insert id="insert" parameterType="com.djb.domain.webcall.CallRecord">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO 
   Dp_Call_Record(
    Called_Id
    ,Related_Id1
    ,Related_Id2
     ,Call_Sequence_Id
     ,Call_Type
     ,Call_Position
    ,Call_Center_Type
    ,Caller_Phone_Number
    ,Called_Phone_Number
    ,Call_Status
    ,Remark
    ,create_time
    ,create_user_id
    ,update_time
    ,update_user_id
    ,delete_flag
   )
  VALUES(
   #{calledId}
   ,#{relatedId1}
   ,#{relatedId2}
   ,#{callSequenceId}
   ,#{callTypeValue}
   ,#{positionValue}
   ,#{callCenterTypeValue}
   ,#{callerPhoneNumber}
   ,#{calledPhoneNumber}
   ,#{callStatus}
   ,#{remark}
   ,#{createDateTime}
   ,#{createUserId}
   ,#{updateDateTime}
   ,#{updateUserId}
   ,#{deleteFlag}
  )
  
  
 </insert>
 
 <delete id="deleteByPrimaryKey">
  DELETE FROM 
   Dp_Call_Record
  WHERE
   id = #{id}
 </delete>
 
 <select id="getCallerCount" parameterType="map" resultType="int">
  SELECT count(*) 
    FROM Dp_Call_Record
   WHERE Caller_Phone_Number=#{phoneNo}
     AND datediff(create_Time, now()) = 0 
 </select>
 
</mapper>
==================================== END webcall/CallRecord.xml =========================


==================================== BEGIN share/SigningShare.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:07:02 
 CST 2013 -->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="SigningShare">
 <resultMap id="signingShare" type="com.djb.domain.signingshare.SigningShare"
  extends="DomainObject.domainObject">
  <result property="orderId" column="Order_Id" />
  <result property="agentUser.mobileNo" column="Mobile_Phone" />
  <result property="viewStatus" column="View_Status" />
  <result property="url" column="url" />
  <result property="contentFile" column="Content_File" />
  <result property="title" column="title" />
  <result property="keywords" column="Keywords" />
  <result property="summary" column="Summary" />
 </resultMap>

 <select id="load" resultMap="signingShare">
  SELECT * FROM Dp_Signing_Share
  WHERE
  id = #{id}
  AND delete_flag = '0'
 </select>

 <select id="findAll" resultMap="signingShare">
  SELECT * FROM Dp_Signing_Share
  WHERE delete_flag = '0'
 </select>

 <insert id="insert" parameterType="com.djb.domain.signingshare.SigningShare">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO
  Dp_Signing_Share(
  Order_id,
  Mobile_Phone,
  View_status,
  url,
  Content_File,
  Title,
  Keywords,
  Summary,
  delete_flag,
  create_user_id,
  create_time,
  update_user_id,
  update_time
  )
  VALUES(
  #{orderId},
  #{agentUser.mobileNo},
  #{viewStatus},
  #{url},
  #{contentFile},
  #{title},
  #{keywords},
  #{summary},
  #{deleteFlag},
  #{createUserId},
  #{createDateTime},
  #{updateUserId},
  #{updateDateTime}
  )


 </insert>
 <update id="update" parameterType="com.djb.domain.signingshare.SigningShare">
  UPDATE
  Dp_Signing_Share
  SET
  order_id=#{orderId},
  Mobile_Phone=#{agentUser.mobileNo},
  view_status=#{viewStatus},
  Url=#{url},
  Content_File=#{contentFile},
  Title=#{title},
  Keywords=#{keywords},
  Summary=#{summary},
  Delete_Flag=#{deleteFlag},
  Create_User_Id=#{createUserId},
  Create_Time=#{createDateTime},
  Update_User_Id=#{updateUserId},
  Update_Time=#{updateDateTime}
  WHERE
  id = #{id}
 </update>

 <sql id="findEmployeeByQueryBeanRef">
  FROM Dp_Signing_Share share
  WHERE delete_flag=0
  <if test="title != null and title != ''">AND
   title like '%${title}%'
  </if>
  <if test="mobilePhone != null and mobilePhone != ''">AND
   Mobile_Phone = #{mobilePhone}
  </if>
  <if test="viewStatus != null and viewStatus != ''">AND
   View_Status = #{viewStatus}
  </if>
  <if test="url != null and url != ''">AND
   url = #{url}
  </if>
 </sql>
 <select id="findSigningShareCountByQueryBean" parameterType="com.djb.domain.signingshare.SigningShareQueryBean"
  resultType="int">
  SELECT COUNT(*)
  <include refid="findEmployeeByQueryBeanRef" />
 </select>

 <select id="findSigningShareByQueryBean" parameterType="com.djb.domain.signingshare.SigningShareQueryBean"
  resultMap="signingShare">
  SELECT *
  <include refid="findEmployeeByQueryBeanRef" />
  ORDER BY share.Order_Id,share.update_time DESC LIMIT ${startIndex},
  ${pageSize}
 </select>

</mapper>
==================================== END share/SigningShare.xml =========================


==================================== BEGIN employee/Employee.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:22:16 
 CST 2013 -->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="Employee">
 <resultMap id="employee" type="com.djb.domain.employee.Employee"
  extends="DomainObject.domainObject">
  <result property="employeeName" column="Employee_Name" />
  <result property="employeeCnName" column="Employee_Cn_Name" />
  <result property="password" column="Password" />
  <result property="status" column="Status" />
  <result property="mobilePhone" column="Mobilephone" />
  <result property="email" column="Email" />
  <result property="loginStatus" column="Login_Status" />
  <result property="provinceId" column="Province_Id" />
  <result property="cityId" column="City_Id" />
  <result property="remark" column="Remark" />
 </resultMap>

 <select id="getEmployeeByName" parameterType="map" resultMap="employee">
  SELECT * FROM Sm_Employee employee
  WHERE Employee_Name = #{employeeName}
  AND delete_flag = '0'
  <if test="loginStatus != null">AND
   Login_Status = #{loginStatus}
  </if>
 </select>

 <select id="getEmployeeById" parameterType="java.lang.Long"
  resultMap="employee">
  SELECT *
  FROM Sm_Employee employee
  WHERE id = #{id}
  AND delete_flag = '0'
 </select>

 <select id="load" parameterType="java.lang.Long" resultMap="employee">
  SELECT *
  FROM Sm_Employee employee
  WHERE id = #{id}
  AND Delete_flag = '0'
 </select>

 <update id="update" parameterType="com.djb.domain.employee.Employee">
  UPDATE Sm_Employee
  SET
  Employee_Name=#{employeeName}
  ,Employee_Cn_Name=#{employeeCnName}
  ,Password=#{password}
  ,Status=#{status}
  ,Mobilephone=#{mobilePhone}
  ,Email=#{email}
  ,Login_Status=#{loginStatus}
  ,Province_Id=#{provinceId}
  ,City_Id=#{cityId}
  ,Remark=#{remark}
  ,Delete_Flag=#{deleteFlag}
  ,Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime}
  WHERE id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.employee.Employee">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO Sm_Employee(
  Employee_Name
  ,Employee_Cn_Name
  ,Password
  ,Status
  ,Mobilephone
  ,Email
  ,Login_Status
  ,Province_Id
  ,City_Id
  ,Remark
  ,Delete_Flag
  ,Create_User_Id
  ,Create_Time
  ,Update_User_Id
  ,Update_Time
  )
  VALUES(
  #{employeeName}
  ,#{employeeCnName}
  ,#{password}
  ,#{status}
  ,#{mobilePhone}
  ,#{email}
  ,#{loginStatus}
  ,#{provinceId}
  ,#{cityId}
  ,#{remark}
  ,#{deleteFlag}
  ,#{createUserId}
  ,#{createDateTime}
  ,#{updateUserId}
  ,#{updateDateTime}
  )


 </insert>

 <select id="getEmployeeByTypeProvince" parameterType="java.util.HashMap"
  resultMap="employee">
  SELECT *
  FROM Sm_Employee
  WHERE delete_flag = 0 and status &lt;> 9
  and remark = #{type}
  <if test="province != null">
   and province_id = #{province.id}
  </if>
 </select>

 <sql id="findEmployeeByQueryBeanRef">
  FROM Sm_Employee employee
  WHERE employee.Delete_Flag = 0

  <if test="username != null and username != ''">
   AND (employee.Employee_Name like '%${username}%'
   OR employee.Employee_Cn_Name like '%${username}%'
   )
  </if>
  <if test="mobilephone != null and mobilephone != ''">
   AND employee.Mobilephone = #{mobilephone}
  </if>
  <if test="status != null and status != ''">
   AND employee.Status = #{status}
  </if>
 </sql>
 <select id="findEmployeeCountByQueryBean" parameterType="com.djb.domain.employee.EmployeeQueryBean"
  resultType="int">
  SELECT count(*)
  <include refid="findEmployeeByQueryBeanRef" />
 </select>

 <select id="findEmployeeByQueryBean" parameterType="com.djb.domain.employee.EmployeeQueryBean"
  resultMap="employee">
  SELECT *
  <include refid="findEmployeeByQueryBeanRef" />
  ORDER BY employee.create_time DESC LIMIT ${startIndex}, ${pageSize}
 </select>

</mapper>
==================================== END employee/Employee.xml =========================


==================================== BEGIN bubble/BubbleAgent.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:24:48 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="BubbleAgent">
 
 <cache type="com.djb.cache.MemcachedCache" eviction="LRU" flushInterval="7200000" size="128"/>
 
 <resultMap id="bubbleAgent" type="com.djb.domain.bubble.BubbleAgent" extends="DomainObject.domainObject">
  <result property="agentUser.id" column="Agent_Id"/>
  <result property="bubble.id" column="Bubble_Id"/>
  <result property="visitTime" column="Visit_Time"/>
  <result property="times" column="times"/>
 </resultMap>
 
 <select id="load" resultMap="bubbleAgent">
  SELECT * FROM Dp_Bubble_Agent
  WHERE id = #{id}
  AND delete_flag = '0'  
 </select>
 
 <select id="findAll" resultMap="bubbleAgent">
  SELECT * FROM Dp_Bubble_Agent
  WHERE delete_flag = '0'  
 </select>
 
 <insert id="insert" parameterType="com.djb.domain.bubble.BubbleAgent">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
   INSERT INTO 
    Dp_Bubble_Agent(
    Agent_Id,
    Bubble_Id,
    Visit_Time,
    Times,
    Delete_flag,
    Create_user_id,
    Create_time,
    Update_user_id,
    Update_time
   )
   VALUES(
    #{agentUser.id},
    #{bubble.id},
    #{visitTime},
    #{times},
    #{deleteFlag},
    #{createUserId},
    #{createDateTime},
    #{updateUserId},
    #{updateDateTime}
   )
   
      
 </insert>
 <update id="update" parameterType="com.djb.domain.bubble.BubbleAgent">
 UPDATE
   Dp_Bubble_Agent
  SET
   Agent_Id=#{agentUser.id},
   Bubble_Id=#{bubble.id},
   Visit_Time=#{visitTime},
   Times=#{times},
   Delete_Flag=#{deleteFlag},
   Create_User_Id=#{createUserId},
   Create_Time=#{createDateTime},
   Update_User_Id=#{updateUserId},
   Update_Time=#{updateDateTime}
 WHERE
   id = #{id}
 </update>
 <select id="findBubbleAgentVisit" resultMap="bubbleAgent">
  SELECT  * FROM Dp_Bubble_Agent bulAgent 
   JOIN Dp_Bubble bubble ON bulAgent.Bubble_Id=bubble.Id
   WHERE bulAgent.delete_Flag=0
     AND bulAgent.Bubble_Id=#{bubbleId}
     AND bulAgent.Agent_Id=#{agentId}
     AND bulAgent.Visit_Time  &gt;  bubble.Update_Time
     AND bubble.delete_Flag=0
 </select>
 
</mapper>
==================================== END bubble/BubbleAgent.xml =========================


==================================== BEGIN bubble/Bubble.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:24:47 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="Bubble">
 <resultMap id="bubble" type="com.djb.domain.bubble.Bubble" extends="DomainObject.domainObject">
  <result property="viewStatus" column="View_Status"/>
  <result property="type" column="Type"/>
  <result property="name" column="Name"/>
  <result property="content" column="Content"/>
 </resultMap>
 
 <select id="load" resultMap="bubble">
  SELECT * FROM Dp_Bubble
  WHERE id = #{id}
  AND delete_flag = '0'  
 </select>
 
 <select id="findAll" resultMap="bubble">
  SELECT * FROM Dp_Bubble
  WHERE delete_flag = '0'  
 </select>
 
 <insert id="insert" parameterType="com.djb.domain.bubble.Bubble">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
   INSERT INTO 
    Dp_Bubble(
    Type,
    Name,
    View_Status,
    Content,
    delete_flag,
    create_user_id,
    create_time,
    update_user_id,
    update_time
   )
   VALUES(
    #{type},
    #{name},
    #{viewStatus},
    #{content},
    #{deleteFlag},
    #{createUserId},
    #{createDateTime},
    #{updateUserId},
    #{updateDateTime}
   )
   
      
 </insert>
 <update id="update" parameterType="com.djb.domain.bubble.Bubble">
 UPDATE
   Dp_Bubble
  SET
   Type=#{type},
   Name=#{name},
   View_Status=#{viewStatus},
   Content=#{content},
   Delete_Flag=#{deleteFlag},
   Create_User_Id=#{createUserId},
   Create_Time=#{createDateTime},
   Update_User_Id=#{updateUserId},
   Update_Time=#{updateDateTime}
 WHERE
   id = #{id}
 </update>
 
 
</mapper>
==================================== END bubble/Bubble.xml =========================


==================================== BEGIN agent/AgentComplaint.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="AgentComplaint" >

 <resultMap id="agentComplaint" type="com.djb.domain.agent.AgentComplaint" extends="DomainObject.domainObject" >
  <result property="agentId" column="Agent_Id" />
  <result property="complaintReason" column="Complaint_Reason" />
  <result property="addReason" column="Add_Reason" />
  <result property="telePhone" column="TelePhone" />
  <result property="surname" column="Surname" />
  <result property="sex" column="Sex" />
 </resultMap>

 <select id="load" resultMap="agentComplaint" >
  SELECT  *
    FROM  Sm_Agent_Complaint
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.agent.AgentComplaint" >
  UPDATE  Sm_Agent_Complaint
     SET  
   Agent_Id=#{agentId}
   ,Complaint_Reason=#{complaintReason}
   ,Add_Reason=#{addReason}
   ,TelePhone=#{telePhone}
   ,Surname=#{surname}
   ,Sex=#{sex}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   WHERE  id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.agent.AgentComplaint" >
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Sm_Agent_Complaint(
   Agent_Id
   ,Complaint_Reason
   ,Add_Reason
   ,TelePhone
   ,Surname
   ,Sex
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{agentId}
   ,#{complaintReason}
   ,#{addReason}
   ,#{telePhone}
   ,#{surname}
   ,#{sex}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey" >
  DELETE FROM  Sm_Agent_Complaint
        WHERE  id = #{id}
 </delete>
</mapper>
==================================== END agent/AgentComplaint.xml =========================


==================================== BEGIN agent/AgentCreditDetail.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="AgentCreditDetail">

 <resultMap id="agentCreditDetail" type="com.djb.domain.agent.AgentCreditDetail"
  extends="DomainObject.domainObject">
  <result property="agentId" column="Agent_Id" />
  <result property="changePoint" column="Change_Point" />
  <result property="creditPointNow" column="Credit_Point_Now" />
  <result property="changeReason" column="Change_Reason" />
 </resultMap>

 <select id="load" resultMap="agentCreditDetail">
  SELECT *
  FROM Sm_Agent_Credit_Detail
  WHERE id = #{id}
  AND delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.agent.AgentCreditDetail">
  UPDATE Sm_Agent_Credit_Detail
  SET
  Agent_Id=#{agentId}
  ,Change_Point=#{changePoint}
  ,Credit_Point_Now=#{creditPointNow}
  ,Change_Reason=#{changeReason}
  ,Delete_Flag=#{deleteFlag}
  ,Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime}
  WHERE id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.agent.AgentCreditDetail">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO Sm_Agent_Credit_Detail(
  Agent_Id
  ,Change_Point
  ,Credit_Point_Now
  ,Change_Reason
  ,Delete_Flag
  ,Create_User_Id
  ,Create_Time
  ,Update_User_Id
  ,Update_Time
  )
  VALUES(
  #{agentId}
  ,#{changePoint}
  ,#{creditPointNow}
  ,#{changeReason}
  ,#{deleteFlag}
  ,#{createUserId}
  ,#{createDateTime}
  ,#{updateUserId}
  ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey">
  DELETE FROM
  Sm_Agent_Credit_Detail
  WHERE id = #{id}
 </delete>

 <sql id="findCreditDetailByQueryBeanRef">
  FROM Sm_Agent_Credit_Detail detail
  WHERE detail.Delete_Flag = 0
  AND
  detail.Agent_Id = #{agentId}
  <if test="startTime!=null">
   AND detail.Create_Time &gt;= #{startTime}
  </if>
  <if test="endTime!=null">
   AND detail.Create_Time &lt; #{endTime}
  </if>
 </sql>

 <select id="findCreditDetailCountByQueryBean" parameterType="com.djb.domain.agent.AgentCreditDetailQueryBean"
  resultType="int">
  SELECT count(1)
  <include refid="findCreditDetailByQueryBeanRef" />
 </select>

 <select id="findCreditDetailByQueryBean" parameterType="com.djb.domain.agent.AgentCreditDetailQueryBean"
  resultMap="agentCreditDetail">
  SELECT *
  <include refid="findCreditDetailByQueryBeanRef" />
  ORDER BY detail.Create_Time DESC
  LIMIT ${startIndex}, ${pageSize}
 </select>
</mapper>
==================================== END agent/AgentCreditDetail.xml =========================


==================================== BEGIN agent/Blacklist.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:25:17 
 CST 2013 -->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="Blacklist">
 <resultMap id="blacklist" type="com.djb.domain.agent.Blacklist"
  extends="DomainObject.domainObject">
  <result property="referId" column="Refer_Id" />
  <result property="type" column="Type" />
  <result property="blockReason" column="Block_Reason" />
  <result property="valueType" column="Value_Type" />
 </resultMap>

 <select id="load" resultMap="blacklist">
  SELECT *
  FROM Sm_Blacklist
  WHERE id = #{id}
  AND delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.agent.Blacklist">
  UPDATE Sm_Blacklist
  SET
  Refer_Id=#{referId}
  ,Type=#{type}
  ,Block_Reason=#{blockReason} ,Value_Type=#{valueType}
  ,Delete_Flag=#{deleteFlag}
  ,Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime}
  WHERE id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.agent.Blacklist">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO Sm_Blacklist(
  Refer_Id
  ,Type
  ,Block_Reason ,Value_Type
  ,Delete_Flag
  ,Create_User_Id
  ,Create_Time
  ,Update_User_Id
  ,Update_Time
  )
  VALUES(
  #{referId}
  ,#{type}
  ,#{blockReason} ,#{valueType}
  ,#{deleteFlag}
  ,#{createUserId}
  ,#{createDateTime}
  ,#{updateUserId}
  ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey">
  DELETE FROM Sm_Blacklist
  WHERE id = #{id}
 </delete>

 <select id="findBlacklistByQueryBean" parameterType="com.djb.domain.agent.BlacklistQueryBean"
  resultMap="blacklist">
  SELECT * FROM Sm_Blacklist blacklist
  WHERE blacklist.Delete_Flag = 0
  <if test="referId != null">AND
   blacklist.Refer_Id=#{referId}
  </if>
  <if test="type != null and type != ''">AND
   blacklist.Type = #{type}
  </if>
  <if test="valueType != null and valueType != ''">AND
   blacklist.Value_Type = #{valueType}
  </if>
  ORDER BY blacklist.create_time DESC
  LIMIT ${startIndex}, ${pageSize}
 </select>
</mapper>
==================================== END agent/Blacklist.xml =========================


==================================== BEGIN agent/AgentTraining.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:25:16 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="AgentTraining">
 <resultMap id="agentTraining" type="com.djb.domain.agent.AgentTraining" extends="DomainObject.domainObject">
  <result property="user.id" column="User_Id"/>
  <result property="status" column="Status"/>
  <result property="trainingTime" column="Training_Time"/>
  <result property="trainingContent" column="Training_Content"/>
 </resultMap>
 
 <select id="load" resultMap="agentTraining">
  SELECT *
   FROM Du_Agent_Training
  WHERE id = #{id} 
    AND delete_flag = '0'
 </select>
 
 <select id="findTrainingByAgentId" parameterType="int" resultMap="agentTraining">
  SELECT *
   FROM Du_Agent_Training
  WHERE User_Id = #{agentId} 
    AND delete_flag = '0'
 </select>
 
 <select id="getAll" resultMap="agentTraining">
  SELECT *
   FROM Du_Agent_Training
  WHERE delete_flag = '0'
   ORDER BY Id
 </select>
 
 <insert id="insert" parameterType="com.djb.domain.agent.AgentTraining">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO
   Du_Agent_Training(
    User_Id       
    ,Status       
    ,Training_Time       
    ,Training_Content       
    ,Delete_Flag       
    ,Create_User_Id       
    ,Create_Time       
   )
   VALUES(
    #{user.id}
    ,#{status.value}
    ,#{trainingTime}
    ,#{trainingContent}
    ,#{deleteFlag}
    ,#{createUserId}
    ,#{createDateTime}
   )
 </insert>
  
 <update id="update" parameterType="com.djb.domain.agent.AgentTraining">
  UPDATE Du_Agent_Training
    SET
       Training_Content=#{trainingContent}
       ,Training_Time=#{trainingTime}
      ,Update_User_Id=#{updateUserId}
      ,Update_Time=#{updateDateTime}
      ,Delete_Flag=#{deleteFlag}
   WHERE Id=#{id}
 </update>
 
 <delete id="deleteByPrimaryKey">
  DELETE FROM
   Du_Agent_Training
  WHERE
   id = #{id}
 </delete>
</mapper>
==================================== END agent/AgentTraining.xml =========================


==================================== BEGIN agent/AgentHonor.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:25:15 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="AgentHonor">
 <resultMap id="agentHonor" type="com.djb.domain.agent.AgentHonor" extends="DomainObject.domainObject">
  <result property="user.id" column="User_Id"/>
  <result property="status" column="Status"/>
  <result property="honorTime" column="Honor_Time"/>
  <result property="honorContent" column="Honor_Content"/>
 </resultMap>
 
 <select id="load" resultMap="agentHonor">
  SELECT *
   FROM Du_Agent_Honor
  WHERE id = #{id} 
    AND delete_flag = '0'
 </select>
 
 <select id="findHonorByAgentId" parameterType="int" resultMap="agentHonor">
  SELECT *
   FROM Du_Agent_Honor
  WHERE User_Id = #{agentId} 
    AND delete_flag = '0'
 </select>
 
 <select id="getAll" resultMap="agentHonor">
  SELECT *
   FROM Du_Agent_Honor
  WHERE delete_flag = '0'
   ORDER BY Id
 </select>
  
 <insert id="insert" parameterType="com.djb.domain.agent.AgentHonor">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO
   Du_Agent_Honor(
    User_Id       
    ,Status       
    ,Honor_Time       
    ,Honor_Content       
    ,Delete_Flag       
    ,Create_User_Id       
    ,Create_Time       
   )
   VALUES(
    #{user.id}
    ,#{status.value}
    ,#{honorTime}
    ,#{honorContent}
    ,#{deleteFlag}
    ,#{createUserId}
    ,#{createDateTime}
   )
   
   
 </insert>
 
 <update id="update" parameterType="com.djb.domain.agent.AgentHonor">
  UPDATE Du_Agent_Honor
    SET
       Honor_Content=#{honorContent}
      ,Update_User_Id=#{updateUserId}
      ,Update_Time=#{updateDateTime}
      ,Delete_Flag=#{deleteFlag}
   WHERE Id=#{id}
 </update>
 
 <delete id="deleteByPrimaryKey">
  DELETE FROM
   Du_Agent_Honor
  WHERE
   id = #{id}
 </delete>
</mapper>
==================================== END agent/AgentHonor.xml =========================


==================================== BEGIN agent/AgentClick.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:25:13 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="AgentClick">
 <resultMap id="agentClick" type="com.djb.domain.agent.AgentClick" extends="DomainObject.domainObject">
  <result property="cityId" column="City_Id"/>
  <result property="agentId" column="Agent_Id"/>
  <result property="feeStatus" column="Agent_Type"/>
  <result property="userType" column="Visitor_Type"/>
  <result property="accessIp" column="Ip_Address"/>
  <result property="packageType" column="Package_Type"/>
  <result property="clickType" column="Click_Type"/>
  <result property="source" column="Source"/>
 </resultMap>
 
 <select id="load" resultMap="agentClick">
  SELECT *
    FROM Dp_Agent_Click
   WHERE id = #{id} 
    AND delete_flag = '0'
 </select>
 
 <select id="hasAccessed" parameterType="java.util.Map" resultType="int">
  SELECT count(*)
    FROM Dp_Agent_Click
   WHERE Agent_Id = #{agentId}
     AND Ip_Address = #{ip} 
     AND    Click_Type = 1
    AND delete_flag = '0'
 </select>
 
 <select id="getAccessCount" resultType="int">
  SELECT count(*)
    FROM Dp_Agent_Click
   WHERE Agent_Id = #{agentId} 
    AND delete_flag = '0'
 </select>
 
 
 <select id="getAll" resultMap="agentClick">
  SELECT *
    FROM Dp_Agent_Click
   WHERE delete_flag = '0'
 </select>
 
 <insert id="insert" parameterType="com.djb.domain.agent.AgentClick">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO 
   Dp_Agent_Click(
    City_Id
    ,Agent_Id
    ,Agent_Type
    ,Visitor_Type
    ,Ip_Address
    ,Package_Type
    ,Click_Type
    ,Source
    ,Delete_Flag
    ,Create_User_Id
    ,Create_Time
    ,Update_User_Id
    ,Update_Time
   )
  VALUES(
    #{cityId}
    ,#{agentId}
    ,#{feeStatus}
    ,#{userType}
    ,#{accessIp}
    ,#{packageType}
    ,#{clickType}
    ,#{source}
    ,#{deleteFlag}
    ,#{createUserId}
    ,#{createDateTime}
    ,#{updateUserId}
    ,#{updateDateTime}
  )
 </insert>
 
 <delete id="deleteByPrimaryKey">
   DELETE FROM
    Dp_Agent_Click
   WHERE
    id = #{id}
  </delete>
  
</mapper>
==================================== END agent/AgentClick.xml =========================


==================================== BEGIN agent/AgentMessege.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="AgentMessege" >

 <resultMap id="agentMessege" type="com.djb.domain.agent.AgentMessege" extends="DomainObject.domainObject" >
  <result property="userId" column="User_Id" />
  <result property="myUserId" column="MyUser_Id"/>
  <result property="status" column="Status" />
  <result property="content" column="Content" />
  <result property="messegetype" column="Messege_type" />
 </resultMap>

 <select id="load" resultMap="agentMessege" >
  SELECT  *
    FROM  Du_Agent_Messege
   WHERE  id = #{id}
     AND  delete_flag='0'
    ORDER BY Create_Time DESC  
 </select>
 
 <select id="findTop" parameterType="com.djb.domain.agent.AgentMessegeQueryBean" resultMap="agentMessege" >
  SELECT *
    FROM  Du_Agent_Messege 
   WHERE  delete_flag='0'   
   <if test="status!=null">
      AND Status=#{status}
   </if> 
    AND User_Id=#{agentId}
    ORDER BY Create_Time DESC  
    LIMIT ${len}
 </select>
 
 <select id="findCount" parameterType="long" resultType="int">
  SELECT COUNT(1)
   FROM  Du_Agent_Messege
   WHERE  delete_flag='0'
          AND User_Id=#{agentId}
       AND Status='1'
 </select>

 <update id="update" parameterType="com.djb.domain.agent.AgentMessege" >
  UPDATE  Du_Agent_Messege
     SET  
   User_Id=#{userId}
   ,MyUser_Id=#{myUserId}
   ,Status=#{status}
   ,Content=#{content}
   ,Messege_type=#{messegetype}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   WHERE  id=#{id}
 </update>
 
 <update id="updateStatus" parameterType="com.djb.domain.agent.AgentMessege" >
      UPDATE  Du_Agent_Messege
     SET
     Status='2'
     WHERE Status='1'
     <if test="id!=null">
     AND id = #{id}
     </if>
     <if test="userId!=null">
     AND User_Id=#{userId}
     </if>
 </update>
 

 <insert id="insert" parameterType="com.djb.domain.agent.AgentMessege" >  
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Du_Agent_Messege(
   User_Id
   ,MyUser_Id
   ,Status
   ,Content
   ,Messege_type
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{userId}
   ,#{myUserId}
   ,#{status}
   ,#{content}
   ,#{messegetype}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey" >
  DELETE FROM  Du_Agent_Messege
        WHERE  id = #{id}
 </delete> 
 
</mapper>
==================================== END agent/AgentMessege.xml =========================


==================================== BEGIN rmd/RmdAgentUser.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:07:50 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="RmdAgentUser">
 <resultMap id="rmdAgentUser" type="com.djb.domain.rmd.RmdAgentUser">
  <result property="id" column="id"/>
  <result property="trueName" column="True_Name"/>
  <result property="sex" column="Sex"/>
  <result property="mobileNo" column="Mobilephone"/>
  <result property="email" column="Email"/>
  <result property="imagePath" column="Image_Url"/>
  <result property="imageStatus" column="Image_Status"/>
  <result property="company.id" column="Company"/>
  <result property="province.id" column="Province"/>
  <result property="city.id" column="City"/>
  <result property="citySiteName" column="Site_City_Name"/>
  <result property="companyPinyin" column="Company_Name_Pinyin"/>
  <result property="serviceArea" column="Service_Area"/>
  <result property="serviceSpecialty" column="Service_Specialty"/>
  <result property="careerStartTime" column="Career_Start_time"/>
  <result property="packageType" column="Package_Type"/>
  <result property="cosineAvgRmd" column="Cosine_Avg_Rmd"/>
 </resultMap>
 
 <!-- 查询待推荐的代理人（付费，并且是相同城市的）, 用于前台推荐页面使用 -->
 <select id="findSameCityAgent" parameterType="com.djb.domain.rmd.RecommendQueryBean" resultMap="rmdAgentUser">
    SELECT detail.id
      ,detail.True_Name
      ,detail.Sex
      ,detail.Mobilephone
      ,detail.Email
      ,detail.Image_Url
      ,detail.Image_Status
      ,detail.Company
      ,Province.City_Name Site_City_Name
      ,Company.Company_Name_Pinyin
      ,detail.Service_Area
      ,detail.Service_Specialty
      ,detail.Career_Start_time
      ,detail.Package_Type
      ,rmd_feature.Cosine_Avg_Rmd
      ,agentUser.Province
      ,agentUser.City
      FROM Du_Agent_Detail detail
      INNER JOIN Du_User agentUser ON detail.id = agentUser.id
      INNER JOIN Sm_City Province ON agentUser.Province = Province.Id
      INNER JOIN Sm_Company Company ON detail.Company = Company.Id
      INNER JOIN Stat_Rmd_Feature rmd_feature ON rmd_feature.Agent_User_Id = agentUser.id
     WHERE detail.Fee_Status = #{feeStatus}
       AND (detail.Rmd_Status &lt;&gt; #{blackListAgent} OR detail.Rmd_Status IS NULL )
       AND detail.Verify_Status = #{verifyStatus}
       AND detail.Image_Status = #{imageStatus}
       AND agentUser.Province = #{province.id}
       AND detail.Delete_Flag = '0'
       <!-- 新增 -->
       AND  agentUser.City = #{city.id}
       AND  rmd_feature.Rmd_Total_Count &lt;= #{maxRmdCount}
 </select>
 
 <!-- 查询分配页面使用的待分配代理人列表 -->
 <resultMap id="rmdAgentUserForDispatch" type="com.djb.domain.rmd.RmdAgentUser">
  <result property="id" column="Agent_User_Id"/>
  <result property="packageType" column="Package_Type"/>
  <result property="trueName" column="Agent_User_Name"/>
  <result property="company.id" column="Agent_Company_Id"/>
  <result property="company.companyNickName" column="Agent_Company_Name"/>
  <result property="mobileNo" column="Mobilephone"/>
  <result property="serviceArea" column="Service_Area"/>
  <result property="serviceSpecialty" column="Service_Specialty"/>
  <result property="rmdFeature.payDates" column="Pay_Dates"/>
  <result property="cosineAvgRmd" column="Cosine_Avg_Rmd"/>
  <result property="rmdFeature.rmdTotalCount" column="Rmd_Total_Count"/>
  <result property="rmdFeature.phoneTotalCount" column="Phone_Total_Count"/>
  <result property="rmdFeature.mailTotalCount" column="Mail_Total_Count"/>
  <result property="rmdFeature.totalCount" column="Total_Count"/>
  <result property="rmdFeature.successCount" column="Success_Count"/>
  <result property="rmdFeature.phoneCurDateCount" column="Phone_CurDate_Count"/>
  <result property="rmdFeature.mailCurDateCount" column="Mail_CurDate_Count"/>
 </resultMap>
 
 <select id="findRmdAgentForDispatch" parameterType="com.djb.domain.rmd.RecommendQueryBean" resultMap="rmdAgentUserForDispatch">
    SELECT rmd_feature.Agent_User_Id
      ,rmd_feature.Package_Type
      ,rmd_feature.Agent_User_Name
      ,rmd_feature.Agent_Company_Id
      ,rmd_feature.Agent_Company_Name
      ,rmd_feature.Mobilephone
      ,rmd_feature.Service_Area
      ,rmd_feature.Service_Specialty
      ,rmd_feature.Pay_Dates
      ,rmd_feature.Cosine_Avg_Rmd
      ,rmd_feature.Rmd_Total_Count
      ,rmd_feature.Phone_Total_Count
      ,rmd_feature.Mail_Total_Count
      ,rmd_feature.Total_Count
      ,rmd_feature.Success_Count
      ,rmd_feature.Phone_CurDate_Count
      ,rmd_feature.Mail_CurDate_Count
      ,agentUser.Province 
      ,agentUser.City
      FROM Du_Agent_Detail detail
      INNER JOIN Du_User agentUser ON detail.id = agentUser.id
      INNER JOIN Stat_Rmd_Feature rmd_feature ON rmd_feature.Agent_User_Id = agentUser.id
     WHERE detail.Fee_Status = #{feeStatus}
          AND detail.Verify_Status = #{verifyStatus}
       AND detail.Image_Status = #{imageStatus}
       AND agentUser.Province = #{province.id}
       AND detail.Delete_Flag = '0'
          AND (detail.Rmd_Status &lt;&gt; #{blackListAgent} OR detail.Rmd_Status IS NULL )
       AND rmd_feature.Is_Avg = '0'
       AND NOT EXISTS(
          SELECT 1
            FROM Dp_Tender_Dispatch_Record dispatch
           WHERE dispatch.Agent_Id = detail.id
             AND dispatch.Tender_Id = #{tenderId}
       )
       AND EXISTS(
          SELECT 1
            FROM Du_Agent_Value_Added_Service service
           WHERE service.User_Id = detail.id
             AND service.Service_Id in (1,2)
             AND service.Balance &gt; 0
       )
     
     <!-- 新增 -->
       AND  agentUser.City = #{city.id}
          AND  rmd_feature.Mail_Total_Count &lt;= 15
 </select>
 
</mapper>
==================================== END rmd/RmdAgentUser.xml =========================


==================================== BEGIN rmd/TenderRecommendRecord.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:07:51 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="TenderRecommendRecord">
 <resultMap id="tenderRecommendRecord" type="com.djb.domain.rmd.TenderRecommendRecord" extends="DomainObject.domainObject">
  <result property="tenderType" column="Tender_Type"/>
  <result property="tenderId" column="Tender_Id"/>
  <result property="recommendType" column="Tender_Recommed_Type"/>
  <result property="referId" column="Refer_Id"/>
  <result property="status" column="Tender_Recommend_Status"/>
  <result property="remark" column="Remark"/>
 </resultMap>

 <insert id="insert" parameterType="com.djb.domain.rmd.TenderRecommendRecord">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO
   Dp_Tender_Recommend_Record(
    Tender_Type
    ,Tender_Id
    ,Tender_Recommed_Type
    ,Refer_Id
    ,Tender_Recommend_Status
    ,Remark
    ,Delete_Flag
    ,Create_User_Id
    ,Create_Time
    ,Update_User_Id
    ,Update_Time
  )
  VALUES(
    #{tenderType}
    ,#{tenderId}
    ,#{recommendType}
    ,#{referId}
    ,#{status}
    ,#{remark}
    ,#{deleteFlag}
    ,#{createUserId}
    ,#{createDateTime}
    ,#{updateUserId}
    ,#{updateDateTime}
  )
  
  
 </insert>
 
 <update id="update" parameterType="com.djb.domain.rmd.TenderRecommendRecord">
   UPDATE Dp_Tender_Recommend_Record
     SET
      Tender_Recommend_Status=#{status}
      ,Remark=#{remark}
      ,Delete_Flag=#{deleteFlag}
      ,Update_User_Id=#{updateUserId}
      ,Update_Time=#{updateDateTime}
    WHERE
      Id=#{id}
 </update>
 
</mapper>
==================================== END rmd/TenderRecommendRecord.xml =========================


==================================== BEGIN rmd/RmdProgram.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:07:51 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="RmdProgram">
 
 <cache type="com.djb.cache.MemcachedCache" eviction="LRU" flushInterval="1800000" size="1024"></cache>

 <!-- 查询待推荐的方案列表 -->
 <resultMap id="programFeature" type="com.djb.domain.pro.ProgramFeature">
  <result property="id" column="pgmFeatureId"/>
  <result property="productId" column="Product_Id"/>
  <result property="insuranceFeatureId" column="Insurance_Feature_Id"/>
  <result property="customizeFeature" column="Customize_Feature"/>
  <result property="insuredAmount" column="Insured_Amount"/>
  <result property="priceUnit" column="Price_Unit"/>
 </resultMap>
 
 <resultMap id="rmdAgentUser" type="com.djb.domain.rmd.RmdAgentUser">
  <result property="id" column="agentUserId"/>
  <result property="trueName" column="True_Name"/>
  <result property="mobileNo" column="Mobilephone"/>
  <result property="imagePath" column="Image_Url"/>
  <result property="verifyStatus" column="Verify_Status"/>
  <result property="imageStatus" column="Image_Status"/>
  <result property="company.id" column="Company"/>
  <result property="province.id" column="Province"/>
  <result property="city.id" column="City"/>
  <result property="citySiteName" column="Site_City_Name"/>
  <result property="companyPinyin" column="Company_Name_Pinyin"/>
  <result property="serviceArea" column="Service_Area"/>
  <result property="serviceSpecialty" column="Service_Specialty"/>
  <result property="careerStartTime" column="Career_Start_time"/>
  <result property="cosineAvgRmd" column="cosine_Avg_Rmd"/>
  <result property="rmdFeature.rmdTotalCount" column="Rmd_Total_Count"/>
  <result property="rmdFeature.phoneTotalCount" column="Phone_Total_Count"/>
  <result property="rmdFeature.mailTotalCount" column="Mail_Total_Count"/>
  <result property="rmdFeature.totalCount" column="Total_Count"/>
  <result property="rmdFeature.successCount" column="Success_Count"/>
 </resultMap>
 
 <resultMap id="rmdProgram" type="com.djb.domain.rmd.RmdProgram">
  <result property="id" column="pgmId"/>
  <result property="programName" column="Program_Name"/>
  <result property="totalRemium" column="Total_Premium"/>
  <result property="programType" column="Is_Recommond"/>
  <result property="refreshedTimes" column="Refreshed_Times"/>
  <result property="updateDateTime" column="update_time"/>
  <result property="companyNamePinyin" column="Company_Name_Pinyin"/>
  <result property="remark" column="Remark"/>
  <result property="applicableAge" column="Applicable_Age"/>
  <result property="sex" column="Applicable_Sex"/>
  <result property="siteCityName" column="Site_City_Name"/>
  <collection property="rmdAgentUser" resultMap="RmdProgram.rmdAgentUser"/>
  <collection property="pgmFeatures" resultMap="RmdProgram.programFeature"/>
 </resultMap>
 
 <resultMap id="rmdClickCount" type="com.djb.domain.rmd.RmdProgram">
  <result property="id" column="Id"/>
  <result property="tmpCount" column="Count"/>
 </resultMap>
 
 
 <!-- 查询待推荐的方案列表 -->
 <select id="findRmdPrograms" parameterType="com.djb.domain.rmd.RecommendQueryBean" resultMap="rmdProgram">
    SELECT pf.id pgmFeatureId
      ,pf.Product_Id Product_Id
      ,pf.Insurance_Feature_Id Insurance_Feature_Id
      ,pf.Customize_Feature Customize_Feature
      ,pf.Insured_Amount Insured_Amount
      ,pf.Price_Unit Price_Unit
      ,agent.id agentUserId
      ,agent.True_Name True_Name
      ,agent.Mobilephone Mobilephone
      ,agent.Image_Url Image_Url
      ,agent.Fee_Status Fee_Status
      ,agent.Package_Type Package_Type
      ,agent.Verify_Status Verify_Status
      ,agent.Image_Status Image_Status
      ,agent.Company Company
      ,program.Province
      ,program.City
      ,agent.Service_Area Service_Area
      ,agent.Service_Specialty Service_Specialty
      ,agent.Career_Start_time Career_Start_time
      ,rmd_feature.Cosine_Avg_Rmd Cosine_Avg_Rmd
      ,rmd_feature.Rmd_Total_Count
     ,rmd_feature.Phone_Total_Count
     ,rmd_feature.Mail_Total_Count
     ,rmd_feature.Total_Count
     ,rmd_feature.Success_Count
      ,program.id pgmId
      ,program.Program_Name Program_Name
      ,program.Total_Premium Total_Premium
      ,program.Is_Recommond Is_Recommond
      ,program.Refreshed_Times Refreshed_Times
      ,program.update_time update_time
      ,program.Company_Name_Pinyin Company_Name_Pinyin
      ,program.Remark Remark
      ,program.Applicable_Sex
      ,program.Applicable_Age
      ,Province.City_Name Site_City_Name
       FROM Dp_Program program
  INNER JOIN Du_Agent_Detail agent ON program.User_Id = agent.Id
  INNER JOIN Sm_City Province ON program.Province = Province.Id
   INNER JOIN Stat_Rmd_Feature rmd_feature ON rmd_feature.Agent_User_Id = agent.id AND rmd_feature.Delete_Flag=0
  INNER JOIN Dp_Program_Feature pf ON pf.Program_Id = program.Id
     WHERE agent.Fee_Status = #{feeStatus}
      AND agent.Verify_Status = #{verifyStatus}
      AND agent.Image_Status = #{imageStatus}
      AND (agent.Rmd_Status &lt;&gt; #{blackListAgent} OR agent.Rmd_Status IS NULL )
      AND program.Total_Premium &gt; #{minFee}
      AND program.Total_Premium &lt; #{maxFee}
      AND program.Applicable_Age &gt; #{minAge}
      AND program.Applicable_Age &lt; #{maxAge}
      AND EXISTS(
          SELECT 1
         FROM Dp_Program_Feature pf2
      INNER JOIN Dp_Insurance_Feature iFeature on pf2.Insurance_Feature_Id = iFeature.Id
      INNER JOIN Dp_Insurance_Feature iFeature2 on iFeature.Parent_Id = iFeature2.Id
           WHERE pf2.Program_Id = program.ID
            
         <if test="featureTagIds != null">
             AND iFeature2.Id IN
              <foreach collection="featureTagIds" item="item" separator="," close=")" open="(">
               #{item}
             </foreach>
            </if>
            
         )
      AND NOT EXISTS(
          SELECT 1
            FROM Dp_Tender_Dispatch_Record dispatch
           WHERE dispatch.Agent_Id = agent.id
             AND dispatch.Tender_Id = #{tenderId}
         )
      AND pf.Program_Id = program.Id
      <if test="province != null">
      AND program.Province = #{province.id}
      </if>
     
      AND pf.Delete_Flag = '0'
      AND program.Delete_Flag = '0'
      AND agent.Delete_Flag = '0'
      <!-- 新增 -->
      <if test="city != null">
      AND program.City = #{city.id}
      </if>
     
      AND  rmd_feature.Rmd_Total_Count &lt;= #{maxRmdCount}
 </select>
 
 <!-- 为了减少查询次数，此处一次将方案与店铺的点击数全部查询出来 -->
 <select id="getClickCount" parameterType="java.util.Map" resultMap="rmdClickCount">
  SELECT count(*) Count
     ,Agent_Id Id
    FROM Dp_Agent_Click
   WHERE delete_flag = '0'
     AND Agent_Id in  <foreach collection="agentIds" item="item" separator="," close=")" open="(">
          #{item}
       </foreach>
   GROUP BY Agent_Id
 
 UNION ALL
 
   SELECT count(*) Count
     ,Program_Id Id
    FROM Dp_Program_Click
   WHERE delete_flag = '0'
     AND Program_Id in  <foreach collection="pgmIds" item="item" separator="," close=")" open="(">
            #{item}
          </foreach>
   GROUP BY Program_Id
 </select>
</mapper>
==================================== END rmd/RmdProgram.xml =========================


==================================== BEGIN cs/CustomerServiceLog.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="CustomerServiceLog" >

 <resultMap id="customerServiceLog" type="com.djb.domain.cs.CustomerServiceLog" extends="DomainObject.domainObject" >
  <result property="question.id" column="Question_Id" />
  <result property="logType" column="Log_Type" />
  <result property="employee.id" column="Employee_Id" />
  <result property="remark" column="Remark" />
 </resultMap>

 <select id="load" resultMap="customerServiceLog">
  SELECT  *
    FROM  App_Customer_Service_Log
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>
 
 <select id="findAllLog" resultMap="customerServiceLog">
  SELECT *
    FROM App_Customer_Service_Log
   WHERE delete_flag = 0
     AND Question_Id = #{questionId}
     AND log_type = 1
   ORDER BY Id desc
 </select>
 
 <select id="findReplyLog" resultMap="customerServiceLog">
  SELECT *
    FROM App_Customer_Service_Log
   WHERE delete_flag = 0
     AND log_type = 2
     AND Question_Id = #{questionId}
   ORDER BY Id asc
 </select>

 <update id="update" parameterType="com.djb.domain.cs.CustomerServiceLog" >
  UPDATE  App_Customer_Service_Log
     SET  
   Question_Id=#{question.id}
   ,Log_Type=#{logType}
   ,Employee_Id=#{employee.id}
   ,Remark=#{remark}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   WHERE  id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.cs.CustomerServiceLog" >
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  App_Customer_Service_Log(
   Question_Id
   ,Log_Type
   ,Employee_Id
   ,Remark
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{question.id}
   ,#{logType}
   ,#{employee.id}
   ,#{remark}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey" >
  DELETE FROM  App_Customer_Service_Log
        WHERE  id = #{id}
 </delete>
 
 <select id="getLogByQuestionId" parameterType="long" resultMap="customerServiceLog">
  SELECT * FROM App_Customer_Service_Log
  WHERE Question_Id = #{questionId}
  and Log_Type=2
  and Employee_Id  is not null
  ORDER BY Create_Time
  LIMIT 1 
 </select>
</mapper>

==================================== END cs/CustomerServiceLog.xml =========================


==================================== BEGIN cs/CustomerService.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="CustomerService" >

 <resultMap id="customerService" type="com.djb.domain.cs.CustomerService" extends="DomainObject.domainObject" >
  <result property="content" column="Content" />
  <result property="type" column="Type" />
  <result property="status" column="Status" />
  <result property="isSolved" column="Is_Solved" />
  <result property="satisfyFlag" column="Satisfy_Flag" />
  <result property="unsatisfyReason" column="Unsatisfy_Reason" />
  <result property="acceptDept" column="Accept_Dept" />
  <result property="acceptEmp.id" column="Accept_Emp" />
  <result property="remark" column="Remark" />
  <result property="tender.id" column="Tender_Id"/>
  <result property="questionTypes" column="Question_type"/>
 </resultMap>
 
 <resultMap id="flagCount" type="java.util.HashMap">
  <result property="flag" column="flag" javaType="int"/>
  <result property="count" column="count" javaType="int"/>
 </resultMap>

 <select id="load" resultMap="customerService" >
  SELECT  *
    FROM  Sm_Customer_Service
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>
 
 <select id="statisticPerformance" parameterType="com.djb.domain.cs.CSQueryBean" resultMap="flagCount">
  SELECT flag, count(1) as count
    FROM (
  SELECT (case when Satisfy_Flag is null then 0 else Satisfy_Flag end) as flag 
    FROM Sm_Customer_Service
   WHERE delete_flag = 0
     AND Status = 4
   <if test="acceptDept != null">
     AND Accept_Dept = #{acceptDept}
   </if>
   <if test="rangeStartDate != null">
     AND Create_Time &gt;= #{rangeStartDate}
   </if>
   <if test="rangeEndDate != null">
     AND Create_Time &lt; #{rangeEndDate}
   </if>
    ) t GROUP BY t.flag
 </select>
 
 <sql id="queryForListRef">
  FROM Sm_Customer_Service customer
    LEFT JOIN Du_Agent_Detail agent
    on customer.Create_User_Id=agent.Id
   WHERE customer.delete_flag = 0
   <if test="agentId != null">
     AND customer.Create_User_Id = #{agentId}
   </if>
   <if test="questionId != null">
     AND customer.Id = #{questionId}
   </if>
   <if test="keyword != null">
     AND customer.Content like concat('%', #{keyword}, '%')
   </if>
   <if test="tenderId != null">
      AND customer.Tender_Id=#{tenderId}
   </if>
   <if test="selecttime != null">
     <if test="selecttime == 1">
        <if test="rangeStartDate != null">   
      AND customer.Create_Time &gt;= #{rangeStartDate}    
     </if>   
     <if test="rangeEndDate != null">
      AND customer.Create_Time &lt; #{rangeEndDate}
     </if>
    </if>
    <if test="selecttime == 2">
    AND EXISTS(        
        SELECT 1 from App_Customer_Service_Log log1
        WHERE log1.Question_Id = customer.ID
        and log1.Log_Type=2
        and log1.Employee_Id  is not null 
        and log1.delete_flag = 0
          <if test="rangeStartDate != null">   
		       AND log1.Create_Time &gt;= #{rangeStartDate}    
	      </if>   
	      <if test="rangeEndDate != null">
	    	   AND log1.Create_Time &lt; #{rangeEndDate}
	      </if> 
     )
    </if>
   </if>
   
   <if test="acceptDept != null">
     AND customer.Accept_Dept = #{acceptDept}
   </if>
   <if test="acceptEmp != null">
     AND customer.Accept_Emp = #{acceptEmp.id}
   </if>
   <if test="type != null">
     AND customer.Type = #{type}
   </if>
   <if test="null != status">
   <if test="0 == status">
     AND customer.Status in (1,2,3,5,51)
   </if>
   <if test="5 == status">
     AND customer.Status in (5,51)
   </if>
   <if test="0 != status and 5!=status">
     AND customer.Status = #{status}
   </if>
   </if>
   <if test="satisfyFlag != null">
   <if test="0 == satisfyFlag">
     AND customer.Satisfy_Flag is null
   </if>
   <if test="0 != satisfyFlag">
     AND customer.Satisfy_Flag = #{satisfyFlag}
   </if>
   </if>
    <if test="agentMobilePhone != null">
     AND agent.Mobilephone = #{agentMobilePhone}
   </if>
   <if test="agentName != null">
     AND agent.True_Name = #{agentName}
   </if>
    <if test="findType != null">
      <if test="findType == 1">
        AND  agent.Mobilephone=#{findTypeTel}
      </if>
      <if test="findType == 2">
        AND  customer.Tender_Id=#{findTypeTender}
      </if>
   </if>
 
 </sql>
 
 <select id="statTotalCount" parameterType="com.djb.domain.cs.CSQueryBean" resultType="int">
  SELECT COUNT(*) <include refid="queryForListRef"/>
 </select>
 
 <select id="queryForList" parameterType="com.djb.domain.cs.CSQueryBean" resultMap="customerService">
  SELECT * <include refid="queryForListRef"/>
  ORDER BY customer.create_time DESC
  LIMIT ${startIndex}, ${pageSize}
 </select>
 
 
 <select id="exportForList" parameterType="com.djb.domain.cs.CSQueryBean" resultMap="customerService">
   SELECT customer.*
      FROM Sm_Customer_Service customer
      LEFT JOIN Du_Agent_Detail agent
    on customer.Create_User_Id=agent.Id
   WHERE customer.delete_flag = 0
   <if test="agentId != null">
     AND customer.Create_User_Id = #{agentId}
   </if>
   <if test="questionId != null">
     AND customer.Id = #{questionId}
   </if>
   <if test="keyword != null">
     AND customer.Content like concat('%',#{keyword},'%')
   </if>
   <if test="selecttime != null">
     <if test="selecttime == 1">
        <if test="rangeStartDate != null">   
      AND customer.Create_Time &gt;= #{rangeStartDate}    
     </if>   
     <if test="rangeEndDate != null">
      AND customer.Create_Time &lt; #{rangeEndDate}
     </if>
    </if>
    <if test="selecttime == 2">
    AND EXISTS(        
           SELECT * from(
        SELECT * FROM App_Customer_Service_Log log
        WHERE log.Question_Id = customer.ID
        and log.Log_Type=2
        and log.Employee_Id  is not null 
           ORDER BY log.Create_Time LIMIT 1  
      ) tab
        WHERE tab.delete_flag = 0
           <if test="rangeStartDate != null">   
       AND tab.Create_Time &gt;= #{rangeStartDate}    
      </if>   
      <if test="rangeEndDate != null">
       AND tab.Create_Time &lt; #{rangeEndDate}
      </if>
     )   
    </if>
   </if>
   
   <if test="acceptDept != null">
     AND customer.Accept_Dept = #{acceptDept}
   </if>
   <if test="acceptEmp != null">
     AND customer.Accept_Emp = #{acceptEmp.id}
   </if>
   <if test="type != null">
     AND customer.Type = #{type}
   </if>
   <if test="null != status">
   <if test="0 == status">
     AND customer.Status in (1,2,3,5,51)
   </if>
   <if test="5 == status">
     AND customer.Status in (5,51)
   </if>
   <if test="0 != status and 5!=status">
     AND customer.Status = #{status}
   </if>
   </if> 
    <if test="satisfyFlag != null">
   <if test="0 == satisfyFlag">
     AND customer.Satisfy_Flag is null
   </if>
   <if test="0 != satisfyFlag">
     AND customer.Satisfy_Flag = #{satisfyFlag}
   </if>
   </if> 
    <if test="agentMobilePhone != null">
     AND agent.Mobilephone = #{agentMobilePhone}
   </if>
   <if test="agentName != null">
     AND agent.True_Name = #{agentName}
   </if>
     <if test="findType != null">
      <if test="findType == 1">
        AND  agent.Mobilephone=#{findTypeTel}
      </if>
      <if test="findType == 2">
        AND  customer.Tender_Id=#{findTypeTender}
      </if>
   </if>
 </select>
 
 
 <select id="timeoutList" resultMap="customerService">
  SELECT *
    FROM Sm_Customer_Service 
   WHERE Delete_Flag = 0 
     and Status &lt;> 4 
     and date_add(Update_Time, interval 15 day)  &lt; now()
 </select>
 
 <select id="findByDepartmentName" parameterType="String" resultMap="customerService">
  SELECT *
    FROM Sm_Customer_Service 
    WHERE Delete_Flag = 0 
    and Accept_Dept=#{departmentName}
 </select>
 

 <update id="update" parameterType="com.djb.domain.cs.CustomerService" >
  UPDATE  Sm_Customer_Service
     SET  
   Content=#{content}
   ,Type=#{type}
   ,Status=#{status}
   ,Is_Solved=#{isSolved}
   ,Satisfy_Flag=#{satisfyFlag}
   ,Unsatisfy_Reason=#{unsatisfyReason}
   ,Accept_Dept=#{acceptDept}
   ,Accept_Emp=#{acceptEmp.id}
   ,Remark=#{remark}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   ,Tender_Id=#{tender.id}
   ,Question_type=#{questionTypes}
   WHERE  id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.cs.CustomerService" >
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Sm_Customer_Service(
   Content
   ,Type
   ,Status
   ,Is_Solved
   ,Satisfy_Flag
   ,Unsatisfy_Reason
   ,Accept_Dept
   ,Accept_Emp
   ,Remark
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
   ,Tender_Id
   ,Question_type
  )
  VALUES(
   #{content}
   ,#{type}
   ,#{status}
   ,#{isSolved}
   ,#{satisfyFlag}
   ,#{unsatisfyReason}
   ,#{acceptDept}
   ,#{acceptEmp.id}
   ,#{remark}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
   ,#{tender.id}
   ,#{questionTypes}
  )
 </insert>

 <delete id="deleteByPrimaryKey" >
  DELETE FROM  Sm_Customer_Service
        WHERE  id = #{id}
 </delete>
</mapper>
==================================== END cs/CustomerService.xml =========================


==================================== BEGIN cs/QuickReply.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="QuickReply" >

 <resultMap id="quickReply" type="com.djb.domain.cs.QuickReply" extends="DomainObject.domainObject" >
  <result property="replyContent" column="Reply_Content" />
 </resultMap>
 
 <select id="load" resultMap="quickReply" >
  SELECT  *
    FROM  Sm_Quick_Reply
   WHERE  id = #{id}
 </select>

 <select id="findQuickReplyCountByQueryBean" parameterType="com.djb.domain.cs.QuickReplyQueryBean" resultType="int">
  SELECT count(*)
  FROM Sm_Quick_Reply
 </select>

 <select id="findQuickReplyByQueryBean" parameterType="com.djb.domain.cs.QuickReplyQueryBean" resultMap="quickReply">
  SELECT * FROM Sm_Quick_Reply
  ORDER BY create_time DESC
  LIMIT ${startIndex}, ${pageSize}
 </select>
 
 <select id="findById" resultMap="quickReply">
  SELECT *
    FROM Sm_Quick_Reply 
   WHERE id=#{id}
 </select>

 <update id="update" parameterType="com.djb.domain.cs.QuickReply" >
  UPDATE  Sm_Quick_Reply
     SET  
   Reply_Content=#{replyContent}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   WHERE  id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.cs.QuickReply" >
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO 
   Sm_Quick_Reply(
    Reply_Content       
    ,Create_Time    
    ,Create_User_Id
    ,Update_Time
    ,Update_User_Id
  )VALUES(
    #{replyContent}
    ,#{createDateTime}
    ,#{createUserId}
    ,#{updateDateTime}
    ,#{updateUserId}
  )
 </insert>

 <delete id="delete" parameterType="com.djb.domain.cs.QuickReply">
  DELETE FROM  Sm_Quick_Reply
        WHERE  id = #{id}
 </delete>
</mapper>
==================================== END cs/QuickReply.xml =========================


==================================== BEGIN mall/ValueAddedServicePackItem.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:17:47 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="ValueAddedServicePackItem">

 <resultMap id="valueAddedServicePackItem" type="com.djb.domain.mall.ValueAddedServicePackItem" extends="DomainObject.domainObject">
  <result property="pack.id" column="Package_Id"/>
  <result property="item.id" column="Item_Id"/>
  <result property="quantity" column="Item_Quantity"/>
  <result property="remark" column="Remark"/>
 </resultMap>

 <select id="load" resultMap="valueAddedServicePackItem">
  SELECT  *
    FROM  Sm_Value_Added_Service_Pack_Item
   WHERE  id = #{id}
     AND  delete_flag = 0
 </select>
 
 <select id="findPackItemByPack" parameterType="com.djb.domain.mall.ValueAddedServicePack" resultMap="valueAddedServicePackItem">
  SELECT *
    FROM Sm_Value_Added_Service_Pack_Item
   WHERE delete_flag = 0
     AND Package_Id = #{id}
 </select>

 <update id="update" parameterType="com.djb.domain.mall.ValueAddedServicePackItem">
  UPDATE  Sm_Value_Added_Service_Pack_Item
     SET  
      Package_Id=#{pack.id}
      ,Item_Id=#{item.id}
      ,Item_Quantity=#{quantity}
      ,Remark=#{remark}
      ,Delete_Flag=#{deleteFlag}
      ,Update_User_Id=#{updateUserId}
      ,Update_Time=#{updateDateTime}
   WHERE Id = #{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.mall.ValueAddedServicePackItem">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Sm_Value_Added_Service_Pack_Item(
   Package_Id
   ,Item_Id
   ,Item_Quantity
   ,Remark
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{pack.id}
   ,#{item.id}
   ,#{quantity}
   ,#{remark}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
  
  
 </insert>

</mapper>
==================================== END mall/ValueAddedServicePackItem.xml =========================


==================================== BEGIN mall/Order.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:17:43 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="Order">

 <resultMap id="order" type="com.djb.domain.mall.Order" extends="DomainObject.domainObject">
  <result property="orderNo" column="Order_No"/>
  <result property="agent.id" column="User_Id"/>
  <result property="type" column="Order_Type"/>
  <result property="amount" column="Amount"/>
  <result property="status" column="Status"/>
  <result property="remark" column="Remark"/>
  <result property="signTime" column="Sign_Time"/>
  <result property="seller.id" column="Seller"/>
  <result property="realAmount" column="Real_Amount"/>
  <result property="payType" column="Pay_Type"/>
  <result property="buyScene" column="Buy_Scene"/>
  <result property="createRemark" column="Create_Remark"/>
  <result property="confirmRemark" column="Confirm_Remark"/>
  <result property="confirmTime" column="Confirm_Time"/>
  <result property="remainBalance" column="Remain_Balance"/>
 </resultMap>

 <select id="load" resultMap="order">
  SELECT  *
    FROM  Sm_Order
   WHERE  id = #{id}
     AND  delete_flag = 0
 </select>
 
 <select id="findByOrderNo" parameterType="string" resultMap="order">
  SELECT  *
    FROM  Sm_Order
   WHERE  Order_No = #{orderNo}
     AND  delete_flag = 0
 </select>
 
 <select id="findAgentOrderByStatus" parameterType="java.util.HashMap" resultMap="order">
  SELECT  *
    FROM  Sm_Order
   WHERE  User_Id = #{userId}
     AND Status = #{status}
     AND  delete_flag = 0
 </select>
 
 <select id="findAgentNotPayOrder" parameterType="long" resultMap="order">
  SELECT  *
    FROM  Sm_Order
   WHERE  User_Id = #{userId}
     AND Status = 1
     AND Buy_Scene = 1
     AND Create_time > date_add(now(), interval -7 day)
     AND  delete_flag = 0
 </select>
 
 <sql id="findOrderByQueryBeanRef">
 FROM Sm_Order so
    LEFT JOIN Du_Agent_Detail ad on so.User_Id = ad.Id
    LEFT JOIN Du_User du on du.id = ad.id
   WHERE so.delete_flag = 0
     AND ad.delete_flag = 0
     AND du.delete_flag = 0
   <if test="startTime != null">
     AND so.Create_Time >= #{startTime}
    </if>
    <if test="endTime != null">
      AND so.Create_Time &lt; #{endTime}
    </if>  
   <if test="minPrice != null">
     AND so.Amount &gt;= #{minPrice}
   </if>
   <if test="maxPrice != null">
     AND so.Amount &lt;= #{maxPrice}
   </if>
   <if test="userId != null">
     AND so.User_Id = #{userId}
   </if>
   <if test="orderNo != null">
     AND so.order_No = #{orderNo}
   </if>
   <if test="status != null and status != ''">
     AND so.Status = #{status}
   </if>
   <if test="payType!=null">
   AND so.pay_Type=#{payType}
   </if>
   <if test="customizedKey != null and customizedKey != ''">
   <if test="customizedValue != null and customizedValue != ''">
   <if test="customizedKey == 3">
     AND so.Order_No = #{customizedValue}
   </if>
   <if test="customizedKey == 1">
     AND ad.Mobilephone = #{customizedValue}
   </if>
   <if test="customizedKey == 2">
     AND ad.True_Name = #{customizedValue}
   </if>
   </if>
   </if>
   <if test="orderType != null and orderType != ''">
     AND so.Order_Type = #{orderType}
   </if>
   <if test="signTime != null">
    AND datediff(so.Create_Time, #{signTime}) = 0
   </if>
   <if test="province != null">
     AND du.Province = #{province.id}
   </if>
   <if test="city != null">
     AND du.City = #{city.id}
   </if>
   <if test="channel != null">
     AND so.Buy_Scene = #{channel}
   </if>
   <if test="amount != null">
     AND so.Amount = #{amount}
   </if>
   <if test="orderStatus != null">
    <if test="orderStatus == 1">
      AND so.Status = 1
    </if>
    <if test="orderStatus == 2">
      AND so.Status in (2,4,5)
    </if>
   </if>
 </sql>
 
 <select id="getTotalCount" parameterType="com.djb.domain.mall.OrderQueryBean" resultType="int">
  SELECT count(*) <include refid="findOrderByQueryBeanRef"/>
 </select>
 
 <select id="findOrderByQueryBean" parameterType="com.djb.domain.mall.OrderQueryBean" resultMap="order">
  SELECT * <include refid="findOrderByQueryBeanRef"/>
  <if test="orderByProperties != null">
   ORDER BY ${orderByFiled} 
  </if>
  <if test="orderByProperties == null">
   ORDER BY so.Create_Time DESC
  </if>
  LIMIT ${startIndex}, ${pageSize}
 </select>
 
 <update id="update" parameterType="com.djb.domain.mall.Order">
  UPDATE  Sm_Order
     SET  
    Order_No=#{orderNo}
    ,User_Id=#{agent.id}
    ,Order_Type=#{type}
    ,Amount=#{amount}
    ,Status=#{status}
    ,Remark=#{remark}
    ,Sign_Time=#{signTime}
    ,Seller=#{seller.id}
    ,Real_Amount=#{realAmount}
    ,Pay_Type=#{payType}
    ,Buy_Scene=#{buyScene}
    ,Create_Remark=#{createRemark}
    ,Confirm_Remark=#{confirmRemark}
    ,Confirm_Time=#{confirmTime}
    ,Remain_Balance=#{remainBalance}
    ,Delete_Flag=#{deleteFlag}
    ,Update_User_Id=#{updateUserId}
    ,Update_Time=#{updateDateTime}
   WHERE Id = #{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.mall.Order">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Sm_Order(
   Order_No
   ,User_Id
   ,Order_Type
   ,Amount
   ,Status
   ,Remark
   ,Sign_Time
   ,Seller
   ,Real_Amount
   ,Pay_Type
   ,Buy_Scene
   ,Create_Remark
   ,Confirm_Remark
   ,Confirm_Time
   ,Remain_Balance
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{orderNo}
   ,#{agent.id}
   ,#{type}
   ,#{amount}
   ,#{status}
   ,#{remark}
   ,#{signTime}
   ,#{seller.id}
   ,#{realAmount}
   ,#{payType}
   ,#{buyScene}
   ,#{createRemark}
   ,#{confirmRemark}
   ,#{confirmTime}
   ,#{remainBalance}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
  
  
 </insert>
 
 <select id="findWeixinOrderAmount" parameterType="map" resultType="double">
  SELECT sum(amount) 
    FROM Sm_Order
   WHERE Remark='  增值服务：[微信包月]'
     AND Status=2
 </select>

 <sql id="statOrderByQueryBeanRef">
    FROM Sm_Order so
    LEFT JOIN Du_User du on du.id = so.User_Id
    LEFT JOIN Sm_Employee emp on so.Seller = emp.Id
   WHERE so.delete_flag = 0
     AND du.delete_flag = 0
     AND so.status &lt;> 3
     AND so.id not in (SELECT id FROM Sm_Order WHERE status = 1 and buy_scene = 1)
   <if test="customizedKey == 1">
   <if test="startTime != null">
     AND so.Create_Time >= #{startTime}
    </if>
    <if test="endTime != null">
      AND so.Create_Time &lt; #{endTime}
    </if>
   </if>
   <if test="customizedKey == 2">
   <if test="startTime != null">
     AND so.Confirm_Time >= #{startTime}
    </if>
    <if test="endTime != null">
      AND so.Confirm_Time &lt; #{endTime}
    </if>
   </if>
   <if test="customizedKey == 3">
   <if test="startTime != null">
     AND so.Sign_Time >= #{startTime}
    </if>
    <if test="endTime != null">
      AND so.Sign_Time &lt; #{endTime}
    </if>
   </if>
   <if test="customizedKey == 4">
   <if test="startTime != null and orderType == 1">
     AND so.Confirm_Time >= #{startTime}
     AND so.Order_Type = 1
     AND so.Status = 2
    </if>
    <if test="startTime != null and orderType == 2">
     AND so.Update_Time >= #{startTime}
     AND so.Order_Type = 2
     AND so.Status = 2
    </if>
    <if test="endTime != null and orderType == 1">
      AND so.Confirm_Time &lt; #{endTime}
      AND so.Order_Type = 1
      AND so.Status = 2
    </if>
    <if test="endTime != null and orderType == 2">
      AND so.Update_Time &lt; #{endTime}
      AND so.Order_Type = 2
      AND so.Status = 2
    </if>
   </if>
   <if test="province != null">
     AND du.Province = #{province.id}
   </if>
   <if test="city != null">
     AND du.City = #{city.id}
   </if>
   <if test="itemType != null and itemId != null">
     AND EXISTS (SELECT * FROM Sm_Order_Item WHERE Order_Id = so.Id and Item_Id = #{itemId} and Item_Type = #{itemType})
   </if>
   <if test="sellerId != null">
     AND emp.id = #{sellerId}
   </if>
    <if test="status != null">
     AND so.Status = #{status}
   </if>
   <if test="payType!=null">
     AND so.pay_Type=#{payType}
   </if> 
   <if test="orderType!=null">
     AND so.Order_Type=#{orderType}
   </if>
 
 </sql>

 <select id="statTotalCount" parameterType="com.djb.domain.mall.OrderQueryBean" resultType="int">
  SELECT count(*) <include refid="statOrderByQueryBeanRef"/>
 </select>
 
 <select id="statOrderByQueryBean" parameterType="com.djb.domain.mall.OrderQueryBean" resultMap="order">
  SELECT * <include refid="statOrderByQueryBeanRef"/>
  ORDER BY 
   <if test="customizedKey == 1">
    so.create_time 
   </if>
   <if test="customizedKey == 2">
    so.Confirm_Time 
   </if>
   <if test="customizedKey == 3">
    so.Sign_Time 
   </if>
   <if test="customizedKey == 4">
    so.Confirm_Time 
   </if>
    DESC
  LIMIT ${startIndex}, ${pageSize}
 </select>
 
 <select id="exportOrderByQueryBean" parameterType="com.djb.domain.mall.OrderQueryBean" resultMap="order">
  SELECT so.*
    FROM Sm_Order so
    LEFT JOIN Du_User du on du.id = so.User_Id
    LEFT JOIN Sm_Employee emp on so.Seller = emp.Id
   WHERE so.delete_flag = 0
     AND du.delete_flag = 0
     AND so.status &lt;> 3
     AND so.id not in (SELECT id FROM Sm_Order WHERE status = 1 and buy_scene = 1)   
   <if test="customizedKey == 1">
   <if test="startTime != null">
     AND so.Create_Time >= #{startTime}
    </if>
    <if test="endTime != null">
      AND so.Create_Time &lt; #{endTime}
    </if>
   </if>
   <if test="customizedKey == 2">
   <if test="startTime != null">
     AND so.Confirm_Time >= #{startTime}
    </if>
    <if test="endTime != null">
      AND so.Confirm_Time &lt; #{endTime}
    </if>
   </if>
   <if test="customizedKey == 3">
   <if test="startTime != null">
     AND so.Sign_Time >= #{startTime}
    </if>   
    <if test="endTime != null">
      AND so.Sign_Time &lt; #{endTime}
    </if>
   </if>
   <if test="customizedKey == 4">
   <if test="startTime != null and orderType == 1">
     AND so.Confirm_Time >= #{startTime}
     AND so.Order_Type = 1
     AND so.Status = 2
    </if>
    <if test="startTime != null and orderType == 2">
     AND so.Update_Time >= #{startTime}
     AND so.Order_Type = 2
     AND so.Status = 2
    </if>
    <if test="endTime != null and orderType == 1">
      AND so.Confirm_Time &lt; #{endTime}
      AND so.Order_Type = 1
      AND so.Status = 2
    </if>
    <if test="endTime != null and orderType == 2">
      AND so.Update_Time &lt; #{endTime}
      AND so.Order_Type = 2
      AND so.Status = 2
    </if>
   </if>
   <if test="province != null">
     AND du.Province = #{province.id}
   </if>
   <if test="city != null">
     AND du.City = #{city.id}
   </if>
   <if test="itemType != null and itemId != null">
     AND EXISTS (SELECT * FROM Sm_Order_Item WHERE Order_Id = so.Id and Item_Id = #{itemId} and Item_Type = #{itemType})
   </if>
   <if test="sellerId != null">
     AND emp.id = #{sellerId}
   </if>
    <if test="status != null">
     AND so.Status = #{status}
   </if>
   <if test="payType!=null">
     AND so.pay_Type=#{payType}
   </if>
   <if test="orderType!=null">
     AND so.Order_Type=#{orderType}
   </if>    
   ORDER BY 
   <if test="customizedKey == 1">
    so.create_time 
   </if>
   <if test="customizedKey == 2">
    so.Confirm_Time 
   </if>
   <if test="customizedKey == 3">
    so.Sign_Time 
   </if>
    <if test="customizedKey == 4">
    so.Confirm_Time 
   </if>
    DESC
 </select>
 
 <select id="statAmount" parameterType="com.djb.domain.mall.OrderQueryBean" resultType="map">
  SELECT sum(so.amount) as totalAmount,sum(so.real_amount) as totalRealAmount
    FROM Sm_Order so
    LEFT JOIN Du_User du on du.id = so.User_Id
    LEFT JOIN Sm_Employee emp on so.Seller = emp.Id
   WHERE so.delete_flag = 0
     AND du.delete_flag = 0
     AND so.status &lt;> 3
     AND so.id not in (SELECT id FROM Sm_Order WHERE status = 1 and buy_scene = 1)   
   <if test="customizedKey == 1">
   <if test="startTime != null">
     AND so.Create_Time >= #{startTime}
    </if>
    <if test="endTime != null">
      AND so.Create_Time &lt; #{endTime}
    </if>
   </if>
   <if test="customizedKey == 2">
   <if test="startTime != null">
     AND so.Confirm_Time >= #{startTime}
    </if>
    <if test="endTime != null">
      AND so.Confirm_Time &lt; #{endTime}
    </if>
   </if>
   <if test="customizedKey == 3">
   <if test="startTime != null">
     AND so.Sign_Time >= #{startTime}
    </if>
    <if test="endTime != null">
      AND so.Sign_Time &lt; #{endTime}
    </if>
   </if>
   <if test="customizedKey == 4">
   <if test="startTime != null and orderType == 1">
     AND so.Confirm_Time >= #{startTime}
     AND so.Order_Type = 1
     AND so.Status = 2
    </if>
    <if test="startTime != null and orderType == 2">
     AND so.Update_Time >= #{startTime}
     AND so.Order_Type = 2
     AND so.Status = 2
    </if>
    <if test="endTime != null and orderType == 1">
      AND so.Confirm_Time &lt; #{endTime}
      AND so.Order_Type = 1
      AND so.Status = 2
    </if>
    <if test="endTime != null and orderType == 2">
      AND so.Update_Time &lt; #{endTime}
      AND so.Order_Type = 2
      AND so.Status = 2
    </if>
   </if>
   <if test="province != null">
     AND du.Province = #{province.id}
   </if>
   <if test="city != null">
     AND du.City = #{city.id}
   </if>
   <if test="itemType != null and itemId != null">
     AND EXISTS (SELECT * FROM Sm_Order_Item WHERE Order_Id = so.Id and Item_Id = #{itemId} and Item_Type = #{itemType})
   </if>
   <if test="sellerId != null">
     AND emp.id = #{sellerId}
   </if>
    <if test="status != null">
     AND so.Status = #{status}
   </if>
   <if test="payType!=null">
     AND so.pay_Type=#{payType}
   </if>
   <if test="orderType!=null">
     AND so.Order_Type=#{orderType}
   </if>  
 </select>
 
 <select id="isBuyYearPackage" parameterType="map" resultType="int">
  SELECT * 
    FROM Sm_Order smOrder
   WHERE EXISTS(
   SELECT 1 FROM Sm_Order_Item
   WHERE Item_Type=1
   AND item_id=8
   AND (Is_Open=0 OR Is_Open is Null)
   AND smOrder.id=Order_Id
   AND Delete_Flag=0
  )
  AND user_Id = #{userId}
  AND Status = 2
  AND Delete_Flag=0

 </select>
 
 <select id="findAmountOrderList" parameterType="com.djb.domain.mall.OrderQueryBean" resultMap="order">
  SELECT User_Id,sum(Amount) as Amount 
    FROM Sm_Order
   WHERE status in (2,4,5)
     AND Create_Time &gt;=#{startTime}
     AND Create_Time &lt;=#{endTime}
     AND (Percentage_Status is NULL OR Percentage_Status != 1)
   GROUP BY User_Id
 </select>
 
 <update id="updateOrderByTime" parameterType="com.djb.domain.mall.OrderQueryBean">
   UPDATE Sm_Order
      SET Percentage_Status = 1
    WHERE status in (2,4,5)
     AND Create_Time &gt;=#{startTime}
     AND Create_Time &lt;=#{endTime}   
 </update>  
 
 <select id="findAgentUserOrder" parameterType="com.djb.domain.user.AgentUser" resultMap="order">
    SELECT * 
           FROM Sm_Order
           WHERE Delete_Flag=0
           AND User_Id = #{id}
 </select>
 
 
</mapper>
==================================== END mall/Order.xml =========================


==================================== BEGIN mall/ValueAddedService.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:17:44 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="ValueAddedService">

 <resultMap id="valueAddedService" type="com.djb.domain.mall.ValueAddedService" extends="DomainObject.domainObject">
  <result property="name" column="Name"/>
  <result property="unit" column="Unit"/>
  <result property="remark" column="Remark"/>
  <result property="type" column="Type"/>
 </resultMap>

 <select id="load" resultMap="valueAddedService">
  SELECT  *
    FROM  Sm_Value_Added_Service
   WHERE  id = #{id}
     AND  delete_flag = 0
 </select>
 
 <update id="update" parameterType="com.djb.domain.mall.ValueAddedService">
  UPDATE  Sm_Value_Added_Service
     SET  
      Name=#{name}
      ,Unit=#{unit}
      ,Remark=#{remark}
      ,,Type=#{type}
      ,Delete_Flag=#{deleteFlag}
      ,Update_User_Id=#{updateUserId}
      ,Update_Time=#{updateDateTime}
    WHERE Id = #{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.mall.ValueAddedService">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Sm_Value_Added_Service(
   Name
   ,Unit
   ,Remark
   ,Type
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{name}
   ,#{unit}
   ,#{remark}
   ,#{type}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
  
  
 </insert>

</mapper>
==================================== END mall/ValueAddedService.xml =========================


==================================== BEGIN mall/ValueAddedServicePack.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:17:46 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="ValueAddedServicePack">

 <resultMap id="valueAddedServicePack" type="com.djb.domain.mall.ValueAddedServicePack" extends="DomainObject.domainObject">
  <result property="name" column="Package_Name"/>
  <result property="price" column="Price"/>
  <result property="originPrice" column="Origin_Price"/>
  <result property="status" column="Status"/>
  <result property="remark" column="Remark"/>
 </resultMap>

 <select id="load" resultMap="valueAddedServicePack">
  SELECT  *
    FROM  Sm_Value_Added_Service_Pack
   WHERE  id = #{id}
     AND  delete_flag = 0
 </select>
 
 <select id="findValueAddedServicePackByCity" parameterType="java.util.HashMap" resultMap="valueAddedServicePack">
  SELECT pack.*
    FROM Sm_Value_Added_Pack_Area area
    LEFT JOIN Sm_Value_Added_Service_Pack pack on area.Package_Id = pack.id
   WHERE area.delete_flag = 0
     AND pack.delete_flag = 0
     AND pack.Status = 1
   <if test="city != null">
     and area.Service_Province = #{city.id}
   </if>
 </select>
 
 <select id="getUserBuyCount" parameterType="java.util.HashMap" resultType="int">
  SELECT sum(item.Item_Quantity)
    FROM Sm_Order_Item item
    LEFT JOIN Sm_Order od on item.Order_Id = od.Id
    LEFT JOIN Du_User du on od.User_Id = du.Id
   WHERE od.User_Id = #{userId}
     and item.Item_Type = 2
     and item.Item_Id = #{packId}
     and od.Status = 2
     and od.Create_Time &gt; date_add(now(), interval -30 day)
 </select>

 <update id="update" parameterType="com.djb.domain.mall.ValueAddedServicePack">
  UPDATE  Sm_Value_Added_Service_Pack
     SET  
      Package_Name=#{name}
      ,Price=#{price}
      ,Origin_Price=#{originPrice}
      ,Status=#{status}
      ,Remark=#{remark}
      ,Delete_Flag=#{deleteFlag}
      ,Update_User_Id=#{updateUserId}
      ,Update_Time=#{updateDateTime}
   WHERE Id = #{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.mall.ValueAddedServicePack">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Sm_Value_Added_Service_Pack(
   Package_Name
   ,Price
   ,Origin_Price
   ,Status
   ,Remark
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{name}
   ,#{price}
   ,#{originPrice}
   ,#{status}
   ,#{remark}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
  
  
 </insert>

</mapper>
==================================== END mall/ValueAddedServicePack.xml =========================


==================================== BEGIN mall/OrderItem.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:17:43 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="OrderItem">

 <resultMap id="orderItem" type="com.djb.domain.mall.OrderItem" extends="DomainObject.domainObject">
  <result property="order.id" column="Order_Id"/>
  <result property="item.id" column="Item_Id"/>
  <result property="itemType" column="Item_Type"/>
  <result property="itemQuantity" column="Item_Quantity"/>
  <result property="remark" column="Remark"/>
  <result property="isOpen" column="Is_Open"/>
  <result property="appProductId" column="App_Product_Id"/>
 </resultMap>

 <select id="load" resultMap="orderItem">
  SELECT  *
    FROM  Sm_Order_Item
   WHERE  id = #{id}
     AND  delete_flag = 0
 </select>
 
 <select id="findItemsByOrder" parameterType="com.djb.domain.mall.Order" resultMap="orderItem">
  SELECT  *
    FROM  Sm_Order_Item
   WHERE  Order_Id = #{id}
     AND  delete_flag = 0
 </select>
 
 <select id="findAnnualItem" parameterType="com.djb.domain.mall.Order" resultMap="orderItem">
  SELECT  *
    FROM  Sm_Order_Item
   WHERE  Order_Id = #{id}
     AND  delete_flag = 0
     AND Item_Type = 1
     AND Item_Id = 8
 </select>
 
 <update id="update" parameterType="com.djb.domain.mall.OrderItem">
  UPDATE  Sm_Order_Item
     SET  
      Order_Id=#{order.id}
      ,Item_Id=#{item.id}
      ,Item_Type=#{itemType}
      ,Item_Quantity=#{itemQuantity}
      ,Remark=#{remark}
      ,Is_Open=#{isOpen}
      ,Delete_Flag=#{deleteFlag}
      ,Update_User_Id=#{updateUserId}
      ,Update_Time=#{updateDateTime}
   WHERE Id = #{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.mall.OrderItem">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Sm_Order_Item(
   Order_Id
   ,Item_Id
   ,Item_Type
   ,Item_Quantity
   ,Remark
   ,Is_Open
   ,App_Product_Id
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{order.id}
   ,#{item.id}
   ,#{itemType}
   ,#{itemQuantity}
   ,#{remark}
   ,#{isOpen}
   ,#{appProductId}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
  
  
 </insert>
 
 <select id="findOrderItemMailUser"  resultType="long">
        SELECT DISTINCT User_Id FROM Sm_Order smOrder
          WHERE smOrder.Delete_Flag=0
            AND smOrder.status in (2,4,5)
            AND Order_Type = 2 <!-- 购买的是套餐和增值服务 -->
        AND smOrder.Create_Time >= date_add(now(), interval -1 day)
 </select>
 
 <select id="findOrderItemMail" parameterType="map" resultMap="orderItem">
  SELECT * 
    FROM Sm_Order_Item item
   WHERE item.Delete_Flag = 0
     AND EXISTS(
         SELECT 1 FROM Sm_Order smOrder
           WHERE smOrder.Delete_Flag=0
             AND smOrder.User_Id=#{userId}
             AND item.Order_Id=smOrder.Id
             AND smOrder.status in (2,4,5)
             AND Order_Type = 2<!-- 购买的是套餐和增值服务 -->
     )
    AND item.Create_Time >= date_add(now(), interval -1 day)
 </select>
 
 <select id="findOrderItemList" parameterType="map" resultMap="orderItem">
  SELECT * 
    FROM Sm_Order_Item item
   WHERE item.Delete_Flag = 0
     AND EXISTS(
         SELECT 1 FROM Sm_Order smOrder
           WHERE smOrder.Delete_Flag=0
             AND item.Order_Id=smOrder.Id
             AND smOrder.status in (2,4,5)
     )
   <if test="appProductId != null">
    AND item.App_Product_Id = #{appProductId}
   </if>  
 </select>

</mapper>
==================================== END mall/OrderItem.xml =========================


==================================== BEGIN pro/ProgramClassify.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="ProgramClassify">

 <resultMap id="programClassify" type="com.djb.domain.pro.ProgramClassify"
  extends="DomainObject.domainObject">
  <result property="name" column="Name" />
 </resultMap>

 <select id="load" resultMap="programClassify">
  SELECT *
  FROM Dp_Program_Classify
  WHERE id = #{id}
  AND delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.pro.ProgramClassify">
  UPDATE Dp_Program_Classify
  SET
  Name=#{name}
  ,Delete_Flag=#{deleteFlag}
  ,Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime}
  WHERE id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.pro.ProgramClassify">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO Dp_Program_Classify(
  Name
  ,Delete_Flag
  ,Create_User_Id
  ,Create_Time
  ,Update_User_Id
  ,Update_Time
  )
  VALUES(
  #{name}
  ,#{deleteFlag}
  ,#{createUserId}
  ,#{createDateTime}
  ,#{updateUserId}
  ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey">
  DELETE FROM Dp_Program_Classify
  WHERE id = #{id}
 </delete>

 <select id="findProgramClassifyByProgramClassify" parameterType="com.djb.domain.pro.ProgramClassify"
  resultMap="programClassify">
  SELECT *
  FROM Dp_Program_Classify
  WHERE delete_flag='0'
  <if test="name!=null">
   AND name=#{name}
  </if>
  <if test="createUserId!=null">
   and Create_User_Id=#{createUserId}
  </if>
 </select>

 <sql id="findProgramClassifyByQueryBeanRef">
  FROM Dp_Program_Classify
  WHERE Delete_Flag=0
  <if test="createUserId">
   and Create_User_Id=#{createUserId}
  </if>
 </sql>

 <select id="findProgramClassifyCountByQueryBean" parameterType="com.djb.domain.pro.ProgramClassifyQueryBean"
  resultType="int">
  SELECT COUNT(*) <include refid="findProgramClassifyByQueryBeanRef"/>
 </select>
 <select id="findProgramClassifyByQueryBean" parameterType="com.djb.domain.pro.ProgramClassifyQueryBean"
  resultMap="programClassify">
  SELECT * <include refid="findProgramClassifyByQueryBeanRef"/>
  ORDER BY Create_Time DESC
  LIMIT ${startIndex}, ${pageSize}
 </select>
</mapper>
==================================== END pro/ProgramClassify.xml =========================


==================================== BEGIN pro/Program.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:13:32 
 CST 2013 -->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="Program">

 <cache type="com.djb.cache.MemcachedCache">
  <property name="timeout" value="1800" />
  <property name="disFlushQuery"
   value="findById,findHotRmdPrograms,findCmsRelationPgm,getHotRank,findProgramById" />
 </cache>
 <resultMap id="program" type="com.djb.domain.pro.Program"
  extends="DomainObject.domainObject">
  <result property="agentUser.id" column="User_Id" />
  <result property="status" column="Status" />
  <result property="programName" column="Program_Name" />
  <!-- <result property="classify" column="Insurance_Classify_Id"/> -->
  <result property="programDescription" column="Program_Description" />
  <result property="applicablePeople" column="Applicable_People" />
  <result property="applicableAge" column="Applicable_Age" />
  <result property="sex" column="Applicable_Sex" />
  <result property="totalRemium" column="Total_Premium" />
  <result property="features" column="Program_Feature" />
  <result property="remark" column="Remark" />
  <result property="programDetailFileUrl" column="Program_Detail_File_Url" />
  <result property="programType" column="Is_Recommond" />
  <result property="programCase" column="Program_Case" />
  <result property="programTag" column="Program_Tag" />
  <result property="refreshedTimes" column="Refreshed_Times" />
  <result property="refreshTime" column="Refresh_Time" />
  <result property="companyNamePinyin" column="Company_Name_Pinyin" />
  <result property="solrjIndexStatus" column="Solrj_Index_Status" />
  <result property="updateIndexStatus" column="Update_Index_Status" />
  <result property="isDraft" column="Is_Draft" />
  <result property="applicableAgeStage" column="Applicable_Age_Stage" />
  <result property="quickRecommond" column="Quick_Recommond" />
 </resultMap>

 <resultMap id="rmdProgram" type="com.djb.domain.pro.Program">
  <result property="id" column="id" />
  <result property="programName" column="Program_Name" />
  <result property="classifyString" column="Insurance_Classify_Id" />
  <result property="features" column="Program_Feature" />
  <result property="totalRemium" column="Total_Premium" />
 </resultMap>

 <resultMap id="questionProgram" type="com.djb.domain.pro.Program"
  extends="DomainObject.domainObject">
  <result property="programName" column="Program_Name" />
  <result property="companyNamePinyin" column="Company_Name_Pinyin" />
 </resultMap>

 <resultMap id="classifyCount" type="java.util.HashMap">
  <result property="classify" column="Insurance_Classify_Id" javaType="int"/>
  <result property="count" column="count" javaType="int"/>
 </resultMap>


 <!-- 查询待推荐的方案列表 -->
 <resultMap id="programFeature" type="com.djb.domain.pro.ProgramFeature">
  <result property="id" column="pgmFeatureId" />
  <result property="productId" column="Product_Id" />
  <result property="insuranceFeatureId" column="Insurance_Feature_Id" />
  <result property="customizeFeature" column="Customize_Feature" />
  <result property="insuredAmount" column="Insured_Amount" />
  <result property="priceUnit" column="Price_Unit" />
  <result property="description" column="Description" />
 </resultMap>

 <resultMap id="pgmAgentUser" type="com.djb.domain.user.AgentUser">
  <result property="id" column="agentUserId" />
  <result property="trueName" column="True_Name" />
  <result property="mobileNo" column="Mobilephone" />
  <result property="imagePath" column="Image_Url" />
  <result property="feeStatus" column="Fee_Status" />
  <result property="packageType" column="Package_Type" />
  <result property="verifyStatus" column="Verify_Status" />
  <result property="imageStatus" column="Image_Status" />
  <result property="company.id" column="Company" />
  <result property="serviceArea" column="Service_Area" />
  <result property="serviceSpecialty" column="Service_Specialty" />
  <result property="careerStartTime" column="Career_Start_time" />
  <result property="province.id" column="Province" />
  <result property="city.id" column="City" />
  <result property="wpStatus" column="Wp_Status" />
 </resultMap>

 <resultMap id="loadProgram" type="com.djb.domain.pro.Program">
  <result property="id" column="pgmId" />
  <result property="programName" column="Program_Name" />
  <result property="classifyString" column="Insurance_Classify_Id" />
  <result property="totalRemium" column="Total_Premium" />
  <result property="programType" column="Is_Recommond" />
  <result property="refreshedTimes" column="Refreshed_Times" />
  <result property="updateDateTime" column="update_time" />
  <result property="programCase" column="Program_Case" />
  <result property="companyNamePinyin" column="Company_Name_Pinyin" />
  <result property="remark" column="Remark" />
  <result property="applicableAge" column="Applicable_Age" />
  <result property="applicableAgeStage" column="Applicable_Age_Stage" />
  <result property="sex" column="Applicable_Sex" />
  <result property="programDescription" column="Program_Description" />
  <collection property="agentUser" resultMap="Program.pgmAgentUser" />
  <collection property="pgmFeatures" resultMap="Program.programFeature" />
 </resultMap>

 <resultMap id="programStatus" type="com.djb.domain.pro.Program">
  <result property="status" column="Status" />
  <result property="programTag" column="Program_Tag" />
  <result property="programType" column="Is_Recommond" />
  <result property="isDraft" column="Is_Draft" />
  <result property="quickRecommond" column="Quick_Recommond" />
 </resultMap>

 <resultMap id="pgmProgramProduct" type="com.djb.domain.pro.ProgramProduct">
  <result property="coveragePeriod" column="Coverage_Period" />
  <result property="paymentPeriod" column="Payment_Period" />
  <result property="premium" column="Premium" />
 </resultMap>

 <resultMap id="productRelatedProgram" type="com.djb.domain.pro.Program">
  <result property="id" column="pgmId" />
  <result property="programName" column="Program_Name" />
  <result property="totalRemium" column="Total_Premium" />
  <result property="companyNamePinyin" column="Company_Name_Pinyin" />
  <result property="applicableAge" column="Applicable_Age" />
  <result property="applicableAgeStage" column="Applicable_Age_Stage" />
  <collection property="pgmFeatures" resultMap="Program.programFeature" />
  <collection property="agentUser" resultMap="Program.pgmAgentUser" />
  <collection property="programProduct" resultMap="Program.pgmProgramProduct" />
 </resultMap>

 <select id="findTenderEmail" parameterType="map" resultType="string">
  SELECT email
  FROM Dp_Personal_Tender
  WHERE Id = (SELECT tender_id
  FROM Dp_Tender_Dispatch_Record
  WHERE Agent_Id = #{agentId}
  AND Program_Id = #{programId}
  AND Delete_Flag = 0
  )
 </select>

 <select id="findByIds" resultMap="questionProgram">
  SELECT *
  FROM Dp_Program
  WHERE delete_flag = '0'
  <if test="programIds != null">
   AND Id IN
   <foreach collection="programIds" item="item" separator=","
    close=")" open="(">
    #{item}
   </foreach>
  </if>
 </select>

 <select id="getPgmStatusListByAgent" resultMap="programStatus">
  SELECT Status
  ,Program_Tag
  ,Is_Recommond
  ,Is_Draft ,Quick_Recommond
  FROM Dp_Program
  WHERE delete_flag = '0'
  AND User_Id = #{agentId}
 </select>

 <select id="load" resultMap="loadProgram">
  SELECT pf.id pgmFeatureId
  ,pf.Product_Id Product_Id
  ,pf.Insurance_Feature_Id Insurance_Feature_Id
  ,pf.Customize_Feature Customize_Feature
  ,pf.Insured_Amount Insured_Amount
  ,pf.Price_Unit Price_Unit
  ,pf.Description
  ,agent.id agentUserId
  ,agent.True_Name True_Name
  ,agent.Mobilephone Mobilephone
  ,agent.Image_Url Image_Url
  ,agent.Fee_Status Fee_Status
  ,agent.Image_Status Image_Status
  ,agent.Package_Type Package_Type
  ,agent.Verify_Status Verify_Status
  ,agent.Company Company
  ,agent.Service_Area Service_Area
  ,agent.Service_Specialty Service_Specialty
  ,agent.Career_Start_time Career_Start_time ,agent.Wp_Status
  ,program.id pgmId
  ,program.Program_Name Program_Name
  ,program.Insurance_Classify_Id Insurance_Classify_Id
  ,program.Total_Premium Total_Premium
  ,program.Is_Recommond Is_Recommond
  ,program.Refreshed_Times Refreshed_Times
  ,program.update_time update_time
  ,program.Program_Case Program_Case
  ,program.Company_Name_Pinyin Company_Name_Pinyin
  ,program.Remark Remark
  ,program.Applicable_Sex
  ,program.Applicable_Age ,program.Applicable_Age_Stage
  ,program.Program_Description
  ,agentUser.Province
  ,agentUser.City
  FROM Dp_Program program
  INNER JOIN Du_Agent_Detail agent ON program.User_Id = agent.Id
  INNER JOIN Du_User agentUser ON program.User_Id = agentUser.Id
  LEFT JOIN Dp_Program_Feature pf ON ( pf.Program_Id = program.Id AND
  pf.delete_flag = '0' )
  WHERE program.id = #{id}
  AND program.delete_flag = '0'
  AND agent.delete_flag = '0'
 </select>

 <select id="loalPreNextPgm" parameterType="map"
  resultType="com.djb.domain.pro.Program">
  SELECT program.Id,program.Program_Name as programName
  FROM Dp_Program program
  WHERE program.delete_flag = '0'
  AND program.User_Id=#{userId}
  <if test="condition == 'pre'">
   AND Id &gt; #{id}
   ORDER BY Id
  </if>
  <if test="condition == 'next'">
   AND Id &lt; #{id}
   ORDER BY Id DESC
  </if>
  LIMIT 1
 </select>

 <select id="findById" resultMap="program">
  SELECT *
  FROM Dp_Program
  WHERE id = #{id}
  and delete_flag = 0
 </select>

 <select id="findProgramById" resultMap="loadProgram">
  SELECT pf.id pgmFeatureId
  ,pf.Product_Id Product_Id
  ,pf.Insurance_Feature_Id Insurance_Feature_Id
  ,pf.Customize_Feature Customize_Feature
  ,pf.Insured_Amount Insured_Amount
  ,pf.Price_Unit Price_Unit
  ,pf.Description
  ,agent.id agentUserId
  ,agent.True_Name True_Name
  ,agent.Mobilephone Mobilephone
  ,agent.Image_Url Image_Url
  ,agent.Fee_Status Fee_Status
  ,agent.Image_Status Image_Status
  ,agent.Package_Type Package_Type
  ,agent.Verify_Status Verify_Status
  ,agent.Company Company
  ,agent.Service_Area Service_Area
  ,agent.Service_Specialty Service_Specialty
  ,agent.Career_Start_time Career_Start_time
  ,program.id pgmId
  ,program.Program_Name Program_Name
  ,program.Insurance_Classify_Id Insurance_Classify_Id
  ,program.Total_Premium Total_Premium
  ,program.Is_Recommond Is_Recommond
  ,program.Refreshed_Times Refreshed_Times
  ,program.update_time update_time
  ,program.Program_Case Program_Case
  ,program.Company_Name_Pinyin Company_Name_Pinyin
  ,program.Remark Remark
  ,program.Applicable_Sex
  ,program.Applicable_Age
  ,program.Program_Description
  ,agentUser.Province
  ,agentUser.City
  FROM Dp_Program program
  INNER JOIN Du_Agent_Detail agent ON program.User_Id = agent.Id
  INNER JOIN Du_User agentUser ON program.User_Id = agentUser.Id
  INNER JOIN Dp_Program_Feature pf ON pf.Program_Id = program.Id
  WHERE program.id = #{id}
  AND pf.delete_flag = '0'
  AND agent.delete_flag = '0' AND program.delete_flag='0'
 </select>

 <select id="findProgramByProduct" parameterType="java.util.Map"
  resultMap="productRelatedProgram">
  
  SELECT PF.id pgmFeatureId ,agent.id agentUserId ,agent.True_Name True_Name
  ,agent.Mobilephone Mobilephone ,agent.Image_Url Image_Url
  ,agent.Fee_Status Fee_Status ,agent.Package_Type Package_Type
  ,agent.Verify_Status Verify_Status ,agent.Image_Status Image_Status
  ,agent.Company Company ,agent.Service_Area Service_Area
  ,agent.Service_Specialty Service_Specialty ,agent.Career_Start_time
  Career_Start_time ,agent.Province_Id ,agent.City_Id ,PF.Product_Id
  Product_Id ,PF.Insurance_Feature_Id Insurance_Feature_Id
  ,PF.Customize_Feature Customize_Feature ,PF.Insured_Amount
  Insured_Amount ,PF.Price_Unit Price_Unit ,PF.Description ,PROGRAM.id
  pgmId ,PROGRAM.Program_Name Program_Name ,PROGRAM.Total_Premium
  Total_Premium ,PROGRAM.Company_Name_Pinyin Company_Name_Pinyin
  ,PROGRAM.Applicable_Age Applicable_Age ,PROGRAM.Applicable_Age_Stage
  Applicable_Age_Stage ,PP.Coverage_Period ,PP.Payment_Period
  ,PP.Premium
  
  FROM Dp_Program PROGRAM
  INNER JOIN Du_Agent_Detail agent ON PROGRAM.User_Id = agent.Id 
  INNER JOIN Dp_Program_Product PP ON PP.Program_Id = PROGRAM.Id
  INNER JOIN Dp_Product PRODUCT ON PP.Product_Id = PRODUCT.Id 
  LEFT JOIN Dp_Program_Feature PF ON PF.Program_Id = PROGRAM.Id 
  WHERE PP.Delete_Flag = 0 
  	AND agent.delete_flag = '0'
  	AND PF.delete_flag = '0'
  	AND (agent.Rmd_Status &lt;&gt; #{blackListAgent} OR agent.Rmd_Status IS NULL ) 
  	AND PROGRAM.delete_flag = '0' AND PROGRAM.Id in (select program_id from (
	  SELECT distinct program_id 
	  FROM Dp_Program_Product pp1 
	  WHERE pp1.Product_Id = #{product_id} 
	  and pp1.Delete_Flag = 0 
	  and exists( SELECT * from Dp_Program pgm 
	  	WHERE pgm.Delete_Flag=0 and (pgm.Is_Draft is null or
	  	pgm.Is_Draft=0) and pgm.Status=1 and pgm.Id=pp1.Program_Id ) 
	  order by pp1.Program_Id DESC limit ${size}) A)
 </select>


 <select id="findProgramAboutProductByProduct" parameterType="java.util.Map"
  resultMap="productRelatedProgram">
  SELECT
  PF.id pgmFeatureId
  ,agent.id agentUserId
  ,agent.True_Name True_Name
  ,agent.Mobilephone Mobilephone
  ,agent.Image_Url Image_Url
  ,agent.Fee_Status Fee_Status
  ,agent.Package_Type Package_Type
  ,agent.Verify_Status Verify_Status
  ,agent.Image_Status Image_Status
  ,agent.Company Company
  ,agent.Service_Area Service_Area
  ,agent.Service_Specialty Service_Specialty
  ,agent.Career_Start_time Career_Start_time
  ,agent.Province_Id
  ,agent.City_Id
  ,PF.Product_Id Product_Id
  ,PF.Insurance_Feature_Id Insurance_Feature_Id
  ,PF.Customize_Feature Customize_Feature
  ,PF.Insured_Amount Insured_Amount
  ,PF.Price_Unit Price_Unit
  ,PF.Description
  ,PROGRAM.id pgmId
  ,PROGRAM.Program_Name Program_Name
  ,PROGRAM.Total_Premium Total_Premium
  ,PROGRAM.Company_Name_Pinyin Company_Name_Pinyin
  ,PROGRAM.Applicable_Age Applicable_Age
  ,PROGRAM.Applicable_Age_Stage Applicable_Age_Stage
  ,PP.Coverage_Period
  ,PP.Payment_Period
  ,PP.Premium
  ,ifnull(PROGRAM.Applicable_Age,substring(PROGRAM.Applicable_Age_Stage,1,instr(',',PROGRAM.Applicable_Age_Stage))) applicableAge
  FROM Dp_Program PROGRAM
  INNER JOIN Du_Agent_Detail agent ON PROGRAM.User_Id = agent.Id
  INNER JOIN Dp_Program_Product PP ON PP.Program_Id = PROGRAM.Id
  INNER JOIN Dp_Product PRODUCT ON PP.Product_Id = PRODUCT.Id
  LEFT JOIN Dp_Program_Feature PF ON PF.Program_Id = PROGRAM.Id
  WHERE PP.Delete_Flag = 0
  AND agent.delete_flag = '0'
  AND PF.delete_flag = '0'
  AND (agent.Rmd_Status &lt;&gt; #{blackListAgent} OR agent.Rmd_Status IS NULL )
  AND PROGRAM.delete_flag = '0'
  AND PRODUCT.Id=#{product_id}
  AND PF.Product_Id=PRODUCT.Id
  AND PROGRAM.Id IN (select program_id from 
	  (SELECT distinct program_id
	  FROM Dp_Program_Product pp1
	  WHERE pp1.Product_Id = #{product_id}
		  and pp1.Delete_Flag = 0
		  and exists (
		   SELECT * FROM (
			    SELECT premium ,MAX(program_id) maxProgramId
			    FROM Dp_Program_Product
			    WHERE Delete_Flag=0
			    GROUP BY Premium
		   ) pp2
		   WHERE pp1.Program_Id=pp2.maxProgramId
			   and exists(
				    SELECT pgm.Id FROM Dp_Program pgm
				    WHERE pgm.Delete_Flag=0
				    and (pgm.Is_Draft is null or pgm.Is_Draft=0)
				    and pgm.Status=1
				    and pgm.Id=pp1.Program_Id
			   )
		  )
	  ORDER BY pp1.Program_Id DESC
	  LIMIT ${size}) A
  )
  ORDER BY applicableAge,PP.Premium
 </select>


 <select id="findSEOProgram" parameterType="java.util.Map"
  resultMap="productRelatedProgram">
  SELECT distinct 
  	   PROGRAM.id pgmId
	  ,PROGRAM.Program_Name Program_Name
  FROM Dp_Program PROGRAM
  INNER JOIN Du_Agent_Detail agent ON PROGRAM.User_Id = agent.Id
  INNER JOIN Dp_Program_Product PP ON PP.Program_Id = PROGRAM.Id
  WHERE agent.delete_flag = '0' 
      AND (agent.Rmd_Status &lt;&gt; #{blackListAgent} OR agent.Rmd_Status IS NULL)
	  AND PROGRAM.delete_flag = '0'
	  AND PROGRAM.Status = 1
	  AND (PROGRAM.Is_Draft is null or PROGRAM.Is_Draft=0)
	  AND PROGRAM.Insurance_Classify_Id like '%${classify_id}%'
	  AND PP.delete_flag = '0'
  ORDER BY PROGRAM.Id DESC LIMIT ${size}
  <!-- SELECT
	  PF.id pgmFeatureId
	  ,agent.id agentUserId
	  ,agent.True_Name True_Name
	  ,agent.Mobilephone Mobilephone
	  ,agent.Image_Url Image_Url
	  ,agent.Fee_Status Fee_Status
	  ,agent.Package_Type Package_Type
	  ,agent.Verify_Status Verify_Status
	  ,agent.Image_Status Image_Status
	  ,agent.Company Company
	  ,agent.Service_Area Service_Area
	  ,agent.Service_Specialty Service_Specialty
	  ,agent.Career_Start_time Career_Start_time
	  ,agent.Province_Id
	  ,agent.City_Id
	  ,PF.Product_Id Product_Id
	  ,PF.Insurance_Feature_Id Insurance_Feature_Id
	  ,PF.Customize_Feature Customize_Feature
	  ,PF.Insured_Amount Insured_Amount
	  ,PF.Price_Unit Price_Unit
	  ,pf.Description
	  ,PROGRAM.id pgmId
	  ,PROGRAM.Program_Name Program_Name
	  ,PROGRAM.Total_Premium Total_Premium
	  ,PROGRAM.Company_Name_Pinyin Company_Name_Pinyin
  
  FROM Dp_Program PROGRAM
  INNER JOIN Du_Agent_Detail agent ON program.User_Id = agent.Id
  INNER JOIN Dp_Program_Product PP ON PP.Program_Id = PROGRAM.Id
  INNER JOIN Dp_Product PRODUCT ON PP.Product_Id = PRODUCT.Id
  LEFT JOIN Dp_Program_Feature PF ON PF.Program_Id = PROGRAM.Id
  WHERE PP.Delete_Flag = 0
	  AND agent.delete_flag = '0'
	  AND PF.delete_flag = '0'
	  AND (agent.Rmd_Status &lt;&gt; #{blackListAgent} OR agent.Rmd_Status IS NULL)
	  AND PROGRAM.delete_flag = '0'
	  AND PROGRAM.Id in (
		  SELECT distinct dpp.program_id
		  FROM Dp_Program_Product dpp
		  LEFT JOIN Dp_Program dp on dpp.Program_Id = dp.Id
		  WHERE dpp.Delete_Flag = 0
			  and dp.Delete_Flag = 0
			  and dp.Status=1
			  and (dp.Is_Draft is null or dp.Is_Draft=0)
			  and dp.Insurance_Classify_Id like '%${classify_id}%'
		  ORDER BY dpp.Program_Id DESC LIMIT ${size}
	  ) -->
 </select>

 <select id="getAgentProgramClassifySummary" parameterType="long"
  resultMap="classifyCount">
  SELECT classifyId Insurance_Classify_Id
  ,count(*) count
  FROM (
  SELECT DISTINCT program.Id
  ,product.Insurance_Classify_Id as classifyId
  FROM Dp_Program_Product relate
  LEFT JOIN Dp_Program program on relate.Program_Id = program.Id
  LEFT JOIN Dp_Product product on relate.Product_Id = product.Id
  WHERE program.User_Id = #{agentUserId}
  AND program.Delete_Flag = 0
  AND product.Delete_Flag=0 AND relate.Delete_Flag=0 AND program.Status=1
  AND (program.is_Draft!=1 or program.is_Draft is null)
  ) sub_query
  GROUP BY sub_query.classifyId
 </select>

 <select id="getAgentProgramClassifyCount" parameterType="long"
  resultType="int">
  SELECT count(id)
  FROM Dp_Program
  WHERE User_Id = #{agentUserId}
  AND Delete_Flag = 0
 </select>

 <sql id="findPgmByQueryBeanRef">
  FROM Dp_Program program
  WHERE program.User_Id = #{agentId}
  <if test="classifyValue != null">
   AND EXISTS(
   SELECT 1
   FROM Dp_Product product
   INNER JOIN Dp_Program_Product relate ON relate.Product_Id = product.Id
   WHERE product.Insurance_Classify_Id = #{classifyValue}
   AND relate.Program_Id = program.Id
   AND relate.Delete_Flag = 0
   AND product.Delete_Flag = 0
   )
  </if>
  AND program.Delete_Flag = 0
  AND program.Status = 1
  AND (program.is_Draft!=1 or program.is_Draft is null)
 </sql>

 <!-- 根据QueryBean查询方案列表 -->
 <select id="getPgmCountByQueryBean" parameterType="com.djb.domain.pro.ProgramQueryBean"
  resultType="int">
  SELECT COUNT(*) <include refid="findPgmByQueryBeanRef"/>
 </select>


 <select id="findPgmByQueryBean" parameterType="com.djb.domain.pro.ProgramQueryBean"
  resultMap="program">
  SELECT * <include refid="findPgmByQueryBeanRef"/>
  <if test="orderByProperties != null">
   ORDER BY ${orderByFiled}
  </if>
  LIMIT ${startIndex}, ${pageSize}
 </select>



 <sql id="getPgmByQueryBeanRef">
  FROM Dp_Program
  WHERE Delete_Flag = 0

  <if test="agentId != null">
   and User_Id = #{agentId}
  </if>
  <if test="programName != null">
   and Program_Name like '%${programName}%'
  </if>
  <if test="classify != null">
   and Insurance_Classify_Id like '%${classify}%'
  </if>
  <if test="selectedTab != null">
   <if test="selectedTab == 'total'">
    and Status = 1
   </if>
   <if test="selectedTab == 'recycle'">
    and Status = 0
   </if>
   <if test="selectedTab == 'template'">
    and Program_Tag = 1 and Status = 1
   </if>
   <if test="selectedTab == 'recommend'">
    and Is_Recommond = 1 and Status = 1
   </if>
   <if test="selectedTab == 'unrecommend'">
    and Is_Recommond = 0 and Status = 1
   </if>
   <if test="selectedTab == 'pub'"> and Status = 1 and (Is_Draft=0 or Is_Draft is null)

   </if>
   <if test="selectedTab == 'draft'">
    and Status = 1 and Is_Draft=1

   </if>
   <if test="selectedTab == 'quickRecommend'">
    and Quick_Recommond=1 and Status = 1

   </if>
  </if>
 
 </sql>


 <select id="getCountByQueryBean" parameterType="com.djb.domain.pro.MyPlanProgramQueryBean"
  resultType="int">
  SELECT count(*) <include refid="getPgmByQueryBeanRef"/>
 </select>

 <select id="getPgmByQueryBean" parameterType="com.djb.domain.pro.MyPlanProgramQueryBean"
  resultMap="program" useCache="false">
  SELECT * <include refid="getPgmByQueryBeanRef"/>
  <if test="orderByProperties != null">
   ORDER BY ${orderByFiled}
  </if>
  LIMIT ${startIndex}, ${pageSize}
 </select>

 <insert id="insert" parameterType="com.djb.domain.pro.Program">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO
  Dp_Program(
  Id
  ,User_Id
  ,Status
  ,Program_Name
  ,Insurance_Classify_Id
  ,Program_Description
  ,Applicable_Age
  ,Applicable_Sex
  ,Total_Premium
  ,Program_Feature
  ,Remark
  ,Program_Detail_File_Url
  ,Program_Case
  ,Is_Recommond
  ,Program_Tag
  ,Refreshed_Times
  ,Company_Name_Pinyin
  ,Delete_Flag
  ,Create_User_Id
  ,Create_Time
  ,Update_User_Id
  ,Update_Time ,Province ,City
  ,Is_Draft ,Applicable_Age_Stage
  )VALUES(
  #{id}
  ,#{agentUser.id}
  ,#{status}
  ,#{programName}
  ,#{classifyString}
  ,#{programDescription}
  ,#{applicableAge}
  ,#{sex}
  ,#{totalRemium}
  ,#{features}
  ,#{remark}
  ,#{programDetailFileUrl}
  ,#{programCase}
  ,#{programType}
  ,#{programTag}
  ,#{refreshedTimes}
  ,#{companyNamePinyin}
  ,#{deleteFlag}
  ,#{createUserId}
  ,#{createDateTime}
  ,#{updateUserId}
  ,#{updateDateTime} ,#{agentUser.province.id} ,#{agentUser.city.id}
  ,#{isDraft} ,#{applicableAgeStage}
  )
 </insert>

 <update id="update" parameterType="com.djb.domain.pro.Program">
  UPDATE
  Dp_Program
  SET
  Id=#{id}
  ,User_Id=#{agentUser.id}
  ,Status=#{status}
  ,Program_Name=#{programName}
  ,Insurance_Classify_Id=#{classifyString}
  ,Program_Description=#{programDescription}
  ,Applicable_Age=#{applicableAge}
  ,Applicable_Sex=#{sex}
  ,Total_Premium=#{totalRemium}
  ,Program_Feature=#{features}
  ,Remark=#{remark}
  ,Program_Detail_File_Url=#{programDetailFileUrl}
  ,Program_Case=#{programCase}
  ,Is_Recommond=#{programType}
  ,Program_Tag=#{programTag}
  ,Refreshed_Times=#{refreshedTimes}
  ,Refresh_Time=#{refreshTime}
  ,Company_Name_Pinyin=#{companyNamePinyin}
  ,Delete_Flag=#{deleteFlag}
  ,Create_User_Id=#{createUserId}
  ,Create_Time=#{createDateTime}
  ,Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime}
  ,Update_Index_Status=1
  ,Is_Draft=#{isDraft} ,Applicable_Age_Stage=#{applicableAgeStage}
  WHERE
  id = #{id}
 </update>

 <delete id="deleteByPrimaryKey">
  DELETE FROM
  Dp_Program
  WHERE
  id = #{id}
 </delete>

 <!-- 获取代理人已经推荐的方案数 -->
 <select id="getAgentRecommendNum" parameterType="long"
  resultType="int">
  SELECT COUNT(1)
  FROM Dp_Program
  WHERE User_Id = #{agentId}
  AND Is_Recommond=1
  AND Delete_Flag = 0
 </select>

 <update id="refreshProgram" parameterType="map" flushCache="false">

  UPDATE Dp_Program
  SET Update_User_Id=#{updateUserId}
  ,Refresh_Time=#{updateTime}
  ,Refreshed_Times=Refreshed_Times+1
  ,Update_Time=#{updateTime}
  ,Update_Index_Status=1
  WHERE Id=#{programId}
  AND Refreshed_Times &lt; #{policyRefreshNum} AND User_Id =
  #{updateUserId}

 </update>

 <update id="recommendProgram" parameterType="map">

  UPDATE Dp_Program
  SET Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateTime} ,Refresh_Time=#{updateTime}
  ,Is_Recommond=1
  WHERE Id in ${programId} AND User_Id = #{updateUserId}

 </update>

 <update id="cancelProgram" parameterType="map">

  UPDATE Dp_Program
  SET Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateTime}
  ,Is_Recommond=0
  WHERE Id in ${programId} AND User_Id = #{updateUserId}

 </update>

 <update id="recycleProgram" parameterType="map">

  UPDATE Dp_Program
  SET Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateTime}
  ,Status=0
  ,Is_Recommond=0
  WHERE Id in ${programId} AND User_Id = #{updateUserId}

 </update>

 <update id="delTemplateFlag" parameterType="map">

  UPDATE Dp_Program
  SET Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateTime}
  ,Program_Tag=0
  WHERE Id in ${programId} AND User_Id = #{updateUserId}

 </update>

 <update id="recoverProgram" parameterType="map">

  UPDATE Dp_Program
  SET Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateTime}
  ,Status=1
  WHERE Id in ${programId}
  AND User_Id = #{updateUserId}

 </update>

 <update id="deleteProgram" parameterType="map">

  UPDATE Dp_Program
  SET Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateTime}
  ,Delete_Flag=1
  WHERE Id in ${programId}
  AND User_Id = #{updateUserId}

 </update>

 <update id="deleteProgramByUserId" parameterType="map">

  UPDATE Dp_Program
  SET Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateTime}
  ,Delete_Flag=1
  WHERE User_Id=#{userId}

 </update>

 <select id="findTemplatePgmByAgent" resultMap="program">
  SELECT *
  FROM Dp_Program
  WHERE delete_flag = '0'
  AND User_Id = #{agentId}
  AND Program_Tag = 1
  AND Status = 1
 </select>

 <select id="findAgentProgramCount" parameterType="long"
  resultType="int">
  SELECT COUNT(*)
  FROM Dp_Program
  WHERE delete_flag = 0
  AND User_Id = #{agentId}
  AND Status = 1
 </select>


 <sql id="getPgmListByQueryBeanRef">
  FROM Dp_Program program JOIN Du_Agent_Detail d ON program.User_Id=d.Id
  AND d.Delete_flag=0 AND (d.Rmd_Status &lt;&gt; #{blackListAgent} OR
  d.Rmd_Status IS NULL )
  <if test="searchCity != null and searchCity != ''">
   JOIN Du_User Du_User ON program.User_Id=Du_User.Id
  </if>
  WHERE EXISTS(
  SELECT 1
  FROM Du_User duser
  WHERE duser.Delete_flag=0
  AND
  program.User_Id=duser.Id
  )
  <if test="classifyValue != null">
   AND EXISTS(
   SELECT 1
   FROM Dp_Product product
   INNER JOIN
   Dp_Program_Product relate ON relate.Product_Id = product.Id
   WHERE
   product.Insurance_Classify_Id = #{classifyValue}
   AND relate.Program_Id
   = program.Id
   AND relate.Delete_Flag = 0
   AND product.Delete_Flag = 0
   )
  </if>
  <if test="applicableSex != null">AND
   program.Applicable_Sex=#{applicableSex}
  </if>
  <if test="minPremium != null">
   AND #{minPremium} &lt;= program.Total_Premium
  </if>
  <if test="maxPremium != null">
   AND program.Total_Premium &lt;= #{maxPremium}
  </if>
  <if test="searchCity != null and searchCity != ''">
   AND (Du_User.Province = #{searchCity} OR
   Du_User.City=#{searchCity})
  </if>
  <if test="page != null and page == 'index'">
   AND program.Create_Time &gt;= date_add(now(), interval -10
   day)
  </if>
  AND program.Delete_Flag = 0
  AND program.Status = 1
 </sql>

 <select id="getPgmListCountByQueryBean" parameterType="com.djb.domain.pro.ProgramQueryBean"
  resultType="int">
  SELECT count(*)
  <include refid="getPgmListByQueryBeanRef" />
 </select>

 <select id="getPgmListByQueryBean" parameterType="com.djb.domain.pro.ProgramQueryBean"
  resultMap="program">
  SELECT program.*
  <include refid="getPgmListByQueryBeanRef" />
  <if test="orderByProperties != null">
   ORDER BY ${orderByFiled}
  </if>
  <if test="orderByProperties == null">
   ORDER BY d.Fee_Status ASC,program.Is_Recommond DESC,program.Refresh_Time
   DESC,program.Create_Time DESC
  </if>
  LIMIT ${startIndex}, ${pageSize}
 </select>

 <select id="getHotRank" parameterType="map"
  resultType="com.djb.domain.pro.Program">
  SELECT a.Id AS Id,a.Program_Name as programName FROM Dp_Program
  a,(SELECT c.User_Id,MAX(c.Click_Num) as click_num FROM
  Du_Agent_Detail b,Dp_Program c WHERE b.Id = c.User_Id AND b.Fee_Status
  = 1 AND c.Is_Recommond = 1 AND b.Delete_Flag = 0 AND c.Delete_Flag = 0
  AND c.Status = 1 GROUP BY c.User_Id ORDER BY click_num DESC LIMIT 10) t WHERE
  a.User_Id = t.User_Id AND a.Click_Num = t.click_num ORDER BY
  t.click_num DESC LIMIT 10
 </select>

 <!-- 该方法主要用于加载全文检索同步时的方案， 如果方案是新增方案那么需要将新增方案加入到全文检索中， 如果方案被删除，那么需要将该方案从全文检索中删除， 
  如果方案发生了变化，那么需要更新该全文检索 -->
 <select id="findFullText" resultMap="program" useCache="false">
  SELECT program.*
  FROM Dp_Program program
  JOIN Du_Agent_Detail d ON program.User_Id=d.Id <!-- AND d.Delete_flag=0 AND 
   (d.Rmd_Status &lt;&gt; 1 OR d.Rmd_Status IS NULL ) -->
  WHERE program.Delete_flag = #{delete_flag}
  AND program.Solrj_Index_Status = #{solrjStatus}
       <!-- AND EXISTS( SELECT 1 FROM 
   Du_User duser WHERE duser.Delete_flag=0 AND program.User_Id=duser.Id ) -->
  <if test="updateIndexStatus != null">
   AND program.Update_Index_Status = #{updateIndexStatus}
  </if>

  ORDER BY d.Fee_Status ASC,program.Is_Recommond
  DESC,program.Refresh_Time DESC
 </select>

 <update id="solrUpdate" parameterType="com.djb.domain.pro.Program"
  flushCache="false">
  UPDATE
  Dp_Program
  SET
  Solrj_Index_Status=#{solrjIndexStatus}
  ,Update_Index_Status=#{updateIndexStatus}
  ,Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime}
  WHERE
  id = #{id}
 </update>

 <!-- 查询cms相关方案 -->
 <select id="findCmsRelationPgm" parameterType="map" resultMap="program">
  SELECT * FROM Dp_Program program
  WHERE EXISTS(
  SELECT 1 FROM Dp_Product product, Dp_Program_Product pgmProduct

  WHERE product.id=pgmProduct.product_Id
  AND program.id=pgmProduct.program_Id
  AND EXISTS (
  SELECT 1 FROM Dp_Cms_Content_Classify classify WHERE
  cms_content_id=#{contentId}
  AND classify.Classify_Id=product.Insurance_Classify_Id
  AND classify.delete_Flag=0
  )
  AND product.delete_Flag=0
  AND program.delete_Flag=0
  )
  ORDER BY Click_Num DESC
  LIMIT ${size}
 </select>

 <select id="findHotRmdPrograms" parameterType="map" resultMap="rmdProgram">
  SELECT
  Id
  ,Program_Name
  ,Insurance_Classify_Id
  ,Program_Feature
  ,Total_Premium
  FROM Dp_Program
  WHERE delete_Flag=0
  AND Status = '1'
  AND (Program_Case IS NOT NULL AND length(Program_Case) &gt; 50)
  AND User_Id=#{agentUserId}
  AND Id &lt;&gt; #{curProgramId}
  LIMIT ${size}
 </select>

 <select id="findHotPrograms" parameterType="map" resultMap="program"
  useCache="false">
  SELECT a.Id,a.Program_Name
  FROM Dp_Program a,
  (
  SELECT program_Id ,count(program_Id) as pids
  FROM Dp_Program_Click
  WHERE Update_time > date_add(now(), interval -7 day)
  GROUP BY program_Id
  ) as b
  WHERE a.Delete_Flag=0
  AND a.Status = '1'
  AND (a.Is_Draft=0 or a.Is_Draft is null)
  AND a.id = b.program_Id
  ORDER BY pids DESC
  LIMIT ${size}
 </select>

 <select id="loadSimilarPgm" resultMap="loadProgram">
  SELECT pf.id pgmFeatureId
  ,pf.Product_Id Product_Id
  ,pf.Insurance_Feature_Id Insurance_Feature_Id
  ,pf.Customize_Feature Customize_Feature
  ,pf.Insured_Amount Insured_Amount
  ,pf.Price_Unit Price_Unit
  ,pf.Description
  ,agent.id agentUserId
  ,agent.True_Name True_Name
  ,agent.Mobilephone Mobilephone
  ,agent.Image_Url Image_Url
  ,agent.Fee_Status Fee_Status
  ,agent.Image_Status Image_Status
  ,agent.Package_Type Package_Type
  ,agent.Verify_Status Verify_Status
  ,agent.Company Company
  ,agent.Service_Area Service_Area
  ,agent.Service_Specialty Service_Specialty
  ,agent.Career_Start_time Career_Start_time
  ,program.id pgmId
  ,program.Program_Name Program_Name
  ,program.Insurance_Classify_Id Insurance_Classify_Id
  ,program.Total_Premium Total_Premium
  ,program.Is_Recommond Is_Recommond
  ,program.Refreshed_Times Refreshed_Times
  ,program.update_time update_time
  ,program.Program_Case Program_Case
  ,program.Company_Name_Pinyin Company_Name_Pinyin
  ,program.Remark Remark
  ,program.Applicable_Sex
  ,program.Applicable_Age
  ,program.Program_Description
  ,agentUser.Province
  ,agentUser.City
  FROM Dp_Program program
  INNER JOIN Du_Agent_Detail agent ON program.User_Id = agent.Id
  INNER JOIN Du_User agentUser ON program.User_Id = agentUser.Id
  LEFT JOIN Dp_Program_Feature pf ON ( pf.Program_Id = program.Id AND
  pf.delete_flag = '0' )
  WHERE program.id = (
  SELECT a.Program_Id
  FROM (
  SELECT Program_Id
  ,COUNT(distinct Product_Id) similar
  FROM Dp_Program_Product
  WHERE Delete_Flag = 0
  and Program_Id &lt;> #{id}
  and Product_Id in (
  SELECT distinct Product_Id
  FROM Dp_Program_Product
  WHERE Delete_Flag = 0
  and Program_Id = #{id}
  and Product_Type = 1)
  GROUP BY Program_Id) a
  LEFT JOIN Dp_Program pgm on a.Program_Id = pgm.Id
  WHERE pgm.Delete_Flag = 0
  ORDER BY similar desc, Update_Time DESC LIMIT 1)
  AND program.delete_flag = '0'
  AND agent.delete_flag = '0'
 </select>

 <select id="findLikeTitle" parameterType="com.djb.domain.pro.Program"
  resultMap="program">
  SELECT *
  FROM Dp_Program
  WHERE Delete_Flag = 0
  <if test="agentUser!=null">
   AND User_Id=#{agentUser.id}
  </if>
  <if test="programName!=null">
   AND Program_Name like '%${programName}%'
  </if>
 </select>

 <select id="findProgramCountByProgram" parameterType="com.djb.domain.pro.Program"
  resultType="int">
  SELECT COUNT(1)
  FROM Dp_Program
  WHERE Delete_Flag = 0
  <if test="programType!=null">
   AND Is_Recommond=#{programType}
  </if>
  <if test="isDraft!=null">
   AND Is_Draft=#{isDraft}
  </if>
  <if test="status!=null">
   AND Status=#{status}
  </if>
  <if test="createUserId!=null">
   AND Create_User_Id=#{createUserId}
  </if>
  <if test="quickRecommond!=null">
   AND Quick_Recommond=#{quickRecommond}
  </if>
 </select>

 <update id="quickRecommendProgram" parameterType="map">
  UPDATE
  Dp_Program
  SET Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateTime}
  ,Quick_Recommond=1
  WHERE Id in ${programId}
 </update>
 <update id="cancelQuickRecommendProgram" parameterType="map">
  UPDATE
  Dp_Program
  SET Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateTime}
  ,Quick_Recommond=0
  WHERE Id in ${programId}
 </update>

 <select id="getTop5PgmListByQueryBean" parameterType="com.djb.domain.pro.ProgramQueryBean"
  resultMap="program">
	  SELECT program.*
	  FROM Dp_Program program
	  JOIN Du_Agent_Detail d ON program.User_Id=d.Id AND d.Delete_flag=0 AND
	  (d.Rmd_Status &lt;&gt; #{blackListAgent} OR d.Rmd_Status IS NULL )
	  <if test="searchCity != null and searchCity != ''">
	   JOIN Du_User Du_User ON program.User_Id=Du_User.Id
	  </if>
	  WHERE EXISTS(
		  SELECT 1
		  FROM Du_User duser
		  WHERE duser.Delete_flag=0
		  AND program.User_Id=duser.Id
	  )
	  <if test="classifyValue != null">
	   AND EXISTS(
		   SELECT 1
		   FROM Dp_Product product
		   INNER JOIN Dp_Program_Product relate ON relate.Product_Id = product.Id
		   WHERE product.Insurance_Classify_Id = #{classifyValue}
		   AND relate.Program_Id = program.Id
		   AND relate.Delete_Flag = 0
		   AND product.Delete_Flag = 0
	   )
	  </if>
	  <if test="searchCity != null and searchCity != ''">AND
	   (Du_User.Province = #{searchCity} OR Du_User.City=#{searchCity})
	  </if>
	  AND
	  program.id in
	  (
		  SELECT MAX(id) FROM Dp_Program program1
		  LEFT JOIN Du_User du_user ON program1.User_Id=du_user.Id
		  WHERE program1.Delete_Flag=0
		  AND program1.Status = 1
		  AND length(program1.Program_Name)>6
		  <if test="searchCity != null and searchCity != ''">
		  AND (du_user.Province =#{searchCity} OR du_user.City=#{searchCity})
		  </if>
		  GROUP BY program1.User_Id
	  )
	  AND program.Delete_Flag = 0
	  AND program.Status = 1
	  ORDER BY program.Create_Time DESC
	  LIMIT 5
 </select>
 
 
 <select id="getTopNPgmListByQueryBean" parameterType="com.djb.domain.pro.ProgramQueryBean"
		resultMap="program">
		SELECT top ${size} * FROM(
		SELECT program.*,ROW_NUMBER()OVER( ORDER BY d.Fee_Status
		ASC,program.Is_Recommond DESC,program.Update_Time
		DESC,program.Create_Time DESC
		)AS RowNumber
		FROM Dp_Program program
		JOIN Du_Agent_Detail d ON program.User_Id=d.Id AND d.Delete_flag=0 AND
		(d.Rmd_Status &lt;&gt; #{blackListAgent} OR d.Rmd_Status IS NULL )

		WHERE EXISTS(
		SELECT 1
		FROM Du_User duser
		WHERE duser.Delete_flag=0
		AND program.User_Id=duser.Id
		)
		<if test="page != null and page == 'index'">
			AND program.Create_Time &gt;= DATEADD(DAY,-10,program.Create_Time)
		</if>
		<if test="classifyValue != null">
			AND EXISTS(
			SELECT 1
			FROM Dp_Product product
			INNER JOIN Dp_Program_Product relate ON relate.Product_Id = product.Id
			WHERE product.Insurance_Classify_Id = #{classifyValue}
			AND relate.Program_Id = program.Id
			AND relate.Delete_Flag = 0
			AND product.Delete_Flag = 0
			)
		</if>
		AND program.Delete_Flag = 0
		AND program.Status = 1
		)AS p
		where p.RowNumber=(

		SELECT min(RowNumber) FROM(
		SELECT program.*,ROW_NUMBER()OVER(
		ORDER BY d.Fee_Status ASC,program.Is_Recommond DESC,program.Refresh_Time
		DESC,program.Create_Time DESC
		)AS RowNumber
		FROM Dp_Program program
		JOIN Du_Agent_Detail d ON program.User_Id=d.Id AND d.Delete_flag=0 AND
		(d.Rmd_Status &lt;&gt; #{blackListAgent} OR d.Rmd_Status IS NULL )
		WHERE
		EXISTS(
		SELECT 1
		FROM Du_User duser
		WHERE duser.Delete_flag=0
		AND program.User_Id=duser.Id
		)
		<if test="classifyValue != null">
			AND EXISTS(
			SELECT 1
			FROM Dp_Product product
			INNER JOIN Dp_Program_Product relate ON relate.Product_Id = product.Id
			WHERE product.Insurance_Classify_Id = #{classifyValue}
			AND relate.Program_Id = program.Id
			AND relate.Delete_Flag = 0
			AND product.Delete_Flag = 0
			)
		</if>
		AND program.Delete_Flag = 0
		AND program.Status = 1
		)AS p1
		where p1.User_Id=p.User_Id
		)
	</select>
</mapper>
==================================== END pro/Program.xml =========================


==================================== BEGIN pro/ProgramProduct.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:13:34 
	CST 2013 -->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="ProgramProduct">
	<resultMap id="programProduct" type="com.djb.domain.pro.ProgramProduct"
		extends="DomainObject.domainObject">
		<result property="program.id" column="Program_Id" />
		<result property="product.id" column="Product_Id" />
		<result property="insuranceType" column="Product_Type" />
		<result property="orderNumber" column="Order_Number" />
		<result property="productSimplifyName" column="Product_Simplify_Name" />
		<result property="productCategory" column="Product_Category" />
		<result property="initialFee" column="Initial_Fee" />
		<result property="minReturnRate" column="Min_Return_Rate" />
		<result property="coveragePeriod" column="Coverage_Period" />
		<result property="coveragePeriodUnit" column="Coverage_Period_Unit" />
		<result property="paymentPeriod" column="Payment_Period" />
		<result property="paymentPeriodUnit" column="Payment_Period_Unit" />
		<result property="premium" column="Premium" />
		<result property="remark" column="Remark" />
	</resultMap>

	<select id="load" resultMap="programProduct">
		SELECT *
		FROM Dp_Program_Product
		WHERE id = #{id}
		AND delete_flag = '0'
	</select>

	<select id="findPgmProductsByPgmId" resultMap="programProduct">
		SELECT *
		FROM Dp_Program_Product
		WHERE Program_Id = #{pgmId}
		AND delete_flag = '0'
	</select>


	<update id="update" parameterType="com.djb.domain.pro.ProgramProduct">
		UPDATE
		Dp_Program_Product
		SET
		Id=#{id}
		,Program_Id=#{program.id}
		,Product_Id=#{product.id}
		,Product_Type=#{insuranceType}
		,Order_Number=#{orderNumber}
		,Product_Simplify_Name=#{productSimplifyName}
		,Product_Category=#{productCategory}
		,Initial_Fee=#{initialFee}
		,Min_Return_Rate=#{minReturnRate}
		,Coverage_Period=#{coveragePeriod}
		,Coverage_Period_Unit=#{coveragePeriodUnit}
		,Payment_Period=#{paymentPeriod}
		,Payment_Period_Unit=#{paymentPeriodUnit}
		,Premium=#{premium}
		,Remark=#{remark}
		,Delete_Flag=#{deleteFlag}
		,Create_User_Id=#{createUserId}
		,Create_Time=#{createDateTime}
		,Update_User_Id=#{updateUserId}
		,Update_Time=#{updateDateTime}
		WHERE
		id = #{id}
	</update>

	<insert id="insert" parameterType="com.djb.domain.pro.ProgramProduct">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
		INSERT INTO
		Dp_Program_Product(
		Program_Id
		,Product_Id
		,Product_Type
		,Order_Number
		,Product_Simplify_Name
		,Product_Category
		,Initial_Fee
		,Min_Return_Rate
		,Coverage_Period
		,Coverage_Period_Unit
		,Payment_Period
		,Payment_Period_Unit
		,Premium
		,Remark
		,Delete_Flag
		,Create_User_Id
		,Create_Time
		,Update_User_Id
		,Update_Time
		)
		VALUES(
		#{program.id}
		,#{product.id}
		,#{insuranceType}
		,#{orderNumber}
		,#{productSimplifyName}
		,#{productCategory}
		,#{initialFee}
		,#{minReturnRate}
		,#{coveragePeriod}
		,#{coveragePeriodUnit}
		,#{paymentPeriod}
		,#{paymentPeriodUnit}
		,#{premium}
		,#{remark}
		,#{deleteFlag}
		,#{createUserId}
		,#{createDateTime}
		,#{updateUserId}
		,#{updateDateTime}
		)


	</insert>

	<delete id="deleteByPrimaryKey">
		DELETE FROM
		Dp_Program_Product
		WHERE
		id = #{id}
	</delete>

	<update id="deleteByProgram" parameterType="map">
		UPDATE Dp_Program_Product
		SET Update_User_Id=#{updateUserId}
		,Update_Time=#{updateTime}
		,Delete_Flag=1
		WHERE Program_Id = #{programId}
	</update>

</mapper>
==================================== END pro/ProgramProduct.xml =========================


==================================== BEGIN pro/PgmProgramClassify.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="PgmProgramClassify" >

 <resultMap id="pgmProgramClassify" type="com.djb.domain.pro.PgmProgramClassify" extends="DomainObject.domainObject" >
  <result property="programId" column="Program_Id" />
  <result property="classifyId" column="Classify_Id" />
 </resultMap>

 <select id="load" resultMap="pgmProgramClassify" >
  SELECT  *
    FROM  Dp_Pgm_Program_Classify
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.pro.PgmProgramClassify" >
  UPDATE  Dp_Pgm_Program_Classify
     SET  
   Program_Id=#{programId}
   ,Classify_Id=#{classifyId}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   WHERE  id=#{id}
 </update>
 
 <update id="deleteByClassifyId" parameterType="long">
  UPDATE Dp_Pgm_Program_Classify
  SET Delete_Flag=1
  WHERE Classify_Id=#{classifyId}
 </update>
 
 <update id="deleteByProgramId" parameterType="map">
  UPDATE Dp_Pgm_Program_Classify
  SET Delete_Flag=1
    ,Update_User_Id=#{updateUserId}
     ,Update_Time=#{updateTime}
  WHERE Program_Id in ${programId}
 
 </update>

 <insert id="insert" parameterType="com.djb.domain.pro.PgmProgramClassify" >
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Dp_Pgm_Program_Classify(
   Program_Id
   ,Classify_Id
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{programId}
   ,#{classifyId}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey" >
  DELETE FROM  Dp_Pgm_Program_Classify
        WHERE  id = #{id}
 </delete>
 
 <select id="findByProgramId" parameterType="long" resultMap="pgmProgramClassify">
  SELECT  *
    FROM  Dp_Pgm_Program_Classify
   WHERE  Program_Id = #{Program_id}
     AND  delete_flag='0'
 
 </select>
 
 <select id="findCountByProgramId" parameterType="long" resultType="int">
  SELECT  count(1)
    FROM  Dp_Pgm_Program_Classify
   WHERE  Program_Id = #{Program_id}
     AND  delete_flag='0'
 
 </select>
</mapper>
==================================== END pro/PgmProgramClassify.xml =========================


==================================== BEGIN pro/ProgramFeature.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:13:33 
	CST 2013 -->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="ProgramFeature">
	<resultMap id="pgmFeature" type="com.djb.domain.pro.ProgramFeature"
		extends="DomainObject.domainObject">
		<result property="program.id" column="Program_Id" />
		<result property="prodcut.id" column="Product_Id" />
		<result property="insuranceFeatureId" column="Insurance_Feature_Id" />
		<result property="customizeFeature" column="Customize_Feature" />
		<result property="insuredAmount" column="Insured_Amount" />
		<result property="priceUnit" column="Price_Unit" />
		<result property="description" column="Description" />
	</resultMap>

	<select id="load" resultMap="pgmFeature">
		SELECT *
		FROM Dp_Program
		WHERE id = #{id}
		AND delete_flag = '0'
	</select>

	<select id="findPgmFeaturesByPgmAndPdt" resultMap="pgmFeature">
		SELECT *
		FROM Dp_Program_Feature
		WHERE Program_Id = #{programId}
		AND Product_Id = #{productId}
		AND delete_flag = '0'
	</select>

	<select id="findPgmFeaturesByPgm" resultMap="pgmFeature">
		SELECT *
		FROM Dp_Program_Feature
		WHERE Program_Id = #{programId}
		AND delete_flag = '0'
	</select>

	<delete id="deleteByPrimaryKey">
		DELETE FROM
		Dp_Program_Feature
		WHERE
		id = #{id}
	</delete>

	<update id="deleteByProgram" parameterType="map">
		UPDATE Dp_Program_Feature
		SET Update_User_Id=#{updateUserId}
		,Update_Time=#{updateTime}
		,Delete_Flag=1
		WHERE Program_Id = #{programId}
	</update>

	<insert id="insert" parameterType="com.djb.domain.pro.ProgramFeature">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
		INSERT into
		Dp_Program_Feature(
		Program_Id
		,Insurance_Feature_Id
		,Product_Id
		,Customize_Feature
		,Insured_Amount
		,Price_Unit
		,Description
		,Delete_Flag
		,Create_User_Id
		,Create_Time
		,Update_User_Id
		,Update_Time
		)values(
		#{program.id}
		,#{insuranceFeatureId}
		,#{prodcut.id}
		,#{customizeFeature}
		,#{insuredAmount}
		,#{priceUnit}
		,#{description}
		,#{deleteFlag}
		,#{createUserId}
		,#{createDateTime}
		,#{updateUserId}
		,#{updateDateTime}
		)


	</insert>

</mapper>
==================================== END pro/ProgramFeature.xml =========================


==================================== BEGIN pro/ProductFeature.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:13:31 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="ProductFeature">
 <resultMap id="productFeature" type="com.djb.domain.pro.ProductFeature" extends="DomainObject.domainObject">
  <result property="product.id" column="Product_Id"/>
  <result property="feature.id" column="Insurance_Feature_Id"/>
 </resultMap>
 
 <select id="load" resultMap="productFeature">
  SELECT  *
   FROM Dp_Product_Feature
   WHERE id = #{id} 
    AND delete_flag = '0'
 </select>
 
 <select id="getAll" resultMap="productFeature">
  SELECT  *
   FROM Dp_Product_Feature
   WHERE delete_flag = '0'
 ORDER BY Product_Id
 </select>
 
 <update id="update" parameterType="com.djb.domain.pro.ProductFeature">
  UPDATE
   Dp_Product_Feature
  SET
   Product_Id = #{product.id},
   Insurance_Feature_Id = #{feature.id},
   update_time = #{updateDateTime},
   update_user_id = #{updateUserId},
   delete_flag = #{deleteFlag}
  WHERE
   id = #{id}
 </update>
 
 <insert id="insert" parameterType="com.djb.domain.pro.ProductFeature">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO 
   Dp_Product_Feature(
    Product_Id,
    Insurance_Feature_Id,
    create_time,
    create_user_id,
    update_time,
    update_user_id,
    delete_flag
   )
  VALUES(
   #{product.id},
   #{feature.id},
   #{createDateTime},
   #{createUserId},
   #{updateDateTime},
   #{updateUserId},
   #{deleteFlag}
  )
  
  
 </insert>
 
 <delete id="removeByFKey">
  DELETE FROM 
   Dp_Product_Feature
  WHERE
   Product_Id = #{product.id}
 </delete>
 
 <delete id="deleteByPrimaryKey">
  DELETE FROM 
   Dp_Product_Feature
  WHERE
   id = #{id}
 </delete>
 
 <update id="logicDeleteByFKey">
  UPDATE Dp_Product_Feature
    SET Delete_Flag='1'
   WHERE Product_Id=#{productId}
 </update>
 
</mapper>
==================================== END pro/ProductFeature.xml =========================


==================================== BEGIN pro/ProgramClick.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:13:33 
	CST 2013 -->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="ProgramClick">
	<resultMap id="programClick" type="com.djb.domain.pro.ProgramClick"
		extends="DomainObject.domainObject">
		<result property="programId" column="Program_Id" />
		<result property="programType" column="Program_Type" />
		<result property="cityId" column="City_Id" />
		<result property="agentId" column="Agent_Id" />
		<result property="feeStatus" column="Agent_Type" />
		<result property="userType" column="Visitor_Type" />
		<result property="accessIp" column="Ip_Address" />
	</resultMap>

	<select id="load" resultMap="programClick">
		SELECT *
		FROM Dp_Program_Click
		WHERE id = #{id}
		AND delete_flag = '0'
	</select>

	<select id="hasAccessed" parameterType="java.util.Map"
		resultType="int">
		SELECT count(*)
		FROM Dp_Program_Click
		WHERE Program_Id = #{programId}
		AND Ip_Address = #{ip}
		AND delete_flag = '0'
	</select>

	<select id="getAccessCount" resultType="int">
		SELECT count(*)
		FROM Dp_Program_Click
		WHERE Program_Id = #{programId}
		AND delete_flag = '0'
	</select>

	<update id="update" parameterType="com.djb.domain.pro.ProgramClick">
		UPDATE Dp_Program_Click
		SET
		Program_Id=#{programId}
		,Program_Type=#{programType}
		,City_Id=#{cityId}
		,Agent_Id=#{agentId}
		,Agent_Type=#{feeStatus}
		,Visitor_Type=#{userType}
		,Ip_Address=#{accessIp}
		,Delete_Flag=#{deleteFlag}
		,Create_User_Id=#{createUserId}
		,Create_Time=#{createDateTime}
		,Update_User_Id=#{updateUserId}
		,Update_Time=#{updateDateTime}
		WHERE id=#{id}
	</update>

	<insert id="insert" parameterType="com.djb.domain.pro.ProgramClick">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
		INSERT INTO
		Dp_Program_Click(
		Program_Id
		,Program_Type
		,City_Id
		,Agent_Id
		,Agent_Type
		,Visitor_Type
		,Ip_Address
		,Delete_Flag
		,Create_User_Id
		,Create_Time
		,Update_User_Id
		,Update_Time
		)VALUES(
		#{programId}
		,#{programType}
		,#{cityId}
		,#{agentId}
		,#{feeStatus}
		,#{userType}
		,#{accessIp}
		,#{deleteFlag}
		,#{createUserId}
		,#{createDateTime}
		,#{updateUserId}
		,#{updateDateTime}
		)


	</insert>

	<delete id="deleteByPrimaryKey">
		DELETE FROM
		Dp_Program_Click
		WHERE
		id = #{id}
	</delete>

	<select id="loadProgramByIp" parameterType="java.util.Map"
		resultMap="programClick">
		SELECT *
		FROM Dp_Program_Click
		WHERE Program_Id = #{programId}
		AND Ip_Address = #{ip}
		AND delete_flag = '0'
	</select>
</mapper>
==================================== END pro/ProgramClick.xml =========================


==================================== BEGIN pro/ProductClick.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="ProductClick" >

 <resultMap id="productClick" type="com.djb.domain.pro.ProductClick" extends="DomainObject.domainObject" >
  <result property="productId" column="Product_Id" />
  <result property="userId" column="User_Id" />
  <result property="userType" column="User_Type" />
  <result property="ipAddress" column="Ip_Address" />
 </resultMap>

 <select id="load" resultMap="productClick" >
  SELECT  *
    FROM  Dp_Product_Click
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.pro.ProductClick" >
  UPDATE  Dp_Product_Click
     SET  
   Product_Id=#{productId}
   ,User_Id=#{userId}
   ,User_Type=#{userType}
   ,Ip_Address=#{ipAddress}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   WHERE  id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.pro.ProductClick" >
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Dp_Product_Click(
   Product_Id
   ,User_Id
   ,User_Type
   ,Ip_Address
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{productId}
   ,#{userId}
   ,#{userType}
   ,#{ipAddress}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey" >
  DELETE FROM  Dp_Product_Click
        WHERE  id = #{id}
 </delete>
 
 <select id="loadProductClickByIp" parameterType="java.util.Map" resultMap="productClick">
  SELECT *
    FROM Dp_Product_Click
   WHERE Product_Id = #{productId}
     AND Ip_Address = #{ip} 
     AND delete_flag = '0'
 </select>
</mapper>
==================================== END pro/ProductClick.xml =========================


==================================== BEGIN pro/InsuranceFeature.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:13:30 
 CST 2013 -->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="InsuranceFeature">

 <cache type="com.djb.cache.MemcachedCache">
  <property name="timeout" value="7200" />
 </cache>
 <resultMap id="insuranceFeature" type="com.djb.domain.pro.InsuranceFeature"
  extends="DomainObject.domainObject">
  <result property="name" column="Name" />
  <result property="value" column="Value" />
  <result property="parentId" column="Parent_Id" />
  <result property="type" column="Type" />
 </resultMap>

 <resultMap id="groupInsuranceFeature" type="com.djb.domain.pro.InsuranceFeature">
  <result property="id" column="classify_id" />
  <result property="name" column="classify_name" />
  <result property="value" column="classify_value" />
  <result property="type" column="classify_type" />
  <collection property="childFeatures" resultMap="InsuranceFeature.insuranceFeature" />
 </resultMap>

 <select id="load" resultMap="insuranceFeature" useCache="false">
  SELECT *
  FROM Dp_Insurance_Feature
  WHERE id = #{id}
  AND delete_flag = '0'
 </select>

 <select id="loadByValue" resultMap="insuranceFeature">
  SELECT *
  FROM Dp_Insurance_Feature
  WHERE value = #{value}
  AND delete_flag = '0'
 </select>

 <select id="findFeatureByProduct" resultMap="insuranceFeature">
  SELECT DP_IF.*
  FROM Dp_Insurance_Feature DP_IF
  INNER JOIN Dp_Product_Feature PF ON DP_IF.id = PF.Insurance_Feature_Id
  WHERE PF.Product_Id = #{productId}
  AND PF.Delete_Flag = '0'
 </select>

 <select id="findFeatureByTender" resultMap="insuranceFeature">
  SELECT DP_IF.*
  FROM Dp_Insurance_Feature DP_IF
  INNER JOIN Dp_Tender_Feature TF ON DP_IF.id = TF.Insurance_Feature_Id
  WHERE TF.Tender_Id = #{tenderId}
  AND TF.delete_flag = '0'
 </select>

 <select id="findProductFeatureTag" resultMap="insuranceFeature">
  SELECT TAG.*
  FROM Dp_Insurance_Feature TAG
  INNER JOIN Dp_Insurance_Classify CLASSIFY ON CLASSIFY.Id = TAG.Parent_Id
  WHERE CLASSIFY.Value = #{selectedValue}
  AND TAG.Type = 2
  ORDER BY TAG.ID
 </select>

 <select id="findTenderFeatureTag" resultMap="insuranceFeature">
  SELECT TAG.*
  FROM Dp_Insurance_Feature TAG
  INNER JOIN Dp_Insurance_Classify CLASSIFY ON CLASSIFY.Id = TAG.Parent_Id
  WHERE CLASSIFY.Value = #{selectedValue}
  AND TAG.Type = 2
  AND TAG.Choice_Flag = 0
  ORDER BY TAG.ID
 </select>

 <select id="findFeatureByTags" parameterType="java.util.Map"
  resultMap="insuranceFeature">
  SELECT *
  FROM Dp_Insurance_Feature IFEATURE
  INNER JOIN Dp_Insurance_Feature TAG ON IFEATURE.Parent_Id = TAG.Id
  WHERE TAG.Type = 2
  AND TAG.ID IN
  <foreach collection="selectedTagValue" item="item" separator=","
   close=")" open="(">
   #{item}
  </foreach>
  ORDER BY IFEATURE.ID
 </select>

 <select id="findGroupFeatures" resultMap="groupInsuranceFeature">
  SELECT CLASSIFY.id
  classify_id
  ,CLASSIFY.Name classify_name
  ,CLASSIFY.Value classify_value
  ,CLASSIFY.Type classify_type
  ,TAG.*
  FROM Dp_Insurance_Feature CLASSIFY
  INNER JOIN Dp_Insurance_Feature TAG ON CLASSIFY.ID = TAG.Parent_Id
  WHERE CLASSIFY.Type = #{type}
  AND CLASSIFY.Delete_Flag = '0'
  ORDER BY TAG.ID
 </select>

 <select id="getAll" resultMap="insuranceFeature">
  SELECT *
  FROM Dp_Insurance_Feature
  WHERE delete_flag = '0'
 </select>

 <select id="findProductFeatureByProductId" resultMap="insuranceFeature">
  select
  dif.*
  FROM Dp_Product_Feature dpf
  LEFT JOIN Dp_Insurance_Feature dif on dpf.Insurance_Feature_Id = dif.Id
  WHERE dpf.Product_Id = #{productId}
  and dif.type = 1
  and dpf.Delete_Flag = 0
  and dif.Delete_Flag = 0
 </select>

 <insert id="insert" parameterType="com.djb.domain.pro.InsuranceFeature">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO
  Dp_Insurance_Feature(
	Name
  ,Value
  ,Parent_Id
  ,Type
  ,Delete_Flag
  ,Create_User_Id
  ,Create_Time
  ,Update_User_Id
  ,Update_Time
  )VALUES(
  #{name}
  ,#{value}
  ,#{parentId}
  ,#{type}
  ,#{deleteFlag}
  ,#{createUserId}
  ,#{createDateTime}
  ,#{updateUserId}
  ,#{updateDateTime}
  )
 </insert>

 <update id="update" parameterType="com.djb.domain.pro.InsuranceFeature">
  UPDATE
  Dp_Insurance_Feature
  SET
  Name=#{name}
  ,Value=#{value}
  ,Parent_Id=#{parentId}
  ,Type=#{type}
  ,Delete_Flag=#{deleteFlag}
  ,Create_User_Id=#{createUserId}
  ,Create_Time=#{createDateTime}
  ,Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime}
 </update>

 <delete id="deleteByPrimaryKey">
  DELETE FROM
  Dp_Insurance_Feature
  WHERE
  id = #{id}
 </delete>

</mapper>
==================================== END pro/InsuranceFeature.xml =========================


==================================== BEGIN pro/Product.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:13:31 
 CST 2013 -->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="Product">

 <cache type="com.djb.cache.MemcachedCache">
  <property name="timeout" value="7200" />
 </cache>
 <resultMap id="product" type="com.djb.domain.pro.Product"
  extends="DomainObject.domainObject">
  <result property="company.id" column="Company_Id" />
  <result property="classify.id" column="Insurance_Classify_Id" />
  <result property="insuranceSubclassId.id" column="Insurance_Subclass_Id" />
  <result property="insuranceType" column="Type" />
  <result property="productType" column="Product_Type" />
  <result property="title" column="Title" />
  <result property="simplifyName" column="Simplify_Name" />
  <result property="titlePinyin" column="Title_Pinyin" />
  <result property="applicableAge" column="Applicable_Age" />
  <result property="applicablePeople" column="Applicable_People" />
  <result property="insuranceCoveragePeriod" column="Insurance_Coverage_Period" />
  <result property="status" column="Status" />
  <result property="attentionCount" column="Attention_Count" />
  <result property="solrjIndexStatus" column="Solrj_Index_Status" />
  <result property="updateIndexStatus" column="Update_Index_Status" />
  <association property="features"
   select="InsuranceFeature.findFeatureByProduct" column="id" />
 </resultMap>

 <resultMap id="questionProduct" type="com.djb.domain.pro.Product"
  extends="DomainObject.domainObject">
  <result property="company.id" column="Company_Id" />
  <result property="company.companyNamePinyin" column="Company_Name_Pinyin" />
  <result property="title" column="Title" />
  <result property="simplifyName" column="Simplify_Name" />
  <result property="titlePinyin" column="Title_Pinyin" />
 </resultMap>

 <resultMap id="companyProductCount" type="com.djb.domain.Company">
  <result property="id" column="company" />
  <result property="productCount" column="count" />
  <result property="displayOrder" column="Display_Order" />
  <result property="companyNickName" column="Company_Nick_Name" />
  <result property="companyNamePinyin" column="Company_Name_Pinyin" />
 </resultMap>

 <select id="load" resultMap="product">
  SELECT *
  FROM Dp_Product
  WHERE id = #{uuid}
  AND delete_flag = '0'
 </select>

 <select id="getAll" resultMap="product">
  SELECT *
  FROM Dp_Product
  WHERE delete_flag = '0'
 </select>

 <select id="findByIds" resultMap="questionProduct">
  SELECT *
  FROM Dp_Product product
  INNER JOIN Sm_Company company on product.Company_Id = company.Id
  WHERE product.delete_flag = '0'
  <if test="productIds != null">
   AND product.Id IN
   <foreach collection="productIds" item="item" separator=","
    close=")" open="(">
    #{item}
   </foreach>
  </if>
 </select>

 <select id="getByTitlePinyin" parameterType="java.util.Map"
  resultMap="product">
  SELECT PRODUCT.*
  FROM Dp_Product PRODUCT
  INNER JOIN Sm_Company COMPANY ON COMPANY.Id = PRODUCT.Company_Id
  WHERE Title_Pinyin = #{titlePinyin}
  AND COMPANY.Company_Name_Pinyin = #{companyPyinyin}
  AND PRODUCT.delete_flag = '0'
 </select>

 <select id="getByTitle" resultMap="product">
  SELECT *
  FROM Dp_Product
  WHERE Title = #{title}
  AND delete_flag = '0'
 </select>

 <select id="getClassifyProCount" resultType="java.util.HashMap">
  SELECT
  CLASSIFY.value classify, COUNT(*) count
  FROM Dp_Product PRODUCT
  INNER JOIN Dp_Insurance_Classify CLASSIFY ON PRODUCT.Insurance_Classify_Id = CLASSIFY.ID
  WHERE PRODUCT.delete_flag = '0'
  GROUP BY CLASSIFY.value
 </select>

 <select id="getTotalCount" resultType="int">
  SELECT count(*)
  FROM Dp_Product
  WHERE delete_flag = '0'
 </select>

 <select id="getCompanyProCount" resultMap="companyProductCount">
  SELECT Company_Id
  company,
  COUNT(*) count,
  COMPANY.Display_Order,
  COMPANY.Company_Nick_Name,
  COMPANY.Company_Name_Pinyin
  FROM Dp_Product PRODUCT
  LEFT JOIN Sm_Company COMPANY ON COMPANY.Id = PRODUCT.Company_Id
  WHERE PRODUCT.delete_flag = '0'
  GROUP BY Company_Id,
  COMPANY.Display_Order,
  COMPANY.Company_Nick_Name,
  COMPANY.Company_Name_Pinyin
  ORDER BY COMPANY.Display_Order
 </select>

 <!-- 该方法主要用于加载全文检索同步时的产品， 如果产品是新增产品那么需要将新增产品加入到全文检索中， 如果产品被删除，那么需要将该产品从全文检索中删除， 
  如果产品发生了变化，那么需要更新该全文检索 -->
 <select id="findFullText" resultMap="product" useCache="false">
  SELECT *
  FROM Dp_Product
  WHERE delete_flag = #{delete_flag}
  AND Solrj_Index_Status = #{solrjStatus}

  <if test="updateIndexStatus != null">
   AND Update_Index_Status = #{updateIndexStatus}
  </if>
  AND Status = 1
 </select>

 <!-- 查找相同分类的产品 -->
 <select id="findSameClassifyPros" parameterType="java.util.Map"
  resultMap="product">
  SELECT  *
  FROM Dp_Product PRODUCT
  WHERE PRODUCT.Insurance_Classify_Id = #{classifyId}
  AND PRODUCT.id != #{cur_product_id}
  AND delete_flag = '0'
  AND PRODUCT.status='1'
  ORDER BY PRODUCT.Attention_Count DESC,
  PRODUCT.Create_Time DESC
  LIMIT ${size}
 </select>


 <sql id="findByQueryBeanRef">
  FROM Dp_Product PRODUCT
  LEFT JOIN Sm_Company COMPANY ON PRODUCT.Company_Id = COMPANY.id
  WHERE PRODUCT.delete_flag='0'
  <if test="productName != null">
   AND title like '%${productName}%'
  </if>
  
  <if test="companyName != null">
   AND Company_Name like '%${companyName}%'
  </if>

  <if test="companyNamePinyin != null">
   AND Company_Name_Pinyin = #{companyNamePinyin}
  </if>

  <if test="classify != null">
   AND Insurance_Classify_Id = #{classify.id}
  </if>

  <if test="subClassify != null">
   AND Insurance_Subclass_Id = #{subClassify.id}
  </if>

  <if test="formDate != null">
   AND PRODUCT.Create_Time &gt;= #{formDate}
  </if>

  <if test="toDate != null">
   AND PRODUCT.Create_Time &lt;= #{toDate}
  </if>

  <if test="isSpider">
   AND PRODUCT.Spilder_Access_Time &gt; now()
  </if>

  <if test="featureIds != null">
   <foreach collection="featureIds" item="item">
    AND EXISTS (
    SELECT 1
    FROM Dp_Insurance_Feature AS FEATURE
    INNER JOIN Dp_Product_Feature AS PF ON PF.Insurance_Feature_Id =
    FEATURE.id
    WHERE PRODUCT.Id = PF.Product_Id
    AND FEATURE.Id = #{item}
    AND FEATURE.delete_flag='0'
    AND PF.delete_flag='0'
    )
   </foreach>
  </if>
 </sql>
 
 <!-- 根据queryBean， 查找产品个数 -->
 <select id="getCountByQueryBean" parameterType="com.djb.domain.pro.ProductQueryBean"
  resultType="int">
  SELECT COUNT(*)
  <include refid="findByQueryBeanRef" />
 </select>
 
 <!-- 根据queryBean， 查找产品指定页的数据 -->
 <select id="findByQueryBean" parameterType="com.djb.domain.pro.ProductQueryBean"
  resultMap="product">
  SELECT PRODUCT.*
  <if test="frontList">
   ,(SELECT COUNT(1) FROM Dq_Question QUESTION
   WHERE PRODUCT.Id = QUESTION.Refer_Id
   AND QUESTION.Delete_Flag = '0'
   AND QUESTION.Type = 3
   AND QUESTION.Status !=13) AS QUESTIONCOUNT
  </if>
  <include refid="findByQueryBeanRef" />
  ORDER BY
  <if test="frontList">Status DESC, QUESTIONCOUNT DESC,</if>
  update_time DESC
  LIMIT ${startIndex}, ${pageSize}
 </select>


 <insert id="insert" parameterType="com.djb.domain.pro.Product">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO
  Dp_Product(
  Company_Id
  ,Insurance_Classify_Id
  ,Insurance_Subclass_Id
  ,Type
  ,Product_Type
  ,Title
  ,Simplify_Name
  ,Title_Pinyin
  ,Applicable_Age
  ,Applicable_People
  ,Insurance_Coverage_Period
  ,Status
  ,Attention_Count
  ,Solrj_Index_Status
  ,Update_Index_Status
  ,Delete_Flag
  ,Create_User_Id
  ,Create_Time
  ,Update_User_Id
  ,Update_Time
  ,Spilder_Access_Time
  )VALUES(
  #{company.id}
  ,#{classify.id}
  ,#{insuranceSubclassId.id}
  ,#{insuranceType}
  ,#{productType}
  ,#{title}
  ,#{simplifyName}
  ,#{titlePinyin}
  ,#{applicableAge}
  ,#{applicablePeople}
  ,#{insuranceCoveragePeriod}
  ,#{status}
  ,#{attentionCount}
  ,#{solrjIndexStatus}
  ,#{updateIndexStatus}
  ,#{deleteFlag}
  ,#{createUserId}
  ,#{createDateTime}
  ,#{updateUserId}
  ,#{updateDateTime}
  ,now()
  )
 </insert>

 <update id="solrUpdate" parameterType="com.djb.domain.pro.Product"
  flushCache="false">
  UPDATE
  Dp_Product
  SET
  Solrj_Index_Status=#{solrjIndexStatus}
  ,Update_Index_Status=#{updateIndexStatus}
  ,Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime}
  WHERE
  id = #{id}
 </update>

 <update id="update" parameterType="com.djb.domain.pro.Product">
  UPDATE
  Dp_Product
  SET
  Company_Id=#{company.id}
  ,Insurance_Classify_Id=#{classify.id}
  ,Insurance_Subclass_Id=#{insuranceSubclassId.id}
  ,Type=#{insuranceType}
  ,Product_Type=#{productType}
  ,Title=#{title}
  ,Simplify_Name=#{simplifyName}
  ,Title_Pinyin=#{titlePinyin}
  ,Applicable_Age=#{applicableAge}
  ,Applicable_People=#{applicablePeople}
  ,Insurance_Coverage_Period=#{insuranceCoveragePeriod}
  ,Status=#{status}
  ,Attention_Count=#{attentionCount}
  ,Solrj_Index_Status=#{solrjIndexStatus}
  ,Update_Index_Status=#{updateIndexStatus}
  <if test="deleteFlag != null">
   ,Delete_Flag=#{deleteFlag}
  </if>
  <if test="createUserId != null">
   ,Create_User_Id=#{createUserId}
  </if>
  <if test="createDateTime != null">
   ,Create_Time=#{createDateTime}
  </if>
  ,Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime}
  ,Spilder_Access_Time=now()
  WHERE
  id = #{id}
 </update>

 <update id="updateAttention" parameterType="com.djb.domain.pro.Product"
  flushCache="false">
  UPDATE Dp_Product
  SET Attention_Count=#{attentionCount}
  ,Update_User_Id=#{updateUserId}
  ,Update_Time=#{updateDateTime}
  WHERE id = #{id}
 </update>

 <delete id="deleteByPrimaryKey">
  DELETE FROM
  Dp_Product
  WHERE
  id = #{id}
 </delete>

 <update id="logicDelete">
  UPDATE Dp_Product
  SET Delete_Flag='1'
  WHERE id = #{id}
 </update>

 <select id="findProductByName" resultMap="product">
  SELECT *
  FROM Dp_Product
  WHERE Title like concat('%',#{name},'%')
  AND Company_Id = #{companyId}
  AND Type = #{type} AND Status = 1
  AND delete_flag = '0'
  LIMIT 10
 </select>

 <select id="findAgentProductByName" resultMap="product">
  SELECT a.*
  FROM (
  SELECT *
  FROM Dp_Product
  WHERE Id in (SELECT link_id FROM Dp_Distributor_Product WHERE link_type = 2
  and Distributor_Id = #{companyId} and Status = 1 and Delete_Flag = 0)
  and Status = 1
  union
  SELECT *
  FROM Dp_Product
  WHERE Company_Id in (SELECT link_id FROM Dp_Distributor_Product where
  link_type = 1 and Distributor_Id = #{companyId} and Status = 1 and
  Delete_Flag = 0) and Status = 1
  ) a
  WHERE a.Type = #{type}
  and a.delete_flag = 0
  and a.Title like concat('%',#{name},'%')
  LIMIT 10
 </select>

 <select id="findNext" parameterType="java.util.Map" resultMap="product">
  SELECT *
  FROM Dp_Product
  WHERE Insurance_Classify_Id = #{classify.id}
  AND delete_flag = 0
  AND id > #{id}
  ORDER BY Create_Time
  LIMIT 1
 </select>

 <select id="findPrevious" parameterType="java.util.Map"
  resultMap="product">
  SELECT *
  FROM Dp_Product
  WHERE Insurance_Classify_Id = #{classify.id}
  AND delete_flag = 0
  AND id &lt; #{id}
  ORDER BY Create_Time DESC
  LIMIT 1
 </select>

 <select id="findHotProducts" parameterType="map" resultMap="product"
  useCache="false">
  SELECT a.Id,a.Title
  FROM Dp_Product a,
  (
  SELECT product_Id ,count(product_Id) as pids
  FROM Dp_Product_Click
  WHERE Update_time > date_add(now(), interval -10 day)
  GROUP BY product_Id
  ) as b
  WHERE a.Delete_Flag=0
  AND a.id = b.product_Id
  ORDER BY pids DESC
  LIMIT ${size}
 </select>

 <select id="loadRelatedProduct" resultMap="product">
  SELECT *
  FROM Dp_Product
  WHERE delete_flag = 0
  AND Insurance_Subclass_Id = #{classify}
  ORDER BY rand()
  LIMIT 7
 </select>
</mapper>
==================================== END pro/Product.xml =========================


==================================== BEGIN Site.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:27:22 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="Site">

 <resultMap id="site" type="com.djb.domain.Site" extends="DomainObject.domainObject">
  <result property="siteModuleName" column="Site_Module_Name"/>
  <result property="siteModuleType" column="Site_Module_Type"/>
  <result property="prdAccessUrl" column="Prd_AccessUrl"/>
  <result property="stagingAccessUrl" column="Staging_AccessUrl"/>
  <result property="localAccessUrl" column="Local_AccessUrl"/>
  <result property="siteNameCn" column="Site_Name_Cn"/>
  <result property="siteNamePinyin" column="Site_Name_Pinyin"/>
  <result property="siteNameShortPinyin" column="Site_Name_Short_Pinyin"/>
  <result property="cityId" column="City_Id"/>
  <result property="cookieValue" column="Cookie_Value"/>
  <result property="remark" column="Remark"/>
  <result property="disOrder" column="Dis_Order"/>
 </resultMap>

 <select id="load" resultMap="site">
  SELECT  *
    FROM  Sm_Site
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>
 
 <select id="getAll" resultMap="site">
  SELECT  *
    FROM  Sm_Site
   WHERE  delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.Site">
  UPDATE  Sm_Site
     SET  
   Site_Module_Name=#{siteModuleName}
   ,Site_Module_Type=#{siteModuleType}
   ,Prd_AccessUrl=#{prdAccessUrl}
   ,Staging_AccessUrl=#{stagingAccessUrl}
   ,Local_AccessUrl=#{localAccessUrl}
   ,Site_Name_Cn=#{siteNameCn}
   ,Site_Name_Pinyin=#{siteNamePinyin}
   ,Site_Name_Short_Pinyin=#{siteNameShortPinyin}
   ,City_Id=#{cityId}
   ,Cookie_Value=#{cookieValue}
   ,Remark=#{remark}
   ,Dis_Order=#{disOrder}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
 </update>

 <insert id="insert" parameterType="com.djb.domain.Site">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Sm_Site(
   Site_Module_Name
   ,Site_Module_Type
   ,Prd_AccessUrl
   ,Staging_AccessUrl
   ,Local_AccessUrl
   ,Site_Name_Cn
   ,Site_Name_Pinyin
   ,Site_Name_Short_Pinyin
   ,City_Id
   ,Cookie_Value
   ,Remark
   ,Dis_Order
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{siteModuleName}
   ,#{siteModuleType}
   ,#{prdAccessUrl}
   ,#{stagingAccessUrl}
   ,#{localAccessUrl}
   ,#{siteNameCn}
   ,#{siteNamePinyin}
   ,#{siteNameShortPinyin}
   ,#{cityId}
   ,#{cookieValue}
   ,#{remark}
   ,#{disOrder}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
  
  
 </insert>

 <delete id="deleteByPrimaryKey">
  DELETE FROM  Sm_Site
        WHERE  id = #{id}
 </delete>
</mapper>
==================================== END Site.xml =========================


==================================== BEGIN weiboyi/WeiboyiPayLog.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="WeiboyiPayLog" >

 <resultMap id="weiboyiPayLog" type="com.djb.domain.weiboyi.WeiboyiPayLog" extends="DomainObject.domainObject" >
  <result property="companyId" column="Company_Id" />
  <result property="tm" column="tm" />
  <result property="cost" column="cost" />
  <result property="tradeNo" column="Trade_No" />
  <result property="code" column="Code" />
 </resultMap>

 <select id="load" resultMap="weiboyiPayLog" >
  SELECT  *
    FROM  Sm_Weiboyi_Pay_Log
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.weiboyi.WeiboyiPayLog" >
  UPDATE  Sm_Weiboyi_Pay_Log
     SET  
   Company_Id=#{companyId}
   ,tm=#{tm}
   ,cost=#{cost}
   ,Trade_No=#{tradeNo}
   ,Code=#{code}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   WHERE  id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.weiboyi.WeiboyiPayLog" >
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Sm_Weiboyi_Pay_Log(
   Company_Id
   ,tm
   ,cost
   ,Trade_No
   ,Code
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{companyId}
   ,#{tm}
   ,#{cost}
   ,#{tradeNo}
   ,#{code}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey" >
  DELETE FROM  Sm_Weiboyi_Pay_Log
        WHERE  id = #{id}
 </delete>
</mapper>
==================================== END weiboyi/WeiboyiPayLog.xml =========================


==================================== BEGIN dx/SalesCompany.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="SalesCompany" >

 <resultMap id="salesCompany" type="com.djb.domain.dx.SalesCompany" extends="DomainObject.domainObject" >
  <result property="shortName" column="Short_Name" />
  <result property="fullName" column="Full_Name" />
  <result property="password" column="Password" />
  <result property="provinceId" column="Province_Id" />
  <result property="cityId" column="City_Id" />
  <result property="districtId" column="District_Id" />
  <result property="address" column="Address" />
  <result property="expiredDate" column="Expired_Date" />
  <result property="phone" column="Phone" />
  <result property="fax" column="Fax" />
  <result property="code" column="Code" />
 </resultMap>

 <select id="load" resultMap="salesCompany" >
  SELECT  *
    FROM  Dx_Company
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>
 
 <select id="findCompanyByShortName" resultMap="salesCompany" >
  SELECT  *
    FROM  Dx_Company
   WHERE  Short_Name = #{shortName}
     AND  delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.dx.SalesCompany" >
  UPDATE  Dx_Company
     SET  
   Short_Name=#{shortName}
   ,Full_Name=#{fullName}
   ,Password=#{password}
   ,Province_Id=#{provinceId}
   ,City_Id=#{cityId}
   ,District_Id=#{districtId}
   ,Address=#{address}
   ,Expired_Date=#{expiredDate}
   ,Phone=#{phone}
   ,Fax=#{fax}
   ,Code=#{code}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   WHERE  id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.dx.SalesCompany" >
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Dx_Company(
   Short_Name
   ,Full_Name
   ,Password
   ,Province_Id
   ,City_Id
   ,District_Id
   ,Address
   ,Expired_Date
   ,Phone
   ,Fax
   ,Code
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{shortName}
   ,#{fullName}
   ,#{password}
   ,#{provinceId}
   ,#{cityId}
   ,#{districtId}
   ,#{address}
   ,#{expiredDate}
   ,#{phone}
   ,#{fax}
   ,#{code}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey" >
  DELETE FROM  Dx_Company
        WHERE  id = #{id}
 </delete>
</mapper>
==================================== END dx/SalesCompany.xml =========================


==================================== BEGIN dx/CardType.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="CardType" >

 <resultMap id="cardType" type="com.djb.domain.dx.CardType" extends="DomainObject.domainObject" >
  <result property="name" column="Name" />
  <result property="price" column="Price" />
  <result property="settlementPrice" column="Settlement_Price" />
  <result property="years" column="Years" />
  <result property="phoneTender" column="Phone_Tender" />
  <result property="mailTender" column="Mail_Tender" />
 </resultMap>

 <select id="load" resultMap="cardType" >
  SELECT  *
    FROM  Dx_Card_Type
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.dx.CardType" >
  UPDATE  Dx_Card_Type
     SET  
   Name=#{name}
   ,Price=#{price}
   ,Settlement_Price=#{settlementPrice}
   ,Years=#{years}
   ,Phone_Tender=#{phoneTender}
   ,Mail_Tender=#{mailTender}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   WHERE  id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.dx.CardType" >
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Dx_Card_Type(
   Name
   ,Price
   ,Settlement_Price
   ,Years
   ,Phone_Tender
   ,Mail_Tender
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{name}
   ,#{price}
   ,#{settlementPrice}
   ,#{years}
   ,#{phoneTender}
   ,#{mailTender}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey" >
  DELETE FROM  Dx_Card_Type
        WHERE  id = #{id}
 </delete>
</mapper>
==================================== END dx/CardType.xml =========================


==================================== BEGIN dx/CardBatch.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="CardBatch" >

 <resultMap id="cardBatch" type="com.djb.domain.dx.CardBatch" extends="DomainObject.domainObject" >
  <result property="batchCode" column="Batch_Code" />
  <result property="startNum" column="Start_Num" />
  <result property="endNum" column="End_Num" />
  <result property="cardType" column="Card_Type" />
  <result property="expriedDate" column="Expried_Date" />
  <result property="companyId" column="Company_Id" />
 </resultMap>
 
 <resultMap type="java.util.HashMap" id="cardUsedSammary">
  <result property="cardName" column="Card_Name" javaType="string"/>
  <result property="cardPrice" column="Card_Price" javaType="int"/>
  <result property="startNum" column="Start_Num" javaType="string"/>
  <result property="endNum" column="End_Num" javaType="string"/>
  <result property="activeNum" column="Active_Num" javaType="int"/>
  <result property="expiredDate" column="Expired_Date" javaType="int"/>
 </resultMap>
 
 <select id="cardStatistic" resultMap="cardUsedSammary">
  SELECT type.Name AS Card_Name
      ,type.Price AS Card_Price
      ,batch.Start_Num
      ,batch.End_Num
      ,(SELECT COUNT(1) 
       FROM Sm_Djb_Key 
         WHERE Delete_Flag = 0 
           AND Status = 2 
           AND Create_Time &lt;&gt; Update_Time
           <if test="startTime != null">
           AND Update_Time &gt;= #{startTime}
           </if>
           <if test="endTime != null">
           AND Update_Time &lt;= #{endTime}
           </if>
           AND Batch_Id = batch.Id) AS Active_Num
      ,datediff(now(),batch.Expried_Date) AS Expired_Date
   FROM Dx_Card_Batch batch
      LEFT JOIN Dx_Card_Type type ON batch.Card_Type = type.Id
    WHERE batch.Company_Id = #{companyId}
      AND batch.Delete_Flag = 0
 </select>
 
 <select id="load" resultMap="cardBatch" >
  SELECT  *
    FROM  Dx_Card_Batch
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.dx.CardBatch" >
  UPDATE  Dx_Card_Batch
     SET  
   Batch_Code=#{batchCode}
   ,Start_Num=#{startNum}
   ,End_Num=#{endNum}
   ,Card_Type=#{cardType}
   ,Expried_Date=#{expriedDate}
   ,Company_Id=#{companyId}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   WHERE  id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.dx.CardBatch" >
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Dx_Card_Batch(
   Batch_Code
   ,Start_Num
   ,End_Num
   ,Card_Type
   ,Expried_Date
   ,Company_Id
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{batchCode}
   ,#{startNum}
   ,#{endNum}
   ,#{cardType}
   ,#{expriedDate}
   ,#{companyId}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey" >
  DELETE FROM  Dx_Card_Batch
        WHERE  id = #{id}
 </delete>
</mapper>
==================================== END dx/CardBatch.xml =========================


==================================== BEGIN Comment.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="Comment" >

 <resultMap id="comment" type="com.djb.domain.Comment" extends="DomainObject.domainObject" >
  <result property="content" column="Content" />
  <result property="referId" column="Refer_Id" />
  <result property="referType" column="Refer_Type" />
  <result property="status" column="Status" />
 </resultMap>

 <select id="load" resultMap="comment" >
  SELECT  *
    FROM  Dp_Comment
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>

 <update id="update" parameterType="com.djb.domain.Comment" >
  UPDATE  Dp_Comment
     SET  
   Content=#{content}
   ,Refer_Id=#{referId}
   ,Refer_Type=#{referType}
   ,Status=#{status}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   WHERE  id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.Comment" >
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Dp_Comment(
   Content
   ,Refer_Id
   ,Refer_Type
   ,Status
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{content}
   ,#{referId}
   ,#{referType}
   ,#{status}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey" >
  DELETE FROM  Dp_Comment
        WHERE  id = #{id}
 </delete>
 
 <sql id="finCommentListRef">
   FROM Dp_Comment  comment
     WHERE comment.Delete_flag=0
     <if test="productName != null and productName != ''">AND
      EXISTS(
       SELECT 1 
         FROM Dp_App_Product product
        WHERE product.Delete_Flag=0
          AND product.name like '%${productName}%'
          AND comment.Refer_Id = product.Id
          AND comment.Refer_Type = 1
      )
     </if>
     <if test="id != null">AND
      comment.id = #{id}
     </if>
     <if test="commentContent != null and commentContent != ''">AND
      comment.content like '%${commentContent}%'
     </if>
     <if test="type != null">AND
      comment.Refer_Type = #{type}
     </if>
     <if test="referId != null">AND
      comment.Refer_Id = #{referId}
     </if>
     <if test="statusList != null">AND
      comment.status IN
      <foreach collection="statusList" item="item" separator="," close=")" open="(">
         #{item}
       </foreach>
     </if>
 </sql>
 
 <!-- 根据queryBean查找类别的数量 -->
 <select id="getCountByQueryBean" parameterType="com.djb.domain.CommentQueryBean" resultType="int">
  SELECT count(*) <include refid="finCommentListRef"/>
 </select>
 
 <!-- 根据queryBean查找所有符合条件的类别 -->
 <select id="finCommentList" parameterType="com.djb.domain.CommentQueryBean" resultMap="comment">
  SELECT * <include refid="finCommentListRef"/>
  <if test="orderByProperties != null">
   ORDER BY ${orderByFiled} 
  </if>
  <if test="orderByProperties == null">
   ORDER BY comment.create_time DESC
  </if>
  LIMIT ${startIndex}, ${pageSize}
 </select>
</mapper>
==================================== END Comment.xml =========================


==================================== BEGIN note/AgentCalendar.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="AgentCalendar" >

 <resultMap id="agentCalendar" type="com.djb.domain.note.AgentCalendar" extends="DomainObject.domainObject" >
  <result property="agentId" column="Agent_Id" />
  <result property="content" column="Content" />
  <result property="categoryId" column="Category_Id" />
  <result property="scheduleTime" column="Schedule_Time" />
 </resultMap>

 <select id="load" resultMap="agentCalendar" >
  SELECT  *
    FROM  Sm_Agent_Calendar
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>
 
 <select id="findByAgentId" parameterType="long" resultMap="agentCalendar">
  SELECT  *
    FROM  Sm_Agent_Calendar
    WHERE delete_flag='0'
    AND Agent_Id=#{agentId}
 </select>
 
 <select id="findByAllotId" parameterType="long" resultMap="agentCalendar">
  SELECT  *
    FROM  Sm_Agent_Calendar
    WHERE delete_flag='0'
    AND Category_Id=#{categoryId}
 </select>
 
 <select id="findByNotepadId" parameterType="com.djb.domain.note.AgentCalendar" resultType="long">
  SELECT id
    FROM  Sm_Agent_Calendar
    WHERE delete_flag='0'
    AND Agent_Id=#{agentId}
    AND Content=#{content}
    AND Category_Id=#{categoryId}
    LIMIT 1
 </select>

 <update id="update" parameterType="com.djb.domain.note.AgentCalendar" >
  UPDATE  Sm_Agent_Calendar
     SET  
   Agent_Id=#{agentId}
   ,Content=#{content}
   ,Category_Id=#{categoryId}
   ,Schedule_Time=#{scheduleTime}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   WHERE  id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.note.AgentCalendar" >
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Sm_Agent_Calendar(
   Agent_Id
   ,Content
   ,Category_Id
   ,Schedule_Time
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{agentId}
   ,#{content}
   ,#{categoryId}
   ,#{scheduleTime}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey" >
  DELETE FROM  Sm_Agent_Calendar
        WHERE  id = #{id}
 </delete>
</mapper>
==================================== END note/AgentCalendar.xml =========================


==================================== BEGIN note/AgentScheduleCategory.xml =========================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="AgentScheduleCategory" >

 <resultMap id="agentScheduleCategory" type="com.djb.domain.note.AgentScheduleCategory" extends="DomainObject.domainObject" >
  <result property="agentId" column="Agent_Id" />
  <result property="categoryName" column="Category_Name" />
  <result property="colorFlag" column="Color_Flag" />
 </resultMap>

 <select id="load" resultMap="agentScheduleCategory" >
  SELECT  *
    FROM  Sm_Agent_Schedule_Category
   WHERE  id = #{id}
     AND  delete_flag='0'
 </select>
 
 <select id="findAllotByAgentId" parameterType="long" resultMap="agentScheduleCategory">
  SELECT  *
     FROM  Sm_Agent_Schedule_Category
     WHERE delete_flag='0'
     AND ( Agent_Id=#{agentId} or Agent_Id = 0 )
 </select>
 
 <select id="countAllotByAgentId" parameterType="long" resultType="int">
  SELECT  count(1)
     FROM  Sm_Agent_Schedule_Category
     WHERE delete_flag='0'
     AND Agent_Id=#{agentId} 
 </select>
 
 <select id="findById" parameterType="com.djb.domain.note.AgentScheduleCategory" resultType="long">
      SELECT id 
           FROM  Sm_Agent_Schedule_Category
     WHERE delete_flag='0'
     AND Agent_Id=#{agentId}
     AND Category_Name=#{categoryName}
     AND Color_Flag=#{colorFlag}
             LIMIT 1
 </select>
  
 <update id="update" parameterType="com.djb.domain.note.AgentScheduleCategory" >
  UPDATE  Sm_Agent_Schedule_Category
     SET  
   Agent_Id=#{agentId}
   ,Category_Name=#{categoryName}
   ,Color_Flag=#{colorFlag}
   ,Delete_Flag=#{deleteFlag}
   ,Update_User_Id=#{updateUserId}
   ,Update_Time=#{updateDateTime}
   WHERE  id=#{id}
 </update>

 <insert id="insert" parameterType="com.djb.domain.note.AgentScheduleCategory" >
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT INTO  Sm_Agent_Schedule_Category(
   Agent_Id
   ,Category_Name
   ,Color_Flag
   ,Delete_Flag
   ,Create_User_Id
   ,Create_Time
   ,Update_User_Id
   ,Update_Time
  )
  VALUES(
   #{agentId}
   ,#{categoryName}
   ,#{colorFlag}
   ,#{deleteFlag}
   ,#{createUserId}
   ,#{createDateTime}
   ,#{updateUserId}
   ,#{updateDateTime}
  )
 </insert>

 <delete id="deleteByPrimaryKey" >
  DELETE FROM  Sm_Agent_Schedule_Category
        WHERE  id = #{id}
 </delete>
</mapper>

==================================== END note/AgentScheduleCategory.xml =========================


==================================== BEGIN friendlink/FriendLink.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:20:57 
 CST 2013 -->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="FriendLink">

 <cache type="com.djb.cache.MemcachedCache">
  <property name="timeout" value="7200" />
 </cache>
 <resultMap id="friendLink" type="com.djb.domain.friendlink.FriendLink"
  extends="DomainObject.domainObject">
  <result property="linkType" column="link_type" />
  <result property="linkName" column="link_name" />
  <result property="foreignUrl" column="foreign_url" />
  <result property="imageUrl" column="image_url" />
  <result property="description" column="description" />
  <result property="activeTime" column="active_time" />
  <result property="expiredTime" column="expired_time" />
  <result property="friendSiteName" column="friend_site_name" />
  <result property="friendSiteUrl" column="friend_site_url" />
  <result property="friendSitePr" column="friend_site_pr" />
  <result property="friendContactInfo" column="friend_contact_info" />
  <result property="remark" column="remark" />
 </resultMap>

 <select id="load" resultMap="friendLink">
  SELECT * FROM Dp_Friend_Link link
  WHERE id = #{id}
  AND delete_flag = '0'
 </select>

 <select id="getAllLink" resultMap="friendLink">
  SELECT * FROM Dp_Friend_Link
  link
  WHERE delete_flag = '0'
 </select>

 <select id="findLinkByChannerAndCity" parameterType="map"
  resultMap="friendLink">
  SELECT  link.*
  FROM Dp_Friend_Link_Order od
  LEFT JOIN Dp_Friend_Link_Channel ch
  on od.Channel_Id = ch.id
  LEFT JOIN  Dp_Friend_Link link
  ON od.Link_Id = link.id
  WHERE od.delete_flag = 0
  AND link.delete_flag = 0
  AND ch.delete_flag = 0
  AND link.Active_Time &lt;= now()
  AND link.Expired_Time &gt;= now()
  <if test="channel != null and channel != ''">
   AND ch.Link_Position_Name = #{channel}
  </if>
  <if test="city != null and city != ''">
   AND ch.City_Site = #{city}
  </if>
  <if test="linkType != null and linkType != ''">
   AND link.Link_Type = #{linkType}
  </if>
  AND ch.id IS NOT NULL
  AND link.id IS NOT NULL
  ORDER BY od.Order_Id ASC
  LIMIT ${size}
 </select>

 <insert id="insert" parameterType="com.djb.domain.friendlink.FriendLink">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
  INSERT into
  Dp_Friend_Link(
  link_type,
  link_name,
  foreign_url,
  image_url,
  description,
  active_time,
  expired_time,
  friend_site_name,
  friend_site_url,
  friend_site_pr,
  friend_contact_info,
  remark,
  delete_flag,
  create_user_id,
  create_time,
  update_user_id,
  update_time
  )values(
  #{linkType},
  #{linkName},
  #{foreignUrl},
  #{imageUrl},
  #{description},
  #{activeTime},
  #{expiredTime},
  #{friendSiteName},
  #{friendSiteUrl},
  #{friendSitePr},
  #{friendContactInfo},
  #{remark},
  #{deleteFlag},
  #{createUserId},
  #{createDateTime},
  #{updateUserId},
  #{updateDateTime}
  )


 </insert>

 <update id="update" parameterType="com.djb.domain.friendlink.FriendLink">
  update
  Dp_Friend_Link
  set
  link_type = #{linkType},
  link_name = #{linkName},
  foreign_url = #{foreignUrl},
  image_url = #{imageUrl},
  description = #{description},
  active_time = #{activeTime},
  expired_time = #{expiredTime},
  friend_site_name = #{friendSiteName},
  friend_site_url = #{friendSiteUrl},
  friend_site_pr = #{friendSitePr},
  friend_contact_info = #{friendContactInfo},
  remark = #{remark},
  Delete_Flag = #{deleteFlag},
  Create_User_Id = #{createUserId},
  Create_Time = #{createDateTime},
  Update_User_Id = #{updateUserId},
  Update_Time = #{updateDateTime}
  where
  id = #{id}
 </update>

</mapper>
==================================== END friendlink/FriendLink.xml =========================


==================================== BEGIN friendlink/FriendLinkChannel.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:20:58 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="FriendLinkChannel">
 <resultMap id="friendLinkChannel" type="com.djb.domain.friendlink.FriendLinkChannel" extends="DomainObject.domainObject">
  <result property="linkPositionName" column="link_position_name"/>
  <result property="cityRelated" column="is_City_related"/>
  <result property="citySite" column="city_site"/>
 </resultMap>
 
 <resultMap id="friendLinkChannelBean" type="com.djb.domain.friendlink.FriendLinkChannel" extends="DomainObject.domainObject">
  <result property="linkPositionName" column="link_position_name"/>
  <result property="cityRelated" column="is_City_related"/>
  <result property="citySite" column="city_site"/>
  <result property="linkSum" column="linkSum"/>
 </resultMap>
 
 <select id="load" resultMap="friendLinkChannel">
  SELECT * FROM Dp_Friend_Link_Channel linkChannel 
  WHERE id = #{id}
  AND delete_flag = '0'  
 </select>
 
 <select id="getAllLinkChannel" resultMap="friendLinkChannel">
  SELECT * FROM Dp_Friend_Link_Channel linkChannel
  WHERE delete_flag = '0'
 </select>

 <insert id="insert" parameterType="com.djb.domain.friendlink.FriendLinkChannel">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
   INSERT into 
    Dp_Friend_Link_Channel(
     link_position_name,
     is_City_related,
     city_site,
     delete_flag,
     create_user_id,
     create_time,
     update_user_id,
     update_time   
    )values(
     #{linkPositionName},
     #{cityRelated},
     #{citySite},
     #{deleteFlag},
     #{createUserId},
     #{createDateTime},
     #{updateUserId},
     #{updateDateTime}
    ) 
    
   
 </insert>
 
 <update id="update" parameterType="com.djb.domain.friendlink.FriendLinkChannel">
  update
   Dp_Friend_Link_Channel
  set
   link_position_name = #{linkPositionName},
   is_City_related = #{cityRelated},
   city_site = #{citySite},
   Delete_Flag = #{deleteFlag},
   Create_User_Id = #{createUserId},
   Create_Time = #{createDateTime},
   Update_User_Id = #{updateUserId},
   Update_Time = #{updateDateTime}
  where
   id = #{id}
 </update>
 
 <!-- 根据queryBean查找链接位的数量 -->
 <select id="getCountByBean" parameterType="com.djb.domain.friendlink.FriendLinkChannelQueryBean" resultType="int">
  SELECT count(*) 
  FROM Dp_Friend_Link_Channel
  WHERE delete_flag = '0'
 </select>
 
 <!-- 根据queryBean查找所有符合条件的类别 -->
 <select id="findAllLinkChannel" parameterType="com.djb.domain.friendlink.FriendLinkChannelQueryBean" resultMap="friendLinkChannelBean">
  SELECT channel.*, ifnull(linkOrder.linkSum,0) as linkSum
  FROM (SELECT * FROM Dp_Friend_Link_Channel WHERE delete_flag = '0' ) channel
  LEFT JOIN (
   SELECT Channel_Id,COUNT(*) as linkSum 
   FROM Dp_Friend_Link_Order
   WHERE delete_flag = '0'
   GROUP BY Channel_Id) linkOrder
     on linkOrder.Channel_Id = channel.Id
  ORDER BY channel.Create_Time DESC
  LIMIT ${startIndex}, ${pageSize}
 </select>
</mapper>
==================================== END friendlink/FriendLinkChannel.xml =========================


==================================== BEGIN friendlink/FriendLinkOrder.xml =========================
<?xml version="1.0" encoding="UTF-8"?><!--Converted at: Thu Apr 25 13:20:58 CST 2013-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="FriendLinkOrder">
 <resultMap id="friendLinkOrder" type="com.djb.domain.friendlink.FriendLinkOrder" extends="DomainObject.domainObject">
  <result property="orderId" column="order_id"/>
  <result property="channel.id" column="channel_id"/>
  <result property="link.id" column="link_id"/>
 </resultMap>
 
 <select id="load" resultMap="friendLinkOrder">
  SELECT * FROM Dp_Friend_Link_Order link_order 
  WHERE id = #{id}
  AND delete_flag = '0'  
 </select>
 
 <select id="getAllLinkOrder" resultMap="friendLinkOrder">
  SELECT * FROM Dp_Friend_Link_Order link_order
  WHERE delete_flag = '0'
 </select>

 <insert id="insert" parameterType="com.djb.domain.friendlink.FriendLinkOrder">
  <selectKey resultType="long"  keyProperty="id" order="AFTER">SELECT LAST_INSERT_ID()</selectKey>
   INSERT into 
    Dp_Friend_Link_Order(
     order_id,
     channel_id,
     link_id,
     delete_flag,
     create_user_id,
     create_time,
     update_user_id,
     update_time 
    )values(  
     #{orderId},
     #{channel.id},
     #{link.id},
     #{deleteFlag},
     #{createUserId},
     #{createDateTime},
     #{updateUserId},
     #{updateDateTime}    
    )
    
   
 </insert>
 
 <update id="update" parameterType="com.djb.domain.friendlink.FriendLinkOrder">
 UPDATE
   Dp_Friend_Link_Order
  SET
   order_id = #{orderId},
   channel_id = #{channel.id},
   link_id = #{link.id},
   Delete_Flag = #{deleteFlag},
   Create_User_Id = #{createUserId},
   Create_Time = #{createDateTime},
   Update_User_Id = #{updateUserId},
   Update_Time = #{updateDateTime}
 WHERE
   id = #{id}
 </update>
 
 <sql id="getLinkOrdersRef">
  FROM Dp_Friend_Link_Order linkOrder,Dp_Friend_Link link,Dp_Friend_Link_Channel channel
    WHERE 
     linkOrder.Delete_Flag='0'
     and link.Delete_Flag='0'
     and channel.Delete_Flag='0'
     and linkOrder.Link_Id = link.Id
     and linkOrder.channel_id = channel.id
        
      <if test="linkName != null and linkName != ''">
       and link.link_name like '%${linkName}%'
      </if>
      <if test="linkUrl != null and linkUrl != ''">
       and link.foreign_url like '%${linkUrl}%'
      </if>
      <if test="linkChannel != null and linkChannel != ''">
       and linkOrder.channel_id=#{linkChannel.id}
      </if>
 </sql>
 
 <select id="getLinkOrderCount" parameterType="com.djb.domain.friendlink.FriendLinkQueryBean" resultType="int">
  SELECT COUNT(*) <include refid="getLinkOrdersRef"/>
 </select>
 
 <select id="getLinkOrders" parameterType="com.djb.domain.friendlink.FriendLinkQueryBean" resultMap="friendLinkOrder">
  SELECT linkOrder.* <include refid="getLinkOrdersRef"/>
  <if test="orderByProperties != null">
   ORDER BY ${orderByFiled} 
  </if>
  LIMIT ${startIndex}, ${pageSize}
 </select>
 
 <select id="getLinkOrderByChannelId" parameterType="long" resultMap="friendLinkOrder">
  SELECT * FROM Dp_Friend_Link_Order link_order
  WHERE delete_flag = '0' and channel_id=#{channelId}
 </select> 
 
 <select id="getLinkOrderByLinkId" parameterType="long" resultMap="friendLinkOrder">
  SELECT * FROM Dp_Friend_Link_Order link_order
  WHERE delete_flag = '0' and Link_Id=#{linkId}
 </select>
</mapper>
==================================== END friendlink/FriendLinkOrder.xml =========================

