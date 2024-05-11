/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package psm.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import psm.helper.DatabaseConnection;
import psm.helper.FormatTeks;
import psm.model.Anggota;

/**
 *
 * @author Fajar Waskito
 */
public class KelolaAnggota {

  protected DatabaseConnection dbc;
  protected ResultSet rs = null;
  protected String query = "";

  public KelolaAnggota() {
    dbc = new DatabaseConnection();
  }

  public ArrayList<Anggota> ambilSemuaAnggota() {
    ArrayList<Anggota> daftarAnggota = new ArrayList<>();
    query = "SELECT * FROM anggota";
    try {
      rs = dbc.getStatement().executeQuery(query);
      while (rs.next()) {
        Anggota anggota = new Anggota();
        anggota.setIdAnggota(rs.getString("id_anggota"));
        anggota.setNama(rs.getString("nama"));
        anggota.setNoTelpon(rs.getString("no_telpon"));
        anggota.setEmail(rs.getString("email"));
        anggota.setJenKel(rs.getString("jen_kel"));
        anggota.setTglLahir(rs.getDate("tgl_lahir"));
        anggota.setAlamat(rs.getString("alamat"));
        anggota.setKlasifikasi(rs.getString("klasifikasi"));
        anggota.setPassword(rs.getString("password"));
        daftarAnggota.add(anggota);
      }
    } catch (SQLException e) {
      dbc.closeResultSet(rs);
      dbc.closeConnection();
    }
    dbc.closeResultSet(rs);
    dbc.closeConnection();
    return daftarAnggota;
  }

  public Anggota ambilAnggota(String kolomKunci, String nilaiKunci) {
    Anggota anggota = new Anggota();
    query = "SELECT * FROM anggota WHERE "
            + kolomKunci + " ='" + nilaiKunci + "'";
    try {
      rs = dbc.getStatement().executeQuery(query);
      rs.next();
      anggota = new Anggota();
      anggota.setIdAnggota(rs.getString("id_anggota"));
      anggota.setNama(rs.getString("nama"));
      anggota.setNoTelpon(rs.getString("no_telpon"));
      anggota.setEmail(rs.getString("email"));
      anggota.setJenKel(rs.getString("jen_kel"));
      anggota.setTglLahir(rs.getDate("tgl_lahir"));
      anggota.setAlamat(rs.getString("alamat"));
      anggota.setKlasifikasi(rs.getString("klasifikasi"));
      anggota.setPassword(rs.getString("password"));
    } catch (SQLException e) {
      dbc.closeResultSet(rs);
      dbc.closeConnection();
    }
    dbc.closeResultSet(rs);
    dbc.closeConnection();
    return anggota;
  }

  public boolean tambahAnggota(Anggota anggota) {
    FormatTeks ft = new FormatTeks();
    query = "INSERT INTO anggota VALUES ("
            + "concat('AG', lpad(concat('',floor(321.0*rand()+123)),3,'0')),'"
            + anggota.getNama() + "','"
            + anggota.getNoTelpon() + "','"
            + anggota.getEmail() + "','"
            + anggota.getJenKel() + "','"
            + ft.formatTanggalKeInternasional(anggota.getTglLahir()) + "','"
            + anggota.getAlamat() + "','"
            + anggota.getKlasifikasi() + "','"
            + anggota.getPassword() + "'"
            + ")";
    boolean result = false;
    try {
      result = dbc.getStatement().executeUpdate(query) > 0;
    } catch (SQLException e) {
      dbc.closeConnection();
      return result;
    }
    dbc.closeConnection();
    return result;
  }

  public boolean hapusAnggota(String nilaiKunci) {
    query = "DELETE FROM anggota WHERE id_anggota='" + nilaiKunci + "'";
    try {
      boolean result = dbc.getStatement().executeUpdate(query) > 0;
      dbc.closeConnection();
      return result;
    } catch (SQLException e) {
      dbc.closeConnection();
      return false;
    }
  }
}
