public class ContentException extends Exception {

    public enum errorMsg {
        BLOB_SIZE_MSG_CONTENTVERSION,
        PARAMETERS_MSG_CONTENTVERSION,
        EX_MSG_CONTENTVERSION,
        EX_MSG_CONTENTWORKSPACE,
        EX_MSG_CONTENTFOLDER,
        EX_MSG_CONTENTDOCUMENTLINK,
        EX_MSG_CONTENTFOLDERMEMBER,
        DML_EX_MSG_CONTENTVERSION,
        DML_EX_MSG_CONTENTWORKSPACE,
        DML_EX_MSG_CONTENTFOLDER,
        DML_EX_MSG_CONTENTDOCUMENTLINK,
        DML_EX_MSG_CONTENTFOLDERMEMBER
    }

    private static String elseString = 'An error occured.';

    public static String getErrorMessage(errorMsg em) {
        String errMsg;
        switch on em {
            when BLOB_SIZE_MSG_CONTENTVERSION {
                errMsg = 'ContentVersion blob size exceeded.';
            }
            when PARAMETERS_MSG_CONTENTVERSION {
                errMsg = 'ContentVersion parameters cannot be blank';
            }
            when EX_MSG_CONTENTVERSION {
                errMsg = 'An Error occured during ContentVersion operation.';
            }
            when EX_MSG_CONTENTWORKSPACE {
                errMsg = 'An Error occured during ContentWorkspace operation.';
            }
            when EX_MSG_CONTENTFOLDER {
                errMsg = 'An Error occured during ContentFolder operation.';
            }
            when EX_MSG_CONTENTDOCUMENTLINK {
                errMsg = 'An Error occured during ContentDocumentLink operation.';
            }
            when EX_MSG_CONTENTFOLDERMEMBER {
                errMsg = 'An Error occured during ContentFolderMember operation.';
            }
            when DML_EX_MSG_CONTENTVERSION {
                errMsg = 'DML Error occured during ContentVersion DML operation.';
            }
            when DML_EX_MSG_CONTENTWORKSPACE {
                errMsg = 'DML Error occured during ContentWorkspace DML operation.';
            }
            when DML_EX_MSG_CONTENTFOLDER {
                errMsg = 'An Error occured during ContentFolder DML operation.';
            }
            when DML_EX_MSG_CONTENTDOCUMENTLINK {
                errMsg = 'DML Error occured during ContentDocumentLink DML operation.';
            }
            when DML_EX_MSG_CONTENTFOLDERMEMBER {
                errMsg = 'An Error occured during ContentFolderMember DML operation.';
            }
            when else {
                errMsg = elseString;
            }
        }

        return errMsg;
    }

}
