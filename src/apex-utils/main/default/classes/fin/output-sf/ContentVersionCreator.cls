public class ContentVersionCreator {

    private static final String FILE_EXTENSION = '.csv';
    private static final String DATE_FORMAT = 'yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'';

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

    public static ContentVersion saveContentVersion(String contentWorkspaceName, String contentFolderName, String contentVersionTitle, String content) {

        initCrud();

        List<String> stringParams = new List<String>{contentWorkspaceName, contentFolderName, contentVersionTitle, content};
        if (StringUtils.stringIsBlank(stringParams)) throw new ContentException(ContentException.getErrorMessage(ContentException.errorMsg.PARAMETERS_MSG_CONTENTVERSION));

        String title = makeDocumentTitle(contentVersionTitle);
        String pathOnClient = makePathOnClient(title);

        ContentVersion contentVersion = saveContentVersion(pathOnClient, title, content);

        ContentWorkspace contentWorkspace = getContentWorkSpace(contentWorkspaceName);

        ContentFolder contentWorkspaceContentFolder = getContentFolder(contentWorkspace.Id);

        ContentFolder childContentFolder = getContentFolder(contentFolderName);

        ContentDocumentLink contentDocumentlink = saveContentDocumentlink(contentVersion, contentWorkspace);

        saveContentFolderMember(contentWorkspaceContentFolder, childContentFolder);

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
        ContentVersion cv;
        cv = crud.saveContentVersion(pathOnClient, documentTitle, content);

        return cv;
    }

    private static ContentWorkspace getContentWorkSpace(String contentWorkspaceName) {
        ContentWorkspace contentWorkspace;
        contentWorkspace = crud.getContentWorkSpace(contentWorkspaceName);

        if(contentWorkspace==null) throw new ContentException(ContentException.getErrorMessage(ContentException.errorMsg.NULL_MSG_CONTENTWORKSPACE));

        return contentWorkspace;
    }

    private static ContentFolder getContentFolder(String contentFolderName) {
        ContentFolder contentFolder = crud.getContentFolder(contentFolderName);

        if(contentFolder==null) throw new ContentException(ContentException.getErrorMessage(ContentException.errorMsg.NULL_MSG_CONTENTFOLDER));

        return contentFolder;
    }

    private static ContentDocumentLink saveContentDocumentlink(ContentVersion contentVersion, ContentWorkspace contentWorkSpace){
        ContentDocumentLink contentDocumentLink = crud.saveContentDocumentLink(contentVersion, contentWorkspace);

        if(contentDocumentLink==null) throw new ContentException(ContentException.getErrorMessage(ContentException.errorMsg.NULL_MSG_CONTENTDOCUMENTLINK));

        return contentDocumentLink;
    }

    private static void saveContentFolderMember(ContentFolder parentContentFolder, ContentFolder childContentFolder){
    
        ContentFolderMember contentFolderMember = CRUD.saveContentFolderMember(parentContentFolder.Id, childContentFolder.Id);

        if(contentFolderMember==null) throw new ContentException(ContentException.getErrorMessage(ContentException.errorMsg.NULL_MSG_CONTENTFOLDERMEMBER));
    }
}


// public class ContentVersionCreator {

//     private static final String FILE_EXTENSION = '.csv';
//     private static final String DATE_FORMAT = 'yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'';

//     private static ICRUD crud;

//     public static void initCrud(){
//         if (crud == null){
//             CRUD c = new CRUD();
//             crud = c;
//         }
//     }

//     public static void setCrud(ICrud crudRef){
//         crud = crudRef;
//     }

//     public static ContentVersion saveContentVersion(String contentWorkspaceName, String contentFolderName, String contentVersionTitle, String content) {

//         initCrud();

//         List<String> stringParams = new List<String>{contentWorkspaceName, contentFolderName, contentVersionTitle, content};
//         if (StringUtils.stringIsBlank(stringParams)) throw new ContentException(ContentException.getErrorMessage(ContentException.errorMsg.PARAMETERS_MSG_CONTENTVERSION));

//         String title = makeDocumentTitle(contentVersionTitle);
//         String pathOnClient = makePathOnClient(title);

//         ContentVersion contentVersion = saveContentVersion(pathOnClient, title, content);

//         ContentWorkspace contentWorkspace = getContentWorkSpace(contentWorkspaceName);

//         ContentFolder contentWorkspaceContentFolder = getContentFolder(contentWorkspace.Id);

//         ContentFolder childContentFolder = getContentFolder(contentFolderName);

//         ContentDocumentLink contentDocumentlink = saveContentDocumentlink(contentVersion, contentWorkspace);

//         saveContentFolderMember(contentWorkspaceContentFolder, childContentFolder);

//         return contentVersion;
//     }

//     private static String makeDocumentTitle(String title){
//         String timestamp = Datetime.now().format(DATE_FORMAT);
//         String documentTitle = title + '-' + timeStamp;

//         return documentTitle;
//     }

