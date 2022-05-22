public class ObjectInfoExtract implements IObjectInfoExtract {
    
    	private String objectAPIName;
        private List<ObjectInfoRecordType> objectInfoRecordTypes;
        // public static final String[] CSV_HEADERS = new String[] {'Object API Name'};

        public final String[] CSV_HEADERS = new String[] {'Object API Name'};



        public ObjectInfoExtract(){
            if (objectInfoRecordTypes == null) {
                objectInfoRecordTypes = new List<ObjectInfoRecordType>();
            }
        }

        public String[] getCSV_Headers(){
            return this.CSV_HEADERS;
        }

        public void addObjectInfoRecordType(ObjectInfoRecordType objectInfoRecordType){
            objectInfoRecordTypes.add(objectInfoRecordType);
        }

        public String getObjectAPIName(){
            return this.objectAPIName;
        }

        public List<ObjectInfoRecordType> getObjectInfoRecordTypes(){
            return this.objectInfoRecordTypes;
        }
    
        public String setObjectAPIName(String objectAPIName){
            return this.objectAPIName = objectAPIName;
        }

}