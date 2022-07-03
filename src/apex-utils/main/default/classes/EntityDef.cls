public class EntityDef {
    public Integer size {get;set;} 
    public Integer totalSize {get;set;} 
    public Boolean done {get;set;} 
    public Object queryLocator {get;set;} 
    public String entityTypeName {get;set;} 
    public List<Record> records {get;set;} 
    
    public class EntityDefinition {
        public Attributes attributes {get;set;} 
        public String DurableId {get;set;} 
        public String QualifiedApiName {get;set;} 
    }
    public class Attributes {
        public String type_Z {get;set;} // in json: type
        public String url {get;set;} 
    }
    public class Record {
        public Attributes attributes {get;set;} 
        public EntityDefinition entityDefinition {get;set;} 
        public String DeveloperName {get;set;} 
        public String CreatedDate {get;set;} 
        public String LastModifiedDate {get;set;} 
        public String TableEnumOrId {get;set;} 
    } 
    
    public static EntityDef parse(String json){
        return (EntityDef) System.JSON.deserialize(json, EntityDef.class);
    }
}

// {
//     "size":2,
//     "totalSize":2,
//     "done":true,
//     "queryLocator":null,
//     "entityTypeName":"CustomField",
//     "records":[
//        {
//           "attributes":{
//              "type":"CustomField",
//              "url":"/services/data/v41.0/tooling/sobjects/CustomField/00N5j000009FZRPEA4"
//           },
//           "EntityDefinition":{
//              "attributes":{
//                 "type":"EntityDefinition",
//                 "url":"/services/data/v41.0/tooling/sobjects/EntityDefinition/Contact"
//              },
//              "DurableId":"Contact",
//              "QualifiedApiName":"Contact"
//           },
//           "DeveloperName":"Level",
//           "CreatedDate":"2022-01-07T00:38:25.000+0000",
//           "LastModifiedDate":"2022-01-07T00:38:25.000+0000",
//           "TableEnumOrId":"Contact"
//        },
//        {
//           "attributes":{
//              "type":"CustomField",
//              "url":"/services/data/v41.0/tooling/sobjects/CustomField/00N5j000009FZROEA4"
//           },
//           "EntityDefinition":{
//              "attributes":{
//                 "type":"EntityDefinition",
//                 "url":"/services/data/v41.0/tooling/sobjects/EntityDefinition/Contact"
//              },
//              "DurableId":"Contact",
//              "QualifiedApiName":"Contact"
//           },
//           "DeveloperName":"Languages",
//           "CreatedDate":"2022-01-07T00:38:25.000+0000",
//           "LastModifiedDate":"2022-01-07T00:38:25.000+0000",
//           "TableEnumOrId":"Contact"
//        }
//     ]
//  }


// public class EntityDef {
//     public Integer size {get;set;} 
//     public Integer totalSize {get;set;} 
//     public Boolean done {get;set;} 
//     public Object queryLocator {get;set;} 
//     public String entityTypeName {get;set;} 
//     public List<Record> records {get;set;} 
    
//     public class Layout {
//         public Attributes attributes {get;set;} 
//         public String Name {get;set;} 
//     }
//     public class Attributes {
//         public String type_Z {get;set;} // in json: type
//         public String url {get;set;} 
//     }
//     public class Record {
//         public Attributes attributes {get;set;} 
//         public Layout Layout {get;set;} 
//         public String LayoutId {get;set;} 
//         public String RecordTypeId {get;set;} 
//     } 
    
//     public static LayoutRecord parse(String json){
//         return (LayoutRecord) System.JSON.deserialize(json, LayoutRecord.class);
//     }
// }
