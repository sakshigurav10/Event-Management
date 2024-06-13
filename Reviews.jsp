<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title> Review jsp</title>
</head>
<body>
    <% 
    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;

    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/demo", "root", "Shruti@07");

        String query = "";
        String name = request.getParameter("name_r");
        String city = request.getParameter("city_r");
        String rating = request.getParameter("rating_r");
        String message = request.getParameter("message_r");
        int rate = 0;

        
        //out.println("name : "+name);
        //out.println("city : "+city);
        //out.println("message : "+message);
        //out.println("rating :" + rating);

        if(name==null || name.isEmpty()){
            out.println("An error occurred: Name cannot be empty.");

        }
        if (rating == null) {
            out.println("An error occurred: Rating cannot be empty.1");
        } else if (rating.trim().isEmpty()) {
            out.println("An error occurred: Rating cannot be empty. 2");
        }
        else{

            try {
                rate = Integer.parseInt(rating);
            } catch (NumberFormatException e) {
                out.println("An error occurred: Rating must be a valid number. inside");
            }
            query =  "Insert into reviews(Name, City,Ratings, Review) values (?,?,?,?)";

            PreparedStatement pst = connection.prepareStatement(query);
            pst.setString(1, name);
            pst.setString(2, city);
            pst.setInt(3, rate);
            pst.setString(4,message);
            pst.execute();

        }
    }
    catch (Exception e) {
        e.printStackTrace();
        out.println("An error occurred: " + e.getMessage());
    } finally {
        // Close resources
        if (resultSet != null) resultSet.close();
        if (statement != null) statement.close();
        if (connection != null) connection.close();
        response.sendRedirect("/events/Reviews.html");
    }
    
    %>
</body>

</html>