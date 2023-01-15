<cfoutput>
    <div class="px-4">
        <script>window.linkToken="#encodeForJavascript( args.linkToken )#";</script>
    </div>
</cfoutput>

<!--
    Blatantly copied from https://plaid.com/docs/quickstart/#how-it-works
    Thanks Plaid! 😁😁😁
-->
<div class="container mx-auto py-10 mb-10">
    <button id="plaidLink" class="border-b-2 text-green">Link Account</button>
</div>
<script src="https://cdn.plaid.com/link/v2/stable/link-initialize.js"></script>
<script type="text/javascript">
var handler = Plaid.create({
    // Create a new link_token to initialize Link
    token: window.linkToken,
    onLoad: function() {
    // Optional, called when Link loads
    },
    onSuccess: function(public_token, metadata) {
        // Send the public_token to your app server.
        // The metadata object contains info about the institution the
        // user selected and the account ID or IDs, if the
        // Select Account view is enabled.
        const endpoint = "/plaid/exchange";
        let payload = {
            "public_token" : public_token
        };
        fetch( endpoint, {
            method : "POST",
            body : JSON.stringify( payload )
        } ).then( res => {
            // show handy message that they're all connected!
            console.log( "DUDE, you're all connected to Plaid! 😎😎😎" );
        }).catch( res => {
            // uh, log error?
            console.error( "Error sending public_token to Plaid 😠", res );
        });
    },
    onExit: function(err, metadata) {
        // The user exited the Link flow.
        if (err != null) {
            // The user encountered a Plaid API error prior to exiting.
            console.error( "Error connecting to Plaid 😠", err );
        }
        // metadata contains information about the institution
        // that the user selected and the most recent API request IDs.
        // Storing this information can be helpful for support.
    },
    onEvent: function(eventName, metadata) {
        // Optionally capture Link flow events, streamed through
        // this callback as your users connect an Item to Plaid.
        // For example:
        // eventName = "TRANSITION_VIEW"
        // metadata  = {
        //   link_session_id: "123-abc",
        //   mfa_type:        "questions",
        //   timestamp:       "2017-09-14T14:42:19.350Z",
        //   view_name:       "MFA",
        // }
        console.debug( eventName, metadata );
    }
});
document.getElementById( "plaidLink" ).addEventListener( "click", () => handler.open() );
</script>