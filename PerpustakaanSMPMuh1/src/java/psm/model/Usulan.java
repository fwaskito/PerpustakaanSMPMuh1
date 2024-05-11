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
public class Usulan {

  private String kodeUsulan;
  private String idAnggota;
  private String idPustakawan;
  private String isi;
  private Date tglUsul;
  private String status;

  public Usulan() {
  }

  public Usulan(String kodeUsulan, String idAnggota, String idPustakawan,
          String isi, Date tglUsul, String status) {
    this.kodeUsulan = kodeUsulan;
    this.idAnggota = idAnggota;
    this.idPustakawan = idPustakawan;
    this.isi = isi;
    this.tglUsul = tglUsul;
    this.status = status;
  }

  public String getKodeUsulan() {
    return kodeUsulan;
  }

  public void setKodeUsulan(String kodeUsulan) {
    this.kodeUsulan = kodeUsulan;
  }

  public String getIdAnggota() {
    return idAnggota;
  }

  public void setIdAnggota(String idAnggota) {
    this.idAnggota = idAnggota;
  }

  public String getIdPustakawan() {
    return idPustakawan;
  }

  public void setIdPustakawan(String idPustakawan) {
    this.idPustakawan = idPustakawan;
  }

  public String getIsi() {
    return isi;
  }

  public void setIsi(String isi) {
    this.isi = isi;
  }

  public Date getTglUsul() {
    return tglUsul;
  }

  public void setTglUsul(Date tglUsul) {
    this.tglUsul = tglUsul;
  }

  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
  }

}
