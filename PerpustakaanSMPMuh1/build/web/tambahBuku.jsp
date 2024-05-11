<%--
    Document   : test
    Created on : Nov 28, 2021, 7:07:34 PM
    Author     : Fernando, Riska, & Fajar
--%>

<%@page import="psm.model.Buku"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
  String tambahBuku = (String) session.getAttribute("tambah_buku");
  String unggahSampul = (String) session.getAttribute("unggah_sampul");
  String noPanggil = "";
  String judul = "";
  String pengarang = "";
  String penerbit = "";
  String kota = "";
  String tahun = "";
  String jumHal = "";
  String edisi = "";
  String kategori = "";
  String jumEks = "";
%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="fontawesome/css/all.min.css">
    <link rel="stylesheet" href="css/navigasi-pustakawan.stl.css">
    <title>Tambah Buku</title>
  </head>
  <body>
    <jsp:include page="WEB-INF/jspf/navigasiPustakawan.jspf"/>
    <div class="container-fluid">
      <div class="row">
        <div class="col-md-11" style="margin-left: 80px;">
          <div class="container-fluid p-0 my-4">
            <div class="row">
              <div class="col-md-7 p-4 border">
                <div class="container-fluid">
                  <h4><center>Tambah Buku</center></h4>

                  <form class="row g-2 p-2" action="LayananBuku?aksi=tambahbuku" method="POST">
                    <%
                      if (tambahBuku != null) {
                        if (tambahBuku.equals("berhasil")) {
                          Buku b = (Buku) session.getAttribute("buku_baru_ditambah");
                          noPanggil = b.getNoPanggil();
                          judul = b.getJudul();
                          pengarang = b.getPengarang();
                          penerbit = b.getPenerbit();
                          kota = b.getKota();
                          tahun = b.getTahun().substring(0, 4);
                          jumHal = String.valueOf(b.getJumHal());
                          jumEks = String.valueOf(b.getJumEks());
                          edisi = (String) session.getAttribute("edisi_buku_baru_ditambah");
                          kategori = (String) session.getAttribute("kategori_buku_baru_ditambah");
                    %>
                    <div class="col-md-12">
                      <label for="input-judul" class="form-label">Judul</label>
                      <input type="text" class="form-control" id="input-judul" placeholder="<%=judul%>" disabled>
                    </div>
                    <div class="col-md-12">
                      <label for="input-pengarang" class="form-label">Pengarang</label>
                      <input type="text" class="form-control" id="input-pengarang" placeholder="<%=pengarang%>" disabled>
                    </div>
                    <div class="col-md-6">
                      <label for="input-penerbit" class="form-label">Penerbit</label>
                      <input type="text" class="form-control" id="input-penerbit" placeholder="<%=penerbit%>" disabled>
                    </div>
                    <div class="col-md-6">
                      <label for="input-kota" class="form-label">Kota</label>
                      <input type="text" class="form-control" id="input-kota" placeholder="<%=kota%>" disabled>
                    </div>
                    <div class="col-md-2">
                      <label for="input-tahun" class="form-label">Tahun Terbit</label>
                      <select id="input-tahun" class="form-select" disabled>
                        <option selected><%=tahun%></option>
                      </select>
                    </div>
                    <div class="col-md-2">
                      <label for="input-jum-hal" class="form-label">Jum. Hal</label>
                      <input type="text" class="form-control" id="input-jum-hal" placeholder="<%=jumHal%>" disabled>
                    </div>
                    <div class="col-md-2">
                      <label for="input-edisi" class="form-label">Edisi</label>
                      <select id="input-edisi" class="form-select" disabled>
                        <option selected><%=edisi%></option>
                      </select>
                    </div>
                    <div class="col-md-6">
                      <label for="input-kategori" class="form-label">Kategori</label>
                      <select id="input-kategori"class="form-select" disabled>
                        <option selected><%=kategori%></option>
                      </select>
                    </div>
                    <div class="col-md-3">
                      <label for="input-jum-eks" class="form-label">Jum. Eksemplar</label>
                      <input type="number" class="form-control" id="input-jum-eks" placeholder="<%=jumEks%>" disabled>
                    </div>
                    <div class="col-md-2">
                    </div>
                    <div class="col-md-2" style="padding-top: 30px">
                      <center>
                        <input type="submit" class="btn btn-light border" value="Simpan" disabled>
                      </center>
                    </div>
                    <div class="col-md-4" style="padding-top: 35px">
                      <span><font color="green">Berhasil ditambahkan</font></span>
                    </div>
                    <%
                    } else if (tambahBuku.equals("gagal")) {
                    %>
                    <div class="col-md-12">
                      <label for="input-judul" class="form-label">Judul</label>
                      <input type="text" class="form-control" id="input-judul" name="judul" placeholder="Masukan judul buku">
                    </div>
                    <div class="col-md-12">
                      <label for="input-pengarang" class="form-label">Pengarang</label>
                      <input type="text" class="form-control" id="input-pengarang" name="pengarang" placeholder="Masukan nama pengarang">
                    </div>
                    <div class="col-md-6">
                      <label for="input-penerbit" class="form-label">Penerbit</label>
                      <input type="text" class="form-control" id="input-penerbit" name="penerbit" placeholder="Masukan nama penerbit">
                    </div>
                    <div class="col-md-6">
                      <label for="input-kota" class="form-label">Kota</label>
                      <input type="text" class="form-control" id="input-kota" name="kota" placeholder="Masukan kota terbit">
                    </div>
                    <div class="col-md-2">
                      <label for="input-tahun" class="form-label">Tahun Terbit</label>
                      <select id="input-tahun" name="tahun" class="form-select">
                        <option selected>Pilih..</option>
                        <option value="1980">1980</option>
                        <option value="1981">1981</option>
                        <option value="1982">1982</option>
                        <option value="1983">1983</option>
                        <option value="1984">1984</option>
                        <option value="1985">1985</option>
                        <option value="1986">1986</option>
                        <option value="1987">1987</option>
                        <option value="1988">1988</option>
                        <option value="1989">1989</option>
                        <option value="1990">1990</option>
                        <option value="1991">1991</option>
                        <option value="1992">1992</option>
                        <option value="1993">1993</option>
                        <option value="1994">1994</option>
                        <option value="1995">1995</option>
                        <option value="1996">1996</option>
                        <option value="1997">1997</option>
                        <option value="1998">1998</option>
                        <option value="1999">1999</option>
                        <option value="2000">2000</option>
                        <option value="2001">2001</option>
                        <option value="2002">2002</option>
                        <option value="2003">2003</option>
                        <option value="2004">2004</option>
                        <option value="2005">2005</option>
                        <option value="2006">2006</option>
                        <option value="2007">2007</option>
                        <option value="2008">2008</option>
                        <option value="2009">2009</option>
                        <option value="2010">2010</option>
                        <option value="2011">2011</option>
                        <option value="2012">2012</option>
                        <option value="2013">2013</option>
                        <option value="2014">2014</option>
                        <option value="2015">2015</option>
                        <option value="2016">2016</option>
                        <option value="2017">2017</option>
                        <option value="2018">2018</option>
                        <option value="2019">2019</option>
                        <option value="2020">2020</option>
                        <option value="2021">2021</option>
                      </select>
                    </div>
                    <div class="col-md-2">
                      <label for="input-jum-hal" class="form-label">Jum. Hal</label>
                      <input type="text" class="form-control" id="input-jum-hal" name="jum_hal" placeholder="Angka">
                    </div>
                    <div class="col-md-2">
                      <label for="input-edisi" class="form-label">Edisi</label>
                      <select id="input-edisi" name="edisi" class="form-select">
                        <option selected>Pilih..</option>
                        <option value="Tidak ada">Tidak ada</option>
                        <option value="Pertama">1</option>
                        <option value="Kedua">2</option>
                        <option value="Ketiga">3</option>
                        <option value="Keempat">4</option>
                        <option value="Kelima">5</option>
                        <option value="Keenam">6</option>
                        <option value="Ketujuh">7</option>
                        <option value="Kedelapan">8</option>
                        <option value="Kesembilan">9</option>
                        <option value="Kesepuluh">10</option>
                        <option value="Revisi">Revisi</option>
                        <option value="Terjemah">Terjemah</option>
                      </select>
                    </div>
                    <div class="col-md-6">
                      <label for="input-kategori" class="form-label">Kategori</label>
                      <select id="input-kategori" name="kategori" class="form-select">
                        <option selected>Pilih...</option>
                        <option value="000">Ilmu Komputer, Informasi, & Umum</option>
                        <option value="100">Filosofi & Psikologi</option>
                        <option value="200">Agama</option>
                        <option value="300">Ilmu Sosial</option>
                        <option value="400">Bahasa</option>
                        <option value="500">Ilmu Alam/Murni</option>
                        <option value="600">Teknologi</option>
                        <option value="700">Seni & Rekreasi</option>
                        <option value="800">Sastra</option>
                        <option value="900">Sejarah & Geografi</option>
                      </select>
                    </div>
                    <div class="col-md-3">
                      <label for="input-jum-eks" class="form-label">Jum. Eksemplar</label>
                      <input type="number" class="form-control" id="input-jum-eks" name="jum_eks" placeholder="Pilih..">
                    </div>
                    <div class="col-md-2">
                    </div>
                    <div class="col-md-2" style="padding-top: 30px">
                      <center>
                        <button type="submit" class="btn btn-primary border shadow">Simpan</button>
                      </center>
                    </div>
                    <div class="col-md-4" style="padding-top: 35px">
                      <span><font color="red">Gagal ditambahkan!</font></span>
                    </div>
                    <%
                      }
                    } else {
                    %>
                    <div class="col-md-12">
                      <label for="input-judul" class="form-label">Judul</label>
                      <input type="text" class="form-control" id="input-judul" name="judul" placeholder="Masukan judul buku">
                    </div>
                    <div class="col-md-12">
                      <label for="input-pengarang" class="form-label">Pengarang</label>
                      <input type="text" class="form-control" id="input-pengarang" name="pengarang" placeholder="Masukan nama pengarang">
                    </div>
                    <div class="col-md-6">
                      <label for="input-penerbit" class="form-label">Penerbit</label>
                      <input type="text" class="form-control" id="input-penerbit" name="penerbit" placeholder="Masukan nama penerbit">
                    </div>
                    <div class="col-md-6">
                      <label for="input-kota" class="form-label">Kota</label>
                      <input type="text" class="form-control" id="input-kota" name="kota" placeholder="Masukan kota terbit">
                    </div>
                    <div class="col-md-2">
                      <label for="input-tahun" class="form-label">Tahun Terbit</label>
                      <select id="input-tahun" name="tahun" class="form-select">
                        <option selected>Pilih..</option>
                        <option value="1980">1980</option>
                        <option value="1981">1981</option>
                        <option value="1982">1982</option>
                        <option value="1983">1983</option>
                        <option value="1984">1984</option>
                        <option value="1985">1985</option>
                        <option value="1986">1986</option>
                        <option value="1987">1987</option>
                        <option value="1988">1988</option>
                        <option value="1989">1989</option>
                        <option value="1990">1990</option>
                        <option value="1991">1991</option>
                        <option value="1992">1992</option>
                        <option value="1993">1993</option>
                        <option value="1994">1994</option>
                        <option value="1995">1995</option>
                        <option value="1996">1996</option>
                        <option value="1997">1997</option>
                        <option value="1998">1998</option>
                        <option value="1999">1999</option>
                        <option value="2000">2000</option>
                        <option value="2001">2001</option>
                        <option value="2002">2002</option>
                        <option value="2003">2003</option>
                        <option value="2004">2004</option>
                        <option value="2005">2005</option>
                        <option value="2006">2006</option>
                        <option value="2007">2007</option>
                        <option value="2008">2008</option>
                        <option value="2009">2009</option>
                        <option value="2010">2010</option>
                        <option value="2011">2011</option>
                        <option value="2012">2012</option>
                        <option value="2013">2013</option>
                        <option value="2014">2014</option>
                        <option value="2015">2015</option>
                        <option value="2016">2016</option>
                        <option value="2017">2017</option>
                        <option value="2018">2018</option>
                        <option value="2019">2019</option>
                        <option value="2020">2020</option>
                        <option value="2021">2021</option>
                      </select>
                    </div>
                    <div class="col-md-2">
                      <label for="input-jum-hal" class="form-label">Jum. Hal</label>
                      <input type="text" class="form-control" id="input-jum-hal" name="jum_hal" placeholder="Angka">
                    </div>
                    <div class="col-md-2">
                      <label for="input-edisi" class="form-label">Edisi</label>
                      <select id="input-edisi" name="edisi" class="form-select">
                        <option selected>Pilih..</option>
                        <option value="Tidak ada">Tidak ada</option>
                        <option value="Pertama">1</option>
                        <option value="Kedua">2</option>
                        <option value="Ketiga">3</option>
                        <option value="Keempat">4</option>
                        <option value="Kelima">5</option>
                        <option value="Keenam">6</option>
                        <option value="Ketujuh">7</option>
                        <option value="Kedelapan">8</option>
                        <option value="Kesembilan">9</option>
                        <option value="Kesepuluh">10</option>
                        <option value="Revisi">Revisi</option>
                        <option value="Terjemah">Terjemah</option>
                      </select>
                    </div>
                    <div class="col-md-6">
                      <label for="input-kategori" class="form-label">Kategori</label>
                      <select id="input-kategori" name="kategori" class="form-select">
                        <option selected>Pilih...</option>
                        <option value="000">Ilmu Komputer, Informasi, & Umum</option>
                        <option value="100">Filosofi & Psikologi</option>
                        <option value="200">Agama</option>
                        <option value="300">Ilmu Sosial</option>
                        <option value="400">Bahasa</option>
                        <option value="500">Ilmu Alam/Murni</option>
                        <option value="600">Teknologi</option>
                        <option value="700">Seni & Rekreasi</option>
                        <option value="800">Sastra</option>
                        <option value="900">Sejarah & Geografi</option>
                      </select>
                    </div>
                    <div class="col-md-3">
                      <label for="input-jum-eks" class="form-label">Jum. Eksemplar</label>
                      <input type="number" class="form-control" id="input-jum-eks" name="jum_eks" placeholder="Pilih..">
                    </div>
                    <div class="col-md-2">
                    </div>
                    <div class="col-md-2" style="padding-top: 30px">
                      <center>
                        <button type="submit" class="btn btn-primary border shadow">Simpan</button>
                      </center>
                    </div>
                    <%
                      }
                    %>
                  </form> <!-- close form data buku-->

                  <!-- form upload sampul -->
                  <form class=" row my-3 p-3 border" action="LayananBuku?aksi=unggahsampul&no_panggil=<%=noPanggil%>" method="POST" enctype="MULTIPART/FORM-DATA">

                    <%
                      if (unggahSampul != null) {
                        if (unggahSampul.equals("berhasil")) {
                    %>
                    <div class="col-md-7">
                      <label for="input-sampul" class="form-label">Sampul</label>
                      <input type="file" class="form-control form-control-sm" id="input-sampul" placeholder="" disabled>
                    </div>
                    <div class="col-md-2" style="padding-top: 30px">
                      <center>
                        <a href="#"></a>
                        <input type="submit" class="btn btn-light border" value="Unggah" disabled>
                      </center>
                    </div>
                    <div class="col-md-3" style="padding-top: 35px">
                      <span><font color="green">Berhasil diunggah</font></span>
                    </div>
                    <%
                    } else if (unggahSampul.equals("gagal")) {
                    %>
                    <div class="col-md-7">
                      <label for="input-sampul" class="form-label">Sampul</label>
                      <input type="file" class="form-control form-control-sm" id="input-sampul" name="sampul" placeholder="">
                    </div>
                    <div class="col-md-2" style="padding-top: 30px">
                      <center>
                        <button type="submit" class="btn btn-primary border shadow">Unggah</button>
                      </center>
                    </div>
                    <div class="col-md-3" style="padding-top: 35px">
                      <span><font color="red">Gagal diunggah!</font></span>
                    </div>
                    <%
                      }
                    } else {
                      if (tambahBuku != null) {
                    %>
                    <div class="col-md-7">
                      <label for="input-sampul" class="form-label">Sampul</label>
                      <input type="file" class="form-control form-control-sm" id="input-sampul" name="sampul" placeholder="">
                    </div>
                    <div class="col-md-2" style="padding-top: 30px">
                      <center>
                        <button type="submit" class="btn btn-primary border shadow">Unggah</button>
                      </center>
                    </div>
                    <%
                    } else {
                    %>
                    <div class="col-md-7">
                      <label for="input-sampul" class="form-label">Sampul</label>
                      <input type="file" class="form-control form-control-sm" id="input-sampul" disabled>
                    </div>
                    <div class="col-md-2" style="padding-top: 30px">
                      <center>
                        <a href="#"></a>
                        <input type="submit" class="btn btn-light border" value="Unggah" disabled>
                      </center>
                    </div>
                    <%
                        }
                      }
                    %>
                  </form> <!-- close form upload sampul -->

                </div> <!--- close conteiner fluid --->
              </div> <!--- close col-md-7 -->


              <!--- hasil buku yang ditambahkan --->
              <div
                <%
                  if (tambahBuku != null) {
                    if (tambahBuku.equals("berhasil")) {
                %>
                class="col-md-5 p-2 border shadow-lg"
                <%
                } else if (tambahBuku.equals("gagal")) {
                %>
                class="col-md-5 p-2 border"
                <%
                  }
                } else {
                %>
                class="col-md-5 p-2 border"
                <%
                  }
                %>
                >

                <div class="container-fluid">
                  <div class="row">
                    <div class="col-md-6 offset-md-3 p-0">
                      <center>
                        <%
                          if (unggahSampul != null) {
                            if (unggahSampul.equals("berhasil")) {
                              String sampul = noPanggil.replace("/", "-");
                        %>
                        <img class="border" src="img/sampul/<%=sampul%>.jpg" height="160px" alt="">
                        <%
                        } else if (unggahSampul.equals("gagal")) {
                        %>
                        <img class="border" src="img/bg/img_not_available.jpg" height="160px" alt="">
                        <%
                          }
                        } else {
                        %>
                        <img class="border" src="img/bg/img_not_available.jpg" height="160px" alt="">
                        <%
                          }
                        %>

                      </center>
                    </div>
                    <div class="col-md-12">
                      <table class="table">
                        <tbody>
                          <tr>
                            <td><b>Judul:</b></td>
                            <td><%=judul%></td>
                          </tr>
                          <tr>
                            <td><b>Pengarang:</b></td>
                            <td><%=pengarang%></td>
                          </tr>
                          <tr>
                            <td><b>Penerbit:</b></td>
                            <td><%=penerbit%></td>
                          </tr>
                          <tr>
                            <td><b>Kota:</b></td>
                            <td><%=kota%></td>
                          </tr>
                          <tr>
                            <td><b>Tahun:</b></td>
                            <td><%=tahun%></td>
                          </tr>
                          <tr>
                            <td><b>Jum. Hal:</b></td>
                            <td><%=jumHal%></td>
                          </tr>
                          <tr>
                            <td><b>Jum. Eks:</b></td>
                            <td><%=jumEks%></td>
                          </tr>
                          <tr>
                            <td><b>No. Panggil:</b></td>
                            <td><%=noPanggil%></td>
                          </tr>
                        </tbody>
                      </table>
                    </div>
                    <div class="col-md-12">
                      <center>
                        <%
                          if (tambahBuku != null) {
                            if (tambahBuku.equals("berhasil")) {
                        %>
                        <a href="LayananBuku?aksi=tutuptambahbuku">
                          <button class="btn btn-secondary border shadow">Tutup</button>
                        </a>
                        <%
                            }
                          }
                        %>
                      </center>
                    </div>
                  </div>
                </div>
              </div> <!-- close col-md-5 -->
            </div> <!-- close inner row -->
          </div><!-- close inner conteiner -->
        </div> <!-- close col-md-11 -->
      </div> <!-- close row --->
    </div> <!-- close container -->
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/navigasi-pustakawan.act.js"></script>
    <script src="js/pesan-modal.act.js"></script>
  </body>
</html>
