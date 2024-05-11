/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package psm.control;

import java.io.IOException;
import java.util.ArrayList;
import java.sql.Date;
import java.text.ParseException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import psm.dao.KelolaAnggota;
import psm.helper.BuatSesuatu;
import psm.model.Anggota;

/**
 *
 * @author Fajar Waskito
 */
@WebServlet(name = "LayananAnggota", urlPatterns = {"/LayananAnggota"})
public class LayananAnggota extends HttpServlet {

  KelolaAnggota ka = null;

  // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
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
      case "keanggotaan":
        lihatKeanggotaan(req, res);
        break;
      case "hapusanggota":
        hapusAnggota(req, res);
        break;
      case "keluar":
        keluarAnggota(req, res);
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
    String aksi = (String) req.getParameter("aksi");
    switch (aksi) {
      case "masuk":
        masukAnggota(req, res);
        break;
      case "daftar": {
        try {
          daftarAnggota(req, res);
        } catch (ParseException ex) {
          Logger.getLogger(LayananAnggota.class.getName()).log(Level.SEVERE, null, ex);
        }
      }
      break;
    }
  }

  protected void lihatKeanggotaan(HttpServletRequest req, HttpServletResponse res) throws IOException {
    ka = new KelolaAnggota();
    ArrayList<Anggota> daftarAnggota = ka.ambilSemuaAnggota();
    req.getSession().setAttribute("keanggotaan", daftarAnggota);
    res.sendRedirect("keanggotaan.jsp");
  }

  protected void masukAnggota(HttpServletRequest req, HttpServletResponse res) throws IOException {
    ka = new KelolaAnggota();
    String kunci = (String) req.getParameter("email");
    String password = (String) req.getParameter("password");
    Anggota anggota = ka.ambilAnggota("email", kunci);
    HttpSession session = req.getSession(true);
    if (anggota.getPassword() != null) {
      if (anggota.getPassword().equalsIgnoreCase(password)) {
        session.setAttribute("user", "anggota");
        session.setAttribute("anggota", anggota);
        //session.setAttribute("masuk", "ya");
        this.getServletConfig().getServletContext().setAttribute("masuk", "ya");
        res.sendRedirect("LayananBuku?aksi=katalog");
      } else {
        this.getServletConfig().getServletContext().setAttribute("masuk", "tidak_anggota");
        res.sendRedirect("masuk.jsp");
      }
    } else {
      this.getServletConfig().getServletContext().setAttribute("masuk", "tidak_anggota");
      res.sendRedirect("masuk.jsp");
    }
  }

  protected void keluarAnggota(HttpServletRequest req, HttpServletResponse res) throws IOException {
    this.getServletConfig().getServletContext().removeAttribute("masuk");
    req.getSession().removeAttribute("user");
    res.sendRedirect("beranda.jsp");
  }

  protected void daftarAnggota(HttpServletRequest req, HttpServletResponse res) throws IOException, ParseException {
    String nama = req.getParameter("nama");
    String noTelpon = req.getParameter("no_telpon");
    String email = req.getParameter("email");
    String jenKel = req.getParameter("jen_kel");
    String tglLahir = req.getParameter("tgl_lahir");
    String alamat = req.getParameter("alamat");
    String klasifikasi = req.getParameter("klasifikasi");
    String password = req.getParameter("password");
    BuatSesuatu bs = new BuatSesuatu();
    Anggota anggota = new Anggota();
    anggota.setNama(nama);
    anggota.setNoTelpon(noTelpon);
    anggota.setEmail(email);
    anggota.setJenKel(jenKel);
    anggota.setTglLahir(bs.ubahKeTanggal(tglLahir));
    anggota.setAlamat(alamat);
    anggota.setKlasifikasi(klasifikasi);
    anggota.setPassword(password);
    ka = new KelolaAnggota();
    if (ka.tambahAnggota(anggota)) {
      req.getSession().setAttribute("tambah_anggota", "berhasil");
    } else {
      req.getSession().setAttribute("tambah_anggota", "gagal");
    }
    res.sendRedirect("daftar.jsp");
  }

  protected void hapusAnggota(HttpServletRequest req, HttpServletResponse res) throws IOException {
    String idAnggota = (String) req.getParameter("id_anggota");
    ka = new KelolaAnggota();
    ka.hapusAnggota(idAnggota);
    res.sendRedirect("LayananAnggota?aksi=keanggotaan");
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
