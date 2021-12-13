%dw 2.0
output application/java
import * from dw::core::Strings
---
{
	payloadText: if ((error.errorType.namespace matches /SYS/) or (error.errorType.namespace == "DATA") or (error.errorType.identifier == "ORG_XREF") or (error.errorType.namespace ++ ":" ++ error.errorType.identifier) == "MULE:RETRY_EXHAUSTED") error.description 
				else error.errorType.namespace ++ ":" ++ error.errorType.identifier ++ " error occured in " ++ error.detailedDescription as String
	
}