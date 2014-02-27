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
            //sb.append("ready to create the statement & execute query " + "<br/>");
             String sql = "select trip_id, title, description, days_spent, "
                     + "user_name, park_name, photos_url, gps_url "
                     + "from web_user, trip_reports, parks"
                     + "WHERE web_user.web_user_id = trip_reports.web_user_id"
                     + "and parks.park_id = trip_reports.park_id ";
            stmt = dbc.getConn().prepareStatement(sql);
            results = stmt.executeQuery();
            //sb.append("executed the query " + "<br/><br/>");
            sb.append("<table class='");
            sb.append(cssClassForResultSetTable);
            sb.append("'>");
            sb.append("<tr>");
            sb.append("<th style='text-align:right'>Trip ID</th>");
            sb.append("<th style='text-align:left'>Title</th>");
            sb.append("<th style='text-align:left'>Description</th>");
            sb.append("<th style='text-align:right'>Days Spent</th>");
            sb.append("<th style='text-align:right'>Date</th>");
            sb.append("<th style='text-align:right'>Submitted By</th>");
            sb.append("<th style='text-align:right'>Park Name</th>");
            sb.append("<th style='text-align:center'>Photos</th></tr>");
            sb.append("<th style='text-align:center'>GPS</th></tr>");
            while (results.next()) {
                sb.append("<tr>");
                sb.append(FormatUtils.formatIntegerTd(results.getObject("web_user_id")));
                sb.append(FormatUtils.formatStringTd(results.getObject("user_email")));
                sb.append(FormatUtils.formatStringTd(results.getObject("user_password")));
                sb.append(FormatUtils.formatDollarTd(results.getObject("membership_fee")));
                sb.append(FormatUtils.formatIntegerTd(results.getObject("user_role_id")));
                sb.append(FormatUtils.formatDateTd(results.getObject("birthday")));
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
}
