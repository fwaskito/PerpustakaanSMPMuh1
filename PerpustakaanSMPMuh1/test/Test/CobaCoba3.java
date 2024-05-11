/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Test;

/**
 *
 * @author Lenovo
 */
public class CobaCoba3 {

  public static void main(String[] args) {
    java.io.File oldFile = new java.io.File("C:\\Users\\Lenovo\\Documents\\NetBeansProjects\\contoh buku baru\\b.jpg");
    java.io.File newFile = new java.io.File("C:\\Users\\Lenovo\\Documents\\NetBeansProjects\\contoh buku baru\\akhirnya berhasil.jpg");
    if (oldFile.renameTo(newFile)) {
      System.out.println("nama file diubah");
    } else {
      System.out.println("nama file gagal diubah");
    }
  }

}
