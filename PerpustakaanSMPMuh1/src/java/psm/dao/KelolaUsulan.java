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
import psm.model.Usulan;

/**
 *
 * @author Fajar Waskito
 */
public class KelolaUsulan {

  protected DatabaseConnection dbc = null;
  protected ResultSet rs = null;
  protected String query = "";

  public KelolaUsulan() {
    dbc = new DatabaseConnection();
  }

  public ArrayList<Usulan> ambilSemuaUsulan() {
    ArrayList<Usulan> daftarUsulan = null;
    ArrayList<String> isbn = null;
    query = "SELECT * FROM usulan "
            + "ORDER BY tgl_usul DESC";
    try {
      daftarUsulan = new ArrayList<>();
      isbn = new ArrayList<>();
      rs = dbc.getStatement().executeQuery(query);
      while (rs.next()) {
        Usulan usulan = new Usulan();
        usulan.setKodeUsulan(rs.getString("kode_usulan"));
        usulan.setIdAnggota(rs.getString("id_anggota"));
        usulan.setTglUsul(rs.getDate("tgl_usul"));
        usulan.setIdPustakawan("id_pustakawan");
        String status = rs.getString("status");
        if (status != null) {
          usulan.setStatus(status);
        } else {
          usulan.setStatus("belum ditanggapi");
        }
        isbn.add((String) rs.getString("isbn"));
        daftarUsulan.add(usulan);
      }
    } catch (SQLException e) {
      dbc.closeResultSet(rs);
      dbc.closeConnection();
    }

    try {
      for (int i = 0; i < isbn.size(); i++) {
        String isiUsulan = "";
        isiUsulan += isbn.get(i) + "; ";
        query = "SELECT * FROM isi_usulan WHERE isbn ='" + isbn.get(i) + "'";
        rs = dbc.getStatement().executeQuery(query);
        rs.next();
        isiUsulan += rs.getString("judul") + "; ";
        isiUsulan += rs.getString("pengarang") + "; ";
        if (rs.getString("edisi") != null) {
          isiUsulan += rs.getString("edisi");
        } else {
          isiUsulan += "";
        }
        daftarUsulan.get(i).setIsi(isiUsulan);
      }
    } catch (SQLException e) {
      dbc.closeResultSet(rs);
      dbc.closeConnection();
    }
    dbc.closeResultSet(rs);
    dbc.closeConnection();
    return daftarUsulan;
  }

  public ArrayList<Usulan> cariUsulan(String kolomAcuan, String nilaiAcuan) {
    ArrayList<Usulan> daftarUsulan = null;
    ArrayList<String> isbn = null;
    query = "SELECT * FROM usulan "
            + "WHERE " + kolomAcuan + " ='" + nilaiAcuan + "' "
            + "ORDER BY tgl_usul DESC";
    try {
      daftarUsulan = new ArrayList<>();
      isbn = new ArrayList<>();
      rs = dbc.getStatement().executeQuery(query);
      while (rs.next()) {
        Usulan usulan = new Usulan();
        usulan.setKodeUsulan(rs.getString("kode_usulan"));
        usulan.setIdAnggota(rs.getString("id_anggota"));
        usulan.setTglUsul(rs.getDate("tgl_usul"));
        usulan.setIdPustakawan("id_pustakawan");
        String status = rs.getString("status");
        if (status != null) {
          usulan.setStatus(status);
        } else {
          usulan.setStatus("belum ditanggapi");
        }
        isbn.add((String) rs.getString("isbn"));
        daftarUsulan.add(usulan);
      }
    } catch (SQLException e) {
      dbc.closeResultSet(rs);
      dbc.closeConnection();
    }

    try {
      for (int i = 0; i < isbn.size(); i++) {
        String isiUsulan = "";
        isiUsulan += isbn.get(i) + "; ";
        query = "SELECT * FROM isi_usulan WHERE isbn ='" + isbn.get(i) + "'";
        rs = dbc.getStatement().executeQuery(query);
        rs.next();
        isiUsulan += rs.getString("judul") + "; ";
        isiUsulan += rs.getString("pengarang") + "; ";
        if (rs.getString("edisi") != null) {
          isiUsulan += rs.getString("edisi");
        } else {
          isiUsulan += "";
        }
        daftarUsulan.get(i).setIsi(isiUsulan);
      }
    } catch (SQLException e) {
      dbc.closeResultSet(rs);
      dbc.closeConnection();
    }
    dbc.closeResultSet(rs);
    dbc.closeConnection();
    return daftarUsulan;
  }

