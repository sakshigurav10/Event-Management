<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Get ready for your event</title>
    <link rel="stylesheet" href="Event.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Alice&display=swap');
    </style>
</head>
<body>
    <body>
        <%
            String price = request.getParameter("price");

            // Initialize the database connection
            Connection connection = null;
            Statement statement = null;
            ResultSet resultSet = null;
            String name = (String) session.getAttribute("username");
            String email = (String) session.getAttribute("email_id");
            String event = (String) session.getAttribute("event");
            String query = "", hall="", city="", area="", guests="", soup="", starters="", maincourse="", roti="", desserts="";
                int cost=0;
                Date date;
                String formattedDate="";

            try {
                // Load the MySQL JDBC driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Establish the database connection
                connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/demo", "root", "Shruti@07");
                
                query = "SELECT * FROM event_packed where Email = '" + email + "'";

                statement = connection.createStatement();
                resultSet = statement.executeQuery(query);


                while (resultSet.next()) {
                    hall = resultSet.getString("Hall");
                    city = resultSet.getString("City");
                    area = resultSet.getString("Area");
                    date = resultSet.getDate("Date");
                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); // Adjust the format as needed
                    formattedDate = dateFormat.format(date);

                    guests = resultSet.getString("Guests");
                    soup = resultSet.getString("Soup");
                    if(soup.equals("-1")) soup = "N/A";
                    starters = resultSet.getString("Starters");if(starters.equals("-1")) starters = "N/A";
                    maincourse = resultSet.getString("Maincourse");if(maincourse.equals("-1")) maincourse = "N/A";
                    roti = resultSet.getString("Roti");if(roti.equals("-1")) roti = "N/A";
                    desserts = resultSet.getString("Desserts");if(desserts.equals("-1")) desserts = "N/A";
                    cost = resultSet.getInt("Cost") + Integer.parseInt(price);

                }

                query = "UPDATE event_packed SET Cost = "+cost+" where Email = "+email;
                PreparedStatement pst = connection.prepareStatement(query);
                pst.executeUpdate();
            

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                // Close resources
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            }
        %>

        <br><br>
    <h1>Confirm Your Details</h1><br><br>
    <div class="container">
    <div class="name">Name : <%= name%> </div>
    <div class="email">Email : <%= email%> </div>
    <div class="event_id">Event: <%= event %></div>
    <div class="hall">Hall: <%= hall %></div>
    <div class="city">City: <%= city %></div>
    <div class="date">Event date: <%= formattedDate %></div>
    <div class="menu">Menu: <br>Soup: <%= soup %><br> Starters: <%= starters%><br> Main Course: <%= maincourse%><br>Desserts: <%= desserts %></div>
    <div class="guests">No. of Guests: <%= guests %></div>
    <div class="mode">Mode of Payment: Online</div>
    <div class="cost">Total Cost: ₹ <%= cost %></div>

    <div class="check"><input type="checkbox"><span class="ch"></span> Confirm Booking </div>
    </div><br>
    <button class="proceed" onclick="window.location.href = 'Payment.html';"> Proceed to Pay Rs. ₹ <%= cost %></button>


    
    </body>
</body>
</html>
