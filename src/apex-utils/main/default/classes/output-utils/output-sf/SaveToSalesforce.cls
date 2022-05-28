public with sharing class SaveToSalesforce {

    private static final String CONTENT_LOCATION = 'S';
    private static final String FILE_EXTENSION = '.csv';
    private static final String DATE_FORMAT = 'yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'';
    private static final String SHARE_TYPE = 'I';

    private static ICRUD crud;

    public static void initCrud(){
        if (crud == null){
            CRUD c = new CRUD();
            crud = c;
        }
    }

    public static void setCrud(ICrud crudRef){
        crud = crudRef;
    }


    public static void save(String workSpaceLibraryName, String contentFolderName, String title, String content) {
        initCrud();

        String documentTitle = makeDocumentTitle(title);
        String pathOnClient = makePathOnClient(documentTitle);
        ContentVersion contentVersion = saveContentVersion(pathOnClient, documentTitle, content);

        ContentWorkspace ContentWorkspace = crud.getContentWorkSpace(workSpaceLibraryName);
        ContentFolder libraryContentFolder = crud.getLibraryContentFolder(ContentWorkspace.Id);
        ContentFolder contentFolder = crud.getContentFolder(contentFolderName);

        linkContentVersionToContentFolder(ContentWorkspace, libraryContentFolder, contentFolder, contentVersion.Id);
    }

    // private static ContentWorkspace getContentWorkSpace(String workSpaceLibraryName){
    //     ContentWorkspace libraryContentWorkSpace = [Select Id from ContentWorkspace where Name =: workSpaceLibraryName];
    //     return libraryContentWorkSpace;
    // }

    // private static ContentFolder getLibraryContentFolder(String WorkSpaceId){
    //     ContentFolder libraryContentFolder = [Select Id from ContentFolder where Name =: WorkSpaceId];
    //     return libraryContentFolder;
    // }

    // private static ContentFolder getContentFolder(String contentFolderName){
    //     ContentFolder folder = [Select Id from ContentFolder where Name =: contentFolderName];
    //     return folder;
    // }

    private static String makeDocumentTitle(String title){
        String timestamp = Datetime.now().format(DATE_FORMAT);
        String documentTitle = title + '-' + timeStamp;
        return documentTitle;
    }

    private static String makePathOnClient(String documentTitle){
        String pathOnClient = documentTitle + FILE_EXTENSION;
        return pathOnClient;
    }

    private static ContentVersion saveContentVersion(String pathOnClient, String documentTitle, String content) {
        ContentVersion cv = new ContentVersion();
        cv.ContentLocation = CONTENT_LOCATION; 
        cv.Title = documentTitle; 
        cv.PathOnClient = pathOnClient;
        cv.VersionData = Blob.valueOf(content);
        
        //insert cv;
        crud.doInsert(cv);

        return cv;
    }

    private static void linkContentVersionToContentFolder(ContentWorkspace libraryContentWorkSpace, ContentFolder libraryContentFolder, ContentFolder contentFolder, String contentVersionId){

        Id conDoc = Crud.getContentVersion(contentVersionId).ContentDocumentId;
        //Id conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:contentVersionId].ContentDocumentId;
        
        ContentDocumentLink cDe = new ContentDocumentLink();
        cDe.ContentDocumentId = conDoc;
        cDe.LinkedEntityId = libraryContentWorkSpace.Id; 
        cDe.ShareType = SHARE_TYPE; 

        //insert cDe;
        CRUD.doInsert(cDe);
    
        //ContentFolderMember cfm = [Select Id, ChildRecordId, ParentContentFolderId from ContentFolderMember where ParentContentFolderId =: libraryContentFolder.Id];
        ContentFolderMember cfm = CRUD.getContentFolderMember(libraryContentFolder);
        cfm.ParentContentFolderId = contentFolder.Id;
        
        //update cfm;
        CRUD.doUpdate(cfm);


    }
    

    // void saveFile(String workSpaceLibraryName, String contentFolderName, String title, String content) {
    
    //     ContentWorkspace libraryContentWorkSpace = [Select Id from ContentWorkspace where Name =: workSpaceLibraryName];
    //     ContentFolder libraryContentFolder = [Select Id from ContentFolder where Name =: libraryContentWorkSpace.Id];
    //     ContentFolder folder = [Select Id from ContentFolder where Name =: contentFolderName];
    
    //     String timestamp = Datetime.now().format(DATE_FORMAT);
    //     String documentTitle = title + '-' + timeStamp;
    
    //     ContentVersion cv = new ContentVersion();
    //     cv.ContentLocation = CONTENT_LOCATION; 
    //     cv.Title = documentTitle; 
    //     cv.PathOnClient = documentTitle + FILE_EXTENSION;
    //     cv.VersionData = Blob.valueOf(content);
    //     insert cv;
    
    
    //     Id conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:cv.Id].ContentDocumentId;
        
    //     ContentDocumentLink cDe = new ContentDocumentLink();
    //     cDe.ContentDocumentId = conDoc;
    //     cDe.LinkedEntityId = libraryContentWorkSpace.Id; 
    //     cDe.ShareType = 'I'; 
    //     insert cDe;
    
    //     ContentFolderMember cfm = [Select Id, ChildRecordId, ParentContentFolderId from ContentFolderMember where ParentContentFolderId =: libraryContentFolder.Id];
    //     cfm.ParentContentFolderId = folder.Id;
    //     update cfm;
    // }
}
