package br.ibm.com.json.api;
/*
*
* IBM Confidential
*
* OCO Source Materials
*
* 5724-R46
*
* (C) COPYRIGHT IBM CORP. 2006,2007
*
* The source code for this program is not published or otherwise
* divested of its trade secrets, irrespective of what has been
* deposited with the U.S. Copyright Office.
*
*/
/**
 * The JSONException is thrown by the JSON.org classes then things are amiss.
 * @author JSON.org
 * @version 2008-09-18
 */
public class JSONException extends Exception {
    private Throwable cause;

    /**
     * Constructs a JSONException with an explanatory message.
     * @param message Detail about the reason for the exception.
     */
    public JSONException(String message) {
        super(message);
    }

    public JSONException(Throwable t) {
        super(t.getMessage());
        this.cause = t;
    }

    public Throwable getCause() {
        return this.cause;
    }
}
