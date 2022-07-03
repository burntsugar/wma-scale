public class SOQLExpressionHelper {

    public enum FieldOperator {
        EQUALS_FIELD
    }

    public enum CriteriaOperator {
        AND_CRIT,
        OR_CRIT
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
