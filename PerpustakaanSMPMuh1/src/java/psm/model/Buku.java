/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package psm.model;

/**
 *
 * @author Fajar Waskito
 */
public class Buku {

  private String kodeBuku;
  private String noPanggil;
  private String judul;
  private String pengarang;
  private String penerbit;
  private String kota;
  private String tahun;
  private int jumHal;
  private int jumEks;
  private String status;

  public Buku() {
  }

  public Buku(String kodeBuku, String noPanggil, String judul, String pengarang,
          String penerbit, String kota, String tahun, int jumHal, int jumEks, String status) {
    this.kodeBuku = kodeBuku;
    this.noPanggil = noPanggil;
    this.judul = judul;
    this.pengarang = pengarang;
    this.penerbit = penerbit;
    this.kota = kota;
    this.tahun = tahun;
    this.jumHal = jumHal;
    this.jumEks = jumEks;
    this.status = status;
  }

  public String getKodeBuku() {
    return kodeBuku;
  }

  public void setKodeBuku(String kodeBuku) {
    this.kodeBuku = kodeBuku;
  }

  public String getNoPanggil() {
    return noPanggil;
  }

  public void setNoPanggil(String noPanggil) {
    this.noPanggil = noPanggil;
  }

  public String getJudul() {
    return judul;
  }

  public void setJudul(String judul) {
    this.judul = judul;
  }

  public String getPengarang() {
    return pengarang;
  }

  public void setPengarang(String pengarang) {
    this.pengarang = pengarang;
  }

  public String getPenerbit() {
    return penerbit;
  }

  public void setPenerbit(String penerbit) {
    this.penerbit = penerbit;
  }

  public String getKota() {
    return kota;
  }

  public void setKota(String kota) {
    this.kota = kota;
  }

  public String getTahun() {
    return tahun;
  }

  public void setTahun(String tahun) {
    this.tahun = tahun;
  }

  public int getJumHal() {
    return jumHal;
  }

  public void setJumHal(int jumHal) {
    this.jumHal = jumHal;
  }

  public int getJumEks() {
    return this.jumEks;
  }

  public void setJumEks(int jumEks) {
    this.jumEks = jumEks;
  }

  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
  }

  public static void main(String[] args) {

  }
}
