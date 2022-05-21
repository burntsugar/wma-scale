public with sharing class CSVHeaders implements ICSVHeaders {
    
    private List<String> cSVHeaders;

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
