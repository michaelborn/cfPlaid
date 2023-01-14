/**
 * Base Plaid request client.
 */
component accessors="false" {
    
	property name="settings"    inject="coldbox:modulesettings:cfPlaid";
	property name="plaidClient" inject="PlaidClient@cfPlaid";

	public component function init(){
		return this;
	}
}