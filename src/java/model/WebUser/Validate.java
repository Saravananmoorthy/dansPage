package model.WebUser;

import validationUtils.*;

/* This class validates a WebUser object (bundle of pre-validated user entered string values)
 * and saves the validated data into a TypedData object (bundle of typed data values).
 * This class provides one error message per field in a WebUser object.
 * This class demonstrates the use of "object composition" and
 * "Single Responsibility" software design principles.
 */
public class Validate {

    // validation error messages, one per field to be validated
    private String userEmailMsg = "";
    private String userPwMsg = "";
    private String userPw2Msg = "";
    private String membershipFeeMsg = "";
    private String userRoleMsg = "";
    private String birthdayMsg = "";

    private boolean isValidated = false; // true iff all fields validate ok.
    private String debugMsg = "";

    // Web User data fields from form (all String, pre-validation), bundled in this object
    private StringData wu = new StringData();

    // Web User data fields after validation (various data types), bundled into this object
    private TypedData wut = new TypedData();

    // default constructor is good for first rendering 
    //   -- all error messages are set to "" (empty string).
    public Validate() {
    }

    public Validate(StringData wu) {
        // validationUtils method validates each user input (String even if destined for other type) from WebUser object
        // side effect of validationUtils method puts validated, converted typed value into TypedData object
        this.wu = wu;

        if (wu.webUserId != null && wu.webUserId.length() != 0) {
            ValidateInteger vi = new ValidateInteger(wu.webUserId, true);
            wut.setWebUserId(vi.getConvertedInteger());
        }

        ValidateString vstr = new ValidateString(wu.userEmail, 45, true);
        wut.setUserEmail(vstr.getConvertedString());
        this.userEmailMsg = vstr.getError();

        vstr = new ValidateString(wu.userPw, 45, true);
        wut.setUserPw(vstr.getConvertedString());
        this.userPwMsg = vstr.getError();

        vstr = new ValidateString(wu.userPw2, 45, true);
        wut.setUserPw2(vstr.getConvertedString());
        if (wut.getUserPw().compareTo(wut.getUserPw2()) != 0) {
            this.userPw2Msg = "Both passwords must match.";
        }

        ValidateDecimal vdec = new ValidateDecimal(wu.membershipFee, false);
        wut.setMembershipFee(vdec.getConvertedDecimal());
        this.membershipFeeMsg = vdec.getError();

        ValidateInteger vi = new ValidateInteger(wu.userRoleId, true);
        wut.setUserRoleId(vi.getConvertedInteger());
        this.userRoleMsg = vi.getError();

        ValidateDate vdate = new ValidateDate(wu.birthday, false);
        wut.setBirthday(vdate.getConvertedDate());
        this.birthdayMsg = vdate.getError();

        String allMessages = this.userEmailMsg + this.userPwMsg
                + this.userPw2Msg + this.membershipFeeMsg
                + this.userRoleMsg + this.birthdayMsg;
        isValidated = (allMessages.length() == 0);
    }

    public StringData getStringData() {
        return this.wu;
    }

    public TypedData getTypedData() {
        return this.wut;
    }

    public String getUserEmailMsg() {
        return this.userEmailMsg;
    }

    public String getUserPwMsg() {
        return this.userPwMsg;
    }

    public String getUserPw2Msg() {
        return this.userPw2Msg;
    }

    public String getMembershipFeeMsg() {
        return this.membershipFeeMsg;
    }

    public String getUserRoleMsg() {
        return this.userRoleMsg;
    }

    public String getBirthdayMsg() {
        return this.birthdayMsg;
    }

    public boolean isValidated() {
        return this.isValidated;
    }

    public String getDebugMsg() {
        return this.debugMsg;
    }

    public String getAllValidationErrors() {
        String allMessages = "userEmail error: " + this.userEmailMsg
                + ", userPw error: " + this.userPwMsg
                + ", userPw2 error: " + this.userPw2Msg
                + ", membershipFee error: " + this.membershipFeeMsg
                + ", userRoleMsg error: " + this.userRoleMsg
                + ", dateAdded error: " + this.birthdayMsg;
        return allMessages;
    }
} // class
