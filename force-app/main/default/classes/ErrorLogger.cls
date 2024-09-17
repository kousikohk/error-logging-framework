public class ErrorLogger {
    
    // Method to log an exception
    public static void logException(Exception ex, String className, String methodName, String additionalInfo) {
        try {
            Error_Log__c errorLog = new Error_Log__c();
            errorLog.Error_Message__c = ex.getMessage();
            errorLog.Stack_Trace__c = ex.getStackTraceString();
            errorLog.Apex_Class__c = className;
            errorLog.Apex_Method__c = methodName;
            errorLog.Log_Level__c = 'Error';
            if (additionalInfo != null) {
                errorLog.Additional_Info__c = additionalInfo;
            }
            insert errorLog;
        } catch (Exception e) {
            // If logging fails, output it to the debug log to avoid recursive failures
            System.debug('Error logging failed: ' + e.getMessage());
        }
    }

    // Method to log a warning message
    public static void logWarning(String message, String className, String methodName, String additionalInfo) {
        logMessage('Warning', message, className, methodName, additionalInfo);
    }

    // Method to log an informational message
    public static void logInfo(String message, String className, String methodName, String additionalInfo) {
        logMessage('Info', message, className, methodName, additionalInfo);
    }

    // General method to log a message (info, warning, or debug)
    public static void logMessage(String logLevel, String message, String className, String methodName, String additionalInfo) {
        try {
            Error_Log__c errorLog = new Error_Log__c();
            errorLog.Error_Message__c = message;
            errorLog.Apex_Class__c = className;
            errorLog.Apex_Method__c = methodName;
            errorLog.Log_Level__c = logLevel;
            if (additionalInfo != null) {
                errorLog.Additional_Info__c = additionalInfo;
            }
            insert errorLog;
        } catch (Exception e) {
            System.debug('Error logging failed: ' + e.getMessage());
        }
    }
}
