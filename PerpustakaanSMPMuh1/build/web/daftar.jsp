<%--
    Document   : test
    Created on : Nov 28, 2021, 7:07:34 PM
    Author     : Riska
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
  String tambahAnggota = (String) session.getAttribute("tambah_anggota");
%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/daftar.stl.css">
    <title>Pendaftaran Anggota</title>
  </head>
  <body>
    <div class="container">
      <div class="row">
        <div class="col-md-6 offset-md-3">
          <div class="container-fluid p-4 my-3 border" style="background-color: #fff;">
            <div class="row p-1">
              <div class="col-md-12"><h3 class="h4 mb-4 text-center"><b>Pendaftaran Anggota</b></h3></div>
            </div>
            <form class="row g-3 p-4" action="LayananAnggota?aksi=daftar" method="POST">
              <div class="col-md-12">
                <label for="input-nama">Nama Lengkap</label>
                <input type="text" class="form-control" name="nama" id="input-nama" placeholder="Masukkan Nama Lengkap">
              </div>
              <div class="col-md-5">
                <label for="inputState" class="form-label">Nomor Telepon</label>
                <input type="text" class="form-control" name="no_telpon" id="inputCity" placeholder="Contoh: 62xxx">
              </div>
              <div class="col-md-7">
                <label for="inputState" class="form-label">Email</label>
                <input type="text" class="form-control" name="email" id="inputCity" placeholder="Contoh: xxx@gmail.com">
              </div>
              <div class="col-md-4">
                <label for="input-jen-kel" class="form-label">Jenis Kelamin</label>
                <select class="form-select" name="jen_kel" aria-label="" id="input-jen-kel">
                  <option selected>Pilih..</option>
                  <option value="P">Perempuan</option>
                  <option value="L">Laki-laki</option>
                </select>
              </div>
              <div class="col-md-5">
                <label for="inputState" class="form-label">Tanggal Lahir</label>
                <input type="date" class="form-control" name="tgl_lahir" id="inputCity" placeholder="Masukkan Tanggal Lahir">
              </div>
              <div class="col-md-3">
                <label for="input-status" class="form-label">Status</label>
                <select class="form-select" name="klasifikasi" aria-label="" id="input-status">
                  <option selected>Pilih..</option>
                  <option value="guru">Guru</option>
                  <option value="murid">Murid</option>
                </select>
              </div>
              <div class="col-md-6">
                <label for="input-alamat" class="form-label">Alamat</label>
                <textarea class="form-control" name="alamat" id="input-alamat" rows="2"></textarea>
              </div>
              <div class="col-md-6">
                <label for="input-password" class="form-label">Password</label>
                <input type="password" class="form-control" name="password" id="input-password" placeholder="Buat Password">
              </div>
              <div class="col-md-5 p-1"></div>
              <div class="col-md-2 p-1">
                <center>
                  <button type="submit" class="btn btn-primary border shadow">Daftar</button>
                </center>
              </div>
              <div class="col-md-5 p-2">
                <%
                  if (session.getAttribute("masukan_kosong") != null) {
                    session.removeAttribute("masukan_kosong");
                %>
                <font color="red">Pastikan semua masukan terisi.</font>
                <%
                  }
                  if (session.getAttribute("konfirm_password_berbeda") != null) {
                    session.removeAttribute("konfirm_password_berbeda");
                %>
                <font color="red">Konfirmasi password salah!</font>
                <%
                  }
                %>
              </div>
            </form>
            <div class="row">
              <div class="col-md-12 p-3">
                Sudah terdaftar sebagai anggota?<a href="masuk.jsp">Masuk</a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!------------------ mulai pesan modal ----------------------->
    <%
      if (session.getAttribute("tambah_anggota") != null) {
        if (tambahAnggota.equals("berhasil")) {
          session.removeAttribute("tambah_anggota");
    %>
    <div class="modal fade" id="pesanModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-sm" >
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">Pendaftaran <font color="green"><b>Berhasil</b></font></h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <div class="container-fluid">
              <div class="row">
                <div class="col-4">
                  <span>Silahkan <a href="masuk.jsp">masuk</a></span>
                </div>
              </div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
          </div>
        </div>
      </div>
    </div>
    <%
    } else if (tambahAnggota.equals("gagal")) {
      session.removeAttribute("tambah_anggota");
    %>
    <div class="modal fade" id="pesanModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-sm">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">Pendaftaran <font color="red"><b>Gagal!</b></font></h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <div class="container-fluid">
              <div class="row">
                <div class="col-4">
                  <span>Terjadi kesalahan</span>
                </div>
              </div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
          </div>
        </div>
      </div>
    </div>
    <%
        }
      }
    %>

    <!------------------ akhir pesan modal -------------------------->
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script>
      var pesanModal = new bootstrap.Modal(document.getElementById('pesanModal'), {})
      pesanModal.show()
    </script>
  </body>
</html>
