package model.Parks;

import validationUtils.*;

/* This class validates a Parks object (bundle of pre-validated user entered string values)
 * and saves the validated data into a TypedData object (bundle of typed data values).
 * This class provides one error message per field in a Parks object.
 * This class demonstrates the use of "object composition" and
 * "Single Responsibility" software design principles.
 */
public class Validate {

    // validation error messages, one per field to be validated
    private String parkNameMsg = "";
    private String overNightFeeMsg = "";
    private String stateNameMsg = "";

    private boolean isValidated = false; // true iff all fields validate ok.
    private String debugMsg = "";

    // Web User data fields from form (all String, pre-validation), bundled in this object
    private StringData park = new StringData();

    // Web User data fields after validation (various data types), bundled into this object
    private TypedData parkT = new TypedData();

    // default constructor is good for first rendering 
    //   -- all error messages are set to "" (empty string).
    public Validate() {
    }

    public Validate(StringData park) {
        // validationUtils method validates each user input (String even if destined for other type) from WebUser object
        // side effect of validationUtils method puts validated, converted typed value into TypedData object
        this.park = park;

        if (park.parkId != null && park.parkId.length() != 0) {
            ValidateInteger vi = new ValidateInteger(park.parkId, true);
            parkT.setParkId(vi.getConvertedInteger());
        }

        ValidateString vstr = new ValidateString(park.parkName, 45, true);
        parkT.setParkName(vstr.getConvertedString());
        this.parkNameMsg = vstr.getError();

        vstr = new ValidateString(park.stateName, 45, true);
        parkT.setStateName(vstr.getConvertedString());
        this.stateNameMsg = vstr.getError();

        ValidateDecimal vdec = new ValidateDecimal(park.overNightFee, false);
        parkT.setOverNightFee(vdec.getConvertedDecimal());
        this.overNightFeeMsg = vdec.getError();

        String allMessages = this.parkNameMsg + this.stateNameMsg + this.overNightFeeMsg;
        isValidated = (allMessages.length() == 0);
    }

    public StringData getStringData() {
        return this.park;
    }

    public TypedData getTypedData() {
        return this.parkT;
    }

    public String getParkNameMsg() {
        return this.parkNameMsg;
    }

    public String getStateNameMsg() {
        return this.stateNameMsg;
    }

    public String getOverNightFeeMsg() {
        return this.overNightFeeMsg;
    }

    public boolean isValidated() {
        return this.isValidated;
    }

    public String getDebugMsg() {
        return this.debugMsg;
    }

    public String getAllValidationErrors() {
        String allMessages = "parkName error: " + this.parkNameMsg
                + ", overNightFee error: " + this.overNightFeeMsg
                + ", stateName error: " + this.stateNameMsg;
        return allMessages;
    }
} // class
