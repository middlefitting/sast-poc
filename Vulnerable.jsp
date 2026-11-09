<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<html>
<head>
    <title>Semgrep JSP Vulnerability Test</title>
</head>
<body>

<%
    /*
     * TEST 1 : SQL Injection
     *
     * Source : request.getParameter()
     * Sink   : Statement.executeQuery()
     */
    String username = request.getParameter("username");

    Connection conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/test",
        "root",
        "password"
    );

    Statement stmt = conn.createStatement();

    String sql =
        "SELECT * FROM users WHERE username = '" + username + "'";

    ResultSet rs = stmt.executeQuery(sql);


    /*
     * TEST 2 : Reflected XSS
     *
     * Source : request.getParameter()
     * Sink   : out.println()
     */
    String message = request.getParameter("message");

    out.println("<div>" + message + "</div>");


    /*
     * TEST 3 : Command Injection
     *
     * Source : request.getParameter()
     * Sink   : Runtime.exec()
     */
    String command = request.getParameter("cmd");

    Runtime.getRuntime().exec(command);
%>

</body>
</html>
