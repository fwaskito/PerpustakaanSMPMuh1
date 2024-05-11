<%--
    Document   : katalog
    Created on : Nov 22, 2021, 3:30:24 PM
    Author     : Riska
--%>
<%@page import="psm.model.Anggota"%>
<%@page import="psm.dao.KelolaBuku"%>
<%@page import="java.util.ArrayList"%>
<%@page import="psm.model.Buku"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
  this.getServletConfig().getServletContext().setAttribute("kembali", "katalog");
%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="css/katalog.stl.css">
    <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
    <link link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
          rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <title>Katalog</title>
  </head>
  <body>
    <jsp:include page="WEB-INF/jspf/navigasi.jspf" />
    <div class="container-fluid">
      <div class="row">
        <div class="col-md-12">&nbsp;</div>
      </div>
      <div class="col-md-8 offset-md-2">
        <div class="container-fluid">
          <form class="row" action="LayananBuku?aksi=caribuku" method="POST">
            <div class="input-group mb-6">
              <input type="text" class="form-control" name="kata_kunci" placeholder="Cari buku..">
              <div class="input-group-text p-0">
                <select class="form-select form-select-lg shadow-none bg-light border-0" name="cari_berdasarkan">
                  <option selected>Berdasarkan..</option>
                  <option value="judul">Judul</option>
                  <option value="pengarang">Pengarang</option>
                  <option value="penerbit">Penerbit</option>
                </select>
              </div>
              <button class="input-group-text shadow-none px-8 btn-primary" type="submit">
                cari
              </button>
            </div>
          </form>
        </div>

      </div>
    </div>
    <div class="small-container-katalog">
      <div class="row-katalog row-2">
        <h2>Katalog</h2>
      </div>
      <div class="row-katalog">
        <%
          ArrayList<Buku> daftarBuku = null;
          daftarBuku = (ArrayList) this.getServletConfig().getServletContext().getAttribute("katalog");
          for (Buku b : daftarBuku) {
            String noPanggil = b.getNoPanggil();
            String judul = b.getJudul();
            String sampul = noPanggil.replace("/", "-");
            String urlLihatInformasiBuku = "LayananBuku?aksi=informasibuku&no_panggil=" + noPanggil;
        %>
        <div class="col-4-katalog">
          <a href="<%=urlLihatInformasiBuku%>">
            <img src="img/sampul/<%=sampul%>.jpg">
            <div class="nopanggil">
              <B><%=noPanggil%></b>
            </div>
            <p><%=judul%></p>
          </a>
        </div>
        <%
          }
        %>
      </div>
    </div <!-- close small-container-katalog -->

    <script src="js/bootstrap.bundle.min.js"></script>
  </body>
</html>
