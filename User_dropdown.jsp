<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Dropdown</title>
</head>
<body>
    <h1>User Dropdown List</h1>
    <label>Soups</label>
    <select>
        <option value ="-1">Select soup</option>
        <%
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;
        
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish the database connection
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/demo", "root", "Shruti@07");

            String query = "Select Menu_id, Soup from menu";
            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            while(rs.next()){
                %>
                <option value = "<%= rs.getInt("Menu_id")%>" ><%= rs.getString("Soup")%></option>
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
</body>
</html>
