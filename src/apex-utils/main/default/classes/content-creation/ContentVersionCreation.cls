public virtual class ContentVersionCreation {

    private final String FILE_EXTENSION = '.csv';
    private final String DATE_FORMAT = 'yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'';

    private IContentVersionCrud crud;

    protected void initCrud(){
        if (crud == null){
            ContentVersionCrud c = new ContentVersionCrud();
            crud = c;
        }
    }

    public void setCrud(IContentVersionCrud crudRef){
        crud = crudRef;
    }

    public ContentVersionCreation() {
        initCrud();
    }

    public virtual ContentVersion create(String contentVersionTitle, String content) {

        List<String> stringParams = new List<String>{contentVersionTitle, content};

        if(!isValidParams(stringParams)){
            throw new ContentException(ContentException.getErrorMessage(ContentException.errorMsg.PARAMETERS_MSG_CONTENTVERSION));
        }

        String title = makeDocumentTitle(contentVersionTitle);

        String pathOnClient = makePathOnClient(title);

        ContentVersion contentVersion = makeContentVersion(pathOnClient, title, content, ContentVersionContentLocations.S);

        saveContentVersion(contentVersion);

        return contentVersion;
    }

    protected virtual boolean isValidParams(List<String> params) {
        if (StringUtils.stringIsBlank(params)) {
            return false;
        }
        return true;
    }

    protected virtual String makeDocumentTitle(String title){
        String timestamp = Datetime.now().format(DATE_FORMAT);
        String documentTitle = title + '-' + timeStamp;

        return documentTitle;
    }

    protected virtual String makePathOnClient(String documentTitle){
        String pathOnClient = documentTitle + FILE_EXTENSION;

        return pathOnClient;
    }

    protected ContentVersion makeContentVersion(String pathOnClient, String documentTitle, String content, ContentVersionContentLocations contentLocation) {

        ContentVersion cv = new ContentVersion();
        cv.ContentLocation = getEnumValueForContentLocations(contentLocation); 
        cv.Title = documentTitle; 
        cv.PathOnClient = pathOnClient;
        cv.VersionData = Blob.valueOf(content);

        return cv;
    }

    protected void saveContentVersion(ContentVersion contentVersion) {
        Database.SaveResult sr = crud.insertContentVersion(contentVersion);

        if (!sr.isSuccess()) {
            throw new ContentException(ContentException.makeSRErrors(sr));
        }
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * Get string value for a given contentLocation.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    * @param    contentLocation    ContentLocations enum. Field name selector.
    * @return    String value for contentLocation.
    * ───────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    public String getEnumValueForContentLocations(ContentVersionContentLocations contentLocation) {
        String cntLocation;
        switch on contentLocation{
            when S {
                cntLocation = 'S';
            }
            when E {
                cntLocation = 'E';
            }
            when L {
                cntLocation = 'L';
            }
        }
        return cntLocation;
    }
}
