/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Test;

//import java.util.Random;
import java.util.concurrent.ThreadLocalRandom;
import java.text.DecimalFormat;

/**
 *
 * @author Fajar Waskito
 */
public class CobaCoba2 {

  public static void main(String[] args) {
//    Random rand = new Random();
//    rand.ints(2, 20, 30).forEach((x) -> System.out.println(x));
    int a = ThreadLocalRandom.current().nextInt(200, 300);
    int b = ThreadLocalRandom.current().nextInt(200, 300);
    double c = Math.round(ThreadLocalRandom.current().nextDouble(20, 30) * 100.0) / 100.0;
    double d = ThreadLocalRandom.current().nextDouble(200, 300);
    double d2 = Math.round(d * 100.0) / 100.0;
    System.out.println(a);
    System.out.println(b);
    System.out.println(c);
    System.out.println(d);
    System.out.println(d2);
    DecimalFormat df = new DecimalFormat("###.##");
    System.out.println(df.format(d));

  }
}
