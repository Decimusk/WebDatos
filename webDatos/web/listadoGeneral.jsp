<%-- 
    Document   : listadoGeneral
    Created on : 23-ago-2022, 17:21:30
    Author     : Ing. Guillermo Pérez
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Listado General de Estudiantes</title>
    </head>
    <body>
       // <!-- Se inicia la programación en Java, con '< %' y termina con'% >'-->
       <%
           Connection conn = null;
           PreparedStatement ps = null;
           ResultSet rs = null;

           String SQL = null;
           try{
               //Instanciar la conexion del Driver
               Class.forName("com.mysql.jdbc.Driver").newInstance();
               conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/universidad","root","");
               conn.setAutoCommit(false);
               
               SQL = "select * from tblestudiantes";
               ps = conn.prepareStatement(SQL, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
               
               rs = ps.executeQuery();
               conn.commit();
               
               //Presentanción de los datos según resultados
               out.println("<h1>Lista de Estudiantes</h1>");
               out.println("<table border=1>");
               out.println("<tr>");
               out.println("<td>Carnet</td>");
               out.println("<td>Nombre</td>");
               out.println("<td>Apellidos</td>");
               out.println("<td>Fecha de Nacimiento</td>");
               out.println("<td>Fecha de Ingreso</td>");
               out.println("<td>Telefono</td>");
               out.println("<td>Dirección</td>");
               out.println("</tr>");
               
               
               //Recorrido por la Tabla
               while(rs.next()){
               out.println("<tr>");
               out.println("<td>"+ rs.getString("CarnetID") +"</td>");
               out.println("<td>"+ rs.getString("Nombre") +"</td>");
               out.println("<td>"+ rs.getString("Apellidos") +"</td>");
               out.println("<td>"+ rs.getString("FechaNacimiento") +"</td>");
               out.println("<td>"+ rs.getString("FechaIngreso") +"</td>");
               out.println("<td>"+ rs.getString("Telefono") +"</td>");
               out.println("<td>"+ rs.getString("Direccion") +"</td>");
               out.println("</tr>");
               } //End While
               out.println("</table>");
           
           } catch(SQLException exSQL){
           out.println(exSQL.toString());
           } catch(Exception ex){
           out.println(ex.toString());
           }
           finally{
           //Se cierran todos los objetos
           if(rs!=null) rs.close();
           if(ps!=null) ps.close();
           if(conn!=null) conn.close();
           }//End Try

       %>
    </body>
</html>
