<%--
    Document   : peminjaman
    Created on : Dec 14, 2021, 2:22:45 AM
    Author     : Fajar Waskito
--%>

<%@page import="psm.model.Anggota"%>
<%@page import="psm.model.Buku"%>
<%@page import="java.sql.Date"%>
<%@page import="psm.helper.FormatTeks"%>
<%@page import="java.util.ArrayList"%>
<%@page import="psm.model.Peminjaman"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
  ArrayList<Peminjaman> daftarPeminjaman = (ArrayList) session.getAttribute("peminjaman");
  ArrayList<Buku> bukuDipinjam = (ArrayList) session.getAttribute("buku_dipinjam");
  ArrayList<Anggota> anggotaPeminjam = (ArrayList) session.getAttribute("anggota_peminjam");
  FormatTeks ft = new FormatTeks();
%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="fontawesome/css/all.min.css">
    <link rel="stylesheet" href="css/navigasi-pustakawan.stl.css">
    <title>Peminjaman</title>
  </head>
  <body>
    <jsp:include page="WEB-INF/jspf/navigasiPustakawan.jspf"/>
    <div class="container-fluid">
      <div class="row">
        <div class="col-md-11">
          <div class="container-fluid p-0 my-3" style="margin-left: 85px">
            <h3 class="h5 mb-4 text-center">Peminjaman</h3>
            <table class="table">
              <thead>
                <tr class="table-dark">
                  <th scope="col">ID Pinjam</th>
                  <th scope="col">Kode Buku</th>
                  <th scope="col">ID Anggota</th>
                  <th scope="col">Tgl. Pinjam</th>
                  <th scope="col">Tgl. H. Kembali</th>
                  <th scope="col">Tgl Kembali</th>
                  <th scope="col">Terlambat</th>
                  <th scope="col"></th>
                </tr>
              </thead>
              <tbody>
                <%
                  if (daftarPeminjaman != null || daftarPeminjaman.size() != 0) {
                    for (int i = 0; i < daftarPeminjaman.size(); i++) {
                      Peminjaman p = daftarPeminjaman.get(i);
                      String idPinjam = p.getIdPinjam();
                      String kodeBuku = p.getKodeBuku();
                      String idAnggota = p.getIdAnggota();
                      String tglPinjam = ft.formatTanggalKeIndonesia(p.getTglPinjam());
                      String tglHarusKembali = ft.formatTanggalKeIndonesia(p.getTglHarusKembali());
                      Date tglKembali = p.getTglKembali();
                      int terlambat = p.getTerlambat();
                %>
                <tr>
                  <td><%=idPinjam%></td>
                  <td><%=kodeBuku%></td>
                  <td><%=idAnggota%></td>
                  <td><%=tglPinjam%></td>
                  <td><%=tglHarusKembali%></td>
                  <td>
                    <%
                      if (tglKembali == null) {
                    %>-<%
                    } else {
                    %><%=ft.formatTanggalKeIndonesia(tglKembali)%><%
                      }
                    %>
                  </td>
                  <td>
                    <%
                      if (terlambat <= 0) {
                    %>-<%
                    } else {
                    %><%=terlambat%>&nbsp;hari<%
                      }
                    %>
                  </td>
                  <%
                    Buku b = bukuDipinjam.get(i);
                    String noPanggil = (String) b.getNoPanggil();
                    String judul = (String) b.getJudul();
                    String pengarang = (String) b.getPengarang();
                    String penerbit = (String) b.getPenerbit();
                    String kota = (String) b.getKota();
                    String tahun = (String) b.getTahun().substring(0, 4);
                    String sampul = noPanggil.replace("/", "-");
                    Anggota a = anggotaPeminjam.get(i);
                    String nama = a.getNama();
                    String email = a.getEmail();
                    String noTelpon = a.getNoTelpon();
                    String jenKel = a.getJenKel();
                    String alamat = a.getAlamat();
                    String klasifikasi = a.getKlasifikasi();
                  %>
                  <td>
                    <!-- Button trigger modal -->
                    <button type="button" class="btn btn-dark" data-bs-toggle="modal" data-bs-target="#infoModal<%=idPinjam%>">
                      Lihat
                    </button>
                    <!-- Modal -->
                    <div class="modal fade" id="infoModal<%=idPinjam%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                      <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                          <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Informasi Peminjaman&nbsp;<%=idPinjam%></h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                          </div>
                          <div class="modal-body">
                            <div class="container-fluid">
                              <div class="row">
                                <div class="col-md-6 p-2">
                                  <h5><b>Buku</b></h5>
                                  <table class="table border">
                                    <tbody>
                                      <tr>
                                        <td class="table-secondary w-25"><b>No. Panggil</b></td>
                                        <td><%=noPanggil%></td>
                                      </tr>
                                      <tr>
                                        <td class="table-secondary"><b>Judul</b></td>
                                        <td><%=judul%></td>
                                      </tr>
                                      <tr>
                                        <td class="table-secondary"><b>Pengarang</b></td>
                                        <td><%=pengarang%></td>
                                      </tr>
                                      <tr>
                                        <td class="table-secondary"><B>Penerbit</B></td>
                                        <td><%=penerbit%></td>
                                      </tr>
                                      <tr>
                                        <td class="table-secondary"><b>Kota</b></td>
                                        <td><%=kota%></td>
                                      </tr>
                                      <tr>
                                        <td class="table-secondary"><b>Tahun</b></td>
                                        <td><%=tahun%></td>
                                      </tr>
                                    </tbody>
                                  </table>
                                </div>
                                <div class="col-md-6 p-2">
                                  <h5><b>Peminjam</b></h5>
                                  <table class="table border">
                                    <tbody>
                                      <tr>
                                        <td class="table-secondary w-25"><b>Nama</b></td>
                                        <td><%=nama%></td>
                                      </tr>
                                      <tr>
                                        <td class="table-secondary w-25"><b>Email</b></td>
                                        <td><%=email%></td>
                                      </tr>
                                      <tr>
                                        <td class="table-secondary"><B>No. Telepon</B></td>
                                        <td><%=noTelpon%></td>
                                      </tr>
                                      <tr>
                                        <td class="table-secondary"><B>Jen. Kel</B></td>
                                        <td><%=jenKel%></td>
                                      </tr>
                                      <tr>
                                        <td class="table-secondary"><B>Alamat</B></td>
                                        <td><%=alamat%></td>
                                      </tr>
                                      <tr>
                                        <td class="table-secondary"><B>Status</B></td>
                                        <td><%=klasifikasi%></td>
                                      </tr>
                                    </tbody>
                                  </table>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div> <!-- close modal -->
                    <%
                      if (tglKembali == null) {
                    %>
                    <a>
                      <!-- Button trigger modal -->
                      <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#telahKembaliModal<%=idPinjam%>">
                        Telah kembali
                      </button>
                    </a>
                    <!-- Modal -->
                    <div class="modal fade" id="telahKembaliModal<%=idPinjam%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                      <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                          <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Konfirmasi Pengembalian</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                          </div>
                          <div class="modal-body">
                            <div class="container-fluid">
                              <div clss="row">
                                <div clss="col-md-12">
                                  <h5><b>Anda yakin, buku ini telah dikembalikan?</b></h5><br>
                                </div>
                              </div>
                              <div class="row">
                                <div class="col-md-5 p-2">
                                  <center><img class="shadow-lg" src="img/sampul/<%=sampul%>.jpg" height="300px" alt=""></center>
                                </div>
                                <div class="col-md-7 p-2">
                                  <table class="table border">
                                    <tbody>
                                      <tr>
                                        <td class="table-secondary w-25"><b>Kode Buku</b></td>
                                        <td><%=kodeBuku%></td>
                                      </tr>
                                      <tr>
                                        <td class="table-secondary w-25"><b>NoPanggil</b></td>
                                        <td><%=noPanggil%></td>
                                      </tr>
                                    </tbody>
                                  </table>
                                </div>
                              </div>
                            </div>
                          </div>
                          <div class="modal-footer">
                            <div class="container-fluid">
                              <di class="row">
                                <div class="col-md-2 offset-md-5">
                                  <a href="LayananPeminjaman?aksi=pengembalian&id_pinjam=<%=idPinjam%>&kode_buku=<%=kodeBuku%>">
                                    <button  type="button" class="btn btn-success">Ya, benar</button>
                                  </a>
                                </div>
                              </di>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div> <!-- close modal -->
                    <%
                      }
                    %>
                  </td>
                </tr>
                <%
                    }
                  }
                %>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
    <script src="js/bootstrap.bundle.min.js" ></script>
    <script src="js/jquery.min.js" ></script>
    <script src="js/navigasi-pustakawan.act.js"></script>
  </body>
</html>
