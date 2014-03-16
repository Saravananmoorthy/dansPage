package validationUtils;

public class ValidateString {

    private String convertedString = "";
    private String error = "";

    /* Check string "val" to see if it is less than the max length
     * and also if it has at least one character (if required is true).
     *
     * error will provide the validation error for the user.
     * convertedString will be the truncated string (if necessary) or
     * empty string (if original value was null).
     */
    public ValidateString(String val, int maxlen, boolean required) {

        this.convertedString = "";
        if (val == null) {
            this.error = "Null not accepted as String Input";
            return;
        }
        if (val.length() == 0) {
            if (required) {
                this.error = "Input is required";
                return;
            } else {
                this.error = ""; // Empty string OK if fld not req'd.
                return;
            }
        }
        if (val.length() > maxlen) {
            this.convertedString = val.substring(0, maxlen);
            this.error = "Please shorten to [" + convertedString + "]";
        }
        this.convertedString = val;
        this.error = "";  // any other input is OK
    }

    public String getError() {
        return this.error;
    }

    public String getConvertedString() {
        return this.convertedString;
    }
} // class

