package happy.jaj.prj.dtos;

public class Subject_Test_DTO {

	private String subjectcode;
	private String testcode;
	private String testname;
	private String testday;
	
	public Subject_Test_DTO() {
	}
	
	public Subject_Test_DTO(String subjectcode, String testcode, String testname, String testday) {
		super();
		this.subjectcode = subjectcode;
		this.testcode = testcode;
		this.testname = testname;
		this.testday = testday;
	}

	public Subject_Test_DTO(String subjectcode, String testcode, String testday) {
		super();
		this.subjectcode = subjectcode;
		this.testcode = testcode;
		this.testday = testday;
	}

	public String getSubjectcode() {
		return subjectcode;
	}

	public void setSubjectcode(String subjectcode) {
		this.subjectcode = subjectcode;
	}

	public String getTestcode() {
		return testcode;
	}

	public void setTestcode(String testcode) {
		this.testcode = testcode;
	}

	public String getTestname() {
		return testname;
	}

	public void setTestname(String testname) {
		this.testname = testname;
	}

	public String getTestday() {
		return testday;
	}

	public void setTestday(String testday) {
		this.testday = testday;
	}

	@Override
	public String toString() {
		return "Subject_Test_DTO [subjectcode=" + subjectcode + ", testcode=" + testcode + ", testname=" + testname
				+ ", testday=" + testday + "]";
	}

	
	
}
