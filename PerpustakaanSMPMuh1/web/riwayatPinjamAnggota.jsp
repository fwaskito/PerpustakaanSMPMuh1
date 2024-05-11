<%--
    Document   : riwayatPinjamAnggota
    Created on : Nov 23, 2021, 12:07:42 PM
    Author     : Fernando & Fajar
--%>

<%@page import="psm.model.Buku"%>
<%@page import="psm.helper.FormatTeks"%>
<%@page import="java.sql.Date"%>
<%@page import="java.util.Map"%>
<%@page import="psm.model.Peminjaman"%>
<%@page import="java.util.ArrayList"%>
<%@page import="psm.model.Anggota"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
  Anggota anggota = (Anggota) session.getAttribute("anggota");
  Map<String, ArrayList> riwayatPinjam = (Map) session.getAttribute("riwayat_pinjam");
  ArrayList<String> bisaPerpanjang = (ArrayList) session.getAttribute("bisa_perpanjang");
  FormatTeks ft = new FormatTeks();
%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/navbar.stl.css">
    <link rel="stylesheet" type="text/css" href="fontawesome/css/all.css">
    <title>Riwayat Pinjam</title>
  </head>
  <body>
    <jsp:include page="WEB-INF/jspf/navigasiAnggota.jspf"/>
    <div class="container-fixed">
      <div class="row">
        <div class="col-md-12">&nbsp;</div>
      </div>
      <div class="row">
        <div class="col-md-12">&nbsp;</div>
      </div>
      <div class="row">
        <div class="col">
          <div class="container p-5 my-0 border">
            <h4><left>Sedang Dipinjam</left></h4>
            <form class="row g-3">
              <table class="table table-hover">
                <thead>
                  <tr class="table-dark">
                    <th scope="col">Kode Buku</th>
                    <th scope="col">Judul Buku</th>
                    <th scope="col">Tgl. Pinjam</th>
                    <th scope="col">Perpanjangan</th>
                    <th scope="col">Tgl. Harus Kembali</th>
                    <th scope="col">Terlambat</th>
                  </tr>
                </thead>
                <tbody>
                  <%
                    ArrayList<Peminjaman> sb = (ArrayList) riwayatPinjam.get("sedang_berlangsung");
                    ArrayList<Buku> bSb = (ArrayList) riwayatPinjam.get("buku_sedang_berlangsung");
                    if (sb != null && sb.size() != 0) {
                      for (int i = 0; i < sb.size(); i++) {
                        Peminjaman p = sb.get(i);
                        Buku b = bSb.get(i);
                        String idPinjam = p.getIdPinjam();
                        String kodeBuku = p.getKodeBuku();
                        Date tglPinjam = p.getTglPinjam();
                        Date tglHarusKembali = p.getTglHarusKembali();
                        int terlambat = p.getTerlambat();
                        String judul = "nul cok!";

                        if (b.getJudul() != null) {
                          judul = b.getJudul();
                        }
                        if (terlambat > 0) {
                  %>
                  <tr class="table-danger">
                    <%
                    } else {
                    %>
                  <tr>
                    <%
                      }
                    %>

                    <td><%=kodeBuku%></td>
                    <td><%=judul%></td>
                    <td><%=ft.formatTanggalKeIndonesia(tglPinjam)%></td>
                    <td>
                      <%
                        if (bisaPerpanjang.get(i).equals("ya")) {
                      %>
                      <a href="LayananPeminjaman?aksi=perpanjang&id_pinjam=<%=idPinjam%>">
                        <button type="button" class="btn btn-primary">Perpanjang</button>
                      </a>
                      <%
                        }
                      %>
                    </td>
                    <td><%=ft.formatTanggalKeIndonesia(tglHarusKembali)%></td>
                    <td>
                      <%
                        if (terlambat <= 0) {
                      %>-<%
                      } else {
                      %><%=terlambat%>&nbsp;hari<%
                        }
                      %>
                    </td>
                  </tr>
                  <%
                      } // close FOR EACH peminjaman IN sd
                    } // close IF sd NOT NOT AND sd.size NOT 0
                  %>
                </tbody>
              </table>
              <%
                if (sb == null || sb.size() == 0) {
              %>
              <p>Tidak ada buku yang sedang dipinjam</p>
              <%
                }
              %>
            </form>

            <h4><left><br>Riwayat Pinjam Saya</left></h4>
            <form class="row g-3">
              <table class="table table-hover">
                <thead>
                  <tr class="table-dark">
                    <th scope="col">Kode Buku</th>
                    <th scope="col">Judul Buku</th>
                    <th scope="col">Tanggal Pinjam</th>
                    <th scope="col">Tanggal Kembali</th>
                  </tr>
                </thead>
                <tbody>
                  <%
                    ArrayList<Peminjaman> tb = (ArrayList) riwayatPinjam.get("telah_berlalu");
                    ArrayList<Buku> bTb = (ArrayList) riwayatPinjam.get("buku_telah_berlalu");
                    if (tb != null && tb.size() != 0) {
                      for (int i = 0; i < tb.size(); i++) {
                        Peminjaman p = tb.get(i);
                        Buku b = bTb.get(i);
                        String kodeBuku = p.getKodeBuku();
                        Date tglPinjam = p.getTglPinjam();
                        Date tglKembali = p.getTglKembali();
                        String judul = b.getJudul();
                  %>
                  <tr>
                    <td><%=kodeBuku%></td>
                    <td><%=judul%></td>
                    <td><%=ft.formatTanggalKeIndonesia(tglPinjam)%></td>
                    <td><%=ft.formatTanggalKeIndonesia(tglKembali)%></td>
                  </tr>
                  <%
                      }
                    }
                  %>
                </tbody>
              </table>
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
