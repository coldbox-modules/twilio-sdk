/**
 * Interact with the Twilio API
 */
component accessors="true" {

    /**
     * The configured account SID.
     * This can be overridden for subaccounts.
     */
    property name="accountSID" inject="coldbox:setting:accountSID@twilio-sdk";
    property name="wirebox" inject="wirebox" setter="false";

    function createSMS( to, from, body ) {
        return variables.newRequest()
            .setMethod( "POST" )
            .setUrl( "/Accounts/#accountSID#/Messages.json" )
            .setBody( {
                "From" = arguments.from,
                "To"   = arguments.to,
                "Body" = arguments.body
            } );
    }

    function sendSMS( to, from, body ) {
        return createSMS( argumentCollection = arguments ).send();
    }

    function newRequest() {
        return wirebox.getInstance( "TwilioHyperClient@twilio-sdk" );
    }

    function onMissingMethod( missingMethodName, missingMethodArguments ) {
        return invoke( variables.new(), missingMethodName, missingMethodArguments );
    }

}