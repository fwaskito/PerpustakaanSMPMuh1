<%--
    Document   : rakAnggota
    Created on : Nov 20, 2021, 8:35:39 PM
    Author     : Fernando
--%>

<%@page import="psm.model.Anggota"%> 
<%@page import="java.util.ArrayList"%>
<%@page import="psm.model.Buku"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
  Anggota anggota = (Anggota) session.getAttribute("anggota");
  this.getServletConfig().getServletContext().setAttribute("kembali", "rak");
  ArrayList<Buku> rak = (ArrayList) session.getAttribute("rak");
%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/navbar.stl.css">
    <link rel="stylesheet" type="text/css" href="fontawesome/css/all.css">
    <title>PinjamBukuRak</title>
  </head>
  <body>
    <jsp:include page="WEB-INF/jspf/navigasiAnggota.jspf" />
    <div class="container-fixed">
      <div class="row">
        <div class="col" style="margin-top: 20px">
          <div class="container p-4 my-4 border">
            <br><h4><left>Rak Buku Saya</left></h4>
            <form class="row g-3">
              <table class="table table-hover">
                <thead>
                  <tr class="table-dark">
                    <th scope="col">No. Panggil</th>
                    <th scope="col">Judul Buku</th>
                    <th scope="col">Jumlah Eksemplar</th>
                    <th scope="col">Ketersediaan</th>
                    <th scope="col">opsi</th>
                  </tr>
                </thead>
                <tbody>
                  <%
                    //ArrayList<Buku> rak = (ArrayList) session.getAttribute("rak");
                    if (rak != null && rak.size() != 0) {
                      for (Buku b : rak) {
                        String noPanggil = b.getNoPanggil();
                        String judul = b.getJudul();
                        int jumEks = b.getJumEks();
                        String status = b.getStatus();
                        String urlInformasiBuku = "LayananBuku?aksi=informasibuku&no_panggil=" + noPanggil;
                  %>

                  <tr>
                    <th scope="row"><a href="<%=urlInformasiBuku%>" style="text-decoration: none; color: black"><%=noPanggil%></a></td></th>
                    <td><a href="<%=urlInformasiBuku%>" style="text-decoration: none; color: black"><%=judul%></a></td>
                    <td><%=jumEks%></td>
                    <td><%=status%></td>

                    <td>
                      <a href="LayananPeminjaman?aksi=pilihpinjam&no_panggil=<%=noPanggil%>">
                        <button type="button" class="btn btn-primary">Pinjam</button>
                      </a>
                      <a href="LayananBuku?aksi=hapusbukudirak&no_panggil=<%=noPanggil%>">
                        <button type="button" class="btn btn-danger">Hapus</button>
                      </a>
                    </td>
                  </tr>

                  <%
                      }
                    }

                  %>
                </tbody>
              </table>
              <%                if (rak == null || rak.size() == 0) {
              %>
              <h5>Raknya kosong :(</h5>
              <%
                }
              %>
            </form>
          </div>
        </div>
      </div>
      <script src="js/bootstrap.bundle.min.js"></script>
      <script src="js/jquery.min.js"></script>
      <script src="js/navbar.act.js"></script>
    </div>
  </body>
</html>
