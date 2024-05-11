package psm.helper;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author Fajar Waskito
 */
public class DatabaseConnection {

  private Connection dbc = null;
  private Statement stmt = null;
  // private ResultSet rs = null;

  protected void hasDriver() {
    try {
      Class.forName("com.mysql.cj.jdbc.Driver");
    } catch (ClassNotFoundException e) {
      System.out.println("Database driver tidak valid!! Mohon periksa driver...");
    }

  }

  protected Connection openConnection() {
    try {
      if (dbc == null) {
        hasDriver();
        String url = "jdbc:mysql://localhost:3306/perpus_smpmuh1?serverTimezone=UTC";
        dbc = DriverManager.getConnection(url, "waskito", "admwaskito");
      }
    } catch (SQLException e) {
      System.out.println("Koneksi Error! PMohon periksa URL, username, dan password MYSQL");
    }
    return dbc;
  }

  public Statement getStatement() {
    try {
      if (stmt == null) {
        stmt = openConnection().createStatement();
      }
    } catch (SQLException e) {
      System.out.println("Mohon periksa statement...");
    }
    return stmt;
  }

  public void closeResultSet(ResultSet rs) {
    try {
      if (rs != null && !rs.isClosed()) {
        rs.close();
      }
    } catch (SQLException e) {
      System.out.println("Mohon periksa resultset");
    }
  }

  public void closeConnection() {
    try {
      if (dbc != null && !dbc.isClosed()) {
        dbc.close();
      }
      if (stmt != null && !stmt.isClosed()) {
        stmt.close();
      }
    } catch (SQLException e) {
      System.out.println("Please check close dbcect, stmt, resutlset");
    }

  }
  
    public static void main(String[] args) {
        DatabaseConnection dbc;
        dbc = new DatabaseConnection();
    }
}

