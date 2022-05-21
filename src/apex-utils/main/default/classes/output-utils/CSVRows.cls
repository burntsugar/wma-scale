public with sharing class CSVRows implements ICSVRows {
    
    public List<String> cSVRows;

    public List<String> getCSVRows(){
        return this.cSVRows;
    }

    public void addCSVRow(String csvRow) {
        if (cSVRows == null) {
            cSVRows = new List<String>();
        }
        cSVRows.add(csvRow);
    }
}
