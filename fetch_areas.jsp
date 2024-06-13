<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    // Retrieve the selected city from the request parameter
    String selectedCity = request.getParameter("city");
    
    // Perform a database query to fetch areas based on the selected city
        try{Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/demo", "root", "Shruti@07");

        String query = "Select Hall_id, Area from halls where City = ?";
        PreparedStatement pstmt = connection.prepareStatement(query);
        pstmt.setString(1, selectedCity);
        ResultSet rs = pstmt.executeQuery();

        while(rs.next()){
            %>
            <option value = "<%= rs.getInt("Hall_id")%>" ><%= rs.getString("Area")%></option>
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
        
     catch (Exception ex) {
        ex.printStackTrace();
        out.println("Error: " + ex.getMessage());
    }
%>
