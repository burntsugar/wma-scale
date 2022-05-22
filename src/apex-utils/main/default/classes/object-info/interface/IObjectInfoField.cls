public interface IObjectInfoField {
    
    String getFieldAPIName();
    String getLabel();
    String getDefaultValue();
    boolean getIsCustom();
    boolean getIsNameField();
    boolean getIsNillable();
    String getFieldDataType();
    String getFieldLength();
    boolean getIsAutoNumber();
    boolean getIsCalculated();
    boolean getIsDependentPicklist();
    boolean getIsExternalId();
    boolean getIsIdLookup();
    boolean getIsUnique();
    String getScale();
    String getPrecision();
    // void addToObjectInfoFields(List<IObjectInfoField> objectInfoFields);
    // List<IObjectInfoField> getObjectInfoFields();



    void addToPicklistValues(List<String> pickListValues);
    List<String> getPicklistValues();



}
