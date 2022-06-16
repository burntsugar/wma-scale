public virtual class ContentWorkspaceCreation {
    
    // TODO 
    
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

    public ContentWorkspaceCreation() {
        initCrud();
    }

        /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * Create a ContentWorkspace record.
    * @param TODO.
    * @param TODO.
    * @return ContentWorkspace instance.
    ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    public virtual ContentWorkspace create() {
        return null;
    }
}
