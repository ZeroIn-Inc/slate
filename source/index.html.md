---
title: API Reference

language_tabs: # must be one of https://git.io/vQNgJ
  - shell
  - typescript
  - javascript

toc_footers:
  - <a href='https://zeroin.ai'>ZeroIn.ai</a>

includes:
  - errors

search: true

code_clipboard: true
---

# Introduction

Welcome to the ZeroIn API! You can use our API to submit new patients into our ASAP appointment queue or to receive our pre-sorted patient queueing. 

You can view code examples in the dark area to the right, and you can switch the programming language of the examples with the tabs in the top right.

# Authentication

> To authorize, use this code:

```javascript
      const apiKey = REPLACE_WITH_IDENTITY_PLATFORM_API_KEY
      const tenantId = REPLACE_WITH_TENANT_ID
      const identityUrl = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=' + {apiKey}
      const identity = fetch(url, {
        body: JSON.stringify({
              "returnSecureToken":true,
              "tenantId": tenantId
              }),
              method: "POST",
              mode: "cors",
              headers: {  new Headers({'content-type': 'application/json'}) },
      }).then(data=>{return data.json()})
        .then(res=>console.log(res))
      const idToken = identity.idToken
```


```shell

local API_KEY = $"REPLACE_WITH_IDENTITY_PLATFORM_API_KEY"
local TENANTID = $"REPLACE_WITH_TENANT_ID"
local URL = $("https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=${API_KEY}")
local auth = $(curl ${URL} -H 'Content-Type: application/json' --data-binary '{"returnSecureToken":true, "tenantId":${TENANTID}' | grep -Po '"idToken":.*?[^\\]",')
```

```typescript
  const tenantId = REPLACE_WITH_TENANT_ID
  const apiKey = REPLACE_WITH_API_KEY
  const idToken = await fetch('https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=' + apiKey, {
    body: JSON.stringify({
              "returnSecureToken":true,
              "tenantId": tenantId
              }),
              method: "POST",
              mode: "cors",
              headers: {  new Headers({'content-type': 'application/json'}) },
      }).then(data=>{return data.json()})
        .then(res=>console.log(res))
      const idToken = identity.idToken
```

> Make sure to replace the API key and tenantID.

ZeroIn uses expiring IDTokens to allow access to the API which are provided via GCP's IdentityPlatform. The underlying assumption of these docs is taht you have the underlying identity platform api key to make these calls possible.

<aside class="notice">
You must have the <code>identityPlatform API Key and tenantId</code> for these queries to work.
</aside>

# Checkins

## POST Checkin

```shell
curl "https://dev-api.zeroin.ai/checkins" \
  -H "Authorization: Bearer ${auth}" \
  --request POST \
  --data '{"name":"xyz","dob":"xyz","phone":"7195553890","chiefComplaint":"2-cool-4-school","emergencySymptoms":0, "spokenLanguage":1, "campaignId":"4567"}
```

```javascript
  const url = "https://dev-api.zeroin.ai/checkins"
  const resp = fetch(url, {
          body: JSON.stringify({
              name: "string",
              dob: "string",
              phone: "7195553890",
              chiefComplaint: "string",
              emergencySymptoms: 0,
              spokenLanguage: 1,
              campaignId: 4567,
          }),
          method: "POST",
          mode: "cors",
          headers: {
          "Authorization": "Bearer " + idToken,
          "TenantID": tentantId,
          },
  }).then(data=>{return data.json()})
    .then(res=>console.log(res))
```

``` typescript
  let config = {
    // prettier-ignore
    'Authorization': 'Bearer ' + idToken as string,
    // prettier-ignore
    'TenantID': tenantId as string,
  }
  const res = await fetch('https://dev-api.zeroin.ai/checkins', {
      body: JSON.stringify({
        name: "string",
        dob: "string",
        phone: "7195553890",
        chiefComplaint: "string",
        emergencySymptoms: 0,
        spokenLanguage: 1,
        campaignId: 4567,
      }),
      method: 'POST',
      mode: 'cors',
      headers: {
        ...config,
      },
    })
```

> The above command returns JSON structured like this:

```json
[
  {
    campaignId: 4567,
    checkin_time: "2021-03-05T22:22:59.693989393Z",
    chiefComplaint: "string",
    dob: "string",
    emergencySymptoms: 0,
    id: "laksdfhgadjshgfasjkdf"
    name: "string"
    phone: "7195553890"
    spokenLanguage: 1
    waiting: 2
  }
]
```

This endpoint posts a patients checkin and returns confirmation & support info

### HTTP Request

`POST http://dev-api.zeroin.ai/checkins`

### Post Parameters

