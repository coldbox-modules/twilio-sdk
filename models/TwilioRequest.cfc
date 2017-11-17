component {

    property name="hyper" inject="TwilioHyperClient";

    function init() {
        return this;
    }

    function onMissingMethod( missingMethodName, missingMethodArguments ) {
        return invoke( hyper, missingMethodName, missingMethodArguments );
    }

}