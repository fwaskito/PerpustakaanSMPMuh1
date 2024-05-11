/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Test;

import java.text.ParseException;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.time.LocalDate;

/**
 *
 * @author Fajar Waskito
 */
public class CobaCoba {

  public static void main(String[] args) throws ParseException {
    /*
    Date
     */
//    java.sql.Date date = new java.sql.Date(System.currentTimeMillis());
//    java.sql.Date date2 = new java.sql.Date(System.currentTimeMillis());
    //java.util.Date date = new java.util.Date();
//    date = Date.valueOf("2021-11-20");
//    date2 = Date.valueOf("2021-11-23");
    //java.util.Locale l = new java.util.Locale("id"); // or args ("lang", "country")
    //java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd MMMM yyyy", l);
    //java.text.DateFormat df = new java.text.SimpleDateFormat("dd MMMM yyyy", l);
    //String sDate = sdf.format(date);
    //String sDate2 = df.format(date);
    //System.out.println(sDate);
    //System.out.println(sDate2);
//    System.out.println("date : " + date);
//    System.out.println("date2: " + date2);
//    System.out.println("date after date2: " + date.after(date2));
//    System.out.println("date2 after date: " + date2.after(date));
//    System.out.println("date compere to date2: " + date.compareTo(date2));
//    System.out.println("date2 compare date: " + date2.compareTo(date));
//    System.out.println("date equals date2: " + date.equals(date2));

    /*
    Split a String
     */
//    String str = "9876666666;Effective Java;J. Bloch;";
//    String[] arrOfStr = str.split(";");
//    System.out.println("Length of arr: " + arrOfStr.length);
//    for (String s : arrOfStr) {
//      System.out.println(s);
    //}
//    SimpleDateFormat format = new SimpleDateFormat("yyyy-mm-dd");
//    Date parsed = format.parse("2021-06-10");
//    java.sql.Date sql = new java.sql.Date(parsed.getTime());
//    System.out.println(sql);
    String[] str = new String[3];
    str[0] = "a";
    str[1] = "";
    str[2] = "";
    boolean kosong = false;
    for (int i = 0; i < str.length; i++) {
      if (str[i] == null) {
        kosong = true;
      }
    }
    System.out.println(kosong);
  }
}
