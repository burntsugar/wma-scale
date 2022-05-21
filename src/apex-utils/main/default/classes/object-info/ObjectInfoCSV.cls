public with sharing class ObjectInfoCSV implements CSVWrapping {

    private CSVHeaders cSVHeaders;
    private CSVRows cSVRows;
    
    private ObjectInfoExtract objectInfoExtract;
    private String csvTitle;

    public ObjectInfoCSV(ObjectInfoExtract objectInfoExtract, String csvTitle) {
        this.objectInfoExtract = objectInfoExtract;
        this.csvTitle = csvTitle;
    }

    private void makecSVHeaders(){
        // TODO replace with constants.
        cSVHeaders = new CSVHeaders();
        cSVHeaders.addCSVHeader('Object API Name');
        cSVHeaders.addCSVHeader('RT Developer Name');
        cSVHeaders.addCSVHeader('RT Id');
    }

    private void makecSVRows(){
        cSVRows = new CSVRows();
        List<ObjectInfoRecordType> rts = objectInfoExtract.getObjectInfoRecordTypes();
        for (ObjectInfoRecordType rt: rts){
            cSVRows.addCSVRow(objectInfoExtract.getObjectAPIName() + ',' + rt.getRecordTypeDeveloperName() + ',' + rt.getRecordTypeId());
        }
    }

    public CSVHeaders getCSVHeaders() {
        if (cSVHeaders == null) {
            makecSVHeaders();
        }
        return this.cSVHeaders;
    }
    public CSVRows getCSVRows(){
        if (cSVRows == null){
            makecSVRows();
        }
        return this.cSVRows;
    }

    public String getCsvTitle(){
        return this.csvTitle;
    }
}
