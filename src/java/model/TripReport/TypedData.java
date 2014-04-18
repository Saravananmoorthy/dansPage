package model.TripReport;

/* This class just bundles together all the pre-validated String values that a 
 * user might enter as part of a Web_User record. 
 */
public class TypedData {

    private Integer tripId = null;
    private String tripTitle = "";
    private String tripDescription = "";
    private java.math.BigDecimal numDaysSpent = null;
    private String photosURL = "";
    private String gpsURL = "";
    private java.sql.Date tripDate = null;
    
    
    
    public String displayHTML() {
        return buildDisplay("<br>");
    }

    public String displayLog() {
        return buildDisplay("\n");
    }

    // pass in "\n" for newline, "<br/>" if to be displayed on jsp page.
    public String buildDisplay(String newLineString) {
        return newLineString
                + "Trip record" + newLineString
                + "==============" + newLineString
                + "tripId: " + myToString(this.getTripId()) + newLineString
                + "tripTitle: " + myToString(this.getTripTitle()) + newLineString
                + "tripDescription" + myToString(this.getTripDescription()) + newLineString
                + "numDaysSpent: " + myToString(this.getNumDaysSpent()) + newLineString
                + "photosURL: " + myToString(this.getPhotosURL()) + newLineString
                + "gpsURL: " + myToString(this.getGpsURL()) + newLineString
                + "tripDate: " + myToString(this.getTripDate()) + newLineString;
    }

    private String myToString(Object obj) {
        if (obj == null) {
            return "null";
        } else {
            return obj.toString();
        }
    }

    
    /**
     * @return the tripId
     */
    public Integer getTripId() {
        return tripId;
    }

    /**
     * @param tripId the tripId to set
     */
    public void setTripId(Integer tripId) {
        this.tripId = tripId;
    }
    
    /**
     * @return the tripTitle
     */
    public String getTripTitle() {
        return tripTitle;
    }

    /**
     * @param tripTitle the tripTitle to set
     */
    public void setTripTitle(String tripTitle) {
        this.tripTitle = tripTitle;
    }

    /**
     * @return the tripDescription
     */
    public String getTripDescription() {
        return tripDescription;
    }

    /**
     * @param tripDescription the tripDescription to set
     */
    public void setTripDescription(String tripDescription) {
        this.tripDescription = tripDescription;
    }
    
    /**
     * @return the photosURL
     */
    public String getPhotosURL() {
        return photosURL;
    }

    /**
     * @param photosURL the photosURL to set
     */
    public void setPhotosURL(String photosURL) {
        this.photosURL = photosURL;
    }
    
     /**
     * @return the gpsURL
     */
    public String getGpsURL() {
        return gpsURL;
    }

    /**
     * @param gpsURL the gpsURL to set
     */
    public void setGpsURL(String gpsURL) {
        this.gpsURL = gpsURL;
    }

    /**
     * @return the numDaysSpent
     */
    public java.math.BigDecimal getNumDaysSpent() {
        return numDaysSpent;
    }

    /**
     * @param numDaysSpent the numDaysSpent to set
     */
    public void setNumDaysSpent(java.math.BigDecimal numDaysSpent) {
        this.numDaysSpent = numDaysSpent;
    }
    
     /**
     * @return the tripDate
     */
    public java.sql.Date getTripDate() {
        return tripDate;
    }

    /**
     * @param tripDate the tripDate to set
     */
    public void setTripDate(java.sql.Date tripDate) {
        this.tripDate = tripDate;
    }
}