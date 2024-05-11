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
import psm.model.Buku;

/**
 *
 * @author Fajar Waskito
 */
public class KelolaBuku {

  protected DatabaseConnection dbc;
  protected ResultSet rs = null;
  protected String query = "";

  public KelolaBuku() {
    dbc = new DatabaseConnection();
  }

  public ArrayList<Buku> ambilSemuaBuku() {
    ArrayList<Buku> daftarBuku = new ArrayList<>();
    //+ " ORDER BY no_panggil";
    try {
      query = "SELECT * FROM informasi_buku";
      rs = dbc.getStatement().executeQuery(query);
      while (rs.next()) {
        Buku buku = new Buku();
        buku.setNoPanggil(rs.getString("no_panggil"));
        buku.setJudul(rs.getString("judul"));
        buku.setPengarang(rs.getString("pengarang"));
        buku.setPenerbit(rs.getString("penerbit"));
        buku.setKota(rs.getString("kota"));
        buku.setTahun(rs.getString("tahun"));
        buku.setJumHal(rs.getInt("jum_hal"));
        daftarBuku.add(buku);
      }
      for (int i = 0; i < daftarBuku.size(); i++) {
        query = "SELECT COUNT(*) AS jum_eks FROM buku "
                + "WHERE no_panggil = '" + daftarBuku.get(i).getNoPanggil() + "'";
        rs = dbc.getStatement().executeQuery(query);
        rs.next();
        daftarBuku.get(i).setJumEks(rs.getInt("jum_eks"));
      }
    } catch (SQLException e) {
      dbc.closeResultSet(rs);
      dbc.closeConnection();
    }
    dbc.closeResultSet(rs);
    dbc.closeConnection();
    return daftarBuku;
  }

  public ArrayList<Buku> ambilBeberapaBuku(String kolomTarget, String nilaiTarget) {
    ArrayList<Buku> daftarBuku = new ArrayList<>();
    try {
      query = "SELECT * FROM informasi_buku WHERE "
              + kolomTarget + " LIKE '%" + nilaiTarget + "%'";
      rs = dbc.getStatement().executeQuery(query);
      while (rs.next()) {
        Buku buku = new Buku();
        buku.setNoPanggil(rs.getString("no_panggil"));
        buku.setJudul(rs.getString("judul"));
        buku.setPengarang(rs.getString("pengarang"));
        buku.setPenerbit(rs.getString("penerbit"));
        buku.setKota(rs.getString("kota"));
        buku.setTahun(rs.getString("tahun"));
        buku.setJumHal(rs.getInt("jum_hal"));
        daftarBuku.add(buku);
      }
      if (daftarBuku.size() != 0) {
        for (int i = 0; i < daftarBuku.size(); i++) {
          query = "SELECT COUNT(*) AS jum_eks FROM buku "
                  + "WHERE no_panggil = '" + daftarBuku.get(i).getNoPanggil() + "'";
          rs = dbc.getStatement().executeQuery(query);
          rs.next();
          daftarBuku.get(i).setJumEks(rs.getInt("jum_eks"));
        }
      }
    } catch (SQLException e) {
      dbc.closeResultSet(rs);
      dbc.closeConnection();
    }
    dbc.closeResultSet(rs);
    dbc.closeConnection();
    return daftarBuku;
  }

  public Buku ambilBuku(String nilaiKunci) {
    Buku buku = new Buku();
    query = "SELECT * FROM informasi_buku"
            + " WHERE no_panggil = '" + nilaiKunci + "'";
    try {
      rs = dbc.getStatement().executeQuery(query);
      rs.next();
      buku.setNoPanggil(rs.getString("no_panggil"));
      buku.setJudul(rs.getString("judul"));
      buku.setPengarang(rs.getString("pengarang"));
      buku.setPenerbit(rs.getString("penerbit"));
      buku.setKota(rs.getString("kota"));
      buku.setTahun(rs.getString("tahun"));
      buku.setJumHal(rs.getInt("jum_hal"));
      query = "SELECT COUNT(*) AS jum_eks FROM buku "
              + "WHERE no_panggil = '" + nilaiKunci + "'";
      rs = dbc.getStatement().executeQuery(query);
      rs.next();
      buku.setJumEks(rs.getInt("jum_eks"));

      query = "SELECT COUNT(*) AS jum_tersedia FROM buku "
              + "WHERE no_panggil = '" + nilaiKunci + "' and "
              + "status = 'tersedia'";
      rs = dbc.getStatement().executeQuery(query);
      rs.next();
      if (rs.getInt("jum_tersedia") > 0) {
        buku.setStatus("Tersedia");
      } else {
        buku.setStatus("Dipinjam");
      }
    } catch (SQLException e) {
      dbc.closeResultSet(rs);
      dbc.closeConnection();
    }
    dbc.closeResultSet(rs);
    dbc.closeConnection();
    return buku;
  }

