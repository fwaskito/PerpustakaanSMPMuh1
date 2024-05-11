<%--
    Document   : masuk
    Created on : Dec 7, 2021, 11:07:02 AM
    Author     : Fernando
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
  String masuk = (String) this.getServletConfig().getServletContext().getAttribute("masuk");
%>
<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/masuk.stl.css">
    <title>Masuk Perpustakaan</title>
  </head>
  <body>
    <div class="container">
      <div class="frame-anggota">
        <div class="nav">
          <ul class="links">
            <label>Masuk sebagai</label>
            <li class="masuk-anggota-active"><a class="btn">Anggota</a></li>
            <li class="masuk-pustakawan-inactive"><a class="btn">Pustakawan</a></li>
          </ul>
        </div>
        <div>
          <form class="form-masuk-anggota" action="LayananAnggota?aksi=masuk" method="post" name="form">
            <label for="email">Email</label>
            <input class="form-styling" type="text" name="email" placeholder="" />
            <label for="password">Password</label>
            <input class="form-styling" type="password" name="password" placeholder="" />
            <button type="submit" class="btn-masuk-anggota">Masuk</button>
            <%
              if (masuk != null && masuk.equals("tidak_anggota")) {

                this.getServletConfig().getServletContext().removeAttribute("masuk");
            %>
            <font color="red">id anggota/password salah!</font>
            <%
              }
            %>

          </form>
          <form class="form-masuk-pustakawan" action="LayananPustakawan?aksi=masuk" method="post">
            <label for="username">Username</label>
            <input class="form-styling" type="text" name="username" placeholder="" />
            <label for="password">Password</label>
            <input class="form-styling" type="password" name="password" placeholder="" />
            <button type="submit" class="btn-masuk-pustakawan">Masuk</button>
            <%
              if (masuk != null && masuk.equals("tidak_pustakawan")) {

                this.getServletConfig().getServletContext().removeAttribute("masuk");
            %>
            <font color="red">username/password salah!</font>
            <%
              }
            %>
          </form>
          <div class="daftar">
            <span><font color="grey">Belum menjadi anggota?</font>
              <a href="daftar.jsp"><font color="white">Daftar</font></a>
            </span>
          </div>
          <div>
            <div class="cover-photo"></div>
            <div class="profile-photo"></div>
            <h1 class="welcome">Welcome, Friend</h1> <a class="btn-goback" value="Refresh" onClick="history.go()">Go back</a>
          </div>
        </div> <a id="refresh" value="Refresh" onClick="history.go()"> <svg class="refreshicon" version="1.1" id="Capa_1" x="0px" y="0px" width="25px" height="25px" viewBox="0 0 322.447 322.447" style="enable-background:new 0 0 322.447 322.447;" xml:space="preserve">
          <path d="M321.832,230.327c-2.133-6.565-9.184-10.154-15.75-8.025l-16.254,5.281C299.785,206.991,305,184.347,305,161.224 c0-84.089-68.41-152.5-152.5-152.5C68.411,8.724,0,77.135,0,161.224s68.411,152.5,152.5,152.5c6.903,0,12.5-5.597,12.5-12.5 c0-6.902-5.597-12.5-12.5-12.5c-70.304,0-127.5-57.195-127.5-127.5c0-70.304,57.196-127.5,127.5-127.5 c70.305,0,127.5,57.196,127.5,127.5c0,19.372-4.371,38.337-12.723,55.568l-5.553-17.096c-2.133-6.564-9.186-10.156-15.75-8.025 c-6.566,2.134-10.16,9.186-8.027,15.751l14.74,45.368c1.715,5.283,6.615,8.642,11.885,8.642c1.279,0,2.582-0.198,3.865-0.614 l45.369-14.738C320.371,243.946,323.965,236.895,321.832,230.327z" /> </svg> </a>
      </div>
      <script src="js/bootstrap.bundle.min.js"></script>
      <script src="js/jquery.min.js"></script>
      <script src="js/masuk.act.js"></script>
  </body>
</html>