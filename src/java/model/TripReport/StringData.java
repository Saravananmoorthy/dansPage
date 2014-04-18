package model.TripReport;

public class StringData {

    public String tripId = "";
    public String tripTitle = "";
    public String tripDescription = "";
    public String numDaysSpent = "";
    public String photosURL = "";
    public String gpsURL = "";
    public String webUserId = "";
    public String parkId = "";
    public String tripDate = "";
    public String recordStatus = "default"; // will be used later when doing ajax

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
     * @return the numDaysSpent
     */
    public String getNumDaysSpent() {
        return numDaysSpent;
    }

    /**
     * @param numDaysSpent the numDaysSpent to set
     */
    public void setNumDaysSpent(String numDaysSpent) {
        this.numDaysSpent = numDaysSpent;
    }


    /**
     * @return the tripId
     */
    public String getTripId() {
        return tripId;
    }

    /**
     * @param tripId the tripId to set
     */
    public void setTripId(String tripId) {
        this.tripId = tripId;
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
     * @return the webUserId
     */
    public String getWebUserId() {
        return webUserId;
    }

    /**
     * @param webUserId the webUserId to set
     */
    public void setWebUserId(String webUserId) {
        this.webUserId = webUserId;
    }
    
    /**
     * @return the parkId
     */
    public String getParkId() {
        return parkId;
    }

    /**
     * @param parkId the parkId to set
     */
    public void setParkId(String parkId) {
        this.parkId = parkId;
    }
    
    /**
     * @return the tripDate
     */
    public String getTripDate() {
        return tripDate;
    }

    /**
     * @param tripDate the tripDate to set
     */
    public void setTripDate(String tripDate) {
        this.tripDate = tripDate;
    }
    
    /**
     * @return the recordStatus
     */
    public String getRecordStatus() {
        return recordStatus;
    }

    /**
     * @param recordStatus the recordStatus to set
     */
    public void setRecordStatus(String recordStatus) {
        this.recordStatus = recordStatus;
    }

    @Override
    public String toString() {
        return "tripId[" + valueOrNull(tripId) + "] tripTitle[" + valueOrNull(tripTitle)
                + "] tripDescription[" + valueOrNull(tripDescription) + "] numDaysSpent[" 
                + valueOrNull(numDaysSpent) + "] tripDate[" + valueOrNull(tripDate) 
                + "] webUserId[" + valueOrNull(webUserId) + "] parkId["
                + valueOrNull(parkId) + "] photosURL[" + valueOrNull(photosURL)
                + "] gpsURL[" + valueOrNull(gpsURL)
                + "] recordStatus[" + valueOrNull(recordStatus) + "]";
    } // toString()

    private String valueOrNull(String in) {
        if (in == null) {
            return "null";
        }
        return in;
    }

    public String toJSON() {
        return "({ tripId: '" + valueOrNull(tripId) + "', tripTitle: '" + valueOrNull(tripTitle)
                + "', tripDescription: '" + valueOrNull(tripDescription) + "', "
                + "numDaysSpent: '" + valueOrNull(numDaysSpent) + "', tripDate:" + valueOrNull(tripDate) 
                + "', webUserId:" + valueOrNull(webUserId) + "', parkId:"
                + valueOrNull(parkId) + "', photosURL:" + valueOrNull(photosURL)
                + "', gpsURL:" + valueOrNull(gpsURL)
                + "', recordStatus: '" + valueOrNull(recordStatus) + "' })";
    }
} // class