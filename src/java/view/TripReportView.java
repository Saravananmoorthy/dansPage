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
             String sql = "select trip_id, title, days_spent, date, "
                     + "user_email, park_name, photos_url "
                     + "FROM web_user, trip_reports, parks "
                     + "WHERE web_user.web_user_id = trip_reports.web_user_id "
                     + "and parks.park_id = trip_reports.park_id "
                     + "ORDER BY trip_id";
            stmt = dbc.getConn().prepareStatement(sql);
            results = stmt.executeQuery();
            //sb.append("executed the query " + "<br/><br/>");
            sb.append("<table class='cssClassForResultSetTable'>");
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
}
