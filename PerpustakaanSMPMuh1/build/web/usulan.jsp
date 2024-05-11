<%--
    Document   : usulan
    Created on : Nov 28, 2021, 7:07:34 PM
    Author     : Fernando
--%>

<%@page import="java.sql.Date"%>
<%@page import="psm.helper.FormatTeks"%>
<%@page import="java.util.ArrayList"%>
<%@page import="psm.model.Usulan"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
  ArrayList<Usulan> daftarUsulan = (ArrayList) session.getAttribute("daftar_usulan");
  FormatTeks ft = new FormatTeks();
%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="fontawesome/css/all.min.css">
    <link rel="stylesheet" href="css/navigasi-pustakawan.stl.css">
    <title>Usulan</title>
  </head>
  <body>
    <jsp:include page="WEB-INF/jspf/navigasiPustakawan.jspf"/>
    <div class="container-fluid">
      <div class="row">
        <div class="col-md-11" style="margin-left: 85px">
          <div class="container-fluid p-0 my-3">
            <h3 class="h5 mb-4 text-center">Usulan</h3>
            <table class="table">
              <thead>
                <tr class="table-dark">
                  <th scope="col">Kode Usulan</th>
                  <th scope="col">Judul</th>
                  <th scope="col">Tgl. usul</th>
                  <th scope="col">Status</th>
                  <th scope="col"></th>
                </tr>
              </thead>
              <tbody>
                <%
                  if (daftarUsulan != null || daftarUsulan.size() != 0) {
                    for (Usulan u : daftarUsulan) {
                      String kodeUsulan = u.getKodeUsulan();
                      String tglUsul = ft.formatTanggalKeIndonesia(u.getTglUsul());
                      String status = u.getStatus();
                      String isiUsulan = u.getIsi();
                      String[] splitIsiUsulan = isiUsulan.split(";");
                      String isbn = splitIsiUsulan[0];
                      String judul = splitIsiUsulan[1];
                      String pengarang = splitIsiUsulan[2];
                      String edisi = "-";
                      if (splitIsiUsulan.length == 4 && splitIsiUsulan[3] != null) {
                        edisi = splitIsiUsulan[3];
                      }
                %>
                <tr>
                  <td><%=kodeUsulan%></td>
                  <td><%=judul%></td>
                  <td><%=tglUsul%></td>
                  <td><%=status%></td>
                  <td>
                    <!-- Button trigger modal -->
                    <button type="button" class="btn btn-dark" data-bs-toggle="modal" data-bs-target="#isiModal<%=kodeUsulan%>">
                      Lihat
                    </button>
                    <!-- Modal -->
                    <div class="modal fade" id="isiModal<%=kodeUsulan%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                      <div class="modal-dialog">
                        <div class="modal-content">
                          <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Isi usulan&nbsp;<%=kodeUsulan%></h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                          </div>
                          <div class="modal-body">
                            <table class="table">
                              <tbody>
                                <tr>
                                  <td><b>Judul Buku</b></td>
                                  <td><%=judul%></td>
                                </tr>
                                <tr>
                                  <td><b>Pengarang</b></td>
                                  <td><%=pengarang%></td>
                                </tr>
                                <tr>
                                  <td><b>Edisi</b></td>
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
                                <tr>
                                  <td><b>ISBN</b></td>
                                  <td><%=isbn%></td>
                                </tr>
                              </tbody>
                            </table>
                          </div>
                        </div>
                      </div>
                    </div> <!-- close modal -->
                    <%
                      if (status.equals("belum ditanggapi")) {
                    %>
                    <a>
                      <!-- Button trigger modal -->
                      <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#tanggapiModal<%=kodeUsulan%>">
                        Tanggapi
                      </button>
                    </a>
                    <!-- Modal -->
                    <div class="modal fade" id="tanggapiModal<%=kodeUsulan%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                      <div class="modal-dialog modal-sm">
                        <div class="modal-content">
                          <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Tanggapi Usulan</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                          </div>
                          <div class="modal-body">
                            <b>Apa tanggapan Anda?</b>
                          </div>
                          <div class="modal-footer">
                            <a href="LayananUsulan?aksi=menanggapiusulan&kode_usulan=<%=kodeUsulan%>&tanggapan=ditolak">
                              <button  type="button" class="btn btn-danger">Tolak</button>
                            </a>
                            <a href="LayananUsulan?aksi=menanggapiusulan&kode_usulan=<%=kodeUsulan%>&tanggapan=diterima">
                              <button type="button" class="btn btn-success">Terima</button>
                            </a>
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
