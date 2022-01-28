package beans;

public class Move {

    private String name;
    private String code;
    private String type;
    private String pp;
    private String accuracy;

    public Move(String name, String code, String type, String pp, String accuracy) {
        this.name = name;
        this.code = code;
        this.type = type;
        this.pp = pp;
        this.accuracy = accuracy;
    }

    public String getName() {
        return name;
    }

    public String getCode() {
        return code;
    }

    public String getType() {
        return type;
    }

    public String getPp() {
        return pp;
    }

    public String getAccuracy() {
        return accuracy;
    }
}
