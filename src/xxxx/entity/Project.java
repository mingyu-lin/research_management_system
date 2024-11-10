package xxxx.entity;

public class Project {
    private String projectTitle;
    private String projectId;
    private String projectBeginTime;
    private String projectEndTime;
    private String projectManager;
    private String projectSource;
    private Integer projectFunding;
    private Integer projectLevel;
    private Integer projectFlag;
    public String getProjectTitle() {
        return projectTitle;
    }

    public Integer getProjectFlag() {
        return projectFlag;
    }

    public void setProjectFlag(Integer projectFlag) {
        this.projectFlag = projectFlag;
    }

    public void setProjectTitle(String projectTitle) {
        this.projectTitle = projectTitle;
    }

    public String getProjectId() {
        return projectId;
    }

    public void setProjectId(String projectId) {
        this.projectId = projectId;
    }

    public String getProjectBeginTime() {
        return projectBeginTime;
    }

    public void setProjectBeginTime(String projectBeginTime) {
        this.projectBeginTime = projectBeginTime;
    }

    public String getProjectEndTime() {
        return projectEndTime;
    }

    public void setProjectEndTime(String projectEndTime) {
        this.projectEndTime = projectEndTime;
    }

    public String getProjectSource() {
        return projectSource;
    }

    public void setProjectSource(String projectSource) {
        this.projectSource = projectSource;
    }

    public String getProjectManager() {
        return projectManager;
    }

    public void setProjectManager(String projectManager) {
        this.projectManager = projectManager;
    }

    public Integer getProjectFunding() {
        return projectFunding;
    }

    public void setProjectFunding(Integer projectFunding) {
        this.projectFunding = projectFunding;
    }

    public Integer getProjectLevel() {
        return projectLevel;
    }

    public void setProjectLevel(Integer projectLevel) {
        this.projectLevel = projectLevel;
    }
}
