package xxxx.entity;

public class Paper {
    private Integer paperId;
    private String paperTitle;
    private String paperAuthor;
    private String paperPublicationVenue;
    private String Keywords;
    private String paperUpdateFrom;
    private String paperAbstract;
    private String paperPublicationTime;
    private Integer paperFlag;
    private String paperLevel;
    public Integer getPaperId() {
        return paperId;
    }

    public Integer getPaperFlag() {
        return paperFlag;
    }

    public void setPaperFlag(Integer paperFlag) {
        this.paperFlag = paperFlag;
    }

    public String getPaperLevel() {
        return paperLevel;
    }

    public void setPaperLevel(String paperLevel) {
        this.paperLevel = paperLevel;
    }

    public void setPaperId(Integer paperId) {
        this.paperId = paperId;
    }

    public String getPaperTitle() {
        return paperTitle;
    }

    public void setPaperTitle(String paperTitle) {
        this.paperTitle = paperTitle;
    }

    public String getPaperAuthor() {
        return paperAuthor;
    }

    public void setPaperAuthor(String paperAuthor) {
        this.paperAuthor = paperAuthor;
    }

    public String getPaperPublicationVenue() {
        return paperPublicationVenue;
    }

    public void setPaperPublicationVenue(String paperPublicationVenue) {
        this.paperPublicationVenue = paperPublicationVenue;
    }

    public String getKeywords() {
        return Keywords;
    }

    public void setKeywords(String keywords) {
        Keywords = keywords;
    }

    public String getPaperUpdateFrom() {
        return paperUpdateFrom;
    }

    public void setPaperUpdateFrom(String paperUpdateFrom) {
        this.paperUpdateFrom = paperUpdateFrom;
    }

    public String getPaperAbstract() {
        return paperAbstract;
    }

    public void setPaperAbstract(String paperAbstract) {
        this.paperAbstract = paperAbstract;
    }

    public String getPaperPublicationTime() {
        return paperPublicationTime;
    }

    public void setPaperPublicationTime(String paperPublicationTime) {
        this.paperPublicationTime = paperPublicationTime;
    }
}
