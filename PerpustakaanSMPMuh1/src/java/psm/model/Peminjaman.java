/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package psm.model;

import java.sql.Date;

/**
 *
 * @author Fajar Waskito
 */
public class Peminjaman {

  private String idPinjam;
  private String kodeBuku;
  private String idAnggota;
  private Date tglPinjam;
  private Date tglHarusKembali;
  private Date tglKembali;
  private int terlambat;

  public Peminjaman() {
  }

  public Peminjaman(String idPinjam, String kodeBuku, String idAnggota,
          Date tglPinjam, Date tglHarusKembali, Date tglKembali, int terlambat) {
    this.idPinjam = idPinjam;
    this.kodeBuku = kodeBuku;
    this.tglPinjam = tglPinjam;
    this.tglHarusKembali = tglHarusKembali;
    this.tglKembali = tglHarusKembali;
    this.terlambat = terlambat;
  }

  public String getIdPinjam() {
    return idPinjam;
  }

  public void setIdPinjam(String idPinjam) {
    this.idPinjam = idPinjam;
  }

  public String getKodeBuku() {
    return kodeBuku;
  }

  public void setKodeBuku(String kodeBuku) {
    this.kodeBuku = kodeBuku;
  }

  public String getIdAnggota() {
    return idAnggota;
  }

  public void setIdAnggota(String idAnggota) {
    this.idAnggota = idAnggota;
  }

  public Date getTglPinjam() {
    return tglPinjam;
  }

  public void setTglPinjam(Date tglPinjam) {
    this.tglPinjam = tglPinjam;
  }

  public Date getTglHarusKembali() {
    return tglHarusKembali;
  }

  public void setTglHarusKembali(Date tglHarusKembali) {
    this.tglHarusKembali = tglHarusKembali;
  }

  public Date getTglKembali() {
    return tglKembali;
  }

  public void setTglKembali(Date tglKembali) {
    this.tglKembali = tglKembali;
  }

  public int getTerlambat() {
    return terlambat;
  }

  public void setTerlambat(int terlambat) {
    this.terlambat = terlambat;
  }

}
