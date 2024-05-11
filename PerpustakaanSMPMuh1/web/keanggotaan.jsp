<%--
    Document   : keanggotaan
    Created on : Dec 13, 2021, 10:21:29 PM
    Author     : Fajar Waskito
--%>

<%@page import="psm.helper.FormatTeks"%>
<%@page import="java.sql.Date"%>
<%@page import="psm.model.Anggota"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
  ArrayList<Anggota> daftarAnggota = (ArrayList) session.getAttribute("keanggotaan");
  FormatTeks ft = new FormatTeks();
%>
<!DOCTYPE html>
<html>
  <head>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="fontawesome/css/all.min.css">
    <link rel="stylesheet" href="css/navigasi-pustakawan.stl.css">
    <link rel="stylesheet" href="css/table-keanggotaan.stl.css">
    <title>Keanggotaan</title>
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
        </div>
        <div class="col-md-1"></div>
        <div class="col-md-2"><h3 class="h5 mb-4 text-center">Keanggotaan</h3></div>
        <div class="col-md-1"></div>
        <div class="col-md-4">
          <input class="form-control" id="myInput" type="text" placeholder="Cari anggota berdasarkan kata kuncinya..">
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
                  <th>ID Anggota</th>
                  <th>Nama</th>
                  <th>Status</th>
                  <th>&nbsp;</th>
                </tr>
              </thead>
              <tbody id="myTable">
                <%
                  int nomor = 0;
                  for (Anggota a : daftarAnggota) {
                    String idAnggota = a.getIdAnggota();
                    String nama = a.getNama();
                    String email = a.getEmail();
                    String noTelpon = a.getNoTelpon();
                    String jenKel = a.getJenKel();
                    String tglLahir = ft.formatTanggalKeIndonesia(a.getTglLahir());
                    String alamat = a.getAlamat();
                    String klasifikasi = a.getKlasifikasi();
                    String password = a.getPassword();
                    String urlHapusAnggota = "LayananAnggota?aksi=hapusanggota&id_anggota=" + idAnggota;
                %>
                <tr class="alert" role="alert">
                  <td><%=++nomor%></td>
                  <td><div>
                      <%
                        if (jenKel.equalsIgnoreCase("p")) {
                      %>
                      <img class="sampul" src="img/icon/anggota_P.jpg">
                      <%
                      } else if (jenKel.equalsIgnoreCase("l")) {
                      %>
                      <img class="sampul" src="img/icon/anggota_L.jpg">
                      <%
                        }
                      %>

                    </div></td>
                  <td>
                    <div class="no-panggil">
                      <a href="#" style="text-decoration: none; color: black">
                        <span><%=idAnggota%></span>
                      </a>
                    </div>
                  </td>
                  <td>
                    <div class="judul-pengarang">
                      <a href="#" style="text-decoration: none; color: black">
                        <span><%=nama%></span><span><%=email%></span>
                      </a>
                    </div>
                  </td>
                  <td><%=klasifikasi%></td>
                  <td>
                    <span><button type="button" class="btn btn-dark" data-bs-toggle="modal" data-bs-target="#infoModal<%=idAnggota%>">
                        Lihat</button></span>&emsp;&emsp;
                    <a href="<%=urlHapusAnggota%>" type="button" class="hapus" data-dismiss="alert" aria-label="Close">
                      <span aria-hidden="true"><i class="fas fa-trash fa-lg"></i></span>
                    </a>
                  </td>
                </tr>

                <!-- Modal -->
              <div class="modal fade" id="infoModal<%=idAnggota%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h5 class="modal-title" id="exampleModalLabel">Informasi Anggota &nbsp;<%=idAnggota%></h5>
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                      <div class="container">
                        <div class="row">
                          <div class="col-md-12 p-3">
                            <p><b>ID Anggota</b>&ensp;: <%=idAnggota%></p>
                            <p><b>Nama</b>&emsp;&emsp;&ensp;&nbsp;&nbsp;: <%=nama%></p>
                            <p><b>No. Telepon</b>&nbsp;: <%=noTelpon%></p>
                            <p><b>No. Telepon</b>&nbsp;: <%=email%></p>
                            <p><b>Jen. Kel</b>&emsp;&ensp;&nbsp;&nbsp;&nbsp;: <%=jenKel%></p>
                            <p><b>Tgl. Lahir</b>&emsp;&nbsp;&nbsp;: <%=tglLahir%></p>
                            <p><b>Alamat</b>&emsp;&emsp;&ensp;: <%=alamat%></p>
                            <p><b>Klasifikasi</b>&emsp;&nbsp;: <%=klasifikasi%></p>
                            <p><b>Password</b>&emsp;&ensp;: <%=password%></p>
                          </div>

                        </div>

                      </div>
                    </div>
                  </div>
                </div> <!-- close modal -->
                <%
                  }
                %>
                </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
    <script src="js/popper.min.js"></script>
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/navigasi-pustakawan.act.js"></script>
    <script src="js/filter-table.act.js"></script>
  </body>
</html>