%dw 2.0
output application/json skipNullOn="everywhere"
var code = vars.errorDetails.code default vars.httpStatus
---
{
	"message": Mule::p(code),
	"error": {
		"correlationId": vars.correlationId,
		"transactionId": vars.transactionId,
		("processType": vars.processType) if vars.processType != null,
		("businessProcessId": vars.processId) if vars.processId != null,
		"code": vars.errorDetails.code default vars.httpStatus,
		"type": vars.errorDetails.'type' default (error.errorType.namespace ++ ":" ++ error.errorType.identifier),
		// Do not send backend error details message if API is exposed directly to Client
		"message": if (error.errorType.namespace == "APIKIT") error.description else vars.errorDetails.payloadText,
		"service": Mule::p('application.name')
	}
}