  public ArrayList<Buku> ambilBeberapaEksemplar(String kolomAcuan, String nilaiAcuan) {
    ArrayList<Buku> daftarEksemplar = null;
    try {
      query = "SELECT * FROM buku "
              + "WHERE " + kolomAcuan + " = '" + nilaiAcuan + "'";
      rs = dbc.getStatement().executeQuery(query);
      daftarEksemplar = new ArrayList<>();
      while (rs.next()) {
        Buku b = new Buku();
        b.setKodeBuku(rs.getString("kode_buku"));
        b.setNoPanggil(rs.getString("no_panggil"));
        b.setStatus(rs.getString("status"));
        daftarEksemplar.add(b);
      }
    } catch (SQLException e) {
      dbc.closeResultSet(rs);
      dbc.closeConnection();
    }

    try {
      for (int i = 0; i < daftarEksemplar.size(); i++) {
        //Buku b = daftarEksemplar.get(i);
        query = "SELECT * FROM informasi_buku WHERE "
                + "no_panggil = '" + daftarEksemplar.get(i).getNoPanggil() + "'";
        rs = dbc.getStatement().executeQuery(query);
        rs.next();
        daftarEksemplar.get(i).setJudul(rs.getString("judul"));
        daftarEksemplar.get(i).setPengarang(rs.getString("pengarang"));
        daftarEksemplar.get(i).setPenerbit(rs.getString("penerbit"));
        daftarEksemplar.get(i).setKota(rs.getString("kota"));
        daftarEksemplar.get(i).setTahun(rs.getString("tahun"));
        daftarEksemplar.get(i).setJumHal(rs.getInt("Jum_hal"));
      }
    } catch (SQLException e) {
      dbc.closeResultSet(rs);
      dbc.closeConnection();
    }
    dbc.closeResultSet(rs);
    dbc.closeConnection();
    return daftarEksemplar;
  }

  public Buku ambilEksemplar(String nilaiKunci) {
    Buku b = new Buku();
    try {
      query = "SELECT * FROM buku "
              + "WHERE kode_buku = '" + nilaiKunci + "'";
      rs = dbc.getStatement().executeQuery(query);
      rs.next();
      b.setKodeBuku(rs.getString("kode_buku"));
      b.setNoPanggil(rs.getString("no_panggil"));
      b.setStatus(rs.getString("status"));

      query = "SELECT * FROM informasi_buku "
              + "WHERE no_panggil = '" + b.getNoPanggil() + "'";
      rs = dbc.getStatement().executeQuery(query);
      rs.next();
      b.setJudul(rs.getString("judul"));
      b.setPengarang(rs.getString("pengarang"));
      b.setPenerbit(rs.getString("penerbit"));
      b.setKota(rs.getString("kota"));
      b.setTahun(rs.getString("tahun"));
      b.setJumHal(rs.getInt("Jum_hal"));
    } catch (SQLException e) {
      dbc.closeResultSet(rs);
      dbc.closeConnection();
    }
    dbc.closeResultSet(rs);
    dbc.closeConnection();
    return b;
  }

  public boolean tambahBuku(Buku buku) {
    query = "INSERT INTO informasi_buku VALUES ('"
            + buku.getNoPanggil() + "','"
            + buku.getJudul() + "','"
            + buku.getPengarang() + "','"
            + buku.getPenerbit() + "','"
            + buku.getKota() + "','"
            + buku.getTahun() + "',"
            + buku.getJumHal()
            + ")";
    boolean result = false;
    try {
      result = dbc.getStatement().executeUpdate(query) > 0;
      if (result) {
        query = "INSERT INTO buku VALUES ("
                + "lpad(concat(floor(12345.0*rand()+54321.0*rand()),''),8,'0'),"
                + "'" + buku.getNoPanggil() + "',"
                + "default"
                + ")";
        result = dbc.getStatement().executeUpdate(query) > 0;
      }
    } catch (SQLException e) {
      dbc.closeConnection();
      return false;
    }
    dbc.closeConnection();
    return result;
  }

