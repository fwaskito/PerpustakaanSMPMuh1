/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package psm.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import psm.helper.DatabaseConnection;
import psm.model.Peminjaman;

/**
 *
 * @author Fajar Waskito
 */
public class KelolaPeminjaman {

  protected DatabaseConnection dbc = null;
  protected ResultSet rs = null;
  protected String query = "";

  public KelolaPeminjaman() {
    dbc = new DatabaseConnection();
  }

  public ArrayList<Peminjaman> ambilSemuaPeminjaman() {
    ArrayList<Peminjaman> daftarPeminjaman = new ArrayList<>();
    query = "SELECT id_pinjam, kode_buku, id_anggota, tgl_pinjam, tgl_harus_kembali, tgl_kembali, \n"
            + "	   IF(tgl_kembali IS NULL, \n"
            + "			IF(CURDATE() > tgl_harus_kembali,\n"
            + "				DATEDIFF(CURDATE(), tgl_harus_kembali), "
            + "                         0\n"
            + "			),\n"
            + "			IF(tgl_kembali > tgl_harus_kembali,\n"
            + "				tgl_kembali-tgl_harus_kembali, "
            + "                         0\n"
            + "			)\n"
            + "       ) AS terlambat \n"
            + "FROM peminjaman \n"
            + "ORDER BY tgl_pinjam DESC";
    try {
      rs = dbc.getStatement().executeQuery(query);
      while (rs.next()) {
        Peminjaman peminjaman = new Peminjaman();
        peminjaman.setIdPinjam(rs.getString("id_pinjam"));
        peminjaman.setKodeBuku(rs.getString("kode_buku"));
        peminjaman.setIdAnggota(rs.getString("id_anggota"));
        peminjaman.setTglPinjam(rs.getDate("tgl_pinjam"));
        peminjaman.setTglHarusKembali(rs.getDate("tgl_harus_kembali"));
        peminjaman.setTglKembali(rs.getDate("tgl_kembali"));
        peminjaman.setTerlambat(rs.getInt("terlambat"));
        daftarPeminjaman.add(peminjaman);
      }
    } catch (SQLException e) {
      dbc.closeResultSet(rs);
      dbc.closeConnection();
    }
    dbc.closeResultSet(rs);
    dbc.closeConnection();
    return daftarPeminjaman;
  }

  public Map<String, ArrayList> cariPeminjaman(String nilaiKunci) {
    ArrayList<Peminjaman> daftarPeminjaman = new ArrayList<>();
    ArrayList<String> bisaPerpanjang = new ArrayList<>();
    query = "SELECT id_pinjam, kode_buku, id_anggota, tgl_pinjam, tgl_harus_kembali, tgl_kembali, \n"
            + "	   IF(tgl_kembali IS NULL, \n"
            + "			IF(CURDATE() > tgl_harus_kembali,\n"
            + "				DATEDIFF(CURDATE(), tgl_harus_kembali), "
            + "                         0\n"
            + "			),\n"
            + "			IF(tgl_kembali > tgl_harus_kembali,\n"
            + "				tgl_kembali-tgl_harus_kembali, "
            + "                         0\n"
            + "			)\n"
            + "       ) AS terlambat,\n"
            + "       IF(SUBDATE(tgl_harus_kembali, 30) = tgl_pinjam AND ADDDATE(tgl_pinjam, 30) >= CURDATE(),\n"
            + "			'ya', 'tidak'\n"
            + "       ) AS bisa_perpanjang\n"
            + "FROM peminjaman WHERE id_anggota = '" + nilaiKunci + "'\n"
            + "ORDER BY tgl_pinjam DESC";
    try {
      rs = dbc.getStatement().executeQuery(query);
      while (rs.next()) {
        Peminjaman peminjaman = new Peminjaman();
        peminjaman.setIdPinjam(rs.getString("id_pinjam"));
        peminjaman.setKodeBuku(rs.getString("kode_buku"));
        peminjaman.setIdAnggota(rs.getString("id_anggota"));
        peminjaman.setTglPinjam(rs.getDate("tgl_pinjam"));
        peminjaman.setTglHarusKembali(rs.getDate("tgl_harus_kembali"));
        peminjaman.setTglKembali(rs.getDate("tgl_kembali"));
        peminjaman.setTerlambat(rs.getInt("terlambat"));
        daftarPeminjaman.add(peminjaman);
        bisaPerpanjang.add(rs.getString("bisa_perpanjang"));
      }
    } catch (SQLException e) {
      dbc.closeResultSet(rs);
      dbc.closeConnection();
    }
    dbc.closeResultSet(rs);
    dbc.closeConnection();
    Map<String, ArrayList> daftarPeminjamanDanPerpanjang = new HashMap<>();
    daftarPeminjamanDanPerpanjang.put("daftar_peminjaman", daftarPeminjaman);
    daftarPeminjamanDanPerpanjang.put("bisa_perpanjang", bisaPerpanjang);
    return daftarPeminjamanDanPerpanjang;
  }

  public boolean tambahPeminjaman(String kodeBuku, String idAnggota) {
    query = "INSERT INTO peminjaman VALUES("
            + "CONCAT('PM', LPAD(CONCAT('',FLOOR(321.0*RAND()+123)),3,'0')), '"
            + kodeBuku + "','"
            + idAnggota + "',"
            + "CONVERT(NOW(), DATE),"
            + "ADDDATE(CONVERT(NOW(), DATE), 30),"
            + "DEFAULT"
            + ")";
    try {
      boolean result = dbc.getStatement().executeUpdate(query) > 0;
      dbc.closeConnection();
      return result;
    } catch (SQLException e) {
      dbc.closeConnection();
      return false;
    }
  }

  //kesalah kuaeri pada nilaiTarget menggunakan tanda petik satu
  public boolean ubahPeminjaman(String kolomTarget, String nilaiTarget, String nilaiKunci) {
    query = "UPDATE peminjaman SET " + kolomTarget + "=" + nilaiTarget + " "
            + "WHERE id_pinjam='" + nilaiKunci + "'";
    try {
      boolean result = dbc.getStatement().executeUpdate(query) > 0;
      dbc.closeConnection();
      return result;
    } catch (SQLException e) {
      dbc.closeConnection();
      return false;
    }
  }

  public static void main(String[] args) {
  }
}
