<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
    <title>Your customized event</title>
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

        String name = (String) session.getAttribute("username");
        String email = (String) session.getAttribute("email_id");
        String event = (String) session.getAttribute("event");
        String city = request.getParameter("city");
        String area = request.getParameter("area");
        String hall = request.getParameter("hall");
        String slot = request.getParameter("slot");
        String date = request.getParameter("date");
        String guests = request.getParameter("guests");
        String soup = request.getParameter("soup");
        String starters = request.getParameter("starters");
        String sabji = request.getParameter("sabji");
        String roti = request.getParameter("roti");
        String desserts = request.getParameter("desserts");

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date dateToInsert = dateFormat.parse(date);
        java.sql.Date sqlDate = new java.sql.Date(dateToInsert.getTime());

        String query1 = "select Hall_charges from halls where Hall_name = ?";
        PreparedStatement pst2 = connection.prepareStatement(query1);
        pst2.setString(1, hall);
        resultSet = pst2.executeQuery();
        float charges = 0,hall_charge = 0;

        if (resultSet.next()) {
            hall_charge = resultSet.getFloat("Hall_charges");
        }
        charges = hall_charge + (Integer.parseInt(guests)*650);

        String query = "insert into event_packed(Name, Email, Event, Hall, City, Area, Date, Slot, Guests, Soup, Starters, Maincourse, Roti, Desserts, Cost)"+"values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement pst = connection.prepareStatement(query);
        
        pst.setString(1, name);
        pst.setString(2, email);
        pst.setString(3, event);
        pst.setString(4, hall);
        pst.setString(5, city);
        pst.setString(6, area);
        pst.setDate(7, sqlDate);
        pst.setString(8, slot);
        pst.setInt(9, Integer.parseInt(guests));
        pst.setString(10, soup);
        pst.setString(11, starters);
        pst.setString(12, sabji);
        pst.setString(13, roti);
        pst.setString(14, desserts);
        pst.setFloat(15, charges);

        pst.execute();
}


 catch (Exception e) {
    e.printStackTrace();
    out.println("An error occurred: " + e.getMessage());
} finally {
    // Close resources
    if (resultSet != null) resultSet.close();
    if (statement != null) statement.close();
    if (connection != null) connection.close();
}
response.sendRedirect("/events/Decoration.html");
%>
</body>
</html>
