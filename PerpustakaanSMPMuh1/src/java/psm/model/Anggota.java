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
public class Anggota {

  private String idAnggota;
  private String nama;
  private String noTelpon;
  private String email;
  private String jenKel;
  private Date tglLahir;
  private String alamat;
  private String klasifikasi;
  private String password;

  public Anggota() {
  }

  public Anggota(String idAnggota, String nama, String noTelpon,
          String klasifikasi, String tglLahir, String alamat, String password) {
  }

  public String getIdAnggota() {
    return idAnggota;
  }

  public void setIdAnggota(String idAnggota) {
    this.idAnggota = idAnggota;
  }

  public String getNama() {
    return nama;
  }

  public void setNama(String nama) {
    this.nama = nama;
  }

  public String getNoTelpon() {
    return noTelpon;
  }

  public void setNoTelpon(String noTelpon) {
    this.noTelpon = noTelpon;
  }

  public String getEmail() {
    return email;
  }

  public void setEmail(String noTelpon) {
    this.email = noTelpon;
  }

  public String getJenKel() {
    return jenKel;
  }

  public void setJenKel(String jenKel) {
    this.jenKel = jenKel;
  }

  public String getKlasifikasi() {
    return klasifikasi;
  }

  public void setKlasifikasi(String klasifikasi) {
    this.klasifikasi = klasifikasi;
  }

  public Date getTglLahir() {
    return tglLahir;
  }

  public void setTglLahir(Date tglLahir) {
    this.tglLahir = tglLahir;
  }

  public String getAlamat() {
    return alamat;
  }

  public void setAlamat(String alamat) {
    this.alamat = alamat;
  }

  public String getPassword() {
    return password;
  }

  public void setPassword(String password) {
    this.password = password;
  }

}
