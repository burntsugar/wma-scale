public class WriteToCSV {

    // public static void createCSV(ObjectInfoCSV objectInfoCSV) {
    //     String content = createCSV(objectInfoCSV.getCSVHeaders().getCSVHeaders(),objectInfoCSV.getCSVRows().getCSVRows(),objectInfoCSV.getCsvTitle());
    //     String title = 'object-record-type-fields';
    //     SaveToSalesforce.save('my-queries','general',title, content);
    // }

    // public static void createCSV(ObjectInfoCSV objectInfoCSV, String reportTitle) {
    //     String content = createCSV(objectInfoCSV.getCSVHeaders().getCSVHeaders(),objectInfoCSV.getCSVRows().getCSVRows(),objectInfoCSV.getCsvTitle());
    //     String title = reportTitle;
    //     SaveToSalesforce.save('my-queries','general',title, content);
    // }

    public static void createCSV(ObjectInfoCSV objectInfoCSV) {
        String content = createCSV(objectInfoCSV.getCSVHeaders(),objectInfoCSV.getCSVRows(),objectInfoCSV.getCsvTitle());
        String title = 'object-record-type-fields';
        SaveToSalesforce.save('my-queries','general',title, content);
    }

    public static void createCSV(ObjectInfoCSV objectInfoCSV, String reportTitle) {
        String content = createCSV(objectInfoCSV.getCSVHeaders(),objectInfoCSV.getCSVRows(),objectInfoCSV.getCsvTitle());
        String title = reportTitle;
        SaveToSalesforce.save('my-queries','general',title, content);
    }

    private static String createCSV(List<String> csvHeaders, List<String> csvRowList, String title){
        String headerRow = String.join(csvHeaders,',') + '\n';
        String concantenatedStr = headerRow;
        Integer i = 0;
        Integer rowListSize = csvRowList.size();

        try {
            for(String row :csvRowList){
            
                i++;
                List<String> res = row.split(',');
                String str = String.join(res,',');
                concantenatedStr += (String)str + ((i != rowListSize) ? '\n' : '');//add new line
            }
            title += '.csv';
        } catch (StringException stre) {
            throw new ContentException(ContentException.getErrorMessage(ContentException.errorMsg.BLOB_SIZE_MSG_CONTENTVERSION), stre);
        }
        //createFile(concantenatedStr, title);
        return concantenatedStr;
    }

}

    // private static void createFile(String versionData, String title) {
    //     ContentVersion cv = new ContentVersion();
    //     cv.ContentLocation = 'S'; // resides on Salesforce
    //     cv.Title = title; // title of file
    //     cv.PathOnClient = title; // full path within Salesforce this can just be the name of file to be in the library
    //     cv.VersionData = Blob.valueOf(versionData); //file data
    //     insert cv;
    // }

    // private static String createCSV(List<String> csvHeaders, List<String> csvRowList, String title){
    //     String headerRow = String.join(csvHeaders,',') + '\n';
    //     String concantenatedStr = headerRow;
    //     Integer i = 0;
    //     Integer rowListSize = csvRowList.size();
    //     for(String row :csvRowList){
           
    //         i++;
    //         List<String> res = row.split(',');
    //         String str = String.join(res,',');
    //         concantenatedStr += (String)str + ((i != rowListSize) ? '\n' : '');//add new line
    //     }
    //     title += '.csv';
    //     //createFile(concantenatedStr, title);
    //     return concantenatedStr;
    // }



// public with sharing class WriteToCSV {

//     public static void createCSV(ObjectInfoCSV objectInfoCSV) {
//         createCSV(objectInfoCSV.getCSVHeaders().getCSVHeaders(),objectInfoCSV.getCSVRows().getCSVRows(),objectInfoCSV.getCsvTitle());
    
//     }

//     private static void createFile(String versionData, String title) {
//         ContentVersion cv = new ContentVersion();
//         cv.ContentLocation = 'S'; // resides on Salesforce
//         cv.Title = title; // title of file
//         cv.PathOnClient = title; // full path within Salesforce this can just be the name of file to be in the library
//         cv.VersionData = Blob.valueOf(versionData); //file data
//         insert cv;
//     }

//     private static void createCSV(List<String> csvHeaders, List<String> csvRowList, String title){
//         String headerRow = String.join(csvHeaders,',') + '\n';
//         String concantenatedStr = headerRow;
//         Integer i = 0;
//         Integer rowListSize = csvRowList.size();
//         for(String row :csvRowList){
           
//             i++;
//             List<String> res = row.split(',');
//             String str = String.join(res,',');
//             concantenatedStr += (String)str + ((i != rowListSize) ? '\n' : '');//add new line
//         }
//         title += '.csv';
//         createFile(concantenatedStr, title);
//     }

// }
