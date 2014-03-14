package view;

// classes imported from java.sql.*
import java.sql.PreparedStatement;
import java.sql.ResultSet;

// classes in my project
import SQL.DbConn;
import SQL.FormatUtils;
 
public class TripReportView {

    /* This method returns a HTML table displaying all the records of the web_user table. 
     * cssClassForResultSetTable: the name of a CSS style that will be applied to the HTML table.
     *   (This style should be defined in the JSP page (header or style sheet referenced by the page).
     * dbc: an open database connection.
     */
    public static String listAllTrips(String cssClassForResultSetTable, DbConn dbc) {
        StringBuilder sb = new StringBuilder("");
        PreparedStatement stmt = null;
        ResultSet results = null;
        try {
             String sql = "select trip_id, title, days_spent, date, "
                     + "user_email, park_name, photos_url "
                     + "FROM web_user, trip_reports, parks "
                     + "WHERE web_user.web_user_id = trip_reports.web_user_id "
                     + "and parks.park_id = trip_reports.park_id "
                     + "ORDER BY trip_id";
            stmt = dbc.getConn().prepareStatement(sql);
            results = stmt.executeQuery();
            sb.append("<table class='");
            sb.append(cssClassForResultSetTable);
            sb.append("'>");
            sb.append("<tr>");
            sb.append("<th>Trip ID</th>");
            sb.append("<th>Title</th>");
            //sb.append("<th style='text-align:left'>Description</th>");
            sb.append("<th>Days Spent</th>");
            sb.append("<th>Date</th>");
            sb.append("<th>Submitted By</th>");
            sb.append("<th>Park Name</th>");
            sb.append("<th>Photos</th></tr>");
            //sb.append("<th class='tableHeader'>GPS</th></tr>");
            while (results.next()) {
                sb.append("<tr>");
                sb.append(FormatUtils.formatIntegerTd(results.getObject("trip_id")));
                sb.append(FormatUtils.formatStringTd(results.getObject("title")));
                //sb.append(FormatUtils.formatStringTd(results.getObject("description")));
                //Description excluded because it makes for a very unbalanced table
                sb.append(FormatUtils.formatIntegerTd(results.getObject("days_spent")));
                sb.append(FormatUtils.formatDateTd(results.getObject("date")));
                sb.append(FormatUtils.formatStringTd(results.getObject("user_email")));
                sb.append(FormatUtils.formatStringTd(results.getObject("park_name")));
                sb.append(FormatUtils.formatStringTd(results.getObject("photos_url")));
                //sb.append(FormatUtils.formatStringTd(results.getObject("gps_url")));
                sb.append("</tr>\n");
            }
            sb.append("</table>");
            results.close();
            stmt.close();
            return sb.toString();
        } catch (Exception e) {
            return "Exception thrown in TripReportSql.listAllTrips(): " + e.getMessage()
                    + "<br/> partial output: <br/>" + sb.toString();
        }
    }
/* This method returns a HTML table displaying all the records of the web_user table. 
     * cssClassForResultSetTable: the name of a CSS style that will be applied to the HTML table.
     *   (This style should be defined in the JSP page (header or style sheet referenced by the page).
     * delFn:  the name of a javascript function in the JSP page, a function that expects an
     *   input parameter (String) which is the id of the web_user record to be deleted.
     * delIcon: the name of the file that holds the delete icon (to be repeated for each web_user record).
     * dbc: an open database connection.
     */
    public static String listDelUsers(String cssClassForResultSetTable, DbConn dbc,
            String delFn, String delIcon) {

        // Prepare some HTML that will be used repeatedly for the delete icon that
        // calls a delete javascript function (see below).
        if ((delIcon == null) || (delIcon.length() == 0)) {
            return "WebUserSql.listAllUsers() error: delete Icon file name (String input parameter) is null or empty.";
        }
        if ((delFn == null) || (delFn.length() == 0)) {
            return "WebUserSql.listAllUsers() error: delete javascript function name (String input parameter) is null or empty.";
        }

        // This is the first half of the HTML that defines a table cell that will hold the delete
        // icon which will be linked to a javascript function for deleting the current row.
        String delStart = "<td style='border:none; text-align:center; background-color:transparent;'><a href='" + delFn + "(";
        // This is the HTML for the second half of that same HTML
        // In between the first half and the second half will be the actual PK of the current row
        // (input parameter to the javascript function).
        String delEnd = ")'><img src='" + delIcon + "'></a></td>"; // after PK value/input parameter to js fn.

        // use StringBuilder object instead of plain String because it is more efficient
        // (with all the appending that we are doing here).
        StringBuilder sb = new StringBuilder("");

        PreparedStatement stmt = null;
        ResultSet results = null;
        try {
            String sql = "select trip_id, title, days_spent, date, "
                     + "user_email, park_name, photos_url "
                     + "FROM web_user, trip_reports, parks "
                     + "WHERE web_user.web_user_id = trip_reports.web_user_id "
                     + "and parks.park_id = trip_reports.park_id "
                     + "ORDER BY trip_id";
            stmt = dbc.getConn().prepareStatement(sql);
            results = stmt.executeQuery();
            sb.append("<table class='");
            sb.append(cssClassForResultSetTable);
            sb.append("'>");
            sb.append("<tr>");
            sb.append("<td style='border:none; text-align:center; background-color:transparent;'></td>");// extra column at left for delete icon
            
            sb.append("<th>Trip ID</th>");
            sb.append("<th>Title</th>");
            //sb.append("<th style='text-align:left'>Description</th>");
            sb.append("<th>Days Spent</th>");
            sb.append("<th>Date</th>");
            sb.append("<th>Submitted By</th>");
            sb.append("<th>Park Name</th>");
            sb.append("<th>Photos</th></tr>");

            while (results.next()) {
                // I'm pretty sure that you must call the getObject methods from the result
                // set in the same order as the columns you selected in your SQL SELECT.
                // And, you cannot read (do a getObject) on the same column more than once.
                // The result set is like sequential text file which you can only
                // read in order and you only get one shot reading each item.

                // since we want to use the primary key value several times, 
                // we save this object so we reuse it.
                Object primaryKeyObj = results.getObject(1);
                Integer primaryKeyInt = (Integer) primaryKeyObj;
                sb.append("<tr>");

                // this is the column with a delete icon that has a link to a javascript function.
                // the input parameter to the delete javascript function is the PK of the user in this row.
                sb.append(delStart + primaryKeyInt.toString() + delEnd);

                sb.append(FormatUtils.formatIntegerTd(results.getObject("trip_id")));
                sb.append(FormatUtils.formatStringTd(results.getObject("title")));
                //sb.append(FormatUtils.formatStringTd(results.getObject("description")));
                //Description excluded because it makes for a very unbalanced table
                sb.append(FormatUtils.formatIntegerTd(results.getObject("days_spent")));
                sb.append(FormatUtils.formatDateTd(results.getObject("date")));
                sb.append(FormatUtils.formatStringTd(results.getObject("user_email")));
                sb.append(FormatUtils.formatStringTd(results.getObject("park_name")));
                sb.append(FormatUtils.formatStringTd(results.getObject("photos_url")));
                //sb.append(FormatUtils.formatStringTd(results.getObject("gps_url")));
                
                sb.append("</tr>\n");
            }
            sb.append("</table>");
            results.close();
            stmt.close();
            return sb.toString();
        } catch (Exception e) {
            return "Exception thrown in WebUserSql.listAllUsers(): " + e.getMessage()
                    + "<br/> partial output: <br/>" + sb.toString();
        }
    }

}
