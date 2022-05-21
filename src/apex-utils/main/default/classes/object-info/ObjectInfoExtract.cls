public class ObjectInfoExtract implements ObjectInfoExtractWrapping {
    
    	private String objectAPIName;
        private List<ObjectInfoRecordType> objectInfoRecordTypes;

        public ObjectInfoExtract(){
            if (objectInfoRecordTypes == null) {
                objectInfoRecordTypes = new List<ObjectInfoRecordType>();
            }
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