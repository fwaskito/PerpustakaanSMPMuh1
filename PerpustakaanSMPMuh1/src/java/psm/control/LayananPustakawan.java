/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package psm.control;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import psm.dao.KelolaPustakawan;
import psm.model.Pustakawan;

/**
 *
 * @author Lenovo
 */
public class LayananPustakawan extends HttpServlet {

  KelolaPustakawan kp = null;

  // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
  /**
   * Handles the HTTP <code>GET</code> method.
   *
   * @param req servlet request
   * @param resp servlet response
   * @throws ServletException if a servlet-specific error occurs
   * @throws IOException if an I/O error occurs
   */
  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse res)
          throws ServletException, IOException {
    String aksi = (String) req.getParameter("aksi");
    switch (aksi) {
      case "keluar":
        keluarPustakawan(req, res);
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
        masukPustakawan(req, res);
        break;
    }
  }

  protected void masukPustakawan(HttpServletRequest req, HttpServletResponse res) throws IOException {
    kp = new KelolaPustakawan();
    String username = (String) req.getParameter("username");
    String password = (String) req.getParameter("password");
    Pustakawan pustakawan = kp.cariPustakawan(username);
    HttpSession session = req.getSession(true);
    if (pustakawan.getPassword() != null) {
      if (pustakawan.getPassword().equalsIgnoreCase(password)) {
        session.setAttribute("user", "pustakawan");
        session.setAttribute("pustakawan", pustakawan);
        this.getServletConfig().getServletContext().setAttribute("masuk", "ya");
        res.sendRedirect("LayananBuku?aksi=katalog");
      } else {
        this.getServletConfig().getServletContext().setAttribute("masuk", "tidak_pustakawan");
        res.sendRedirect("masuk.jsp");
      }
    } else {
      this.getServletConfig().getServletContext().setAttribute("masuk", "tidak_pustakawan");
      res.sendRedirect("masuk.jsp");
    }
  }

  protected void keluarPustakawan(HttpServletRequest req, HttpServletResponse res) throws IOException {
    req.getSession().removeAttribute("tambah_buku");
    req.getSession().removeAttribute("buku_baru_ditambah");
    req.getSession().removeAttribute("unggah_sampul");
    this.getServletConfig().getServletContext().removeAttribute("masuk");
    req.getSession().removeAttribute("user");
    res.sendRedirect("beranda.jsp");
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
