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
public class Pustakawan {

  private String idPustakawan;
  private String nama;
  private String noTelpon;
  private String email;
  private String username;
  private String password;

  public Pustakawan() {
  }

  public Pustakawan(String idPustakawan, String nama, String noTelpon,
          String email, String username, String password) {
    this.idPustakawan = idPustakawan;
    this.nama = nama;
    this.noTelpon = noTelpon;
    this.email = email;
    this.username = username;
    this.password = password;
  }

  public String getIdPustakawan() {
    return idPustakawan;
  }

  public void setIdPustakawan(String idPustakawan) {
    this.idPustakawan = idPustakawan;
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

  public void setEmail(String email) {
    this.email = email;
  }

  public String getUsername() {
    return username;
  }

  public void setUsername(String username) {
    this.username = username;
  }

  public String getPassword() {
    return password;
  }

  public void setPassword(String password) {
    this.password = password;
  }

}
