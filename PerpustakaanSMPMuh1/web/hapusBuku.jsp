<%--
    Document   : test
    Created on : Nov 28, 2021, 7:07:34 PM
    Author     : Fernando
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="psm.model.Buku"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
  String hapusBuku = (String) session.getAttribute("hapus_buku");
  String noPanggil = "";
  String judul = "";
  String pengarang = "";
  int jumEks = 0;
  Buku buku = (Buku) session.getAttribute("buku");
  if (buku != null) {
    noPanggil = buku.getNoPanggil();
    judul = buku.getJudul();
    pengarang = buku.getPengarang();
    jumEks = buku.getJumEks();
  }
  ArrayList<Buku> daftarBuku = (ArrayList) session.getAttribute("pilih_hapus");
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="fontawesome/css/all.min.css">
    <link rel="stylesheet" href="css/navigasi-pustakawan.stl.css">
    <title>Hapus Buku</title>
  </head>
  <body>
    <jsp:include page="WEB-INF/jspf/navigasiPustakawan.jspf"/>
    <div class="container">
      <div class="row">
        <div class="col-md-7 offset-md-3">
          <div class="container-fluid my-4 border shadow">
            <div class="row">
              <div class="col-md-12 p-4">
                <center><h4>Hapus Buku</h4></center>
                <br><b>No Panggil&ensp;:</b> <%=noPanggil%>
                <br><b>Judul&emsp;&emsp;&ensp;&ensp;:</b> <%=judul%>
                <br><b>Pengarang&ensp;:</b> <%=pengarang%>
                <br><b>Jum. Eks&ensp;&ensp;&ensp;:</b>
                <%
                  if (jumEks != 0) {
                %>
                <%=jumEks%>
                <%
                  }
                %>

              </div>
            </div>
            <div class="row">
              <div class="col-md-12 p-2">
                <div class="row">
                  <table class="table table-striped table-hover">
                    <thead>
                      <tr>
                        <th>Kode Buku</th>
                        <th>Status</th>
                          <%
                            if (jumEks != 0) {
                          %>
                        <th><a href="LayananBuku?aksi=hapusbuku&banyak_hapus=semua">
                            <button class="btn btn-danger">Hapus Semua</button></a></th>
                            <%
                              }
                            %>

                      </tr>
                    </thead>
                    <tbody>
                      <%
                        if (daftarBuku != null || daftarBuku.size() == 0) {
                          for (Buku b : daftarBuku) {
                            String kodeBuku = b.getKodeBuku();
                            String status = b.getStatus();
                      %>
                      <tr>
                        <td><%=kodeBuku%></td>
                        <td><%=status%></td>
                        <td><a href="LayananBuku?aksi=hapusbuku&banyak_hapus=satu&kode_buku=<%=kodeBuku%>">
                            <button class="btn btn-danger">Hapus</button></a></td>
                      </tr>
                      <%
                          }
                        }
                      %>
                      <%
                        if (hapusBuku != null) {
                          if (hapusBuku.equals("berhasil")) {
                            session.removeAttribute("hapus_buku");
                      %>
                    <br><font color="greeen">berhasil dihapus</font>
                    <%
                    } else if (hapusBuku.equals("gagal")) {
                      session.removeAttribute("hapus_buku");
                    %>
                    <br><font color="red">Gagal dihapus!</font>
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
    <script src="js/navigasi-pustakawan.act.js"></script>
  </body>
</html>
