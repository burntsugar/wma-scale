public class CriteriaExpressionBuilder {

    private String fieldName;
    private CriteriaExpression.FieldOperator fieldOperator;
    private String fieldValue;
    private CriteriaExpression.CriteriaOperator criteriaOperator;

    public CriteriaExpressionBuilder() {

    }

    public CriteriaExpressionBuilder setFieldName(String fieldName) {
        this.fieldName = fieldName;
        return this;
    }

    public CriteriaExpressionBuilder setFieldOperator(CriteriaExpression.FieldOperator fieldOperator) {
        this.fieldOperator = fieldOperator;
        return this;
    }

    public CriteriaExpressionBuilder setfieldValue(String fieldValue) {
        this.fieldValue = fieldValue;
        return this;
    }

    public CriteriaExpressionBuilder setCriteriaOperator(CriteriaExpression.CriteriaOperator criteriaOperator) {
        this.criteriaOperator = criteriaOperator;
        return this;
    }

    public CriteriaExpression build(){
        return new CriteriaExpression(this.fieldName, this.fieldOperator, this.fieldValue, this.criteriaOperator);
    }
}
