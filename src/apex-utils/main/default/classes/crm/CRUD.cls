public class CRUD implements ICrud {

    public SObject doInsert(SObject record) {
        insert(record);
        return record;
    }

    public SObject doUpdate(SObject record) {
        update(record);
        return record;
    }

    public ContentVersion getContentVersion(String contentVersionId){
        ContentVersion contentVersion = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:contentVersionId];

        return contentVersion;
    }

    public ContentWorkspace getContentWorkSpace(String contentWorkSpaceName){
        ContentWorkspace contentWorkSpace = [Select Id from ContentWorkspace where Name =: contentWorkSpaceName];

        return contentWorkSpace;
    }

    public ContentFolder getContentFolder(String contentFolderName){
        ContentFolder contentFolder = [Select Id from ContentFolder where Name =: contentFolderName];

        return contentFolder;
    }

    public ContentWorkSpace makeContentWorkspace(String name, String developerName){
        ContentWorkspace contentWorkSpace = new ContentWorkspace();
        contentWorkSpace.Name = name;
        contentWorkSpace.DeveloperName = developerName;
        
        this.doInsert(contentWorkSpace);

        return contentWorkSpace;
    }

    public ContentFolder makeContentFolder(String contentFolderName, String parentContentFolderId){
        ContentFolder contentFolder = new ContentFolder(Name=contentFolderName);
        contentFolder.ParentContentFolderId = parentContentFolderId;

        doInsert(contentFolder);

        return contentFolder;
    }

    public ContentDocumentLink makeContentDocumentLink(ContentVersion contentVersion, ContentWorkSpace contentWorkSpace) {
        Id conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:contentVersion.Id].ContentDocumentId;
        
        ContentDocumentLink contentDocumentLink = new ContentDocumentLink();
        contentDocumentLink.ContentDocumentId = conDoc;
        contentDocumentLink.LinkedEntityId = contentWorkSpace.Id; 
        contentDocumentLink.ShareType = 'I'; 

        doInsert(contentDocumentLink);

        return contentDocumentLink;
    }

    public ContentFolderMember makeContentFolderMember(String parentContentFolderId, String contentFolderId){
        ContentFolderMember cfm = [Select Id, ChildRecordId, ParentContentFolderId from ContentFolderMember where ParentContentFolderId =: parentContentFolderId];
        cfm.ParentContentFolderId = contentFolderId;

        doUpdate(cfm);

        return cfm;
    }
}

// public ContentFolderMember getContentFolderMember(String parentContentFolderId){
//     ContentFolderMember cfm = [Select Id, ChildRecordId, ParentContentFolderId from ContentFolderMember where ParentContentFolderId =: parentContentFolderId];
//     return cfm;
// }

    // public List<sObject> doSelect(String id, String objectName) {
    //     String q = 'SELECT id FROM ' + objectName;
    //     List<sObject> o = Database.query(q);
    //     return o;
    // }


// public class CRUD implements ICrud {

//     public SObject doInsert(SObject record) {
//         insert(record);
//         return record;
//     }

//     public SObject doUpdate(SObject record) {
//         update(record);
//         return record;
//     }

//     public List<sObject> doSelect(String id, String objectName) {
//         String q = 'SELECT id FROM ' + objectName;
//         List<sObject> o = Database.query(q);
//         return o;
//     }
//     public ContentVersion getContentVersion(String contentVersionId){
//         // ContentVersion conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:contentVersionId].ContentDocumentId;
//         ContentVersion conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:contentVersionId];

//         return conDoc;
//     }

//     public ContentWorkSpace makeContentWorkspace(String name, String developerName){
//         ContentWorkspace cw = new ContentWorkspace();
//         cw.Name = name;
//         cw.DeveloperName = developerName;
        
//         this.doInsert(cw);
//         return cw;

//     }

//     // public ContentVersion getContentVersionByTitle(String contentVersionTitle){
//     //     String contentVersionTitleStr = '%' + contentVersionTitle + '%';
//     //     // ContentVersion conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:contentVersionId].ContentDocumentId;
//     //     ContentVersion conDoc = [SELECT ContentDocumentId, Title FROM ContentVersion WHERE Title LIKE :contentVersionTitleStr];

//     //     return conDoc;
//     // }

//     public ContentWorkspace getContentWorkSpace(String workSpaceLibraryName){
//         ContentWorkspace libraryContentWorkSpace = [Select Id from ContentWorkspace where Name =: workSpaceLibraryName];
//         return libraryContentWorkSpace;
//     }

//     // public ContentFolder getLibraryContentFolder(String WorkSpaceId){
//     //     ContentFolder libraryContentFolder = [Select Id from ContentFolder where Name =: WorkSpaceId];
//     //     return libraryContentFolder;
//     // }

//     public ContentFolder getContentFolder(String contentFolderName){
//         ContentFolder folder = [Select Id from ContentFolder where Name =: contentFolderName];
//         return folder;
//     }

//     public ContentFolderMember getContentFolderMember(ContentFolder libraryContentFolder){
//         ContentFolderMember cfm = [Select Id, ChildRecordId, ParentContentFolderId from ContentFolderMember where ParentContentFolderId =: libraryContentFolder.Id];
//         return cfm;
//     }

//     public ContentDocumentLink makeContentDocumentLink(ContentVersion contentVersion,ContentWorkSpace contentWorkspace) {
    
//     // Id conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:cv.Id].ContentDocumentId;
    
//     ContentDocumentLink cDe = new ContentDocumentLink();
//     cDe.ContentDocumentId = contentVersion.ContentDocumentId;
//     cDe.LinkedEntityId = contentWorkspace.Id; 
//     cDe.ShareType = 'I'; 

//     System.Debug('CDE:::' + cDe);

//     doInsert(cDe);

//     return cde;
//     }


//     public ContentFolder makeContentFolder(ContentVersion contentVersion, String contentFolderName, ContentWorkspace contentWorkspace){
        
//         //ContentFolder cf = getLibraryContentFolder(contentWorkspace.Id);

//         // get workspace folder
//         // ContentFolder libraryContentFolder = getLibraryContentFolder(contentWorkspace.Id);

//         ContentFolder libraryContentFolder = getContentFolder(contentWorkspace.Id);


//         ContentFolder contentFolder = new ContentFolder(Name=contentFolderName);
//         contentFolder.ParentContentFolderId = libraryContentFolder.Id;
//         doInsert(contentFolder);

        


//        // makeContentDocumentLink(contentVersion,contentWorkspace);



//         //ContentFolderMember cfm = new ContentFolderMember();

//         // ContentFolderMember cfm = getContentFolderMember(cf);
//         ContentFolderMember cfm = new ContentFolderMember();
//         cfm.ParentContentFolderId = contentFolder.Id;
//         //cfm.ChildRecordId = contentFolder.Id;

//         // doUpdate(cfm);
//         doInsert(cfm);


//         return contentFolder;
//     }

//     // ContentFolderMember

// }

// public ContentFolder makeContentFolder(ContentVersion contentVersion, String contentFolderName, ContentWorkspace contentWorkspace){
//     ContentFolder libraryContentFolder = getContentFolder(contentWorkspace.Id);

//     ContentFolder contentFolder = new ContentFolder(Name=contentFolderName);
//     contentFolder.ParentContentFolderId = libraryContentFolder.Id;
//     doInsert(contentFolder);

//     ContentFolderMember cfm = new ContentFolderMember();
//     cfm.ParentContentFolderId = contentFolder.Id;

//     doInsert(cfm);

//     return contentFolder;
// }
