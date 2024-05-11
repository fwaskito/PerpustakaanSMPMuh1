<%--
    Document   : katalogPustakawan
    Created on : Dec 7, 2021, 8:21:10 PM
    Author     : Fernando & Riska
--%>

<%@page import="psm.model.Buku"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
  this.getServletConfig().getServletContext().setAttribute("kembali", "katalog");
  ArrayList<Buku> daftarBuku = (ArrayList) this.getServletConfig().getServletContext().getAttribute("katalog");
%>
<!DOCTYPE html>
<html>
  <head>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="fontawesome/css/all.min.css">
    <link rel="stylesheet" href="css/navigasi-pustakawan.stl.css">
    <link rel="stylesheet" href="css/table-koleksi.stl.css">
    <title>Koleksi</title>
  </head>
  <body>
    <jsp:include page="WEB-INF/jspf/navigasiPustakawan.jspf"/>
    <div class="container-fluid">
      <div class="row">
        <div class="col-md-12">&nbsp;</div>
      </div>
      <div class="row">
        <div class="col-md-1"></div>
        <div class="col-md-2">
          <a class="btn btn-primary shadow" href="tambahBuku.jsp">Tambah buku</a>
        </div>
        <div class="col-md-1"></div>
        <div class="col-md-2"><h3 class="h5 mb-4 text-center">Koleksi</h3></div>
        <div class="col-md-1"></div>
        <div class="col-md-4">
          <input class="form-control" id="myInput" type="text" placeholder="Cari buku berdasarkan kata kuncinya..">
        </div>
      </div>
      <div class="row">
        <div class="col-md-11" style="margin-left: 85px">
          <div class="table-wrap">
            <table class="table">
              <thead class="thead-primary">
                <tr>
                  <th>&nbsp;</th>
                  <th>&nbsp;</th>
                  <th>No. Panggil</th>
                  <th>Judul Buku & Pengarang</th>
                  <th>Jumlah Eksemplar</th>
                  <th>&nbsp;</th>
                </tr>
              </thead>
              <tbody id="myTable">
                <%
                  int nomor = 0;
                  for (Buku b : daftarBuku) {
                    String noPanggil = b.getNoPanggil();
                    String judul = b.getJudul();
                    String pengarang = b.getPengarang();
                    String sampul = noPanggil.replace("/", "-");
                    int jumEks = b.getJumEks();
                    String urlLihatInformasiBuku = "LayananBuku?aksi=informasibuku&no_panggil=" + noPanggil;
                    String urlHapusBuku = "LayananBuku?aksi=pilihhapusbuku&no_panggil=" + noPanggil;
                %>
                <tr class="alert" role="alert">
                  <td><%=++nomor%></td>
                  <td><div><img class="sampul" src="img/sampul/<%=sampul%>.jpg"></div></td>
                  <td>
                    <div class="no-panggil">
                      <a href="<%=urlLihatInformasiBuku%>" style="text-decoration: none; color: black">
                        <span><%=noPanggil%></span>
                      </a>
                    </div>
                  </td>
                  <td>
                    <div class="judul-pengarang">
                      <a href="<%=urlLihatInformasiBuku%>" style="text-decoration: none; color: black">
                        <span><%=judul%></span><span><%=pengarang%></span>
                      </a>
                    </div>
                  </td>
                  <td><%=jumEks%></td>
                  <td>
                    <a href="<%=urlHapusBuku%>" type="button" class="hapus" data-dismiss="alert" aria-label="Close">
                      <span aria-hidden="true"><i class="fas fa-trash fa-lg"></i></span>
                    </a>
                  </td>
                </tr>
                <%
                  }
                %>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/navigasi-pustakawan.act.js"></script>
    <script src="js/filter-table.act.js"></script>
  </body>
</html>