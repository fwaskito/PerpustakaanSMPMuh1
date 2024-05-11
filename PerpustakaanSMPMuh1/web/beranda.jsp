<%--
    Document   : beranda
    Created on : Nov 16, 2021, 9:12:02 AM
    Author     : Fajar Waskito
--%>
<%
  this.getServletConfig().getServletContext().setAttribute("kembali", "beranda");
  String user = (String) session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/beranda.stl.css">
    <link rel="stylesheet" href="css/navbar.stl.css">
    <link rel="stylesheet" href="css/navigasi-pustakawan.stl.css">
    <link href="fontawesome/css/all.css" rel="stylesheet">
    <title>Beranda</title>
  </head>
  <body>
    <%
      if (user == null) {
    %>
    <jsp:include page="WEB-INF/jspf/navigasi.jspf" />
    <%
    } else {
      if (user.equals("anggota")) {
    %>
    <jsp:include page="WEB-INF/jspf/navigasiAnggota.jspf" />
    <%
    } else if (user.equals("pustakawan")) {
    %>
    <jsp:include page="WEB-INF/jspf/navigasiPustakawan.jspf" />
    <%
        }
      }
    %>
    <div class="container-fluid">
      <div class="row">
        <div class="col-md-6 offset-md-3 my-4">
          <br><br><br><br><br><br><br>
          <center><h1><b>Selamat Datang!</b></h1></center>
          <center><h3>Di Perpustakaan SMP Muhammadiyah 1 Godean</h3></center>
        </div>
      </div>
      <div class="row">
        <div class="col-md-12">
          <center>
            <a href="masuk.jsp">
              <button class="btn btn-dark btn-lg rounded-pill shadow-lg">Masuk</button>
            </a>
          </center>

        </div>
      </div>
    </div>
    <div class="container">
    </div>
    <script src="js/bootstrap.bundle.min.js"></script>
    <script src="js/jquery.min.js"></script>
    <script src="js/navbar.act.js"></script>
    <script src="js/navigasi-pustakawan.act.js"></script>
  </body>
</html>