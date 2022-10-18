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
      },
      {
        "value": "user",
        "displayValue": "User Defined"
      }
    ],
    "simpleValueType": true,
    "defaultValue": "ga4",
    "alwaysInSummary": false
  },
  {
    "type": "TEXT",
    "name": "userFormat",
    "displayName": "User Defined Object Format",
    "simpleValueType": true,
    "enablingConditions": [
      {
        "paramName": "format",
        "paramValue": "user",
        "type": "EQUALS"
      }
    ],
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ],
    "defaultValue": "{\"order_id\": $$order_id$$, \"value\": $$amount$$, \"currency\": $$currency$$, \"products\": [{\"id\": $$product_id$$, \"name\": $$product_name$$, \"price\": $$product_price$$, \"quantity\": $$quantity$$}] }",
    "help": "add parameters and values using the following placeholders: $$order_id$$, $$amount$$, $$net_amount$$, $$vat_amount$$, $$product_id$$, $$product_name$$, $$quantity$$, $$currency$$. \n\nNOTE: must be valid JSON in order to work",
    "lineCount": 10
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

const parsedUrl = require('parseUrl')(require("getUrl")());
const params = parsedUrl.searchParams;
const id = params[data.prmOrderId];
const prd = params[data.prmProductId]||"UNKNOWN PRODUCT ID";
const nam = params[data.prmProductName]||"UNKNOWN PRODUCT NAME";
const curr = params[data.prmCurrency]||"EUR";
const amb = params[data.prmAmount];
const qt = params[data.prmQuantity]||1;
const amn = params[data.prmNetAmount]||amb||0;
const tx = params[data.prmTax]||0;

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
} if (data.format === "ga4") {
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
} else {
  //user defined format
  var uFormat = data.userFormat;
  if (!uFormat) return;
  const s = function(str) {return '"'+str+'"';};
  const replaceAll = function(str, oldstr, newstr) {
    var rs = str;
    if (oldstr === newstr) return rs;
    while (rs.indexOf(oldstr) >= 0)
      rs = rs.replace(oldstr, newstr);
    return rs;
  }; 
  uFormat = replaceAll(uFormat, "$$order_id$$", s(id));
  uFormat = replaceAll(uFormat, "$$amount$$", amb);
  uFormat = replaceAll(uFormat, "$$net_amount$$", amn);
  uFormat = replaceAll(uFormat, "$$vat_amount$$", tx);
  uFormat = replaceAll(uFormat, "$$currency$$", s(curr));
  uFormat = replaceAll(uFormat, "$$product_id$$", s(prd));
  uFormat = replaceAll(uFormat, "$$product_name$$", s(nam));
  uFormat = replaceAll(uFormat, "$$product_price$$", prc);
  uFormat = replaceAll(uFormat, "$$quantity$$", qt);
  
  return require("JSON").parse(uFormat);
  
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
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: GA4
  code: |-
    mockData.format = "ga4";
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo({"ecommerce":{"transaction_id":"TESTORDER1","value":"100.42","tax":"0.42","currency":"EUR","items":[{"item_id":"123456","item_name":"some random product","currency":"EUR","price":100,"quantity":"1"}]}});
- name: Universal
  code: |-
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo({"ecommerce":{"purchase":{"actionField":{"id":"TESTORDER1","revenue":"100.42","tax":"0.42"},"products":[{"name":"some random product","id":"123456","price":100,"quantity":"1"}]}}});
- name: User Defined
  code: |-
    mockData.format = "user";
    mockData.userFormat = '{"order": $$order_id$$, "val": $$amount$$, "currency": $$currency$$, "item": [{"id": $$product_id$$, "price": $$product_price$$, "currency": $$currency$$}]}';
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo({"order":"TESTORDER1","val":100.42,"currency":"EUR","item":[{"id":"123456","price":100,"currency":"EUR"}]});
setup: "const mockData = {\n  format: \"ua\",\n  prmOrderId: \"order_id\",\n  prmProductId:\
  \ \"product_id\",\n  prmProductName: \"product_name\",\n  prmCurrency: \"currency\"\
  ,\n  prmQuantity: \"quantity\",\n  prmAmount: \"amount\",\n  prmNetAmount: \"net_amount\"\
  ,\n  prmTax: \"vat_amount\"\n};\nmock(\"parseUrl\", \n{\"searchParams\":  {\"order_id\"\
  :\"TESTORDER1\",\"product_id\":\"123456\",\"product_name\":\"some random product\"\
  ,\"quantity\":\"1\",\"country\":\"DE\",\"currency\":\"EUR\",\"amount\":\"100.42\"\
  ,\"vat_amount\":\"0.42\",\"net_amount\":\"100\"}} \n);"


___NOTES___

Created on 17.10.2022, 22:35:18
