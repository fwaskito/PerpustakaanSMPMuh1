<%--
    Document   : usul
    Created on : Nov 28, 2021, 7:07:34 PM
    Author     : Fernando
--%>

<%@page import="psm.model.Anggota"%>
<%@page import="psm.helper.FormatTeks"%>
<%@page import="psm.model.Usulan"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
  ArrayList<Usulan> daftarUsulan = (ArrayList) session.getAttribute("daftar_usulan");
  FormatTeks ft = new FormatTeks();
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/navbar.stl.css">
    <link rel="stylesheet" type="text/css" href="fontawesome/css/all.css">
    <title>Usul Pustaka</title>
  </head>
  <body>
    <%--<%@include file="headerBaru.jsp" %>--%>
    <%@include file="WEB-INF/jspf/navigasiAnggota.jspf" %>
    <div class="container">
      <div class="container-fluid p-1 my-2">
        <div class="row">
          <div class="col-md-4">
          </div>
        </div>
      </div>
      <div class="row">
        <div class="col" style="margin-top: 18px">
          <div class="container p-3 my-3 border">
            <table class="table border table-hover">
              <br><h4><center>Riwayat Usul Saya</center></h4>
              <thead>
                <tr class="table-dark">
                  <th scope="col">Kode Usulan</th>
                  <th scope="col">Status</th>
                  <th scope="col">Opsi</th>
                </tr>
              </thead>
              <tbody>
                <%
                  if (daftarUsulan != null) {
                    for (Usulan u : daftarUsulan) {
                      String kodeUsulan = u.getKodeUsulan();
                      String status = u.getStatus();
                      String urlLihatLebihUsulan = "LayananUsulan?aksi=lihatlebihusulan&kode_usulan=" + kodeUsulan;
                      String urlHapusUsulan = "LayananUsulan?aksi=hapususulan&kode_usulan=" + kodeUsulan;
                %>
                <tr>
                  <td><%=kodeUsulan%></td>
                  <td><%=status%></td>
                  <td><a href="<%=urlLihatLebihUsulan%>"><button type="button" class="btn btn-primary">Lihat</button></a>
                    <a href="<%=urlHapusUsulan%>"><button type="button" class="btn btn-danger">Hapus</button></a></td>
                </tr>
                <%
                    }
                  }
                %>
              </tbody>
            </table>
            <%              if (session.getAttribute("hapus_usulan") != null) {
                String hapusUsulan = (String) session.getAttribute("hapus_usulan");
                session.removeAttribute("hapus_usulan");
                if (hapusUsulan.equals("berhasil")) {
            %>
            <font color="green">Usulan berhasil dihapus</font>
            <%
            } else if (hapusUsulan.equals("gagal")) {
            %>
            <font color="red">Gagal menghapus usulan!</font>
            <%
                }
              }
            %>
          </div>
        </div>
        <%
          if (session.getAttribute("lihat_lebih_usulan") != null) {
            Usulan usulan = (Usulan) session.getAttribute("lihat_lebih_usulan");
            session.removeAttribute("lihat_lebih_usulan");
            String kodeUsulan = usulan.getKodeUsulan();
            String tglUsul = ft.formatTanggalKeIndonesia(usulan.getTglUsul());
            String status = usulan.getStatus();
            String isiUsulan = usulan.getIsi();
            String[] splitIsiUsulan = isiUsulan.split(";");
            String isbn = splitIsiUsulan[0];
            String judul = splitIsiUsulan[1];
            String pengarang = splitIsiUsulan[2];
            String edisi = "-";
            if (splitIsiUsulan.length == 4 && splitIsiUsulan[3] != null) {
              edisi = splitIsiUsulan[3];
            }
        %>
        <div class="col">
          <div class="container p-5 my-3 border shadow">
            <a href="LayananUsulan?aksi=riwayatusul"><button type="button" class="btn btn-light border">Tutup</button></a>
            <br><h4><center>Lihat Usulan</center></h4><br>
            <table class="table">
              <tbody>
                <tr>
                  <td>Kode Usulan</td>
                  <td><%=kodeUsulan%></td>
                </tr>
                <tr>
                  <td>Tgl. Usul</td>
                  <td><%=tglUsul%></td>
                </tr>
                <tr>
                  <td>Status</td>
                  <td><%=status%></td>
                </tr>
                <tr class="table-secondary">
                  <td>Judul Buku</td>
                  <td><%=judul%></td>
                </tr>
                <tr class="table-secondary">
                  <td>Pengarang</td>
                  <td><%=pengarang%></td>
                </tr>
                <tr class="table-secondary">
                  <td>Edisi</td>
                  <td>
                    <%
                      if (edisi != null) {
                    %>
                    <%=edisi%>
                    <%
                    } else {
                    %>
                    -
                    <%
                      }
                    %>

                  </td>
                </tr>
                <tr class="table-secondary">
                  <td>ISBN</td>
                  <td><%=isbn%></td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
        <%
        } else if (session.getAttribute("lihat_lebih_usulan") == null) {
        %>
        <div class="col" style="margin-top: 18px">
          <div class="container p-3 my-3 border">
            <br><h4><center>Ajukan Usulan</center></h4><br>
            <form class="row g-3" action="LayananUsulan?aksi=mengajukanusulan" method="POST">
              <div class="col-12">
                <input type="text" class="form-control" id="inputText" name="judul" value="" placeholder="Masukan Judul Buku">
              </div>
              <div class="col-12">
                <input type="text" class="form-control" id="inputText" name="pengarang" value="" placeholder="Masukan nama Pengarang">
              </div>
              <div class="col-md-6">
                <input type="text" class="form-control" id="inputText" name="isbn" value="" placeholder="Masukan ISBN">
              </div>
              <div class="col-md-6">
                <input type="text" class="form-control" id="inputText" name="edisi" value="" placeholder="Masukan edisi">
              </div>
              <div class="col-12">
                <button type="submit" class="btn btn-primary">Ajukan</button>
              </div>
              <%
                if (session.getAttribute("mengajukan_usulan") != null) {
                  String mengajukanUsulan = (String) session.getAttribute("mengajukan_usulan");
                  session.removeAttribute("mengajukan_usulan");
                  if (mengajukanUsulan.equals("berhasil")) {
              %>
              <font color="green">Pengajuan berhasil</font>
              <%
              } else if (mengajukanUsulan.equals("gagal")) {
              %>
              <font color="red">Pengajuan gagal!</font>
              <font color="red">Buku yang sama sudah pernah diajukan.</font>
              <%
                  }
                }
              %>
            </form>
          </div>
        </div>
        <%
          }
        %>

      </div>
    </div>
    <script src="js/bootstrap.bundle.min.js"></script>
    <script src="js/jquery.min.js"></script>
    <script src="js/navbar.act.js"></script>
  </body>
</html>
