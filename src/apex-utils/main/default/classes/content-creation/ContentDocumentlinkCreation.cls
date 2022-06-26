public virtual class ContentDocumentlinkCreation {

    private IContentDocumentLinkCrud crud;

    protected void initCrud(){
        if (crud == null){
            ContentDocumentLinkCrud c = new ContentDocumentLinkCrud();
            crud = c;
        }
    }

    public void setCrud(IContentDocumentLinkCrud crudRef){
        crud = crudRef;
    }
    
    public ContentDocumentlinkCreation() {
        initCrud();
    }
    
    public virtual void create(ContentVersion contentVersion, ContentWorkspace contentWorkSpace) {
        Id conDoc;
        try {
            conDoc = DBCrud.doSelectContentDocumentId(contentVersion.Id);
        } catch (NullPointerException np) {
            throw new ContentException(ContentException.getErrorMessage(ContentException.errorMsg.QUERY_EX_MSG_INVALID_PARAMETERS));
        } catch (QueryException qe) {
            throw new ContentException(ContentException.getErrorMessage(ContentException.errorMsg.QUERY_EX_MSG_INVALID_PARAMETERS));
        } catch (Exception e) {
            throw e;
        }

        try {
            ContentDocumentLink cDe = new ContentDocumentLink();
            cDe.ContentDocumentId = conDoc;
            cDe.LinkedEntityId = contentWorkSpace.Id; 
            cDe.ShareType = 'I'; 
            ContentDocumentLinkCrud.insertContentDocumentLink(cde);
        } catch (NullPointerException np) {
            throw new ContentException(ContentException.getErrorMessage(ContentException.errorMsg.PARAMETERS_MSG_CONTENTWORKSPACE));
        }

        // here

        // ContentFolderMember cfm = [Select Id, ChildRecordId, ParentContentFolderId from ContentFolderMember where ParentContentFolderId =: libraryContentFolder.Id];
        // cfm.ParentContentFolderId = folder.Id;
        // update cfm;
        ///

    }
}
