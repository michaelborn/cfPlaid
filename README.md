# cfPlaid

Integrate with the [Plaid API](https://plaid.com/docs/api/) from CFML.

[![Release](https://github.com/michaelborn/cfPlaid/actions/workflows/release.yml/badge.svg)](https://github.com/michaelborn/cfPlaid/actions/workflows/release.yml)

## Features

## Setup

1. Install this module in your app - `box install cfPlaid`
2. Add the required configuration either via environment variables OR module settings

## Configuration

There are two ways to configure API credentials for cfPlaid:

1. Using a [`.env` file](#env-file-and-commandbox-dotenv)
2. Using [Module Settings](#module-settings)

### Env File and `commandbox-dotenv`

```bash
# Plaid API creds
PLAID_URL=https://sandbox.plaid.com

# Plaid keys
PLAID_CLIENT_ID=123_FIXME
PLAID_CLIENT_SECRET=456_FIXME
```

### Module Settings

Add the following to `config/ColdBox.cfc` and update as necessary:

```js
moduleSettings = {
    cfPlaid = {
        api_url          : "https://sandbox.plaid.com",
        api_client_id    : "123_FIXME",
        api_client_secret: "456_FIXME"
    }
}
```