  public boolean tambahBeberapaBuku(Buku buku, int jumEks) {
    query = "INSERT INTO informasi_buku VALUES ('"
            + buku.getNoPanggil() + "','"
            + buku.getJudul() + "','"
            + buku.getPengarang() + "','"
            + buku.getPenerbit() + "','"
            + buku.getKota() + "','"
            + buku.getTahun() + "',"
            + buku.getJumHal()
            + ")";
    boolean result = false;
    try {
      result = dbc.getStatement().executeUpdate(query) > 0;
      if (result) {
        for (int i = 0; i < jumEks; i++) {
          query = "INSERT INTO buku VALUES ("
                  + "lpad(concat(floor(12345.0*rand()+54321.0*rand()),''),8,'0'),"
                  + "'" + buku.getNoPanggil() + "',"
                  + "default"
                  + ")";
          result = dbc.getStatement().executeUpdate(query) > 0;
        }
      }
    } catch (SQLException e) {
      dbc.closeConnection();
      return false;
    }
    dbc.closeConnection();
    return result;
  }

  public boolean ubahBuku(String kolomTarget, String nilaiTarget, String nilaiKunci) {
    query = "UPDATE buku SET " + kolomTarget + "='" + nilaiTarget + "' "
            + "WHERE kode_buku='" + nilaiKunci + "'";
    try {
      boolean result = dbc.getStatement().executeUpdate(query) > 0;
      dbc.closeConnection();
      return result;
    } catch (SQLException e) {
      dbc.closeConnection();
      return false;
    }
  }

  public boolean hapusBuku(String nilaiKunci) {
    query = "DELETE FROM informasi_buku WHERE no_panggil = '" + nilaiKunci + "'";
    try {
      boolean result = dbc.getStatement().executeUpdate(query) > 0;
      dbc.closeConnection();
      return result;
    } catch (SQLException e) {
      dbc.closeConnection();
      return false;
    }
  }

  public boolean hapusEksemplar(String nilaiKunci) {
    query = "DELETE FROM buku WHERE kode_buku = '" + nilaiKunci + "'";
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
    //ArrayList<Buku> B = new ArrayList<>();
//    String noPanggil = "005 RAH m/ed.2";

    //KelolaBuku kb = new KelolaBuku();
    //Buku buku = new Buku("a", "b", "c", "d", "e", "f", "2000", 1, "g");
    // boolean result = kb.hapusBuku("b");
//
// TAMPIL BUKU
//------------------------------------------------------
//    B = kb.lihatSemuaBuku();
//    System.out.printf("%-22s", "No. Panggil");
//    System.out.printf("%s", "Judul");
//
//    for (int i = 0; i < B.size(); i++) {
//      System.out.println();
//      System.out.printf("%-22s", B.get(i).getNoPanggil());
//      System.out.printf("%s", B.get(i).getJudul());
//    }
//    System.out.println();
// LIHAT INFORMASI
//---------------------------------------------------
//    System.out.println("No. Panggil  : " + buku.getNoPanggil());
//    System.out.println("Judul        : " + buku.getJudul());
//    System.out.println("Pengarang    : " + buku.getPengarang());
//    System.out.println("Penerbit     : " + buku.getPenerbit());
//    System.out.println("Kota/Tahun   : " + buku.getKota() + "/" + buku.getTahun());
//    System.out.println("Jum. Halaman : " + buku.getJumHal());
// TAMBAH BUKU
//---------------------------------------------------------
//    if (result) {
//      System.out.println("Berhasil ditambahkan.");
//    } else {
//      System.out.println("gagal ditambahkan!");
//    }
// HAPUS BUKU
//----------------------------------------------------------
//    if (result) {
//      System.out.println("Berhasil dihapus");
//    } else {
//      System.out.println("gagal dihaspus!");
//    }
  }
}
