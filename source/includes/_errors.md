# Errors

<aside class="notice">
This is a small quick error section to help understand any kind of errors you may be seeing (but you really shouldn't be seeing any because we're like totally perfect right?)
</aside>

The ZeroIn API uses the following error codes and more derived from 
https://www.iana.org/assignments/http-status-codes/http-status-codes.xhtml


Error Code | Meaning
---------- | -------
400 | Bad Request -- Your request is invalid.
401 | Unauthorized -- Your auth token is invalid.
403 | Forbidden -- You are not authorized to make this request.
404 | Not Found -- The patient could not be found.
405 | Method Not Allowed -- You tried a query with an invalid method.
406 | Not Acceptable -- You requested a format that isn't json.
500 | Internal Server Error -- We had a problem with our server. Try again later.
503 | Service Unavailable -- We're temporarily offline for maintenance, or seeing server downtime.
