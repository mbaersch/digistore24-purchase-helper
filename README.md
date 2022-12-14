# Digistore24 Purchase Helper 

**Custom Variable Template for Google Tag Manager**

Extracts Digistore24 purchase data from (user-defined) URL parameters and provides an e-commerce object in Universal Analytics or GA4 format.

![Template Status](https://img.shields.io/badge/Community%20Template%20Gallery%20Status-submitted-orange) ![Repo Size](https://img.shields.io/github/repo-size/mbaersch/digistore24-purchase-helper) ![License](https://img.shields.io/github/license/mbaersch/digistore24-purchase-helper)

---

## Adding Parameters to Thank-You-Page URL in Digistore24
When using Digistore24 to sell products, you can opt in to add parameters to the thank you page URL - either automatically or manually. As a fully tagged URL contains a lot of information and gets *very* long, the preferable choice is manual tagging. Add the following parameters to the URL - they contain all data that is used by the variable, using the default parameter keys. 

`?order_id=[ORDER_ID]&product_id=[PRODUCT_ID]&product_name=[PRODUCT_NAME]&quantity=[QUANTITY]&currency=[CURRENCY]&amount=[AMOUNT]&vat_amount=[VAT_AMOUNT]&net_amount=[NET_AMOUNT]`

## Usage
Create a new variable with this template and select "Universal Analytics" or "GA4" (default) as output format. Optionally specify a user-defined set of parameter names for all purchase data for your custom thank you page URL. 

This variable can be used to provide an e-commerce object for a purchase event that can be selected in a UA or GA4 tag for an e-commerce payload to process. 

### Note
This template parses only a few parameters of the whole possible set. If you need to access additional information from the purchase, feel free to fork and send a pull request or reach out.
