public virtual class ContentWorkspaceFetch {

    private IContentWorkspaceCrud crud;

    protected void initCrud(){
        if (crud == null){
            ContentWorkspaceCrud c = new ContentWorkspaceCrud();
            crud = c;
        }
    }

    public void setCrud(IContentWorkspaceCrud crudRef){
        crud = crudRef;
    }
    
    public ContentWorkspaceFetch() {
        initCrud();
    }

    public virtual ContentWorkspace fetch(String contentWorkspaceName) {
        
        List<ContentWorkspace> results = crud.getContentWorkSpace(ContentWorkSpaceFieldSelectors.Name,contentWorkspaceName);

        if(results.size() != 1) throw new ContentException(ContentException.getErrorMessage(ContentException.errorMsg.NULL_MSG_CONTENTWORKSPACE));

        ContentWorkspace contentWorkspace = results.get(0);
        return contentWorkspace;
    }
}
