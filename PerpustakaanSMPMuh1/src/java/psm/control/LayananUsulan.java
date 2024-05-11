/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package psm.control;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import psm.dao.KelolaUsulan;
import psm.model.Anggota;
import psm.model.Usulan;

/**
 *
 * @author Fajar Waskito
 */
public class LayananUsulan extends HttpServlet {

  KelolaUsulan ku = null;

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
      case "riwayatusul":
        lihatRiwayatUsul(req, res);
        break;
      case "lihatlebihusulan":
        lihatLebihUsulan(req, res);
        break;
      case "hapususulan":
        hapusUsulan(req, res);
        break;
      //pustakawan
      case "usulan":
        lihatSemuaUsulan(req, res);
        break;
      case "menanggapiusulan":
        menanggapiUsulan(req, res);
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
      case "mengajukanusulan":
        mengajukanUsulan(req, res);
        break;
    }
  }

  //percobaan 1: daftar usulan tidak tampil
  protected void lihatRiwayatUsul(HttpServletRequest req, HttpServletResponse res) throws IOException {
    Anggota anggota = (Anggota) req.getSession().getAttribute("anggota");
    String idAnggota = anggota.getIdAnggota();
    ku = new KelolaUsulan();
    ArrayList daftarUsulan = ku.cariUsulan("id_anggota", idAnggota);
    req.getSession().setAttribute("daftar_usulan", daftarUsulan);
    res.sendRedirect("usul.jsp");
  }

  protected void lihatSemuaUsulan(HttpServletRequest req, HttpServletResponse res) throws IOException {
    ku = new KelolaUsulan();
    ArrayList daftarUsulan = ku.ambilSemuaUsulan();
    req.getSession().setAttribute("daftar_usulan", daftarUsulan);
    res.sendRedirect("usulan.jsp");
  }

  protected void lihatLebihUsulan(HttpServletRequest req, HttpServletResponse res) throws IOException {
    String kodeUsulan = (String) req.getParameter("kode_usulan");
    ku = new KelolaUsulan();
    Usulan usulan = ku.ambilUsulan(kodeUsulan);
    req.getSession().setAttribute("lihat_lebih_usulan", usulan);
    res.sendRedirect("LayananUsulan?aksi=riwayatusul");
  }

  protected void mengajukanUsulan(HttpServletRequest req, HttpServletResponse res) throws IOException {
    Anggota anggota = (Anggota) req.getSession().getAttribute("anggota");
    String idAnggota = anggota.getIdAnggota();
    String isbn = (String) req.getParameter("isbn");
    String judul = (String) req.getParameter("judul");
    String pengarang = (String) req.getParameter("pengarang");
    String edisi = (String) req.getParameter("edisi");
    String isiUsulan = isbn + ";" + judul + ";" + pengarang + ";" + edisi;
    Usulan usulan = new Usulan();
    usulan.setIdAnggota(idAnggota);
    usulan.setIsi(isiUsulan);
    ku = new KelolaUsulan();
    if (ku.tambahUsulan(usulan)) {
      req.getSession().setAttribute("mengajukan_usulan", "berhasil");
    } else {
      req.getSession().setAttribute("mengajukan_usulan", "gagal");
    }
    res.sendRedirect("LayananUsulan?aksi=riwayatusul");
  }

  protected void menanggapiUsulan(HttpServletRequest req, HttpServletResponse res) throws IOException {
    String kodeUsulan = (String) req.getParameter("kode_usulan");
    String tanggapan = (String) req.getParameter("tanggapan");
    ku = new KelolaUsulan();
    if (ku.ubahUsulan("status", tanggapan, kodeUsulan)) {
      req.getSession().setAttribute("menaggapi_usulan", "berhasil");
    } else {
      req.getSession().setAttribute("menanggapi_usulan", "gagal");
    }
    res.sendRedirect("LayananUsulan?aksi=usulan");
  }

  protected void hapusUsulan(HttpServletRequest req, HttpServletResponse res) throws IOException {
    String kodeUsulan = (String) req.getParameter("kode_usulan");
    ku = new KelolaUsulan();
    if (ku.hapusUsulan(kodeUsulan)) {
      req.getSession().setAttribute("hapus_usulan", "berhasil");
    } else {
      req.getSession().setAttribute("hapus_usulan", "gagal");
    }
    res.sendRedirect("LayananUsulan?aksi=riwayatusul");
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
