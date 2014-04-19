package model.TripReport;

import validationUtils.*;

/* This class validates a Parks object (bundle of pre-validated user entered string values)
 * and saves the validated data into a TypedData object (bundle of typed data values).
 * This class provides one error message per field in a Parks object.
 * This class demonstrates the use of "object composition" and
 * "Single Responsibility" software design principles.
 */
public class Validate {

    // validation error messages, one per field to be validated
    private String tripTitleMsg = "";
    private String tripDescriptionMsg = "";
    private String numDaysSpentMsg = "";
    private String photosURLMsg = "";
    private String gpsURLMsg = "";
    private String tripDateMsg = "";
    private String parkIdMsg = "";
    private String webUserIdMsg = "";

    private boolean isValidated = false; // true iff all fields validate ok.
    private String debugMsg = "";

    // Web User data fields from form (all String, pre-validation), bundled in this object
    private StringData trip = new StringData();

    // Web User data fields after validation (various data types), bundled into this object
    private TypedData tripT = new TypedData();

    // default constructor is good for first rendering 
    //   -- all error messages are set to "" (empty string).
    public Validate() {
    }

    public Validate(StringData trip) {
        // validationUtils method validates each user input (String even if destined for other type) from WebUser object
        // side effect of validationUtils method puts validated, converted typed value into TypedData object
        this.trip = trip;

        if (trip.tripId != null && trip.tripId.length() != 0) {
            ValidateInteger vi = new ValidateInteger(trip.tripId, true);
            tripT.setTripId(vi.getConvertedInteger());
        }

        ValidateString vstr = new ValidateString(trip.tripTitle, 64, true);
        tripT.setTripTitle(vstr.getConvertedString());
        this.tripTitleMsg = vstr.getError();

        vstr = new ValidateString(trip.tripDescription, 512, true);
        tripT.setTripDescription(vstr.getConvertedString());
        this.tripDescriptionMsg = vstr.getError();

        vstr = new ValidateString(trip.photosURL, 128, false);
        tripT.setPhotosURL(vstr.getConvertedString());
        this.photosURLMsg = vstr.getError();

        vstr = new ValidateString(trip.gpsURL, 128, false);
        tripT.setGpsURL(vstr.getConvertedString());
        this.gpsURLMsg = vstr.getError();

        ValidateInteger vint = new ValidateInteger(trip.numDaysSpent, false);
        tripT.setNumDaysSpent(vint.getConvertedInteger());
        this.numDaysSpentMsg = vint.getError();

        vint = new ValidateInteger(trip.parkId, false);
        tripT.setParkId(vint.getConvertedInteger());
        this.parkIdMsg = vint.getError();

        vint = new ValidateInteger(trip.webUserId, false);
        tripT.setWebUserId(vint.getConvertedInteger());
        this.webUserIdMsg = vint.getError();

        ValidateDate vdate = new ValidateDate(trip.tripDate, false);
        tripT.setTripDate(vdate.getConvertedDate());
        this.tripDateMsg = vdate.getError();

        String allMessages = this.tripTitleMsg + this.numDaysSpentMsg
                + this.tripDescriptionMsg + this.tripDateMsg
                + this.photosURLMsg + this.gpsURLMsg;
        isValidated = (allMessages.length() == 0);
    }

    public StringData getStringData() {
        return this.trip;
    }

    public TypedData getTypedData() {
        return this.tripT;
    }

    public String getTripTitleMsg() {
        return this.tripTitleMsg;
    }

    public String getNumDaysSpentMsg() {
        return this.numDaysSpentMsg;
    }

    public String getTripDescriptionMsg() {
        return this.tripDescriptionMsg;
    }

    public String getPhotosURLMsg() {
        return this.photosURLMsg;
    }

    public String getGpsURLMsg() {
        return this.gpsURLMsg;
    }

    public String getTripDateMsg() {
        return this.tripDateMsg;
    }

    public String getParkIdMsg() {
        return this.parkIdMsg;
    }

    public String getWebUserIdMsg() {
        return this.webUserIdMsg;
    }

    public boolean isValidated() {
        return this.isValidated;
    }

    public String getDebugMsg() {
        return this.debugMsg;
    }

    public String getAllValidationErrors() {
        String allMessages = "tripTitle error: " + this.tripTitleMsg
                + ", tripDescripton error: " + this.tripDescriptionMsg
                + ", numDaysSpent error: " + this.numDaysSpentMsg
                + ", photosURL error: " + this.photosURLMsg
                + ", gpsURL error: " + this.gpsURLMsg
                + ", tripDate error: " + this.tripDateMsg
                + ", parkId error: " + this.parkIdMsg
                + ", webUserId error: " + this.webUserIdMsg;
        return allMessages;
    }
} // class
