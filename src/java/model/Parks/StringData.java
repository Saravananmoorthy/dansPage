package model.Parks;

import model.WebUser.*;

public class StringData {

    public String parkId = "";
    public String parkName = "";
    public String overNightFee = "";
    public String stateName = "";
    public String recordStatus = "default"; // will be used later when doing ajax

    /**
     * @return the parkName
     */
    public String getParkName() {
        return parkName;
    }

    /**
     * @param parkName the parkName to set
     */
    public void setParkName(String parkName) {
        this.parkName = parkName;
    }

    /**
     * @return the userPassword
     */
    public String getOverNightFee() {
        return overNightFee;
    }

    /**
     * @param userPassword the userPassword to set
     */
    public void setOverNightFee(String overNightFee) {
        this.overNightFee = overNightFee;
    }


    /**
     * @return the overNightFee2
     */
    public String getStateName() {
        return stateName;
    }

    /**
     * @param stateName the overNightFee2 to set
     */
    public void setStateName(String stateName) {
        this.stateName = stateName;
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
        return "parkId[" + valueOrNull(parkId) + "] parkName[" + valueOrNull(parkName)
                + "] overNightFee[" + valueOrNull(overNightFee) + "] stateName[" + valueOrNull(stateName)
                + "] recordStatus[" + valueOrNull(recordStatus) + "]";
    } // toString()

    private String valueOrNull(String in) {
        if (in == null) {
            return "null";
        }
        return in;
    }

    public String toJSON() {
        return "({ parkId: '" + valueOrNull(parkId) + "', parkName: '" + valueOrNull(parkName)
                + "', overNightFee: '" + valueOrNull(overNightFee) + "', stateName: '" + valueOrNull(stateName)
                + "', recordStatus: '" + valueOrNull(recordStatus) + "' })";
    }
} // class