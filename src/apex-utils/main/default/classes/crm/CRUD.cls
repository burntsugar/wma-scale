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
        // ContentVersion conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:contentVersionId].ContentDocumentId;
        ContentVersion conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:contentVersionId];

        return conDoc;
    }

    // public ContentVersion getContentVersionByTitle(String contentVersionTitle){
    //     String contentVersionTitleStr = '%' + contentVersionTitle + '%';
    //     // ContentVersion conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:contentVersionId].ContentDocumentId;
    //     ContentVersion conDoc = [SELECT ContentDocumentId, Title FROM ContentVersion WHERE Title LIKE :contentVersionTitleStr];

    //     return conDoc;
    // }

    public ContentWorkspace getContentWorkSpace(String workSpaceLibraryName){
        ContentWorkspace libraryContentWorkSpace = [Select Id from ContentWorkspace where Name =: workSpaceLibraryName];
        return libraryContentWorkSpace;
    }

    public ContentFolder getLibraryContentFolder(String WorkSpaceId){
        ContentFolder libraryContentFolder = [Select Id from ContentFolder where Name =: WorkSpaceId];
        return libraryContentFolder;
    }

    public ContentFolder getContentFolder(String contentFolderName){
        ContentFolder folder = [Select Id from ContentFolder where Name =: contentFolderName];
        return folder;
    }

    public ContentFolderMember getContentFolderMember(ContentFolder libraryContentFolder){
        ContentFolderMember cfm = [Select Id, ChildRecordId, ParentContentFolderId from ContentFolderMember where ParentContentFolderId =: libraryContentFolder.Id];
        return cfm;
    }

}
