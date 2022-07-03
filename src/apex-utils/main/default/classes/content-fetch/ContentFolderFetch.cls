public virtual class ContentFolderFetch {

    private IContentFolderCrud crud;

    protected void initCrud(){
        if (crud == null){
            ContentFolderCrud c = new ContentFolderCrud();
            crud = c;
        }
    }

    public void setCrud(IContentFolderCrud crudRef){
        crud = crudRef;
    }
    
    public ContentFolderFetch() {
        initCrud();
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * Retrieve a ContentFolder.
    * @param contentFolderName String. Name of ContentFolder.
    * @return ContentFolder instance.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    public virtual ContentFolder fetch(String contentFolderName) {
       
        List<ContentFolder> results = crud.getContentFolder(ContentFolderFieldSelectors.Name, contentFolderName);

        if(results.size() != 1) throw new ContentException(ContentException.getErrorMessage(ContentException.errorMsg.NULL_MSG_CONTENTFOLDER));

        ContentFolder cf = results.get(0);

        return cf;
    }
}
