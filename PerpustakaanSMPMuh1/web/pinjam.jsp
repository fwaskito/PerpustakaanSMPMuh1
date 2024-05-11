<%--
    Document   : pinjam
    Created on : Nov 22, 2021, 11:10:27 AM
    Author     : Fajar Waskito
--%>

<%@page import="psm.model.Buku"%>
<%@page import="java.util.ArrayList"%>
<%@page import="psm.model.Anggota"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
  Anggota anggota = (Anggota) session.getAttribute("anggota");
  String pinjam = (String) session.getAttribute("pinjam");
  Buku buku = (Buku) session.getAttribute("buku");
  ArrayList<Buku> daftarEksemplar = (ArrayList) session.getAttribute("pilih_pinjam");
%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/navbar.stl.css">
    <link rel="stylesheet" type="text/css" href="fontawesome/css/all.css">
    <title>Pinjam Buku</title>
  </head>
  <body>
    <jsp:include page="WEB-INF/jspf/navigasiAnggota.jspf"/>
    <div class="container">
      <div class="row">
        <div class="col-md-6 offset-md-3" style="margin-top: 30px">
          <div class="container-fluid my-4 border">
            <div class="row">
              <div class="col-md-12 p-4">
                <center><h4>Pinjam Buku</h4></center>
                <br><b>No Panggil&ensp;:</b> <%=buku.getNoPanggil()%>
                <br><b>Judul&emsp;&emsp;&ensp;&ensp;:</b> <%=buku.getJudul()%>
                <br><b>Pengarang&ensp;:</b> <%=buku.getPengarang()%>
                <br><b>Jum. Eks&ensp;&ensp;&ensp;:</b> <%=buku.getJumEks()%>
              </div>
            </div>
            <div class="row">
              <div class="col-md-12 p-2">
                <div class="row">
                  <table class="table table-hover">
                    <thead>
                      <tr class="table-dark">
                        <th>Kode Buku</th>
                        <th>Status</th>
                        <th></th>
                      </tr>
                    </thead>
                    <tbody>
                      <%
                        if (daftarEksemplar != null || daftarEksemplar.size() == 0) {
                          for (Buku eks : daftarEksemplar) {
                            String kodeBuku = eks.getKodeBuku();
                            String status = eks.getStatus();
                            String urlPinjam = "LayananPeminjaman?aksi=pinjam"
                                    + "&no_panggil=" + buku.getNoPanggil()
                                    + "&kode_buku=" + kodeBuku
                                    + "&id_anggota=" + anggota.getIdAnggota();
                      %>
                      <tr>
                        <td><%=kodeBuku%></td>
                        <td><%=status%></td>
                        <td><a href="<%=urlPinjam%>">
                            <button class="btn btn-primary">Pinjam</button></a></td>
                      </tr>
                      <%
                          }
                        }
                      %>
                      <%
                        if (pinjam != null) {
                          if (pinjam.equals("berhasil")) {
                            session.removeAttribute("hapus_buku");
                      %>
                    <br><font color="greeen">berhasil dipinjam.</font>
                    <%
                    } else if (pinjam.equals("gagal")) {
                      session.removeAttribute("hapus_buku");
                    %>
                    <br><font color="red">Peminjaman gagal!</font>
                    <%
                        }
                      }
                    %>
                    </tbody>
                  </table>
                </div>
              </div> <!-- close col-md-12 -->
            </div>
          </div>
        </div>
      </div>
    </div>
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/navbar.act.js"></script>
  </body>
</html>
