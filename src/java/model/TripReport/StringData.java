package model.TripReport;

import model.TripReport.*;

public class StringData {

    public String tripId = "";
    public String tripTitle = "";
    public String tripDescription = "";
    public String numDaysSpent = "";
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
        return "parkId[" + valueOrNull(tripId) + "] parkName[" + valueOrNull(tripTitle)
                + "] overNightFee[" + valueOrNull(tripDescription) + "] stateName[" + valueOrNull(numDaysSpent)
                + "] recordStatus[" + valueOrNull(recordStatus) + "]";
    } // toString()

    private String valueOrNull(String in) {
        if (in == null) {
            return "null";
        }
        return in;
    }

    public String toJSON() {
        return "({ parkId: '" + valueOrNull(tripId) + "', parkName: '" + valueOrNull(tripTitle)
                + "', overNightFee: '" + valueOrNull(tripDescription) + "', stateName: '" + valueOrNull(numDaysSpent)
                + "', recordStatus: '" + valueOrNull(recordStatus) + "' })";
    }
} // class