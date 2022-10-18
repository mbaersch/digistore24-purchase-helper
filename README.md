# Digistore24 Purchase Helper (digistore24-purchase-helper)
Google Tag Manager Custom Variable Template. Extracts Digistore24 purchase data from (user-defined) URL parameters and provides an e-commerce object in Universal Analytics or GA4 format.

## Usage
Create a new variable with this template and select "Universal Analytics" or "GA4" (default) as output format. Optionally specify a user-defined set of parameter names for all purchase data for your custom thank you page URL. 

This variable can be used to provide an e-commerce object for a purchase event that can be selected in a UA or GA4 tag for an e-commerce payload to process. 

### Note
This template parses only a few parameters of the whole possible set. If you need to access additional information from the purchase, feel free to fork and send a pull request or reach out.
