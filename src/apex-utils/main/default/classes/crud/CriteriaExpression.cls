public class CriteriaExpression {

    public enum FieldOperator {
        EQUALS_FIELD
    }

    public enum CriteriaOperator {
        AND_CRIT,
        OR_CRIT
    }

    private final String fieldName;
    private final String fieldOperator;
    private final String fieldValue;
    private final String criteriaOperator;

    public CriteriaExpression(String fieldName, FieldOperator fieldOperator, String fieldValue, CriteriaOperator criteriaOperator) {
        this.fieldName = fieldName;
        this.fieldOperator = this.getFieldOperator(fieldOperator);
        this.fieldValue = fieldValue;
        this.criteriaOperator = this.getCriteriaOperator(criteriaOperator);
    }

    public String getCriteriaExpression(){
        String str = fieldName + ' ' + fieldOperator + ' \'' + fieldValue + '\'';
        if(criteriaOperator != null) str += ' ' + criteriaOperator;
        return str;
    }

    public String getFieldOperator(FieldOperator fieldOperator){
        String op;
        Switch on fieldOperator {
            WHEN EQUALS_FIELD {
                op = '=';
            }
        }

        Return op;
    }

    public String getCriteriaOperator(CriteriaOperator criteriaOperator){
        String op;
        Switch on CriteriaOperator {
            WHEN AND_CRIT {
                op = 'AND';
            }
            WHEN OR_CRIT {
                op = 'OR';
            }
        }

        Return op;
    }
}
