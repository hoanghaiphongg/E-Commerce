<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
  <%@page import="cn.techtutorial.connection.DbCon"%>
<%@page import="cn.techtutorial.model.*"%>
<%@page import="cn.techtutorial.dao.OrderDao"%>
<%@page import="java.util.*"%>
<%@page import="cn.techtutorial.dao.PriceDao"%>

<%
	Customer auth = (Customer) request.getSession().getAttribute("auth");
	if(auth!=null){
		request.setAttribute("auth", auth);
	}
	OrderDao ord= new OrderDao(DbCon.getConnection());
	
	String email = (String) request.getSession().getAttribute("e");
	String password = (String) request.getSession().getAttribute("p");
	List<Order> o = ord.getOrderbyemail(email);
	PriceDao pr= new PriceDao(DbCon.getConnection());

%>
<!DOCTYPE html>
<html>
<head>
<title>Pay</title>
<%@include file="Includes/head.jsp" %>
<style>
        .container{
        margin-top: 200px;
        font-size: 20px;
        }
        .modal{
    position: fixed;
    top: 110px;
    bot: 0;
    left: 0;
    right: 0px;
    background: #ffffff;
    display: flex;
    align-items: center;
    justify-content: center;
}
.modal-container{
    background-color: white;
    width: 1000px;
    height: 1000px;
    position: relative;
}


</style>

</head>
<body>
<%@include file="Includes/nav4.jsp" %>

<div class= "container">

<div class="modal">       

                <div class="modal-container">
                   
										                         <img src="https://media-cdn-v2.laodong.vn/storage/newsportal/2021/6/15/920631/4128Nh_2021-06-15_Lu.jpeg" alt="New York" class="qr">
										
                </div>
                
            </div>


</div>


			
</div>






<%@include file="Includes/Footer.jsp" %>
</body>
</html>