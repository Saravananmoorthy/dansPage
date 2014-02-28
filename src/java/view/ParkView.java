package view;

// classes imported from java.sql.*
import java.sql.PreparedStatement;
import java.sql.ResultSet;

// classes in my project
import SQL.DbConn;
import SQL.FormatUtils;
 
public class ParkView {

    /* This method returns a HTML table displaying all the records of the web_user table. 
     * cssClassForResultSetTable: the name of a CSS style that will be applied to the HTML table.
     *   (This style should be defined in the JSP page (header or style sheet referenced by the page).
     * dbc: an open database connection.
     */
    public static String listAllParks(String cssClassForResultSetTable, DbConn dbc) {
        StringBuilder sb = new StringBuilder("");
        PreparedStatement stmt = null;
        ResultSet results = null;
        try {
            //sb.append("ready to create the statement & execute query " + "<br/>");
             String sql = "select park_id, park_name, overnight_fee, state_name "
                     + "FROM parks "
                     + "ORDER BY park_id";
            stmt = dbc.getConn().prepareStatement(sql);
            results = stmt.executeQuery();
            //sb.append("executed the query " + "<br/><br/>");
            sb.append("<table class='cssClassForResultSetTable'>");
            sb.append("<tr>");
            sb.append("<th style='text-align:right'>Park ID</th>");
            sb.append("<th style='text-align:left'>Park Name</th>");
            sb.append("<th style='text-align:left'>Fee</th>");
            sb.append("<th style='text-align:right'>State</th>");
            while (results.next()) {
                sb.append("<tr>");
                sb.append(FormatUtils.formatIntegerTd(results.getObject("park_id")));
                sb.append(FormatUtils.formatStringTd(results.getObject("park_name")));
                sb.append(FormatUtils.formatDollarTd(results.getObject("overnight_fee")));
                sb.append(FormatUtils.formatStringTd(results.getObject("state_name")));
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
