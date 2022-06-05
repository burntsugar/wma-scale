public with sharing class SaveToSalesforce {

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

    public static ContentVersion save(String contentWorkspaceName, String contentFolderName, String contentVersionTitle, String content) {
        
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

        try {
            cv = crud.saveContentVersion(pathOnClient, documentTitle, content);
        } catch (DmlException dmle) {
            throw new ContentException(ContentException.getErrorMessage(ContentException.errorMsg.DML_EX_MSG_CONTENTVERSION), dmle);
        } catch (Exception e) {
            throw new ContentException(ContentException.getErrorMessage(ContentException.errorMsg.EX_MSG_CONTENTVERSION), e);
        }

        return cv;
    }

    private static ContentWorkspace getContentWorkSpace(String contentWorkspaceName) {
        ContentWorkspace contentWorkspace;

        try {
            contentWorkspace = crud.getContentWorkSpace(contentWorkspaceName);
        } catch (DmlException dmle) {
            throw new ContentException(ContentException.getErrorMessage(ContentException.errorMsg.DML_EX_MSG_CONTENTWORKSPACE), dmle);
        } catch (Exception e) {
            throw new ContentException(ContentException.getErrorMessage(ContentException.errorMsg.EX_MSG_CONTENTWORKSPACE), e);
        }

        if(contentWorkspace==null) throw new ContentException(ContentException.getErrorMessage(ContentException.errorMsg.NULL_MSG_CONTENTWORKSPACE));

        return contentWorkspace;
    }

    private static ContentFolder getContentFolder(String contentFolderName) {
        ContentFolder contentFolder;

        try {
            contentFolder = crud.getContentFolder(contentFolderName);
        } catch (DmlException dmle) {
            throw new ContentException(ContentException.getErrorMessage(ContentException.errorMsg.DML_EX_MSG_CONTENTFOLDER), dmle);
        } catch (Exception e) {
            throw new ContentException(ContentException.getErrorMessage(ContentException.errorMsg.EX_MSG_CONTENTFOLDER), e);
        }

        if(contentFolder==null) throw new ContentException(ContentException.getErrorMessage(ContentException.errorMsg.NULL_MSG_CONTENTFOLDER));

        return contentFolder;
    }

    private static ContentDocumentLink saveContentDocumentlink(ContentVersion contentVersion, ContentWorkspace contentWorkSpace){
        ContentDocumentLink contentDocumentLink;

        try {
            contentDocumentLink = crud.saveContentDocumentLink(contentVersion, contentWorkspace);
        } catch (DmlException dmle) {
            throw new ContentException(ContentException.getErrorMessage(ContentException.errorMsg.DML_EX_MSG_CONTENTDOCUMENTLINK), dmle);
        } catch (Exception e) {
            throw new ContentException(ContentException.getErrorMessage(ContentException.errorMsg.EX_MSG_CONTENTDOCUMENTLINK), e);
        }

        if(contentDocumentLink==null) throw new ContentException(ContentException.getErrorMessage(ContentException.errorMsg.NULL_MSG_CONTENTDOCUMENTLINK));

        return contentDocumentLink;
    }

    private static void saveContentFolderMember(ContentFolder parentContentFolder, ContentFolder childContentFolder){
    
        ContentFolderMember contentFolderMember;
        try {
            contentFolderMember = CRUD.saveContentFolderMember(parentContentFolder.Id, childContentFolder.Id);
        } catch (DmlException dmle) {
            throw new ContentException(ContentException.getErrorMessage(ContentException.errorMsg.DML_EX_MSG_CONTENTFOLDERMEMBER), dmle);
        } catch (Exception e) {
            throw new ContentException(ContentException.getErrorMessage(ContentException.errorMsg.EX_MSG_CONTENTFOLDERMEMBER), e);
        }

        if(contentFolderMember==null) throw new ContentException(ContentException.getErrorMessage(ContentException.errorMsg.NULL_MSG_CONTENTFOLDERMEMBER));
    }
}
