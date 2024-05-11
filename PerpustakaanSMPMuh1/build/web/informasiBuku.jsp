<%--
    Document   : informasiBuku
    Created on : Nov 20, 2021, 3:01:03 PM
    Author     : Riska
--%>

<%@page import="psm.model.Buku"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
  String user = (String) session.getAttribute("user");
  String adaDiRak = (String) session.getAttribute("ada_di_rak");
%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="fontawesome/css/all.css">
    <link rel="stylesheet" href="css/navbar.stl.css">
    <link rel="stylesheet" href="css/navigasi-pustakawan.stl.css">
    <title>Informasi Buku</title>
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
        <div class="col-md-10 offset-md-1" style="margin-top: 35px">
          <div class="container-fluid p-0 my-4">
            <div class="row">
              <%
                Buku b = (Buku) this.getServletConfig().getServletContext().getAttribute("informasi_buku");
                String noPanggil = (String) b.getNoPanggil();
                String judul = (String) b.getJudul();
                String pengarang = (String) b.getPengarang();
                String penerbit = (String) b.getPenerbit();
                String kota = (String) b.getKota();
                String tahun = (String) b.getTahun().substring(0, 4);
                String jumHal = String.valueOf(b.getJumHal());
                String jumEks = String.valueOf(b.getJumEks());
                String status = String.valueOf(b.getStatus());
                String sampul = noPanggil.replace("/", "-");
              %>
              <div class="col-md-5 p-2 border">
                <div class="container-fluid">
                  <div class="row">
                    <div class="col-md-12 p-3 my-2">
                      <center><img class="shadow-lg" src="img/sampul/<%=sampul%>.jpg" height="420px" alt=""></center>
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-md-7 p-4 border">
                <div class="container-fluid">
                  <div class="row">
                    <div class="col-md-12">
                      <h4><%=judul%></h4><br>
                    </div>
                    <div class="col-md-12 my-4">
                      <table class="table">
                        <tbody>
                          <tr>
                            <td class=" w-25"><b>Pengarang</b></td>
                            <td><%=pengarang%></td>
                          </tr>
                          <tr>
                            <td class=""><B>Penerbit</B></td>
                            <td><%=penerbit%></td>
                          </tr>
                          <tr>
                            <td class=""><b>Kota/Tahun</b></td>
                            <td><%=kota%>/<%=tahun%></td>
                          </tr>
                          <tr>
                            <td class=""><b>Jum. Halaman</b></td>
                            <td><%=jumHal%>&nbsp;p.</td>
                          </tr>
                          <tr>
                            <td class=""><b>Jum. Eksemplar</b></td>
                            <td><%=jumEks%>&nbsp;eks.</td>
                          </tr>
                          <tr class="table-secondary">
                            <td class=""><b>Status</b></td>
                            <td><%=status%></td>
                          </tr>
                          <tr class="table-secondary">
                            <td ><b>No. Panggil</b></td>
                            <td><%=noPanggil%></td>
                          </tr>
                        </tbody>
                      </table>
                    </div>
                    <div class="col-md-4"></div>
                    <div class="col-md-3">
                      <%
                        if (user != null) {
                          user = (String) session.getAttribute("user");
                          if (user.equals("anggota")) {
                      %>
                      <a href="LayananBuku?aksi=taruhbukudirak&no_panggil=<%=noPanggil%>">
                        <button class="btn btn-primary border shadow">Taruh Rak</button>
                      </a>
                      <%
                        }
                      } else {
                      %>
                      <a href="masuk.jsp">
                        <button class="btn btn-primary border shadow">Taruh Rak</button>
                      </a>
                      <%
                        }
                      %>
                    </div>
                    <div class="col-md-5">
                      <%
                        if (adaDiRak != null) {
                          if (adaDiRak.equals("ya")) {
                      %>
                      &nbsp;&nbsp;<font color="red">Buku telah ada di rak!</font>
                      <%
                      } else if (adaDiRak.equals("tidak")) {
                      %>
                      &nbsp;&nbsp;<font color="green">Buku berhasil ditaruh di rak</font>
                      <%
                          }
                        }
                        session.removeAttribute("ada_di_rak");
                      %>
                    </div>
                  </div>
                </div>
              </div>
            </div> <!-- close inner row -->
          </div><!-- close inner conteiner -->
        </div> <!-- close col-md-11 -->
      </div> <!-- close row --->
    </div> <!-- close container -->
    <script src="js/bootstrap.bundle.min.js"></script>
    <script src="js/jquery.min.js"></script>
    <script src="js/navbar.act.js"></script>
    <script src="js/navigasi-pustakawan.act.js"></script>
  </body>
</html>
