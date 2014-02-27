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
             String sql = "select web_user_id, user_email, user_password, membership_fee, user_role_id, birthday from web_user";
            stmt = dbc.getConn().prepareStatement(sql);
            results = stmt.executeQuery();
            //sb.append("executed the query " + "<br/><br/>");
            sb.append("<table class='");
            sb.append(cssClassForResultSetTable);
            sb.append("'>");
            sb.append("<tr>");
            sb.append("<th style='text-align:right'>User ID</th>");
            sb.append("<th style='text-align:left'>User Email</th>");
            sb.append("<th style='text-align:left'>User Password</th>");
            sb.append("<th style='text-align:right'>Membership Fee</th>");
            sb.append("<th style='text-align:right'>User Role</th>");
            sb.append("<th style='text-align:center'>Birthday</th></tr>");
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
            return "Exception thrown in WebUserSql.listAllUsers(): " + e.getMessage()
                    + "<br/> partial output: <br/>" + sb.toString();
        }
    }
}