//     private static String makePathOnClient(String documentTitle){
//         String pathOnClient = documentTitle + FILE_EXTENSION;

//         return pathOnClient;
//     }

//     private static ContentVersion saveContentVersion(String pathOnClient, String documentTitle, String content) {
//         ContentVersion cv;
//         cv = crud.saveContentVersion(pathOnClient, documentTitle, content);

//         return cv;
//     }

//     private static ContentWorkspace getContentWorkSpace(String contentWorkspaceName) {
//         ContentWorkspace contentWorkspace;
//         contentWorkspace = crud.getContentWorkSpace(contentWorkspaceName);

//         if(contentWorkspace==null) throw new ContentException(ContentException.getErrorMessage(ContentException.errorMsg.NULL_MSG_CONTENTWORKSPACE));

//         return contentWorkspace;
//     }

//     private static ContentFolder getContentFolder(String contentFolderName) {
//         ContentFolder contentFolder = crud.getContentFolder(contentFolderName);

//         if(contentFolder==null) throw new ContentException(ContentException.getErrorMessage(ContentException.errorMsg.NULL_MSG_CONTENTFOLDER));

//         return contentFolder;
//     }

//     private static ContentDocumentLink saveContentDocumentlink(ContentVersion contentVersion, ContentWorkspace contentWorkSpace){
//         ContentDocumentLink contentDocumentLink = crud.saveContentDocumentLink(contentVersion, contentWorkspace);

//         if(contentDocumentLink==null) throw new ContentException(ContentException.getErrorMessage(ContentException.errorMsg.NULL_MSG_CONTENTDOCUMENTLINK));

//         return contentDocumentLink;
//     }

//     private static void saveContentFolderMember(ContentFolder parentContentFolder, ContentFolder childContentFolder){
    
//         ContentFolderMember contentFolderMember = CRUD.saveContentFolderMember(parentContentFolder.Id, childContentFolder.Id);

//         if(contentFolderMember==null) throw new ContentException(ContentException.getErrorMessage(ContentException.errorMsg.NULL_MSG_CONTENTFOLDERMEMBER));
//     }
// }


// public class ContentVersionCreator {

//     private static final String FILE_EXTENSION = '.csv';
//     private static final String DATE_FORMAT = 'yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'';

//     private static ICRUD crud;

//     public static void initCrud(){
//         if (crud == null){
//             CRUD c = new CRUD();
//             crud = c;
//         }
//     }

//     public static void setCrud(ICrud crudRef){
//         crud = crudRef;
//     }

//     public static ContentVersion saveContentVersion(String contentWorkspaceName, String contentFolderName, String contentVersionTitle, String content) {

//         initCrud();

//         List<String> stringParams = new List<String>{contentWorkspaceName, contentFolderName, contentVersionTitle, content};
//         if (StringUtils.stringIsBlank(stringParams)) throw new ContentException(ContentException.getErrorMessage(ContentException.errorMsg.PARAMETERS_MSG_CONTENTVERSION));

//         String title = makeDocumentTitle(contentVersionTitle);
//         String pathOnClient = makePathOnClient(title);

//         ContentVersion contentVersion = saveContentVersion(pathOnClient, title, content);

//         ContentWorkspace contentWorkspace = getContentWorkSpace(contentWorkspaceName);

//         ContentFolder contentWorkspaceContentFolder = getContentFolder(contentWorkspace.Id);

//         ContentFolder childContentFolder = getContentFolder(contentFolderName);

//         ContentDocumentLink contentDocumentlink = saveContentDocumentlink(contentVersion, contentWorkspace);

//         saveContentFolderMember(contentWorkspaceContentFolder, childContentFolder);

//         return contentVersion;
//     }

//     private static String makeDocumentTitle(String title){
//         String timestamp = Datetime.now().format(DATE_FORMAT);
//         String documentTitle = title + '-' + timeStamp;

//         return documentTitle;
//     }

//     private static String makePathOnClient(String documentTitle){
//         String pathOnClient = documentTitle + FILE_EXTENSION;

//         return pathOnClient;
//     }

//     private static ContentVersion saveContentVersion(String pathOnClient, String documentTitle, String content) {
//         ContentVersion cv;
//         cv = crud.saveContentVersion(pathOnClient, documentTitle, content);

//         return cv;
//     }

//     private static ContentWorkspace getContentWorkSpace(String contentWorkspaceName) {
//         ContentWorkspace contentWorkspace;
//         contentWorkspace = crud.getContentWorkSpace(contentWorkspaceName);

//         if(contentWorkspace==null) throw new ContentException(ContentException.getErrorMessage(ContentException.errorMsg.NULL_MSG_CONTENTWORKSPACE));

//         return contentWorkspace;
//     }

//     private static ContentFolder getContentFolder(String contentFolderName) {
//         ContentFolder contentFolder = crud.getContentFolder(contentFolderName);

//         if(contentFolder==null) throw new ContentException(ContentException.getErrorMessage(ContentException.errorMsg.NULL_MSG_CONTENTFOLDER));

//         return contentFolder;
//     }

