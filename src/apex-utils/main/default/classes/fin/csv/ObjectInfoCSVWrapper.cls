public class ObjectInfoCSVWrapper {

    private CSVHeaders cSVHeaders;
    private CSVRows cSVRows;
    
    private ObjectInfoExtract objectInfoExtract;
    private String csvTitle;

    public ObjectInfoCSVWrapper(ObjectInfoExtract objectInfoExtract, String csvTitle) {
        this.objectInfoExtract = objectInfoExtract;
        this.csvTitle = csvTitle;
    }

    private void makecSVHeaders(){
        cSVHeaders = new CSVHeaders();

        for(String o: objectInfoExtract.getCSV_Headers()){
            cSVHeaders.addCSVHeader(o);
        }

        for (String s: objectInfoExtract.getObjectInfoRecordTypes().get(0).getCSV_Headers()) {
            cSVHeaders.addCSVHeader(s);
        }
    }

    private void makecSVRows(){
        cSVRows = new CSVRows();
        List<ObjectInfoRecordType> rts = objectInfoExtract.getObjectInfoRecordTypes();
        for (ObjectInfoRecordType rt: rts){
            cSVRows.addCSVRow(objectInfoExtract.getObjectAPIName() + ',' + rt.getRecordTypeDeveloperName() + ',' + rt.getRecordTypeId());
            for (ObjectInfoField f: rt.getObjectInfoFields()){
                cSVRows.addCSVRow(objectInfoExtract.getObjectAPIName() + ',' + rt.getRecordTypeDeveloperName() + ',' + rt.getRecordTypeId() + ',' + f.getCsvStrings());
            }
        }
    }

    // public List<String> getCSVHeaders() {
    //     if (cSVHeaders == null) {
    //         makecSVHeaders();
    //     }
    //     return this.cSVHeaders.getCSVHeaders();
    // }

    // public List<String> getCSVRows(){
    //     if (cSVRows == null){
    //         makecSVRows();
    //     }
    //     return this.cSVRows.getCSVRows();
    // }

    public String getCsvTitle(){
        return this.csvTitle;
    }

    public String createCSVContent(){
        makecSVHeaders();
        makecSVRows();
        String headerRow = String.join(cSVHeaders.getCSVHeaders(),',') + '\n';
        String concantenatedStr = headerRow;
        Integer i = 0;
        Integer rowListSize = cSVRows.getCSVRows().size();

        try {
            for(String row :cSVRows.getCSVRows()){
            
                i++;
                List<String> res = row.split(',');
                String str = String.join(res,',');
                concantenatedStr += (String)str + ((i != rowListSize) ? '\n' : '');//add new line
            }
            csvTitle += '.csv';
        } catch (StringException stre) {
            throw new ContentException(ContentException.getErrorMessage(ContentException.errorMsg.BLOB_SIZE_MSG_CONTENTVERSION), stre);
        }
        return concantenatedStr;
    }
}
