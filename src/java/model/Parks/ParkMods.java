package model.Parks;

import SQL.*;   //no need to list each one if we're importing the entire package
import java.sql.*;

/*
 * This class contains all code that modifies records in a table in the
 * database. So, Insert, Update, and Delete code will be in this class
 * (eventually). Right now, it's just doing DELETE.
 *
 * This class requires an open database connection for its constructor method.
 */
public class ParkMods {

    private DbConn dbc;  // Open live database connection
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
                        + " still trip reports for the park. Please delete all"
                        + " trip reports associated with this park first.";
            } else {
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

    /* This method requires a pre-validated Other data object. 
     * It also assumes that an open database connection was provided to the constructor.
     * It returns true if it is able to insert the user data into the database.
     */
    public String insert(Validate parkValidate) {

        this.errorMsg = "";// empty error message means it worked.
        this.debugMsg = "";

        // dont even try to insert if the user data didnt pass validation.
        if (!parkValidate.isValidated()) {
            this.errorMsg = "Please edit record and resubmit before inserting";
            return this.errorMsg;
        }

        TypedData parkTypedData = (TypedData) parkValidate.getTypedData();
        String sql = "INSERT INTO parks (park_name, overnight_fee, state_name) "
                + "VALUES (?,?,?)";
        try {
            PreparedStatement pStatement = dbc.getConn().prepareStatement(sql);
            this.debugMsg += DbEncodeUtils.encodeString(pStatement, 1, parkTypedData.getParkName());
            this.debugMsg += DbEncodeUtils.encodeDecimal(pStatement, 2, parkTypedData.getOverNightFee());
            this.debugMsg += DbEncodeUtils.encodeString(pStatement, 3, parkTypedData.getStateName());

            try {
                int numRows = pStatement.executeUpdate();
                if (numRows == 1) {
                    return ""; // all is GOOD, one record inserted is what we expect
                } else {
                    this.errorMsg = "Error: " + new Integer(numRows).toString()
                            + " records were inserted where only 1 expected."; // probably never get here, bulk sql insert
                    return this.errorMsg;
                }
            } // try execute the statement
            catch (SQLException e) {
                if (e.getSQLState().equalsIgnoreCase("S1000")) {
                    // this error would only be possible for a non-auto-increment primary key.
                    this.errorMsg = "Cannot insert: a record with that ID already exists.";
                } else if (e.getMessage().toLowerCase().contains("duplicate entry")) {
                    this.errorMsg = "A park with that name already exists!"; // for example a unique key constraint.
                } else if (e.getMessage().toLowerCase().contains("foreign key")) {
                    this.errorMsg = "Cannot insert: invalid reference (bad foreign key value)."; // for example a unique key constraint.
                } else {
                    this.errorMsg = "ParkMods.insert: SQL Exception while attempting insert. "
                            + "SQLState:" + e.getSQLState()
                            + ", Error message: " + e.getMessage();
                    // this message would show up in the NetBeans log window (below the editor)
                    System.out.println("************* " + this.errorMsg);
                }
                return this.errorMsg;
            } // catch
            catch (Exception e) {
                // this message would show up in the NetBeans log window (below the editor)
                this.errorMsg = "ParkMods.insert: General Error while "
                        + "attempting the insert. " + e.getMessage();
                System.out.println("****************** " + this.errorMsg);
                return this.errorMsg;
            } // catch
        } // trying to prepare the statement
        catch (Exception e) {
            this.errorMsg = "ParkMods.insert: General Error while trying to "
                    + "prepare the SQL INSERT statement. " + e.getMessage();
            System.out.println("****************** " + this.errorMsg);
            return this.errorMsg;
        }
    }// method

    /*
     * Find the webUser record that has the given primary key. If found, return
     * true and fill up the WebUser object with found data, otherwise, return
     * false.
     *
     * @param primaryKey (input) the primary key of the record to be found.
     * @param sqlPrep (input) an object that knows the SQL statements for the DB
     * we are working with.
     * @param stringData (output) the found record (if the record was found).
     * @return returns true if record was found, false otherwise.
     */
    public StringData find(String primaryKey) {

        this.errorMsg = "";  // clear any error message from before.
        try {
            String sql = "SELECT * FROM parks where park_id=?";
            PreparedStatement sqlSt = dbc.getConn().prepareStatement(sql);
            sqlSt.setString(1, primaryKey);

            try {
                ResultSet results = sqlSt.executeQuery(); // expecting only one row in result set
                StringData stringData = this.extractResultSetToStringData(results);//

                if (stringData != null) {
                    System.out.println("*** ParkMods.find: Park (found or not "
                            + "found) is " + stringData.toString());
                    return stringData; // if stringData is full, record found. else all fields will be blank "".
                } else { // stringData null means there was a problem extracting data
                    // check the System.out message in the log to see exact exception error msg.
                    return null;
                }
            } catch (Exception e) {
                this.errorMsg = e.getMessage();
                System.out.println("*** ParkMods.find: exception thrown running "
                        + "Select Statement " + primaryKey
                        + ". Error is: " + this.errorMsg);
                return null;
            }
        }// try
        catch (Exception e) {
            this.errorMsg = e.getMessage();
            System.out.println("*** ParkMods.find: exception thrown Preparing "
                    + "Select Statement with PK " + primaryKey
                    + ". Error is: " + this.errorMsg);
            return null;
        }
    } // method    

    public StringData extractResultSetToStringData(ResultSet results) {
        StringData parkStringData = new StringData();
        try {
            if (results.next()) { // we are expecting only one rec in result set, so while loop not needed.
                parkStringData.parkId = FormatUtils.objectToString(results.getObject("park_id"));
                parkStringData.parkName = FormatUtils.objectToString(results.getObject("park_name"));
                parkStringData.overNightFee = FormatUtils.objectToString(results.getObject("overnight_fee"));
                parkStringData.stateName = FormatUtils.objectToString(results.getObject("state_name"));
                parkStringData.recordStatus = "Record Found";

                System.out.println("*** ParkMods.extractResultSetToStringData: "
                        + "record values are "
                        + parkStringData.toString());

                return parkStringData; // means OK, record found and wu has been filled
            } else {
                parkStringData.recordStatus = "Record Not Found";
                return parkStringData; // not found, all fields will be blank
            }
        } catch (Exception e) {
            System.out.println("*** ParkMods.extractResultSetToStringData() "
                    + "Exception: " + e.getMessage());
            return null;
        } // catch misc error
    } // method

    // Returning "" empty string means the UPDATE was successful
    public String update(Validate validate) {
        this.errorMsg = "";

        // dont even try to insert if the user data didnt pass validation.
        if (!validate.isValidated()) {
            this.errorMsg = "Please edit record and resubmit";
            return this.errorMsg;
        }

        TypedData parkTypedData = (TypedData) validate.getTypedData();
        String sql = "UPDATE parks SET park_name=?, state_name=?, "
                + "overnight_fee=? where park_id=?";

        try {
            PreparedStatement sqlSt = dbc.getConn().prepareStatement(sql);
            debugMsg += "<br/>Sql was: " + sql;
            debugMsg += "<br/>" + DbEncodeUtils.encodeString(sqlSt, 1, parkTypedData.getParkName());
            debugMsg += "<br/>" + DbEncodeUtils.encodeString(sqlSt, 2, parkTypedData.getStateName());
            debugMsg += "<br/>" + DbEncodeUtils.encodeDecimal(sqlSt, 3, parkTypedData.getOverNightFee());
            debugMsg += "<br/>" + DbEncodeUtils.encodeInteger(sqlSt, 4, parkTypedData.getParkId());

            try {
                int numRows = sqlSt.executeUpdate();
                if (numRows == 1) {
                    this.errorMsg = "";
                    return this.errorMsg; // all is GOOD, one record was updated like we expected.
                } else {
                    // we could be here (numRows==0) if record was not found.
                    // we could be here (numRows>1) if we forgot where clause -- would update all recs.
                    // In either case, it would probalby be a programmer error.
                    this.errorMsg = "Error: " + new Integer(numRows).toString()
                            + " records were updated (when only 1 record expected for update).";
                    return this.errorMsg;
                }
            } // try
            catch (SQLException e) {
                this.errorMsg = "SqlMods.update: SQL Exception during update operation. "
                        + "SQLState [" + e.getSQLState()
                        + "], error message [" + e.getMessage() + "]";
                System.out.println(this.errorMsg);
                return this.errorMsg;
            } // catch
            catch (Exception e) {
                this.errorMsg = "SqlMods.update: General Exception during update operation. "
                        + e.getMessage();
                System.out.println(this.errorMsg);
                return this.errorMsg;
            } // catch
        } // try
        catch (Exception e) {
            this.errorMsg = "SqlMods.update: Problem Compiling Prepared Statement. "
                    + e.getMessage();
            System.out.println(this.errorMsg);
            return this.errorMsg;
        } // catch
    }// method
} // class
