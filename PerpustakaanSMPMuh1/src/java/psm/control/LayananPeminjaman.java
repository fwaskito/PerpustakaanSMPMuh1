/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package psm.control;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import psm.dao.KelolaAnggota;
import psm.dao.KelolaBuku;
import psm.dao.KelolaPeminjaman;
import psm.model.Anggota;
import psm.model.Buku;
import psm.model.Peminjaman;

/**
 *
 * @author Fajar Waskito
 */
@WebServlet(name = "LayananPeminjaman", urlPatterns = {"/LayananPeminjaman"})
public class LayananPeminjaman extends HttpServlet {

  KelolaPeminjaman kp = null;
  KelolaBuku kb = null;
  KelolaAnggota ka = null;

  /**
   * Handles the HTTP <code>GET</code> method.
   *
   * @param req servlet request
   * @param res servlet response
   * @throws ServletException if a servlet-specific error occurs
   * @throws IOException if an I/O error occurs
   */
  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse res)
          throws ServletException, IOException {
    String aksi = (String) req.getParameter("aksi");
    switch (aksi) {
      case "peminjaman":
        lihatPeminjaman(req, res);
        break;
      case "riwayatpinjam":
        lihatRiwayatPinjam(req, res);
        break;
      case "pilihpinjam":
        pilihPinjam(req, res);
        break;
      case "pinjam":
        pinjam(req, res);
        break;
      case "perpanjang":
        perpanjang(req, res);
        break;
      case "pengembalian":
        pengembalian(req, res);
        break;
    }
  }

  /**
   * Handles the HTTP <code>POST</code> method.
   *
   * @param req servlet request
   * @param res servlet response
   * @throws ServletException if a servlet-specific error occurs
   * @throws IOException if an I/O error occurs
   */
  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse res)
          throws ServletException, IOException {
  }

  protected void lihatPeminjaman(HttpServletRequest req, HttpServletResponse res) throws IOException {
    kp = new KelolaPeminjaman();
    ArrayList<Peminjaman> daftarPeminjaman = kp.ambilSemuaPeminjaman();
    ArrayList<Buku> bukuDipinjam = new ArrayList<>();
    ArrayList<Anggota> anggotaPeminjam = new ArrayList<>();
    daftarPeminjaman.forEach((p) -> {
      kb = new KelolaBuku();
      Buku b = kb.ambilEksemplar(p.getKodeBuku());
      bukuDipinjam.add(b);
    });
    daftarPeminjaman.forEach((p) -> {
      ka = new KelolaAnggota();
      Anggota a = ka.ambilAnggota("id_anggota", p.getIdAnggota());
      anggotaPeminjam.add(a);
    });
    req.getSession().setAttribute("peminjaman", daftarPeminjaman);
    req.getSession().setAttribute("buku_dipinjam", bukuDipinjam);
    req.getSession().setAttribute("anggota_peminjam", anggotaPeminjam);
    res.sendRedirect("peminjaman.jsp");
  }

  protected void lihatRiwayatPinjam(HttpServletRequest req, HttpServletResponse res) throws IOException {
    Anggota anggota = (Anggota) req.getSession().getAttribute("anggota");
    String idAnggota = anggota.getIdAnggota();
    kp = new KelolaPeminjaman();
    Map<String, ArrayList> daftarPeminjamanDanPerpanjang = kp.cariPeminjaman(idAnggota);
    ArrayList<Peminjaman> daftarPeminjaman = daftarPeminjamanDanPerpanjang.get("daftar_peminjaman");
    ArrayList<Peminjaman> sedangBerlangsung = new ArrayList<>();
    ArrayList<Peminjaman> telahBerlalu = new ArrayList<>();
    daftarPeminjaman.forEach((p) -> {
      if (p.getTglKembali() == null) {
        sedangBerlangsung.add(p);
      } else {
        telahBerlalu.add(p);
      }
    });
    ArrayList<Buku> bukuSedangBerlangsung = new ArrayList<>();
    ArrayList<Buku> bukuTelahBerlalu = new ArrayList<>();
    sedangBerlangsung.forEach((p) -> {
      kb = new KelolaBuku();
      Buku b = kb.ambilEksemplar(p.getKodeBuku());
      bukuSedangBerlangsung.add(b);
    });
    telahBerlalu.forEach((p) -> {
      kb = new KelolaBuku();
      Buku b = kb.ambilEksemplar(p.getKodeBuku());
      bukuTelahBerlalu.add(b);
    });
    Map<String, ArrayList> riwayatPinjam = new HashMap<>();
    riwayatPinjam.put("sedang_berlangsung", sedangBerlangsung);
    riwayatPinjam.put("buku_sedang_berlangsung", bukuSedangBerlangsung);
    riwayatPinjam.put("telah_berlalu", telahBerlalu);
    riwayatPinjam.put("buku_telah_berlalu", bukuTelahBerlalu);
    req.getSession().setAttribute("riwayat_pinjam", riwayatPinjam);
    req.getSession().setAttribute("bisa_perpanjang", daftarPeminjamanDanPerpanjang.get("bisa_perpanjang"));
    res.sendRedirect("riwayatPinjamAnggota.jsp");
  }

  protected void pilihPinjam(HttpServletRequest req, HttpServletResponse res) throws IOException {
    String noPanggil = (String) req.getParameter("no_panggil");
    kb = new KelolaBuku();
    Buku buku = kb.ambilBuku(noPanggil);
    kb = new KelolaBuku();
    ArrayList<Buku> daftarEksemplar = kb.ambilBeberapaEksemplar("no_panggil", noPanggil);
    req.getSession().setAttribute("buku", buku);
    req.getSession().setAttribute("pilih_pinjam", daftarEksemplar);
    res.sendRedirect("pinjam.jsp");
  }

  protected void pinjam(HttpServletRequest req, HttpServletResponse res) throws IOException {
    String noPanggil = (String) req.getParameter("no_panggil");
    ArrayList<Buku> daftarBuku = (ArrayList) req.getSession().getAttribute("pilih_pinjam");
    String kodeBuku = (String) req.getParameter("kode_buku");
    String idAnggota = (String) req.getParameter("id_anggota");
    boolean tersedia = false;
    for (Buku b : daftarBuku) {
      if (b.getKodeBuku().equals(kodeBuku)) {
        if (b.getStatus().equals("tersedia")) {
          tersedia = true;
          break;
        }
      }
    }
    if (tersedia) {
      kp = new KelolaPeminjaman();
      kb = new KelolaBuku();
      if (kp.tambahPeminjaman(kodeBuku, idAnggota)) {
        req.getSession().setAttribute("pinjam", "berhasil");
        kb.ubahBuku("status", "dipinjam", kodeBuku);
      } else {
        req.getSession().setAttribute("pinjam", "gagal");
      }
    } else {
      req.getSession().setAttribute("pinjam", "gagal");
    }
    res.sendRedirect("LayananPeminjaman?aksi=pilihpinjam&no_panggil=" + noPanggil);
  }

  protected void pengembalian(HttpServletRequest req, HttpServletResponse res) throws IOException {
    String idPinjam = (String) req.getParameter("id_pinjam");
    String kodeBuku = (String) req.getParameter("kode_buku");
    kp = new KelolaPeminjaman();
    if (kp.ubahPeminjaman("tgl_kembali", "CURDATE()", idPinjam)) {
      kb = new KelolaBuku();
      if (kb.ubahBuku("status", "tersedia", kodeBuku)) {
        res.sendRedirect("LayananPeminjaman?aksi=peminjaman");
      }
    }
  }

  protected void perpanjang(HttpServletRequest req, HttpServletResponse res) throws IOException {
    String idPinjam = (String) req.getParameter("id_pinjam");
    kp = new KelolaPeminjaman();
    if (kp.ubahPeminjaman("tgl_harus_kembali", "ADDDATE(CURDATE(), 30)", idPinjam)) {
      req.getSession().setAttribute("perpanjang", "berhasil");
    } else {
      req.getSession().setAttribute("perpanjang", "gagal");
    }
    res.sendRedirect("LayananPeminjaman?aksi=riwayatpinjam");
  }

  /**
   * Returns a short description of the servlet.
   *
   * @return a String containing servlet description
   */
  @Override
  public String getServletInfo() {
    return "Short description";
  }// </editor-fold>

}
