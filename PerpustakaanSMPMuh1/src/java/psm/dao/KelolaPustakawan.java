/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package psm.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import psm.helper.DatabaseConnection;
import psm.model.Pustakawan;

/**
 *
 * @author Fajar Waskito
 */
public class KelolaPustakawan {

  DatabaseConnection dbc = null;
  ResultSet rs = null;
  String query = "";

  public KelolaPustakawan() {
    dbc = new DatabaseConnection();
  }

  public Pustakawan cariPustakawan(String nilaiKunci) {
    Pustakawan pustakawan = new Pustakawan();
    query = "SELECT * FROM pustakawan "
            + "WHERE username ='" + nilaiKunci + "'";
    try {
      rs = dbc.getStatement().executeQuery(query);
      rs.next();
      pustakawan = new Pustakawan();
      pustakawan.setIdPustakawan(rs.getString("id_pustakawan"));
      pustakawan.setNama(rs.getString("nama"));
      pustakawan.setNoTelpon(rs.getString("no_telpon"));
      pustakawan.setNoTelpon(rs.getString("username"));
      pustakawan.setPassword(rs.getString("password"));
    } catch (SQLException e) {
      dbc.closeResultSet(rs);
      dbc.closeConnection();
    }
    dbc.closeResultSet(rs);
    dbc.closeConnection();
    return pustakawan;
  }
}
