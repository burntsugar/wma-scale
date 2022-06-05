public with sharing class GetFieldsForlayout {

    public static Map<String,List<String>> getFields(string objectAPIName, string layoutName) {

        if (layoutName == null ) return null;

        // layoutName, fields.
        Map<String,List<String>> m = new Map<String,List<String>>();
        string requestLayoutName=String.format('{0}-{1}', new String[]{objectAPIName, layoutName}); 
        List<Metadata.Metadata> layouts = Metadata.Operations.retrieve(Metadata.MetadataType.Layout, new List<String> {requestLayoutName});
        List<string> fields=new List<string>();
        Metadata.Layout layoutMd = (Metadata.Layout)layouts.get(0);
        for (Metadata.LayoutSection section : layoutMd.layoutSections) {
            for (Metadata.LayoutColumn column : section.layoutColumns) {
                if (column.layoutItems != null) {
                    List<String> attrValue = new List<String>();
                    for (Metadata.LayoutItem item : column.layoutItems) {
                        fields.add(item.field);
                        attrValue.add(item.field);
                    }
                    if (!m.containsKey(layoutName)){
                        m.put(layoutName,new List<String>());
                    }
                    m.get(layoutName).addAll(attrValue);
                }
            }
        }
        return m;
    }
}
