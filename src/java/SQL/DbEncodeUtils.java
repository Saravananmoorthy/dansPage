package SQL;

import java.math.BigDecimal;
import java.sql.PreparedStatement;

/* DbEncodeUtils: a class with one method per data type. Each method takes a string (that 
 * should have been already validated, converts it into the correct data type, and encodes 
 * the newly converted data into the prepared statement (sql statement).
 */
public class DbEncodeUtils {

    /** convert encode val (a date) into the (Integer)-th position of Prepared statement.
    mostly checking if null, need to encode that specially. */
    public static String encodeDate(PreparedStatement ps, int position, java.sql.Date val) {
        String msg = "EncodeForDbUtils.encodeDate ";
        if (val == null) {
            try {
                ps.setNull(position, java.sql.Types.DATE);
                //System.out.println("**** DbEncodeUtils.encodeDate(): sucessfully encoded null (Date) value into position number "
                //       + position + " of prepared statement.");
                msg = ""; // all is good.
            } catch (Exception e) {
                msg = "**** EncodeForDbUtils.encodeDate():  exception trying to encode null (Date) into position number "
                        + position + " of prepared sql statement. Error: " + e.getMessage();
                //System.out.println(msg);
            }
        } else {
            try {
                ps.setDate(position, val);
                //System.out.println("**** DbEncodeUtils.encodeDate(): sucessfully encoded (Date) value [" + val.toString() + "] into position "
                //        + position + " of prepared sql statement.";
                msg = ""; // all is good.
            } catch (Exception e) {
                msg = "**** EncodeForDbUtils.encodeDate(): exception trying to encode (Date) value [" + val.toString()
                        + "] into position " + position
                        + " of prepared sql statement. Exception: "
                        + e.getMessage();
                //System.out.println(msg);
            } // catch
        } // else
        return msg;
    }// method

    /** convert encode val into (Integer) position of Prepared statement */
    public static String encodeInteger(PreparedStatement ps, int position, Integer val) {
        String msg = "EncodeForDbUtils.encodeInteger ";
        if (val == null) {
            try {
                ps.setNull(position, java.sql.Types.INTEGER);
                //System.out.println("**** DbEncodeUtils.encodeInteger(): sucessfully encoded null (Integer) into position number "
                //        + position + " of prepared statement.");
                msg = ""; // all is good. 
            } catch (Exception e) {
                msg = "**** EncodeForDbUtils.encodeInteger(): exception trying to encode null (Integer) into position number "
                        + position + " of prepared sql statement. Error: " + e.getMessage();
                //System.out.println(msg);
            }
        } else {
            try {
                ps.setInt(position, val);
                //System.out.println("**** DbEncodeUtils.encodeInteger(): sucessfully encoded (Integer) value [" + val + "] into position "
                //        + position + " of prepared sql statement.";
                msg = "";//all is good
            } catch (Exception e) {
                msg = "**** EncodeForDbUtils.encodeInteger(): exception trying to encode value [" + val
                        + "] into (Integer) position " + position
                        + " of prepared sql statement. Exception: "
                        + e.getMessage();
                //System.out.println(msg);
            } // catch
        } // else
        return msg;
    }// method

    /** convert encode val into (Decimal) position of Prepared statement */
    public static String encodeDecimal(PreparedStatement ps, int position, BigDecimal val) {
        String msg = "EncodeForDbUtils.encodeDecimal ";
        if (val == null) {
            try {
                ps.setNull(position, java.sql.Types.DECIMAL);
                //msg += "sucessfully encoded null (Decimal) into position number "
                //       + position + " of prepared statement.";
                msg = ""; // all is good. 
            } catch (Exception e) {
                msg = "**** EncodeForDbUtils.encodeDecimal(): exception trying to encode null (Decimal) into position number "
                        + position + " of prepared sql statement. Error: " + e.getMessage();
            }
        } else {
            try {
                ps.setBigDecimal(position, val);
                //msg = "sucessfully encoded value [" + val.toString() + "] into (Decimal) position "
                //        + position + " of prepared sql statement.";
                msg = ""; // all is good. 
            } catch (Exception e) {
                msg = "**** EncodeForDbUtils.encodeDecimal(): exception trying to encode value [" + val.toString()
                        + "] into (Decimal) position " + position
                        + " of prepared sql statement. Error: "
                        + e.getMessage();
            } // catch
        } // else
        return msg;
    }// method

    /** convert encode val into (String) position of Prepared statement */
    public static String encodeString(PreparedStatement ps, int position, String val) {
        String msg = "EncodeForDbUtils.encodeString ";
        if (val == null) {
            val = "";
            msg += "null String was converted to empty String. ";
        }
        try {
            ps.setString(position, val);
            //msg += "sucessfully encoded value [" + val + "] into (String) position "
            //        + position + " of prepared sql statement.";
            msg = ""; // all is good
        } catch (Exception e) {
            msg += "EncodeForDbUtils.encodeString(): threw exception trying to encode value [" + val
                    + "] into (String) position " + position
                    + " of prepared sql statement. Exception: "
                    + e.getMessage();
        } // catch
        return msg;
    }// method
} // class