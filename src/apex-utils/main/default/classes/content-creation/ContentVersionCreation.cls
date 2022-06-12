public virtual class ContentVersionCreation {

    private final String FILE_EXTENSION = '.csv';
    private final String DATE_FORMAT = 'yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'';

    private IContentVersionCrud crud;

    public void initCrud(){
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

    public virtual ContentVersion create(String contentFolderName, String contentVersionTitle, String content) {

        List<String> stringParams = new List<String>{contentFolderName, contentVersionTitle, content};

        if(!isValidParams(stringParams)){
            throw new ContentException(ContentException.getErrorMessage(ContentException.errorMsg.PARAMETERS_MSG_CONTENTVERSION));
        }

        String title = makeDocumentTitle(contentVersionTitle);

        String pathOnClient = makePathOnClient(title);

        ContentVersion contentVersion = makeContentVersion(pathOnClient, title, content);

        saveContentVersion(contentVersion);

        return contentVersion;
    }

    public virtual boolean isValidParams(List<String> params) {
        if (StringUtils.stringIsBlank(params)) {
            return false;
        }
        return true;
    }

    public virtual String makeDocumentTitle(String title){
        String timestamp = Datetime.now().format(DATE_FORMAT);
        String documentTitle = title + '-' + timeStamp;

        return documentTitle;
    }

    public virtual String makePathOnClient(String documentTitle){
        String pathOnClient = documentTitle + FILE_EXTENSION;

        return pathOnClient;
    }

    public virtual ContentVersion makeContentVersion(String pathOnClient, String documentTitle, String content) {

        ContentVersion cv = new ContentVersion();
        cv.ContentLocation = getEnumValueFor(ContentVersionContentLocations.S); 
        cv.Title = documentTitle; 
        cv.PathOnClient = pathOnClient;
        cv.VersionData = Blob.valueOf(content);

        return cv;
    }

    public void saveContentVersion(ContentVersion contentVersion) {
        Database.SaveResult sr = crud.insertContentVersion(contentVersion);

        if (!sr.isSuccess()) {
            throw new ContentException(makeSRErrors(sr));
        }
    }

    private String makeSRErrors(Database.SaveResult sr) {
        String ers;
        ers += 'The following errors occurred: ';   
        Integer count = 1;
        for (Database.Error er : sr.getErrors()) {         
            ers += count + ': ' + er.getStatusCode() + ': ' + er.getMessage();
            ers += ' - Account fields that affected this error: ' + er.getFields();
            count++;
        }
        return ers;
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * Get string value for a given contentLocation.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    * @param    contentLocation    ContentLocations enum. Field name selector.
    * @return    String value for contentLocation.
    * ───────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    public String getEnumValueFor(ContentVersionContentLocations contentLocation) {
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
