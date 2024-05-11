/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package psm.control;

import com.oreilly.servlet.MultipartRequest;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import psm.dao.KelolaBuku;
import psm.helper.BuatSesuatu;
import psm.model.Buku;

/**
 *
 * @author Fajar Waskito
 */
@WebServlet(name = "LayananBuku", urlPatterns = {"/LayananBuku"})
public class LayananBuku extends HttpServlet {

  KelolaBuku kb = null;

  // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
  /**
   * Handles the HTTP <code>GET</code> method.
   *
   * @param req servlet req
   * @param res servlet res
   * @throws ServletException if a servlet-specific error occurs
   * @throws IOException if an I/O error occurs
   */
  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse res)
          throws ServletException, IOException {
    String aksi = (String) req.getParameter("aksi");
    switch (aksi) {
      case "katalog":
        lihatKatalog(req, res);
        break;
      case "informasibuku":
        lihatInformasiBuku(req, res);
        break;
      case "taruhbukudirak":
        taruhBukuDiRak(req, res);
        break;
      case "rak":
        res.sendRedirect("rak.jsp");
        break;
      case "hapusbukudirak":
        hapusBukuDiRak(req, res);
        break;
      case "tutuptambahbuku":
        tutupTambahBuku(req, res);
        break;
      case "pilihhapusbuku":
        pilihHapus(req, res);
        break;
      case "hapusbuku":
        hapusBuku(req, res);
        break;
    }
  }

  /**
   * Handles the HTTP <code>POST</code> method.
   *
   * @param req servlet req
   * @param res servlet res
   * @throws ServletException if a servlet-specific error occurs
   * @throws IOException if an I/O error occurs
   */
  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse res)
          throws ServletException, IOException {
    String aksi = (String) req.getParameter("aksi");
    switch (aksi) {
      case "caribuku":
        cariBuku(req, res);
        break;
      case "tambahbuku":
        tambahBuku(req, res);
        break;
      case "unggahsampul":
        unggahSampul(req, res);
        break;
    }
  }

  protected void lihatKatalog(HttpServletRequest req, HttpServletResponse res) throws IOException {
    kb = new KelolaBuku();
    ArrayList<Buku> daftarBuku = kb.ambilSemuaBuku();
    this.getServletConfig().getServletContext().setAttribute("katalog", daftarBuku);
    String user = (String) req.getSession().getAttribute("user");
    if (user != null) {
      if (user.equals("anggota")) {
        res.sendRedirect("katalogAnggota.jsp");
      } else if (user.equals("pustakawan")) {
        res.sendRedirect("katalogPustakawan.jsp");
      }
    } else {
      res.sendRedirect("katalog.jsp");
    }
  }

  protected void cariBuku(HttpServletRequest req, HttpServletResponse res) throws IOException {
    String kataKunci = (String) req.getParameter("kata_kunci");
    String cariBerdasarkan = (String) req.getParameter("cari_berdasarkan");
    kb = new KelolaBuku();
    ArrayList<Buku> daftarBuku = kb.ambilBeberapaBuku(cariBerdasarkan, kataKunci);
    this.getServletConfig().getServletContext().setAttribute("katalog", daftarBuku);
    String user = (String) req.getSession().getAttribute("user");
    if (user != null) {
      res.sendRedirect("katalogAnggota.jsp");
    } else {
      res.sendRedirect("katalog.jsp");
    }
  }

  protected void lihatInformasiBuku(HttpServletRequest req, HttpServletResponse res) throws IOException {
    String noPanggil = req.getParameter("no_panggil");
    kb = new KelolaBuku();
    Buku buku = (Buku) kb.ambilBuku(noPanggil);
    this.getServletConfig().getServletContext().setAttribute("informasi_buku", buku);
    res.sendRedirect("informasiBuku.jsp");
  }

  protected void taruhBukuDiRak(HttpServletRequest req, HttpServletResponse res) throws IOException {
    String masuk = (String) this.getServletConfig().getServletContext().getAttribute("masuk");
    if (masuk != null) {
      String noPanggil = req.getParameter("no_panggil");
      kb = new KelolaBuku();
      ArrayList<Buku> rak = (ArrayList) req.getSession().getAttribute("rak");
      String adaDiRak = "tidak";
      if (rak != null) {
        for (int i = 0; i < rak.size(); i++) {
          if (rak.get(i).getNoPanggil().equals(noPanggil)) {
            adaDiRak = "ya";
            break;
          }
        }
        if (adaDiRak.equals("tidak")) {
          rak.add(kb.ambilBuku(noPanggil));
          req.getSession().setAttribute("rak", rak);
        }
        req.getSession().setAttribute("ada_di_rak", adaDiRak);

      } else {
        rak = new ArrayList<>();
        rak.add(kb.ambilBuku(noPanggil));
        req.getSession().setAttribute("rak", rak);
        req.getSession().setAttribute("ada_di_rak", adaDiRak);
      }
      lihatInformasiBuku(req, res);
    } else {
      res.sendRedirect("masukAnggota.jsp");
    }
  }

  protected void hapusBukuDiRak(HttpServletRequest req, HttpServletResponse res) throws IOException {
    String noPanggil = req.getParameter("no_panggil");
    kb = new KelolaBuku();
    ArrayList<Buku> rak = null;
    rak = (ArrayList) req.getSession().getAttribute("rak");
    for (int i = 0; i < rak.size(); i++) {
      if (rak.get(i).getNoPanggil().equals(noPanggil)) {
        rak.remove(i);
        break;
      }
    }
    req.getSession().setAttribute("rak", rak);
    res.sendRedirect("rak.jsp");
  }

  protected void tambahBuku(HttpServletRequest req, HttpServletResponse res) throws IOException {
    String judul = (String) req.getParameter("judul");
    String pengarang = (String) req.getParameter("pengarang");
    String edisi = (String) req.getParameter("edisi");
    String kategori = (String) req.getParameter("kategori");
    String noPanggil = "";
    BuatSesuatu bs = null;
    String jEdisi = "";
    if (edisi == null || edisi.equalsIgnoreCase("Tidak ada")) {
      bs = new BuatSesuatu();
      noPanggil = bs.buatNoPanggil(kategori, judul, pengarang);
      jEdisi = "";
    } else {
      bs = new BuatSesuatu();
      noPanggil = bs.buatNoPanggil(kategori, judul, pengarang, edisi);
      jEdisi = " (Edisi " + edisi + ")";
    }
    Buku b = new Buku();
    b.setNoPanggil(noPanggil);
    b.setJudul(judul + jEdisi);
    b.setPengarang(pengarang);
    b.setPenerbit((String) req.getParameter("penerbit"));
    b.setKota((String) req.getParameter("kota"));
    b.setTahun((String) req.getParameter("tahun"));
    b.setJumHal(Integer.valueOf(req.getParameter("jum_hal")));
    int jumEks = Integer.valueOf(req.getParameter("jum_eks"));
    b.setJumEks(jumEks);
    kb = new KelolaBuku();
    if (jumEks <= 1) {
      if (kb.tambahBuku(b)) {
        req.getSession().setAttribute("tambah_buku", "berhasil");
        kb = new KelolaBuku();
        req.getSession().setAttribute("buku_baru_ditambah", kb.ambilBuku(noPanggil));
        req.getSession().setAttribute("edisi_buku_baru_ditambah", edisi);
        req.getSession().setAttribute("kategori_buku_baru_ditambah", bs.ambilKeteranganKategori(kategori));
        res.sendRedirect("tambahBuku.jsp");
      } else {
        req.getSession().setAttribute("tambah_buku", "gagal");
        res.sendRedirect("tambahBuku.jsp");
      }
    } else {
      if (kb.tambahBeberapaBuku(b, jumEks)) {
        req.getSession().setAttribute("tambah_buku", "berhasil");
        kb = new KelolaBuku();
        req.getSession().setAttribute("buku_baru_ditambah", kb.ambilBuku(noPanggil));
        req.getSession().setAttribute("edisi_buku_baru_ditambah", edisi);
        req.getSession().setAttribute("kategori_buku_baru_ditambah", bs.ambilKeteranganKategori(kategori));
        res.sendRedirect("tambahBuku.jsp");
      } else {
        req.getSession().setAttribute("tambah_buku", "gagal");
        res.sendRedirect("tambahBuku.jsp");
      }
    }
  }

  protected void unggahSampul(HttpServletRequest req, HttpServletResponse res) throws IOException {
    String noPanggil = (String) req.getParameter("no_panggil");
    String tempatUnggahan = "C:\\Users\\Lenovo\\Documents\\NetBeansProjects\\PerpustakaanSMPMuh1\\web\\img\\sampul";
    MultipartRequest mr = new MultipartRequest(req, tempatUnggahan, 10000000);
    Enumeration enumFile = mr.getFileNames();
    String file = (String) enumFile.nextElement();
    String namaFile = mr.getFilesystemName(file);
    if (namaFile != null) {
      java.io.File namaLamaFile = new java.io.File(tempatUnggahan + "\\" + namaFile);
      java.io.File namaBaruFile = new java.io.File(tempatUnggahan + "\\" + noPanggil.replace("/", "-") + ".jpg");
      namaLamaFile.renameTo(namaBaruFile);
      req.getSession().setAttribute("unggah_sampul", "berhasil");
    } else {
      req.getSession().setAttribute("unggah_sampul", "gagal");
    }
    res.sendRedirect("tambahBuku.jsp");
  }

  protected void tutupTambahBuku(HttpServletRequest req, HttpServletResponse res) throws IOException {
    req.getSession().removeAttribute("tambah_buku");
    req.getSession().removeAttribute("buku_baru_ditambah");
    req.getSession().removeAttribute("unggah_sampul");
    res.sendRedirect("tambahBuku.jsp");
  }

  protected void pilihHapus(HttpServletRequest req, HttpServletResponse res) throws IOException {
    String noPanggil = (String) req.getParameter("no_panggil");
    kb = new KelolaBuku();
    ArrayList<Buku> daftarBuku = kb.ambilBeberapaEksemplar("no_panggil", noPanggil);
    kb = new KelolaBuku();
    Buku b = (Buku) kb.ambilBuku(noPanggil);
    req.getSession().setAttribute("buku", b);
    req.getSession().setAttribute("pilih_hapus", daftarBuku);
    res.sendRedirect("hapusBuku.jsp");
  }

  protected void hapusBuku(HttpServletRequest req, HttpServletResponse res) throws IOException {
    String banyakHapus = (String) req.getParameter("banyak_hapus");
    Buku b = (Buku) req.getSession().getAttribute("buku");
    String noPanggil = b.getNoPanggil();
    kb = new KelolaBuku();
    if (banyakHapus.equals("satu")) {
      if (b.getJumEks() > 1) {
        String kodeBuku = (String) req.getParameter("kode_buku");
        if (kb.hapusEksemplar(kodeBuku)) {
          req.getSession().setAttribute("hapus_buku", "berhasil");
        } else {
          req.getSession().setAttribute("hapus_buku", "gagal");
        }
      } else {
        if (kb.hapusBuku(noPanggil)) {
          req.getSession().setAttribute("hapus_buku", "berhasil");
        } else {
          req.getSession().setAttribute("hapus_buku", "gagal");
        }
      }
    } else if (banyakHapus.equals("semua")) {
      if (kb.hapusBuku(noPanggil)) {
        req.getSession().setAttribute("hapus_buku", "berhasil");
      } else {
        req.getSession().setAttribute("hapus_buku", "gagal");
      }
    }
    res.sendRedirect("LayananBuku?aksi=pilihhapusbuku&no_panggil=" + noPanggil);
  }
}
