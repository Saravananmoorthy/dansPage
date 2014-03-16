package model;

import SQL.DbConn;
import java.sql.*;

/** 
 * This class contains all code that modifies records in a table in the database. 
 * So, Insert, Update, and Delete code will be in this class (eventually). Right now, 
 * it's just doing DELETE.
 * 
 * This class requires an open database connection for its constructor method.
 */
public class ParkMods {

    private DbConn dbc;  // Open, live database connection
    private String errorMsg = "";
    private String debugMsg = "";

    // all methods of this class require an open database connection.
    public ParkMods(DbConn dbc) {
        this.dbc = dbc;
    }

    public String getDebugMsg() {
        return this.debugMsg;
    }

    public String getErrorMsg() {
        return this.errorMsg;
    }

    /* returns "" if all went well, otherwise returns error message */
    public String delete(String primaryKey) {
        this.errorMsg = "";  // clear any error message from before.
        
        String sql = "DELETE FROM parks where park_id=?";
        try {
            PreparedStatement sqlSt = dbc.getConn().prepareStatement(sql);
            sqlSt.setString(1, primaryKey);

            int numRows = sqlSt.executeUpdate();
            if (numRows == 1) {
                this.errorMsg = "";
                return this.errorMsg; // all is GOOD
            } else {
                this.errorMsg = "Error - " + new Integer(numRows).toString()
                        + " records deleted (1 was expected)."; // probably never get here
                return this.errorMsg;
            }
        } // try
        catch (SQLException e) {
            this.errorMsg = "";
            if (e.getSQLState().equalsIgnoreCase("S1000")) {
                this.errorMsg = "Could not delete.";
            }
            
            String tempErrorMesg = e.getMessage();
            
            if (tempErrorMesg.contains("FOREIGN KEY")) {
                this.errorMsg = "This park cannot be deleted because there are"
                        + " still trip reports for the park.";
            }
            
            else {
                this.errorMsg += "Problem with SQL in WebUserSql.delete: "
                    + "SQLState [" + e.getSQLState()
                    + "], error message [" + tempErrorMesg + "]";
            }
            
            return this.errorMsg;
        } // catch
        catch (Exception e) {
            this.errorMsg = "General Error in ParkSql.delete: "
                    + e.getMessage();
            System.out.println(this.errorMsg);
            
            return this.errorMsg;
        } // catch
    }// method delete
} // class