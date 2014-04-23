package model.TripReport;

import SQL.DbConn;
import SQL.DbEncodeUtils;
import java.sql.*;

/**
 * This class contains all code that modifies records in a table in the
 * database. So, Insert, Update, and Delete code will be in this class
 * (eventually).
 *
 * This class requires an open database connection for its constructor method.
 */
public class TripReportMods {

    private DbConn dbc;  // Open, live database connection
    private String errorMsg = "";
    private String debugMsg = "";

    // all methods of this class require an open database connection.
    public TripReportMods(DbConn dbc) {
        this.dbc = dbc;
    }

    public String getDebugMsg() {
        return this.debugMsg;
    }

    public String getErrorMsg() {
        return this.errorMsg;
    }

    /* returns "" if all went well, otherwise returns an error message */
    public String insert(Validate tripValidate) {
        String errorMsg = "";
        String debugMsg = "";

        //double check that the info has been validated
        if (!tripValidate.isValidated()) {
            return "Please edit record and resubmit before inserting";
        }

        TypedData tripTypedData = (TypedData) tripValidate.getTypedData();
        String sql = "INSERT INTO trip_reports (title, description, days_spent, "
                + "photos_url, gps_url, web_user_id, park_id, date) "
                + "VALUES (?,?,?,?,?,?,?,?)";
        try {
            PreparedStatement pStatement = dbc.getConn().prepareStatement(sql);
            debugMsg += DbEncodeUtils.encodeString(pStatement, 1, tripTypedData.getTripTitle());
            debugMsg += DbEncodeUtils.encodeString(pStatement, 2, tripTypedData.getTripDescription());
            debugMsg += DbEncodeUtils.encodeInteger(pStatement, 3, tripTypedData.getNumDaysSpent());
            debugMsg += DbEncodeUtils.encodeString(pStatement, 4, tripTypedData.getPhotosURL());
            debugMsg += DbEncodeUtils.encodeString(pStatement, 5, tripTypedData.getGpsURL());
            debugMsg += DbEncodeUtils.encodeInteger(pStatement, 6, tripTypedData.getWebUserId());
            debugMsg += DbEncodeUtils.encodeInteger(pStatement, 7, tripTypedData.getParkId());
            debugMsg += DbEncodeUtils.encodeDate(pStatement, 8, tripTypedData.getTripDate());

            try {
                int numRows = pStatement.executeUpdate();
                if (numRows == 1) {
                    //all is good
                    return "";
                } else {
                    return "Error: " + new Integer(numRows).toString()
                            + " records were inserted where only 1 expected.";
                    // probably never get here, bulk sql insert   
                }
            } catch (SQLException e) {
                if (e.getMessage().contains("title_UNIQUE")) {
                    return "A trip report with that title already exists. Please "
                            + "change the trip title.";
            }
                return "TripReports insert: SQL Exception while attempting insert. "
                        + "SQLState:" + e.getSQLState()
                        + ", Error message: " + e.getMessage();
            }
        } catch (SQLException e) {
            return "TripReportMods.insert: General Error while attempting "
                    + "the insert. " + e.getMessage();
        }

    }

    /* returns "" if all went well, otherwise returns error message */
    public String delete(String primaryKey) {
        this.errorMsg = "";  // clear any error message from before.

        String sql = "DELETE FROM trip_reports where trip_id=?";
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
                this.errorMsg = "Could not delete the trip report. Please "
                        + "cotact us.";
            }

            this.errorMsg += "Problem with SQL in TripReportsSql.delete: "
                    + "SQLState [" + e.getSQLState()
                    + "], error message [" + e.getMessage() + "]";
            System.out.println(this.errorMsg);

            return this.errorMsg;
        } // catch
        catch (Exception e) {
            this.errorMsg = "General Error in TripReportsSql.delete: "
                    + e.getMessage();
            System.out.println(this.errorMsg);

            return this.errorMsg;
        } // catch
    }// method delete
} // class
