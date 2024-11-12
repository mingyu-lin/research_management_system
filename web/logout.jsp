<%-- logout.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 销毁 session
    session.invalidate();
%>
<%
    // 设置禁止缓存的头部信息
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    // 重定向到登录页面
    response.sendRedirect("login.jsp");
%>
