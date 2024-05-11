/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package psm.helper;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.concurrent.ThreadLocalRandom;

/**
 *
 * @author Fajar Waskito
 */
public class BuatSesuatu {

  FormatTeks ft = null;

  public BuatSesuatu() {
    ft = new FormatTeks();
  }

  /**
   *
   * @param kategori
   * @param judul
   * @param pengarang
   * @return noPanggil
   * @Referensi: Pembuatan nomor panggil buku mengandung kode klasifikasi yang
   * dibuat menggunakan interval sistem klasifikasi Dewey Decimal Classification
   * (DDC), tetapi dengan sedikit modifikasi berupa angka random dalam
   * intervalnya. .
   */
  public String buatNoPanggil(String kategori, String judul, String pengarang) {
    String n1 = ft.formatAngkaDesimal(deweyDecimalClassification(kategori), "000.00"); //Kode klasifikasi
    String n2 = ambilKata(pengarang, "terakhir").substring(0, 3).toUpperCase(); //Tiga huruf awal dari nama belakang pengarang
    String n3 = String.valueOf(judul.charAt(0)).toLowerCase(); //Huruf awal dari judul buku
    return n1 + " " + n2 + " " + n3;
  }

  /**
   *
   * @param kategori
   * @param judul
   * @param pengarang
   * @param edisi
   * @return noPanggil
   */
  public String buatNoPanggil(String kategori, String judul, String pengarang, String edisi) {
    String n1 = ft.formatAngkaDesimal(deweyDecimalClassification(kategori), "000.00"); //Kode klasifikasi
    String n2 = ambilKata(pengarang, "terakhir").substring(0, 3).toUpperCase(); //Tiga huruf awal dari nama belakang pengaranga
    String n3 = String.valueOf(judul.charAt(0)).toLowerCase(); //Huruf awal dari judul buku
    String n4 = buatKodeEdisiBuku(edisi); //Beberapa huruf awal edisi atau angka urutan edisi
    return n1 + " " + n2 + " " + n3 + "/" + n4;
  }

  protected double deweyDecimalClassification(String kategori) {
    double klasifikasi = 0.0;
    switch (kategori) {
      case "000":
        klasifikasi = ThreadLocalRandom.current().nextDouble(0, 99);
        break;
      case "100":
        klasifikasi = ThreadLocalRandom.current().nextDouble(100, 199);
        break;
      case "200":
        klasifikasi = ThreadLocalRandom.current().nextDouble(200, 299);
        break;
      case "300":
        klasifikasi = ThreadLocalRandom.current().nextDouble(300, 399);
        break;
      case "400":
        klasifikasi = ThreadLocalRandom.current().nextDouble(400, 499);
        break;
      case "500":
        klasifikasi = ThreadLocalRandom.current().nextDouble(500, 599);
        break;
      case "600":
        klasifikasi = ThreadLocalRandom.current().nextDouble(600, 699);
        break;
      case "700":
        klasifikasi = ThreadLocalRandom.current().nextDouble(700, 799);
        break;
      case "800":
        klasifikasi = ThreadLocalRandom.current().nextDouble(800, 899);
        break;
      case "900":
        klasifikasi = ThreadLocalRandom.current().nextDouble(900, 999);
        break;
    }
    return klasifikasi;
  }

  protected String buatKodeEdisiBuku(String edisi) {
    String kode = "ed.";
    switch (edisi.toLowerCase()) {
      case "pertama":
        kode += "1";
        break;
      case "kedua":
        kode += "2";
        break;
      case "ketiga":
        kode += "3";
        break;
      case "keempat":
        kode += "4";
        break;
      case "kelima":
        kode += "5";
        break;
      case "keenam":
        kode += "6";
        break;
      case "ketujuh":
        kode += "7";
        break;
      case "kedelapan":
        kode += "8";
        break;
      case "kesembilan":
        kode += "9";
        break;
      case "kesepuluh":
        kode += "10";
        break;
      case "revisi":
        kode += "rev";
        break;
      case "terjemah":
        kode += "terj";
        break;
    }
    return kode;
  }

  public String ambilKata(String kalimat, String posisi) {
    String kata = "";
    String[] splitKalimat = kalimat.split(" ");
    switch (posisi) {
      case "pertama":
        kata = splitKalimat[0];
        break;
      case "terakhir":
        kata = splitKalimat[splitKalimat.length - 1];
        break;
    }
    return kata;
  }

  public String ambilKeteranganKategori(String kodeKategori) {
    String ketKategori = "";
    switch (kodeKategori) {
      case "000":
        ketKategori = "Ilmu Komputer, Informasi, & Umum";
        break;
      case "100":
        ketKategori = "Filosofi & Psikologi";
        break;
      case "200":
        ketKategori = "Agama";
        break;
      case "300":
        ketKategori = "Ilmu Sosial";
        break;
      case "400":
        ketKategori = "Bahasa";
        break;
      case "500":
        ketKategori = "Ilmu Alam/Murni";
        break;
      case "600":
        ketKategori = "Teknologi";
        break;
      case "700":
        ketKategori = "Seni & Rekreasi";
        break;
      case "800":
        ketKategori = "Sastra";
        break;
      case "900":
        ketKategori = "Sejarah & Geografi";
        break;
    }
    return ketKategori;
  }

  public java.sql.Date ubahKeTanggal(String sTanggal) throws ParseException {
    SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
    java.util.Date parsed = format.parse(sTanggal);
    java.sql.Date tanggal = new java.sql.Date(parsed.getTime());
    return tanggal;
  }

  public static void main(String[] args) throws ParseException {
    BuatSesuatu bs = new BuatSesuatu();
//    String result = bs.buatNoPanggil("000", "a", "waskito", "10");
//    System.out.println(result);
    String sDate = "20211214";
    java.sql.Date d = bs.ubahKeTanggal(sDate);
    System.out.println(d);
    FormatTeks ft = new FormatTeks();
    System.out.println(ft.formatTanggalKeInternasional(d));
  }
}
