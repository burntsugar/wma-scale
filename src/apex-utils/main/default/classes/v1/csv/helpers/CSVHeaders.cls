public class CSVHeaders {
    
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