  public Usulan ambilUsulan(String nilaiKunci) {
    Usulan usulan = new Usulan();
    query = "SELECT * FROM usulan WHERE kode_usulan='" + nilaiKunci + "'";
    try {
      rs = dbc.getStatement().executeQuery(query);
      rs.next();
      usulan.setKodeUsulan(rs.getString("kode_usulan"));
      usulan.setIdAnggota(rs.getString("id_anggota"));
      usulan.setTglUsul(rs.getDate("tgl_usul"));
      usulan.setIdPustakawan("id_pustakawan");
      String status = rs.getString("status");
      if (status != null) {
        usulan.setStatus(status);
      } else {
        usulan.setStatus("belum ditanggapi");
      }
      query = "SELECT * FROM isi_usulan WHERE isbn='" + rs.getString("isbn") + "'";
      rs = dbc.getStatement().executeQuery(query);
      rs.next();
      usulan.setIsi(rs.getString("isbn")
              + ";" + rs.getString("judul")
              + ";" + rs.getString("pengarang")
              + ";" + rs.getString("edisi"));
    } catch (SQLException e) {
      dbc.closeResultSet(rs);
      dbc.closeConnection();
    }
    dbc.closeResultSet(rs);
    dbc.closeConnection();
    return usulan;
  }

  public boolean tambahUsulan(Usulan usulan) {
    String[] splitIsiUsulan = usulan.getIsi().split(";");
    query = "INSERT INTO isi_usulan VALUES("
            + "'" + splitIsiUsulan[0] + "',"
            + "'" + splitIsiUsulan[1] + "',"
            + "'" + splitIsiUsulan[2] + "',";
    if (splitIsiUsulan.length == 4) {
      query += "'" + splitIsiUsulan[3] + "')";
    } else {
      query += "DEFAULT)";
    }
    boolean result = false;
    try {
      result = dbc.getStatement().executeUpdate(query) > 0;
      if (result) {
        query = "INSERT INTO usulan VALUES("
                + "LPAD(concat(floor(12345.0*rand()+54321.0*rand()),''),8,'0'),"
                + "'" + usulan.getIdAnggota() + "',"
                + "default, "
                + "CURDATE(),"
                + "'" + splitIsiUsulan[0] + "',"
                + "default"
                + ")";
        result = dbc.getStatement().executeUpdate(query) > 0;
      }
    } catch (SQLException e) {
      dbc.closeConnection();
      return result;
    }
    dbc.closeConnection();
    return result;
  }

  public boolean ubahUsulan(String kolomTarget, String nilaiTarget, String nilaiKunci) {
    query = "UPDATE usulan SET " + kolomTarget + "='" + nilaiTarget + "' "
            + "WHERE kode_usulan='" + nilaiKunci + "'";
    try {
      boolean result = dbc.getStatement().executeUpdate(query) > 0;
      dbc.closeConnection();
      return result;
    } catch (SQLException e) {
      dbc.closeConnection();
      return false;
    }
  }

  public boolean hapusUsulan(String nilaiKunci) {
    query = "SELECT isbn FROM usulan WHERE kode_usulan='" + nilaiKunci + "'";
    boolean result = false;
    try {
      rs = dbc.getStatement().executeQuery(query);
      rs.next();
      String isbn = rs.getString("isbn");
      query = "DELETE FROM isi_usulan WHERE isbn='" + isbn + "'";
      result = dbc.getStatement().executeUpdate(query) > 0;
      if (result) {
        query = "DELETE FROM usulan WHERE kode_usulan='" + nilaiKunci + "'";
        result = dbc.getStatement().executeUpdate(query) > 0;
      }
    } catch (SQLException e) {
      dbc.closeResultSet(rs);
      dbc.closeConnection();
      return result;
    }
    dbc.closeResultSet(rs);
    dbc.closeConnection();
    return result;
  }
}
