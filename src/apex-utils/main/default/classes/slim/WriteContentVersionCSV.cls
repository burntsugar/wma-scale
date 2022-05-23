public with sharing class WriteContentVersionCSV {

    public static void toCSV(List<String> headers, List<String> rows, String title) {
        createCSV(headers,rows,title);
    }

    private static void createCSV(List<String> csvHeaders, List<String> csvRowList, String title){
        String headerRow = String.join(csvHeaders,',') + '\n';
        String concantenatedStr = headerRow;
        Integer i = 0;
        Integer rowListSize = csvRowList.size();
        for(String row :csvRowList){
           
            i++;
            List<String> res = row.split(',');
            String str = String.join(res,',');
            concantenatedStr += (String)str + ((i != rowListSize) ? '\n' : '');//add new line
        }
        title += '.csv';
        createFile(concantenatedStr, title);
    }

    private static void createFile(String versionData, String title) {
        ContentVersion cv = new ContentVersion();
        cv.ContentLocation = 'S'; // resides on Salesforce
        cv.Title = title; // title of file
        cv.PathOnClient = title; // full path within Salesforce this can just be the name of file to be in the library
        cv.VersionData = Blob.valueOf(versionData); //file data
        insert cv;
    }
}
