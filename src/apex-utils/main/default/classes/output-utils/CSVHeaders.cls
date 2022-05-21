public with sharing class CSVHeaders implements CSVHeadersWrapping {
    
    List<String> cSVHeaders;

    public CSVHeaders() {

    }

    public List<String> getCSVHeaders(){
        return this.cSVHeaders;
    }

    public void addCSVHeader(String csvHeader){
        if (cSVHeaders == null) {
            cSVHeaders = new List<String>();
        }
        cSVHeaders.add(csvHeader);
    }
}
