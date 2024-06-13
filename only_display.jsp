<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Display Data from Database</title>
    <link rel="stylesheet" type="text/css" href="Reviews.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Alice&display=swap');
        </style>
</head>
<body>
    
    <header>
        <h1>EVENT CURATORS</h1>
        <h2 id="subtitle">Events happen where imagination meets execution</h2>
        <br>
        <br>
        
    </header>
    <h2 style="text-align: center;">OUR TESTIMONIALS</h2>
    <%
    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;

    try {
        // Load the MySQL driver
        Class.forName("com.mysql.jdbc.Driver");

        // Replace with your own database connection details
        String dbURL = "jdbc:mysql://localhost:3306/demo";
        String dbUser = "root";
        String dbPassword = "Shruti@07";

        // Establish a connection to the database
        connection = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // Define your SQL query
        String query = "SELECT * FROM reviews";


        // Create a statement
        statement = connection.createStatement();

        // Execute the query
        resultSet = statement.executeQuery(query);

        // Loop through the result set and display data

        %>
        <div class="reviews" style="align-items: center;">
        <%
        while (resultSet.next()) {
            String columnName1 = resultSet.getString("Name");
            String columnName2 = resultSet.getString("City");
            int columnName3 = resultSet.getInt("Ratings");
            String columnName4 = resultSet.getString("Review");
        %>
        
            <div class="body">

                <div class="image"><img src="3106773.png"></div>
                <div class="name"><%= columnName1 %></div>
                <div class="place"><%= columnName2 %></div>
                <div class="place">Ratings : <%= columnName3 %>/5</div>
                <div class="descript"><%= columnName4 %></div>
            </div>
            <br><br>
            

        <%

            
        }

        %></div><%
    } catch (Exception e) {
        out.println("An error occurred: " + e.getMessage());
    } finally {
        // Close resources
        if (resultSet != null) resultSet.close();
        if (statement != null) statement.close();
        if (connection != null) connection.close();
    }


    %>
    <div class="button2" style = "text-align: center; text-decoration: underline;">
        <a href="Reviews.html">Back to Reviews</a>
    </div><br><br>
    

</body>
</html>
