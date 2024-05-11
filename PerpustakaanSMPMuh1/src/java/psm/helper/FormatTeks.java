/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package psm.helper;

import java.util.Date;
import java.util.Locale;
import java.text.SimpleDateFormat;
import java.text.DecimalFormat;

/**
 *
 * @author Fajar Waskito
 */
public class FormatTeks {

  Date date = null;
  SimpleDateFormat sdf = null;
  DecimalFormat df = null;

  public String formatTanggalKeIndonesia(Date tanggal) {
    Locale id = new Locale("id");
    sdf = new SimpleDateFormat("dd MMMM yyyy", id);
    return sdf.format(tanggal);
  }

  public String formatTanggalKeInternasional(Date tanggal) {
    //Locale us = new Locale("us");
    sdf = new SimpleDateFormat("yyyy-MM-dd");
    return sdf.format(tanggal);
  }

  public String formatAngkaDesimal(Double angka, String format) {
    df = new DecimalFormat(format);
    return df.format(angka);
  }
}
