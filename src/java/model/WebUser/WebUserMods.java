package model.WebUser;

import SQL.*;   //no need to list each one if we're importing the entire package
import java.sql.*;


/*
 * This class contains all code that modifies records in a table in the
 * database. So, Insert, Update, and Delete code will be in this class
 * (eventually). Right now, it's just doing DELETE.
 *
 * This class requires an open database connection for its constructor method.
 */
public class WebUserMods {

    private DbConn dbc;  // Open, live database connection
    private String errorMsg = "";
    private String debugMsg = "";

    // all methods of this class require an open database connection.
    public WebUserMods(DbConn dbc) {
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

        String sql = "DELETE FROM web_user where web_user_id=?";
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
                this.errorMsg = "This camper cannot be deleted because there are"
                        + " still trip reports under their name. Please delete"
                        + " all the trip reports from this user first.";
            } else {
                this.errorMsg += "Problem with SQL in WebUserSql.delete: "
                        + "SQLState [" + e.getSQLState()
                        + "], error message [" + tempErrorMesg + "]";
            }

            System.out.println(this.errorMsg);

            return this.errorMsg;
        } // catch
        catch (Exception e) {
            this.errorMsg = "General Error in WebUserSql.delete: "
                    + e.getMessage();
            System.out.println(this.errorMsg);

            return this.errorMsg;
        } // catch
    }// method delete

    /* This method will create a pick list for user roles to prevent someone
     * from entering an invalid user role.
     */
    public String createPickList() {
        String pickList = "";
        return pickList;
    }

    /* This method requires a pre-validated User data object. 
     * It also assumes that an open database connection was provided to the constructor.
     * It returns true if it is able to insert the user data into the database.
     */
    public String insert(Validate wuValidate) {

        this.errorMsg = "";// empty error message means it worked.
        this.debugMsg = "";

        // dont even try to insert if the user data didnt pass validation.
        if (!wuValidate.isValidated()) {
            this.errorMsg = "Please edit record and resubmit before inserting";
            return this.errorMsg;
        }

        TypedData wuTypedData = (TypedData) wuValidate.getTypedData();
        String sql = "INSERT INTO web_user (user_email, user_password, "
                + "membership_fee, user_role_id, birthday"
                + ") VALUES (?,?,?,?,?)";
        try {
            PreparedStatement pStatement = dbc.getConn().prepareStatement(sql);
            this.debugMsg += DbEncodeUtils.encodeString(pStatement, 1, wuTypedData.getUserEmail());
            this.debugMsg += DbEncodeUtils.encodeString(pStatement, 2, wuTypedData.getUserPw());
            this.debugMsg += DbEncodeUtils.encodeDecimal(pStatement, 3, wuTypedData.getMembershipFee());
            this.debugMsg += DbEncodeUtils.encodeInteger(pStatement, 4, wuTypedData.getUserRoleId());
            this.debugMsg += DbEncodeUtils.encodeDate(pStatement, 5, wuTypedData.getBirthday());

            //System.out.println("************* got past encoding");
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
                    this.errorMsg = "A user with that email address already exists!"; // for example a unique key constraint.
                } else if (e.getMessage().toLowerCase().contains("foreign key")) {
                    this.errorMsg = "Please use a valid User Role Key."; // for example a unique key constraint.
                } else {
                    this.errorMsg = "WebUserMods.insert: SQL Exception while attempting insert. "
                            + "SQLState:" + e.getSQLState()
                            + ", Error message: " + e.getMessage();
                    // this message would show up in the NetBeans log window (below the editor)
                    System.out.println("************* " + this.errorMsg);
                }
                return this.errorMsg;
            } // catch
            catch (Exception e) {
                // this message would show up in the NetBeans log window (below the editor)
                this.errorMsg = "WebUserMods.insert: General Error while attempting the insert. " + e.getMessage();
                System.out.println("****************** " + this.errorMsg);
                return this.errorMsg;
            } // catch
        } // trying to prepare the statement
        catch (Exception e) {
            this.errorMsg = "WebUserMods.insert: General Error while trying to prepare the SQL INSERT statement. " + e.getMessage();
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
            String sql = "SELECT * FROM web_user where web_user_id=?";
            PreparedStatement sqlSt = dbc.getConn().prepareStatement(sql);
            sqlSt.setString(1, primaryKey);

            try {
                ResultSet results = sqlSt.executeQuery(); // expecting only one row in result set
                StringData stringData = this.extractResultSetToStringData(results);//

                if (stringData != null) {
                    System.out.println("*** WebUserMods.find: Web User (found or not found) is " + stringData.toString());
                    return stringData; // if stringData is full, record found. else all fields will be blank "".
                } else { // stringData null means there was a problem extracting data
                    // check the System.out message in the log to see exact exception error msg.
                    return null;
                }
            } catch (Exception e) {
                this.errorMsg = e.getMessage();
                System.out.println("*** WebUserMods.find: exception thrown running Select Statement " + primaryKey
                        + ". Error is: " + this.errorMsg);
                return null;
            }
        }// try
        catch (Exception e) {
            this.errorMsg = e.getMessage();
            System.out.println("*** WebUserMods.find: exception thrown Preparing Select Statement with PK " + primaryKey
                    + ". Error is: " + this.errorMsg);
            return null;
        }
    } // method    

    public StringData extractResultSetToStringData(ResultSet results) {
        StringData wuStringData = new StringData();
        try {
            if (results.next()) { // we are expecting only one rec in result set, so while loop not needed.
                wuStringData.webUserId = FormatUtils.objectToString(results.getObject("web_user_id"));
                wuStringData.userEmail = FormatUtils.objectToString(results.getObject("user_email"));
                wuStringData.userPw = FormatUtils.objectToString(results.getObject("user_password"));
                wuStringData.userPw2 = wuStringData.userPw;
                wuStringData.membershipFee = FormatUtils.objectToString(results.getObject("membership_fee"));
                wuStringData.userRoleId = FormatUtils.objectToString(results.getObject("user_role_id"));
                wuStringData.birthday = FormatUtils.formatDate(results.getObject("birthday"));
                wuStringData.recordStatus = "Record Found";

                System.out.println("*** WebUserMods.extractResultSetToStringData: record values are "
                        + wuStringData.toString());

                return wuStringData; // means OK, record found and wu has been filled
            } else {
                wuStringData.recordStatus = "Record Not Found";
                return wuStringData; // not found, all fields will be blank
            }
        } catch (Exception e) {
            System.out.println("*** WebUserMods.extractResultSetToStringData() Exception: " + e.getMessage());
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

        TypedData wuTypedData = (TypedData) validate.getTypedData();
        String sql = "UPDATE web_user SET user_email=? "
                + ", user_password=?, membership_fee=?, user_role_id=? "
                + ", birthday=? where web_user_id = ?";

        try {
            PreparedStatement sqlSt = dbc.getConn().prepareStatement(sql);
            debugMsg += "<br/>Sql was: " + sql;
            debugMsg += "<br/>" + DbEncodeUtils.encodeString(sqlSt, 1, wuTypedData.getUserEmail());
            debugMsg += "<br/>" + DbEncodeUtils.encodeString(sqlSt, 2, wuTypedData.getUserPw());
            debugMsg += "<br/>" + DbEncodeUtils.encodeDecimal(sqlSt, 3, wuTypedData.getMembershipFee());
            debugMsg += "<br/>" + DbEncodeUtils.encodeInteger(sqlSt, 4, wuTypedData.getUserRoleId());
            debugMsg += "<br/>" + DbEncodeUtils.encodeDate(sqlSt, 5, wuTypedData.getBirthday());
            debugMsg += "<br/>" + DbEncodeUtils.encodeInteger(sqlSt, 6, wuTypedData.getWebUserId());

            //System.out.println("******* Trying to update Web User with id: ["+ wu.getIdWebUser() + "]");
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
                //e.printStackTrace();
                return this.errorMsg;
            } // catch
            catch (Exception e) {
                this.errorMsg = "SqlMods.update: General Exception during update operation. "
                        + e.getMessage();
                System.out.println(this.errorMsg);
                //e.printStackTrace();
                return this.errorMsg;
            } // catch
        } // try
        catch (Exception e) {
            this.errorMsg = "SqlMods.update: Problem Compiling Prepared Statement. "
                    + e.getMessage();
            System.out.println(this.errorMsg);
            //e.printStackTrace();
            return this.errorMsg;
        } // catch
    }// method

    /*
     * Find the webUser record that has the given primary key. If found, return
     * true and fill up the WebUser object with found data, otherwise, return
     * false.
     *
     * @param email (input) the email address of the record to be found.
     * @param password (input) the password potentially associated with the
     *      email address provided.
     * @param webuserStringData (output) the found record (if the record was found).
     * @return returns true if record was found, false otherwise.
     */
    public StringData findLogonUser(String email, String password) {
        StringData webUserStringData = new StringData();
        this.errorMsg = "";     //clean any existing error messages

        try {
            String sql = "SELECT *  FROM web_user WHERE user_email = ? and user_password = ?";
            PreparedStatement sqlSt = dbc.getConn().prepareStatement(sql);
            sqlSt.setString(1, email);
            sqlSt.setString(2, password);

            try {
                ResultSet results = sqlSt.executeQuery(); // expecting only one row in result set
                webUserStringData = this.extractResultSetToStringData(results);//

                if (webUserStringData != null) {
                    System.out.println("*** WebUserMods.findLogon: Web User (found or not found) is " + webUserStringData.toString());
                    return webUserStringData; // if stringData is full, record found. else all fields will be blank "".
                } else { // stringData null means there was a problem extracting data
                    // check the System.out message in the log to see exact exception error msg.
                    return null;
                }
            } catch (Exception e) {
                this.errorMsg = e.getMessage();
                System.out.println("*** WebUserMods.findLogon: exception thrown running Select Statement " + email
                        + ". Error is: " + this.errorMsg);
                return null;
            }
        }// try
        catch (Exception e) {
            this.errorMsg = e.getMessage();
            System.out.println("*** WebUserMods.findLogon: exception thrown Preparing Select Statement with PK " + email
                    + ". Error is: " + this.errorMsg);
            return null;
        }
    } // method    

} // class