//     private static ContentDocumentLink saveContentDocumentlink(ContentVersion contentVersion, ContentWorkspace contentWorkSpace){
//         ContentDocumentLink contentDocumentLink = crud.saveContentDocumentLink(contentVersion, contentWorkspace);

//         if(contentDocumentLink==null) throw new ContentException(ContentException.getErrorMessage(ContentException.errorMsg.NULL_MSG_CONTENTDOCUMENTLINK));

//         return contentDocumentLink;
//     }

//     private static void saveContentFolderMember(ContentFolder parentContentFolder, ContentFolder childContentFolder){
    
//         ContentFolderMember contentFolderMember = CRUD.saveContentFolderMember(parentContentFolder.Id, childContentFolder.Id);

//         if(contentFolderMember==null) throw new ContentException(ContentException.getErrorMessage(ContentException.errorMsg.NULL_MSG_CONTENTFOLDERMEMBER));
//     }
// }


// // public class ContentVersionCreator {

// //     private static final String FILE_EXTENSION = '.csv';
// //     private static final String DATE_FORMAT = 'yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'';

// //     private static ICRUD crud;

// //     public static void initCrud(){
// //         if (crud == null){
// //             CRUD c = new CRUD();
// //             crud = c;
// //         }
// //     }

// //     public static void setCrud(ICrud crudRef){
// //         crud = crudRef;
// //     }

// //     public static ContentVersion saveContentVersion(String contentWorkspaceName, String contentFolderName, String contentVersionTitle, String content) {

// //         initCrud();

// //         List<String> stringParams = new List<String>{contentWorkspaceName, contentFolderName, contentVersionTitle, content};
// //         if (StringUtils.stringIsBlank(stringParams)) throw new ContentException(ContentException.getErrorMessage(ContentException.errorMsg.PARAMETERS_MSG_CONTENTVERSION));

// //         String title = makeDocumentTitle(contentVersionTitle);
// //         String pathOnClient = makePathOnClient(title);

// //         ContentVersion contentVersion = saveContentVersion(pathOnClient, title, content);

// //         ContentWorkspace contentWorkspace = getContentWorkSpace(contentWorkspaceName);

// //         ContentFolder contentWorkspaceContentFolder = getContentFolder(contentWorkspace.Id);

// //         ContentFolder childContentFolder = getContentFolder(contentFolderName);

// //         ContentDocumentLink contentDocumentlink = saveContentDocumentlink(contentVersion, contentWorkspace);

// //         saveContentFolderMember(contentWorkspaceContentFolder, childContentFolder);

// //         return contentVersion;
// //     }

// //     private static String makeDocumentTitle(String title){
// //         String timestamp = Datetime.now().format(DATE_FORMAT);
// //         String documentTitle = title + '-' + timeStamp;

// //         return documentTitle;
// //     }

// //     private static String makePathOnClient(String documentTitle){
// //         String pathOnClient = documentTitle + FILE_EXTENSION;

// //         return pathOnClient;
// //     }

// //     private static ContentVersion saveContentVersion(String pathOnClient, String documentTitle, String content) {
// //         ContentVersion cv;
// //         cv = crud.saveContentVersion(pathOnClient, documentTitle, content);

// //         return cv;
// //     }

// //     private static ContentWorkspace getContentWorkSpace(String contentWorkspaceName) {
// //         ContentWorkspace contentWorkspace;
// //         contentWorkspace = crud.getContentWorkSpace(contentWorkspaceName);

// //         if(contentWorkspace==null) throw new ContentException(ContentException.getErrorMessage(ContentException.errorMsg.NULL_MSG_CONTENTWORKSPACE));

// //         return contentWorkspace;
// //     }

// //     private static ContentFolder getContentFolder(String contentFolderName) {
// //         ContentFolder contentFolder = crud.getContentFolder(contentFolderName);

// //         if(contentFolder==null) throw new ContentException(ContentException.getErrorMessage(ContentException.errorMsg.NULL_MSG_CONTENTFOLDER));

// //         return contentFolder;
// //     }

// //     private static ContentDocumentLink saveContentDocumentlink(ContentVersion contentVersion, ContentWorkspace contentWorkSpace){
// //         ContentDocumentLink contentDocumentLink = crud.saveContentDocumentLink(contentVersion, contentWorkspace);

// //         if(contentDocumentLink==null) throw new ContentException(ContentException.getErrorMessage(ContentException.errorMsg.NULL_MSG_CONTENTDOCUMENTLINK));

// //         return contentDocumentLink;
// //     }

// //     private static void saveContentFolderMember(ContentFolder parentContentFolder, ContentFolder childContentFolder){
    
// //         ContentFolderMember contentFolderMember = CRUD.saveContentFolderMember(parentContentFolder.Id, childContentFolder.Id);

// //         if(contentFolderMember==null) throw new ContentException(ContentException.getErrorMessage(ContentException.errorMsg.NULL_MSG_CONTENTFOLDERMEMBER));
// //     }
// // }
