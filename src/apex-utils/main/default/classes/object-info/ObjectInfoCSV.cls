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
