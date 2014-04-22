package validationUtils;

public class ValidateDecimal {

    private java.math.BigDecimal convertedDecimal = null;
    private String error = "";

    /* Check string "val" to see if it has a valid decimal in it.
     * if required is false, "" (empty string is OK), convertedDecimal => null.
     *
     * error holds "" if value passes validation.
     */
    public ValidateDecimal(String val, boolean required) {
        this.convertedDecimal = null;
        if (val == null) {
            this.error = "Programmer error: should not be trying to validate "
                    + "null in ValidateDecimal constructor";
            return;
        }
        if ((val.length() == 0) && !required) {
            this.error = "";  // Since this field is not required, empty string is valid user entry.
            return;
        }
        try {
            this.convertedDecimal = new java.math.BigDecimal(val);
            this.error = "";
        } catch (Exception e) {
            this.error = "Please enter an dollar amount";
        }
    }

    public String getError() {
        return this.error;
    }

    public java.math.BigDecimal getConvertedDecimal() {
        return this.convertedDecimal;
    }
} // class

