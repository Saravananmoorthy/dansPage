package model.Parks;

import model.Parks.*;

/* This class just bundles together all the pre-validated String values that a 
 * user might enter as part of a Web_User record. 
 */
public class TypedData {

    private Integer parkId = null;
    private String parkName = "";
    private java.math.BigDecimal overNightFee = null;
    private String stateName = "";
    
    
    public String displayHTML() {
        return buildDisplay("<br>");
    }

    public String displayLog() {
        return buildDisplay("\n");
    }

    // pass in "\n" for newline, "<br/>" if to be displayed on jsp page.
    public String buildDisplay(String newLineString) {
        return newLineString
                + "Park record" + newLineString
                + "==============" + newLineString
                + "parkId: " + myToString(this.getParkId()) + newLineString
                + "parkName: " + myToString(this.getParkName()) + newLineString
                + "overNightFee: " + myToString(this.getOverNightFee()) + newLineString
                + "stateName: " + myToString(this.getStateName()) + newLineString;
    }

    private String myToString(Object obj) {
        if (obj == null) {
            return "null";
        } else {
            return obj.toString();
        }
    }

    
    /**
     * @return the parkId
     */
    public Integer getParkId() {
        return parkId;
    }

    /**
     * @param parkId the parkId to set
     */
    public void setParkId(Integer parkId) {
        this.parkId = parkId;
    }
    
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
     * @return the stateName
     */
    public String getStateName() {
        return stateName;
    }

    /**
     * @param stateName the stateName to set
     */
    public void setStateName(String stateName) {
        this.stateName = stateName;
    }

    /**
     * @return the overNightFee
     */
    public java.math.BigDecimal getOverNightFee() {
        return overNightFee;
    }

    /**
     * @param overNightFee the overNightFee to set
     */
    public void setOverNightFee(java.math.BigDecimal overNightFee) {
        this.overNightFee = overNightFee;
    }
}