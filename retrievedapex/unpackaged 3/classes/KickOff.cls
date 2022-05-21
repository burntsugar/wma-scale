public class KickOff {
    
    public void Go(String objectAPIName){
        GetFieldInfo g = new GetFieldInfo();
        List<ObjectInfoWrapper> returnVals = g.getObjectInfo(objectAPIName);
        for (ObjectInfoWrapper s : returnVals) {
            System.Debug(s.objectAPIName);
            System.Debug(s.recordTypeDeveloperName);
            System.Debug(s.recordTypeId);
        }
    }

}