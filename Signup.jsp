<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Database Connection Example</title>
</head>
<body>
<%
    // Initialize the database connection
    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;

    try {
        // Load the MySQL JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish the database connection
        connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/demo", "root", "Shruti@07");

        int id = 0, age = 0;
        String query = "";
        String name = request.getParameter("name");
        String eml = request.getParameter("email");
        String pass = request.getParameter("password");
        <!-- String cpass = request.getParameter("cpassword"); -->
        
        query = "insert into Customers(Name, Email, Password) "+"values(?,?,?)";
        PreparedStatement pst = connection.prepareStatement(query);
        pst.setString(1, name);
        pst.setString(2, eml);
        pst.setString(3, pass);
        pst.execute();
       

    } catch (Exception e) {
        e.printStackTrace();
        out.println("An error occurred: " + e.getMessage());
    } finally {
        // Close resources
        if (resultSet != null) resultSet.close();
        if (statement != null) statement.close();
        if (connection != null) connection.close();
    }
%>
</body>
</html>
