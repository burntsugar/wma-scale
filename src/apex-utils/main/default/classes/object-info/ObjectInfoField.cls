public with sharing class ObjectInfoField {

    private String fieldAPIName;
    private String label;
    private String defaultValue;
    private boolean isCustom;
    private boolean isNameField;
    private boolean isNillable;
    private String fieldDataType;
    private String fieldLength;
    private boolean isAutoNumber;
    private boolean isCalculated;
    private boolean isDependentPicklist;
    private boolean isExternalId;
    private boolean isIdLookup;
    private boolean isUnique;
    private String scale;
    private String precision;

    private List<String> picklistValues;


    public ObjectInfoField(String fieldAPIName, String label,
    String defaultValue,
    boolean isCustom,
    boolean isNameField,
    boolean isNillable,
    String fieldDataType,
    String fieldLength,
    boolean isAutoNumber,
    boolean isCalculated,
    boolean isDependentPicklist,
    boolean isExternalId,
    boolean isIdLookup,
    boolean isUnique,
    String scale,
    String precision) {
        this.fieldAPIName = fieldAPIName;
        this.label = label;
        this.defaultValue = defaultValue;
        this.isCustom = isCustom;
        this.isNameField = isNameField;
        this.isNillable = isNillable;
        this.fieldDataType = fieldDataType;
        this.fieldLength = fieldLength;
        this.isAutoNumber = isAutoNumber;
        this.isCalculated = isCalculated;
        this.isDependentPicklist = isDependentPicklist;
        this.isExternalId = isExternalId;
        this.isIdLookup = isIdLookup;
        this.isUnique = isUnique;
        this.scale = scale;
        this.precision = precision;
    }

    public String getFieldAPIName(){
        return this.fieldAPIName;
    }

    public String getLabel() {
        return this.label;
    }

    public String getDefaultValue(){
        return this.defaultValue;
    }
    public boolean getIsCustom(){
        return this.isCustom;
    }
    public boolean getIsNameField(){
        return this.isNameField;
    }
    public boolean getIsNillable(){
        return this.isNillable;
    }
    public String getFieldDataType(){
        return this.fieldDataType;
    }
    public String getFieldLength(){
        return this.fieldLength;
    }
    public boolean getIsAutoNumber(){
        return this.isAutoNumber;
    }
    public boolean getIsCalculated(){
        return this.isCalculated;
    }
    public boolean getIsDependentPicklist(){
        return this.isDependentPicklist;
    }
    public boolean getIsExternalId(){
        return this.isExternalId;
    }
    public boolean getIsIdLookup(){
        return this.isIdLookup;
    }
    public boolean getIsUnique(){
        return this.isUnique;
    }
    public String getScale(){
        return this.scale;
    }
    public String getPrecision(){
        return this.precision;
    }

    public void addToPicklistValues(List<String> pickListValues){
        if (this.picklistValues == null){
            this.picklistValues = new list<String>();
        }
        pickListValues.addAll(pickListValues);
    }

    public List<String> getPicklistValues(){
        if (this.picklistValues == null){
            this.picklistValues = new list<String>();
        }
        return this.picklistValues;
    }

    public String getCsvStrings() {
        String[] s = new String[] {String.valueOf(this.fieldAPIName),String.valueOf(this.label),String.valueOf(this.defaultValue),String.valueOf(this.isCustom),String.valueOf(this.isNameField),String.valueOf(this.isNillable),String.valueOf(this.fieldDataType),String.valueOf(this.fieldLength),String.valueOf(this.isAutoNumber),String.valueOf(this.isCalculated),String.valueOf(this.isDependentPicklist),String.valueOf(this.isExternalId),String.valueOf(this.isIdLookup),String.valueOf(this.isUnique),String.valueOf(this.scale),String.valueOf(this.precision)};
        String sss = String.join(s,',');
        System.Debug('SSSSSSSSTTTRINGS :::: ' + sss);

        return sss;
    }
}
