___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Digistore24 Purchase Helper",
  "categories": [
    "UTILITY"
  ],
  "description": "Extracts Digistore24 purchase data from (user-defined) URL parameters and provides an e-commerce object in Universal Analytics or GA4 format",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "SELECT",
    "name": "format",
    "displayName": "Output Format",
    "macrosInSelect": false,
    "selectItems": [
      {
        "value": "ga4",
        "displayValue": "GA4"
      },
      {
        "value": "ua",
        "displayValue": "Universal Analytics"
      }
    ],
    "simpleValueType": true,
    "defaultValue": "ga4",
    "alwaysInSummary": false
  },
  {
    "type": "GROUP",
    "name": "paramNames",
    "displayName": "Parameter Names",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "TEXT",
        "name": "prmOrderId",
        "displayName": "Order ID",
        "simpleValueType": true,
        "defaultValue": "order_id",
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "prmCurrency",
        "displayName": "Currency",
        "simpleValueType": true,
        "defaultValue": "currency",
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "prmAmount",
        "displayName": "Amount",
        "simpleValueType": true,
        "defaultValue": "amount",
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "prmNetAmount",
        "displayName": "Amount",
        "simpleValueType": true,
        "defaultValue": "net_amount",
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "prmTax",
        "displayName": "VAT Amout",
        "simpleValueType": true,
        "defaultValue": "vat_amount",
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "prmProductId",
        "displayName": "Product Id",
        "simpleValueType": true,
        "defaultValue": "product_id",
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "prmProductName",
        "displayName": "Product Name",
        "simpleValueType": true,
        "defaultValue": "product_name",
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "prmQuantity",
        "displayName": "Quantity",
        "simpleValueType": true,
        "defaultValue": "quantity",
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ]
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

// Vorlagencode hier eingeben.
const getQueryParameters = require('getQueryParameters');

const id = getQueryParameters(data.prmOrderId);
const prd = getQueryParameters(data.prmProductId)||"UNKNOWN PRODUCT ID";
const nam = getQueryParameters(data.prmProductName)||"UNKNOWN PRODUCT NAME";
const curr = getQueryParameters(data.prmCurrency)||"EUR";
const amb = getQueryParameters(data.prmAmount);
const qt = getQueryParameters(data.prmQuantity)||1;
const amn = getQueryParameters(data.prmNetAmount)||amb||0;
const tx = getQueryParameters(data.prmTax)||0;

if (!id && !amb) return;

const prc = require("Math").round(amn * 100 / qt) / 100;

if (data.format === "ua") {
  //Universal Analytics ecommerce object 
  return {
   ecommerce: {
    purchase: {
      actionField: {
        id: id,
        revenue: amb,
        tax:tx,
      },
      products: [{                            
        name: nam,
        id: prd,
        price: prc,
        quantity: qt
      }]
    }
  }};    
} else {
  //GA4 ecommerce object 
  return {ecommerce: {
    transaction_id: id,
    value: amb,
    tax: tx,
    currency: curr,
    items: [{
      item_id: prd,
      item_name: nam,
      currency: curr,
      price: prc,
      quantity: qt
    }]
  }};  
}


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "get_url",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urlParts",
          "value": {
            "type": 1,
            "string": "any"
          }
        },
        {
          "key": "queriesAllowed",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 17.10.2022, 22:35:18


