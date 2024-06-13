<!-- <html>  
<body>  
<% out.print("welcome to jsp"); %>  
<%= 2*3%>
</body>  
</html>   -->
<html>  
<body>  
<%= "welcome to jsp" %> 
<% out.print("Today is:"+java.util.Calendar.getInstance().getTime()); %>     
</body>  
</html>