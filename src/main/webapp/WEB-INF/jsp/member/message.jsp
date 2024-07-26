<%@ page import="static member.util.SignupConst.NOID" %>
<%@ page import="static member.util.SignupConst.NOPASSWORD" %>
<%@ page import="static member.util.SignupConst.ERROR" %><%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2024-07-26
  Time: 오전 11:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<script>
  if(${result} == <%=NOID%>){
    alert("그런 이메일을 가진 회원이 없어요");
  }else if(${result} == <%=NOPASSWORD%>) {
    alert("비밀번호가 맞지 않아요");
  }else if(${result}==<%=ERROR%>){
    alert("DB오류")
  }else{
    alert("로긴 성공");
  }
</script>
