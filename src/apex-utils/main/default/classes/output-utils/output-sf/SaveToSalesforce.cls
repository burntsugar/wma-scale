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


    // public static void save(String workSpaceLibraryName, String contentFolderName, String title, String content) {
    //     initCrud();

    //     String documentTitle = makeDocumentTitle(title);
    //     String pathOnClient = makePathOnClient(documentTitle);
    //     ContentVersion contentVersion = saveContentVersion(pathOnClient, documentTitle, content);

    //     ContentWorkspace ContentWorkspace = crud.getContentWorkSpace(workSpaceLibraryName);
    //     ContentFolder libraryContentFolder = crud.getLibraryContentFolder(ContentWorkspace.Id);
    //     ContentFolder contentFolder = crud.getContentFolder(contentFolderName);

    //     linkContentVersionToContentFolder(ContentWorkspace, libraryContentFolder, contentFolder, contentVersion.Id);
    // }

    public static ContentVersion save(String contentWorkspaceName, String contentFolderName, String contentVersionTitle, String content) {
        initCrud();

        String title = makeDocumentTitle(contentVersionTitle);
        String pathOnClient = makePathOnClient(title);

        ContentVersion contentVersion = saveContentVersion(pathOnClient, title, content);

        ContentWorkspace contentWorkspace = crud.getContentWorkSpace(contentWorkspaceName);

        ContentFolder contentWorkspaceContentFolder = crud.getContentFolder(contentWorkspace.Id);

        ContentFolder childContentFolder = crud.getContentFolder(contentFolderName);

        ContentDocumentLink contentDocumentlink = saveContentDocumentlink(contentVersion.Id, contentWorkspace);

        updateContentFolderMember(contentWorkspaceContentFolder, childContentFolder);

        return contentVersion;
    }

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
        
        crud.doInsert(cv);

        return cv;
    }

    private static ContentDocumentLink saveContentDocumentlink(String contentVersionId, ContentWorkspace libraryContentWorkSpace){
        Id conDoc = Crud.getContentVersion(contentVersionId).ContentDocumentId;
        
        ContentDocumentLink cDe = new ContentDocumentLink();
        cDe.ContentDocumentId = conDoc;
        cDe.LinkedEntityId = libraryContentWorkSpace.Id; 
        cDe.ShareType = SHARE_TYPE; 

        CRUD.doInsert(cDe);

        return cde;
    }

    private static void updateContentFolderMember(ContentFolder libraryContentFolder, ContentFolder contentFolder){
        ContentFolderMember cfm = CRUD.makeContentFolderMember(libraryContentFolder.Id, contentFolder.Id);
        cfm.ParentContentFolderId = contentFolder.Id;
        
        CRUD.doUpdate(cfm);
    }

    // private static void updateContentFolderMember(ContentFolder libraryContentFolder, ContentFolder contentFolder){
    //     ContentFolderMember cfm = CRUD.getContentFolderMember(libraryContentFolder.Id);
    //     cfm.ParentContentFolderId = contentFolder.Id;
        
    //     CRUD.doUpdate(cfm);
    // }
}
