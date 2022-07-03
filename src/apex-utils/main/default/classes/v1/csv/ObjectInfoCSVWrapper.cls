public class ObjectInfoCSVWrapper {

    private CSVHeaders cSVHeaders;
    private CSVRows cSVRows;
    
    private ObjectInfoExtract objectInfoExtract;
    private String csvTitle;

    public ObjectInfoCSVWrapper(ObjectInfoExtract objectInfoExtract, String csvTitle) {
        this.objectInfoExtract = objectInfoExtract;
        this.csvTitle = csvTitle;
    }

    public CSVHeaders makecSVHeaders(){
        cSVHeaders = new CSVHeaders();

        for(String o: objectInfoExtract.getCSV_Headers()){
            cSVHeaders.addCSVHeader(o);
        }

        for (String s: objectInfoExtract.getObjectInfoRecordTypes().get(0).getCSV_Headers()) {
            cSVHeaders.addCSVHeader(s);
        }

        return cSVHeaders;
    }

    public CSVRows makecSVRows(){
        cSVRows = new CSVRows();
        List<ObjectInfoRecordType> rts = objectInfoExtract.getObjectInfoRecordTypes();
        for (ObjectInfoRecordType rt: rts){
            cSVRows.addCSVRow(objectInfoExtract.getObjectAPIName() + ',' + rt.getRecordTypeDeveloperName() + ',' + rt.getRecordTypeId());
            for (ObjectInfoField f: rt.getObjectInfoFields()){
                cSVRows.addCSVRow(objectInfoExtract.getObjectAPIName() + ',' + rt.getRecordTypeDeveloperName() + ',' + rt.getRecordTypeId() + ',' + f.getCsvStrings());
            }
        }
        return cSVRows;
    }

    public String getCsvTitle(){
        return this.csvTitle;
    }
}