Parameter  | Default | Description
---------  | ------- | -----------
campaignId | undefined  | if set, the patient will become viewable to only certain queues. Otherwise they enter the general queue
chiefComplaint | string | help they're seeking
dob | string | date of birth
emergencySymptoms | 0 | are they experiencing emergency symptoms, 1 if true
name | string | patient's first and last name
phone | string | patient's phone number
spokenLanguage | 0 | patient's preferred language for visit. 1 if spanish

<aside class="success">
Feel free to check out the console on https://dev-pat.zeroin.ai to see it in action!
</aside>

## Get Checkins
<aside class="warning">The following Get and sse examples do not contain all of the sufficient info to operate them yourself. These are to give you an idea of what's happening behind the scenes.</aside>

```shell
curl "https://some-url-with-auth-and-stuff" \
  -H "Authorization: Bearer ${auth}, \
      TenantID: ${tenantId}" \
  --request GET \
```

```javascript
  const url = "https://some-url-with-auth-and-stuff"
  const resp = fetch(url, {
          method: "GET",
          mode: "cors",
          headers: {
          "Authorization": "Bearer " + idToken,
          "TenantID": tentantId,
          },
          cache: 'default',
  }).then(data=>{return data.json()})
    .then(res=>console.log(res))
```

``` typescript
  let config = {
      // prettier-ignore
      'Authorization': 'Bearer ' + idToken as string,
      // prettier-ignore
      'TenantID': tenantId as string,
    }
    const res = await fetch(`https://some-url-with-auth-and-stuff`, {
      method: 'GET',
      headers: {
        ...config,
      },
      cache: 'default',
    })
    const json = await res.json()
```

> The above command returns JSON structured like this:

```json
{
  "0":
    "campaignId": "4567",
    "checkin_time": "2021-03-04T16:41:21.966117945Z",
    "chiefComplaint": "string",
    "contactedBy": "Dr. Johnny Appleseed",
    "dibsTimer": "2021-03-04T18:17:44.621569527Z",
    "dibsTimes": (2) ["2021-03-04T16:42:49.923369375Z", "2021-03-04T18:17:44.621569527Z"],
    "dob": "2021-03-24",
    "emergencySymptoms": 0,
    "facility": {…},
    "id": "laksdfhgadjshgfasjkdf",
    "messageTimes": null,
    "messaged": 0,
    "messages": null,
    "name": "David Martin",
    "phone": "7192003890",
    "processed": false,
    "processedBy": "",
    "processedReason": "",
    "readyForCall": 0,
    "spokenLanguage": 1,
    "timesContacted": 1,
    "waiting": 2
  "1": …
}
```

This endpoint retrieves checkins for the dashboard

### HTTP Request

`GET https://some-url-with-auth-and-stuff`

### URL Parameters

Parameter | Description
--------- | -----------
none      | retrieves all checkins relative and auth-ed for a specific user.

## SSE

```shell
const evt = new EventSource("https://some-url-with-auth-and-stuff");
evt.addEventListener('eventType', (e)=> console.log(e));
```

```javascript
evt.addEventListener('checkin', async (e) => {
    const cmd = JSON.parse(element.data)
    addNotification({
      ...etc
    })
    document.title = 'New Patient Waiting'
    newPatientSound.play()
    this.handleNewPatient(cmd)
  })

  evt.addEventListener('messaged', (e) => {
    const cmd = JSON.parse(element.data)
    this.updatePatients(cmd)
  })
  ...etc
```

``` typescript
  evt.addEventListener('checkin', async (e) => {
    let element = e as MessageEvent
    const cmd = JSON.parse(element.data)
    addNotification({
      ...etc
    })
    document.title = 'New Patient Waiting'
    newPatientSound.play()
    this.handleNewPatient(cmd)
  })

  evt.addEventListener('messaged', (e) => {
    let element = e as MessageEvent
    const cmd = JSON.parse(element.data)
    this.updatePatients(cmd)
  })

  ... etc
```

> The above command returns JSON structured like this:

```json
{
    "campaignId": "4567",
    "checkin_time": "2021-03-04T16:41:21.966117945Z",
    "chiefComplaint": "string",
    "contactedBy": "Dr. Johnny Appleseed",
    "dibsTimer": "2021-03-04T18:17:44.621569527Z",
    "dibsTimes": (2) ["2021-03-04T16:42:49.923369375Z", "2021-03-04T18:17:44.621569527Z"],
    "dob": "2021-03-24",
    "emergencySymptoms": 0,
    "facility": {…},
    "id": "laksdfhgadjshgfasjkdf",
    "messageTimes": null,
    "messaged": 0,
    "messages": null,
    "name": "David Martin",
    "phone": "7192003890",
    "processed": false,
    "processedBy": "",
    "processedReason": "",
    "readyForCall": 0,
    "spokenLanguage": 1,
    "timesContacted": 1,
    "waiting": 2
}
```

This is how we handle updates on the client side

