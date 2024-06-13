<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>You choose what we offer</title>
    <link rel="stylesheet" href="Events_info.css">
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Alice&display=swap');
  </style>
 


        <script>
            function validateForm(){
                // var p = document.forms["myform"]["date_of_func"].value;
                var p = document.getElementById("date_of_func").value;
                var date_valid = new Date();
                var given_date = new Date(p);
                var given_year = given_date.getFullYear();  //user inp date
                var given_month = given_date.getMonth();
                var given_day = given_date.getDate();


                // var check = (date_valid);
                var year = date_valid.getFullYear();   // todays date
                var month = date_valid.getMonth();
                var day = date_valid.getDate();
                if(Date.parse(p)<Date.parse(date_valid)){
                    alert("PLEASE ENTER VALID DATE  " )
                    document.getElementById("myform").reset();
                    return false;
                }
                
                // var given_date = Date.parse(p);
                // if(p.getFullYear()!=year && p.getMonth()!=11 && (p.getMonth()!=month || p.getMonth()+1!=month) ){
                //     alert("YOU CAN PRE-BOOK ONLY A MONTH PRIOR ")
                //     document.getElementById("myform").reset();
                //     return false;
                // }
                // else if(p.getFullYear()+1!=year && p.getMonth()==11 && month!=0){
                //     alert("YOU CAN PRE-BOOK ONLY A MONTH PRIOR ")
                //     document.getElementById("myform").reset();
                //     return false;
                // }
                if(given_year == year && month==given_month){
                    return true;
                }
                else if((given_year != year && month != 11) ){
                    alert("YOU CAN PRE-BOOK ONLY A MONTH PRIOR")
                    document.getElementById("myform").reset();
                    return false;

                }
                else if (given_year==year&& month!=11 && given_month==month+1 && given_day>=day){
                    alert("YOU CAN PRE-BOOK ONLY A MONTH PRIOR")
                    document.getElementById("myform").reset();
                    return false;
                }
                else if(month==11 && given_month!=0 && given_year != year+1){
                    alert("YOU CAN PRE-BOOK ONLY A MONTH PRIOR")
                    document.getElementById("myform").reset();
                    return false;
                }


            }

            function updateAreaOptions() {
                document.addEventListener('DOMContentLoaded', function () {
                const citySelect = document.getElementById("citySelect");
                const areaSelect = document.getElementById("areaSelect");

                citySelect.addEventListener('change', function () {
                    const selectedCity = citySelect.value;
                    
                    // Clear the existing area options
                    areaSelect.innerHTML = '<option value="-1">Select area</option>';
                    
                    if (selectedCity !== "-1") {
                    // Make an AJAX request to fetch areas for the selected city
                    const xhr = new XMLHttpRequest();
                    xhr.onreadystatechange = function() {
                        if (xhr.readyState === 4 && xhr.status === 200) {
                        areaSelect.innerHTML = xhr.responseText; // Directly set the HTML content
                        }
                    };

                    // Replace 'fetch_areas.jsp' with the URL of a JSP page that fetches areas based on the selected city
                    xhr.open("GET", "fetch_areas.jsp?city=" + selectedCity, true);
                    xhr.send();
                    }
                });
                });
            }

        </script>
    </head>
    <body >
        <%String event = request.getParameter("event");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        session.setAttribute("event", event);
        %>
        <h3>Customize your <%= event %></h3>
        <h1 style="color: rgb(247, 183, 44);font-size: 3rem;">EVENTS WE CATER</h1>
        <form class="select" name = "myform" onsubmit="return validateForm()" method="post" action = "Event_details.jsp" style="font-size: medium; ">
            <h3 style="color: rgb(23, 141, 66);">LETS CHOOSE YOUR HALL</h3><hr><br>
            SELECT CITY TO CONDUCT YOUR EVENT : <select id="citySelect" name = "city" >
                <option value ="-1">Select city</option>
                <%

                Connection connection = null;
                Statement statement = null;
                ResultSet resultSet = null;
                
                try{Class.forName("com.mysql.cj.jdbc.Driver");
                    connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/demo", "root", "Shruti@07");
        
                    String query = "Select DISTINCT City from halls";
                    Statement stmt = connection.createStatement();
                    ResultSet rs = stmt.executeQuery(query);
                    while(rs.next()){
                        %>
                        <option value = "<%= rs.getString("City")%>" ><%= rs.getString("City")%></option>
                        <%
                    }
        
                }
        
                catch (Exception ex) {
                    ex.printStackTrace();
                    out.println("Error: " + ex.getMessage());
                } finally {
                    // Close resources in a finally block to ensure proper cleanup
                    if (resultSet != null) {
                        resultSet.close();
                    }
                    if (statement != null) {
                        statement.close();
                    }
                    if (connection != null) {
                        connection.close();
                    }
                }
                %>
            </select>
            <br><br>
            SELECT AREA IN THE CITY : <select id="areaSelect" name = "area">
                <option value ="-1">Select area in city</option>
                <%
                
                try{Class.forName("com.mysql.cj.jdbc.Driver");
                    connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/demo", "root", "Shruti@07");
        
                    String query = "Select Hall_id, Area from halls";
                    Statement stmt = connection.createStatement();
                    ResultSet rs = stmt.executeQuery(query);
                    while(rs.next()){
                        %>
                        <option value = "<%= rs.getString("Area")%>" ><%= rs.getString("Area")%></option>
                        <%
                    }
        
                }
        
                catch (Exception ex) {
                    ex.printStackTrace();
                    out.println("Error: " + ex.getMessage());
                } finally {
                    // Close resources in a finally block to ensure proper cleanup
                    if (resultSet != null) {
                        resultSet.close();
                    }
                    if (statement != null) {
                        statement.close();
                    }
                    if (connection != null) {
                        connection.close();
                    }
                }
                %>
                
            </select>
            <br><br>
            CHOOSE YOUR HALL : <select id="hallSelect" name="hall">
                <option value ="-1">Select hall</option>
                <%
                
                try{Class.forName("com.mysql.cj.jdbc.Driver");
                    connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/demo", "root", "Shruti@07");
        
                    String query = "Select Hall_id, Hall_name from halls";
                    Statement stmt = connection.createStatement();
                    ResultSet rs = stmt.executeQuery(query);
                    while(rs.next()){
                        %>
                        <option value = "<%= rs.getString("Hall_name")%>" ><%= rs.getString("Hall_name")%></option>
                        <%
                    }
        
                }
        
                catch (Exception ex) {
                    ex.printStackTrace();
                    out.println("Error: " + ex.getMessage());
                } finally {
                    // Close resources in a finally block to ensure proper cleanup
                    if (resultSet != null) {
                        resultSet.close();
                    }
                    if (statement != null) {
                        statement.close();
                    }
                    if (connection != null) {
                        connection.close();
                    }
                }
                %>
            </select>
            <br><br>
            CHOOSE DATE FOR YOUR EVENT : <input type="date" id = "date_of_func" required style="width: 96%;" name ="date">
            <br><br>
            CHOOSE YOUR SLOT : <select name = "slot_name" id = "slotOfFunc" required style="width: 100%;" name ="slot">
                <option value = "MORNING" >MORNING</option>
                <option value = "EVENING">EVENING</option>
            </select>
            <br><br>
            
                <h3 style="color: rgb(23, 141, 66);">LETS DECIDE YOUR MENU</h3><hr><br>
             ENTER NUMBER OF GUESTS ATTENDING : <input type ="number" id = "guests" required style="width: 96%;" name="guests"> <br>
             CHOOSE YOUR SOUP: <select name = "soup">
                <option value ="-1">Select soup</option>
                <%
                
                try{
                    Class.forName("com.mysql.cj.jdbc.Driver");
        
                    // Establish the database connection
                    connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/demo", "root", "Shruti@07");
        
                    String query = "Select Menu_id, Soup from menu";
                    Statement stmt = connection.createStatement();
                    ResultSet rs = stmt.executeQuery(query);
                    while(rs.next()){
                        %>
                        <option value = "<%= rs.getString("Soup")%>" ><%= rs.getString("Soup")%></option>
                        <%
                    }
        
                }
        
                catch (Exception ex) {
                    ex.printStackTrace();
                    out.println("Error: " + ex.getMessage());
                } finally {
                    // Close resources in a finally block to ensure proper cleanup
                    if (resultSet != null) {
                        resultSet.close();
                    }
                    if (statement != null) {
                        statement.close();
                    }
                    if (connection != null) {
                        connection.close();
                    }
                }
                %>
            </select>
            <br><br>
            CHOOSE YOUR STARTER: <select name = "starters">
                <option value ="-1">Select starters</option>
               <%
                
                try{Class.forName("com.mysql.cj.jdbc.Driver");
                    connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/demo", "root", "Shruti@07");
        
                    String query = "Select Menu_id, Starters from menu";
                    Statement stmt = connection.createStatement();
                    ResultSet rs = stmt.executeQuery(query);
                    while(rs.next()){
                        %>
                        <option value = "<%= rs.getString("Starters")%>" ><%= rs.getString("Starters")%></option>
                        <%
                    }
        
                }
        
                catch (Exception ex) {
                    ex.printStackTrace();
                    out.println("Error: " + ex.getMessage());
                } finally {
                    // Close resources in a finally block to ensure proper cleanup
                    if (resultSet != null) {
                        resultSet.close();
                    }
                    if (statement != null) {
                        statement.close();
                    }
                    if (connection != null) {
                        connection.close();
                    }
                }
                %>
            </select>
            <br><br>
            CHOOSE YOUR ROTI: <select name = "roti">
                <option value ="-1">Select rotis</option>
               <% 
                
                try{Class.forName("com.mysql.cj.jdbc.Driver");
                    connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/demo", "root", "Shruti@07");
        
                    String query = "SELECT DISTINCT Rotis FROM menu";
                    Statement stmt = connection.createStatement();
                    ResultSet rs = stmt.executeQuery(query);
                    while(rs.next()){
                        %>
                            <option value="<%= rs.getString("Rotis") %>"><%= rs.getString("Rotis") %></option>
                        <%
                    }
        
                }
        
                catch (Exception ex) {
                    ex.printStackTrace();
                    out.println("Error: " + ex.getMessage());
                } finally {
                    // Close resources in a finally block to ensure proper cleanup
                    if (resultSet != null) {
                        resultSet.close();
                    }
                    if (statement != null) {
                        statement.close();
                    }
                    if (connection != null) {
                        connection.close();
                    }
                }
                %>
            </select>
            <br><br>
            CHOOSE YOUR MAIN COURSE: <select name="sabji">
                <option value ="-1">Select main course</option>
                <%
                
                try{Class.forName("com.mysql.cj.jdbc.Driver");
                    connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/demo", "root", "Shruti@07");
        
                    String query = "Select Menu_id, Sabji from menu";
                    Statement stmt = connection.createStatement();
                    ResultSet rs = stmt.executeQuery(query);
                    while(rs.next()){
                        %>
                        <option value = "<%= rs.getString("Sabji")%>" ><%= rs.getString("Sabji")%></option>
                        <%
                    }
        
                }
        
                catch (Exception ex) {
                    ex.printStackTrace();
                    out.println("Error: " + ex.getMessage());
                } finally {
                    // Close resources in a finally block to ensure proper cleanup
                    if (resultSet != null) {
                        resultSet.close();
                    }
                    if (statement != null) {
                        statement.close();
                    }
                    if (connection != null) {
                        connection.close();
                    }
                }
                %>
            </select>
            <br><br>
            CHOOSE YOUR DESSERTS: <select name="desserts">
                <option value ="-1">Select dessert</option>
                <%
                
                try{Class.forName("com.mysql.cj.jdbc.Driver");
                    connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/demo", "root", "Shruti@07");
        
                    String query = "Select Menu_id, Desserts from menu";
                    Statement stmt = connection.createStatement();
                    ResultSet rs = stmt.executeQuery(query);
                    while(rs.next()){
                        %>
                        <option value = "<%= rs.getString("Desserts")%>" ><%= rs.getString("Desserts")%></option>
                        <%
                    }
        
                }
        
                catch (Exception ex) {
                    ex.printStackTrace();
                    out.println("Error: " + ex.getMessage());
                } finally {
                    // Close resources in a finally block to ensure proper cleanup
                    if (resultSet != null) {
                        resultSet.close();
                    }
                    if (statement != null) {
                        statement.close();
                    }
                    if (connection != null) {
                        connection.close();
                    }
                }
                %>
            </select>
            <br>
            <input type = "submit" value = "Submit" >
        </form>
    </body>
</html>
<!-- 20 - 6th row 83,84,85 -->
<!-- 19 - 7th row -->
<!-- 40- 7th row -->