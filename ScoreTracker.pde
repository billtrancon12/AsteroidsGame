import java.io.FileWriter;
import java.io.IOException;

class ScoreTracker{
  int highest_score;
  int previous_score;
  int current_score;
  Map<String, Integer> leaderboard;
  List<Integer> leaderScore;
  String path;
  FileHelper fileHelper;
  
  ScoreTracker(){
    this.path = System.getProperty("user.dir");
    leaderboard = new HashMap<String, Integer>();
    leaderScore = new ArrayList<Integer>();
    this.fileHelper = new FileHelper(path);
  }
  
  void updateScore(String user, int total_score){
    this.setScore(path + "\\score\\highest_score.txt", total_score);
    this.recordHighest();
    this.setScore(path + "\\score\\previous_score.txt", total_score);
    this.recordPreviousScore();
    this.recordLeaderBoard(user, total_score); 
  }
  
  void setup(){
    this.createRecord();
    this.setScore(path + "\\score\\highest_score.txt", 0);
    this.setScore(path + "\\score\\previous_score.txt", 0);
    this.getLeaderBoard();
  }
  
  void createRecord(){
    if(!fileHelper.exist(path + "\\score\\highest_score.txt")){
      fileHelper.createFile("highest_score.txt","score");
      fileHelper.writeFile("highest_score 0", path + "\\score\\highest_score.txt");
    }
    if(!fileHelper.exist(path + "\\score\\previous_score.txt")){
      fileHelper.createFile("previous_score.txt","score");
      fileHelper.writeFile("previous_score 0", path + "\\score\\previous_score.txt"); 
    }
    if(!fileHelper.exist(path + "\\score\\leaderboard.txt")){
      fileHelper.createFile("leaderboard.txt","score");  
    }
  }
  
  void recordHighest(){
    fileHelper.writeFile("highest_score " + this.highest_score,path + "\\score\\highest_score.txt");  
  }
  
  void recordPreviousScore(){
    fileHelper.writeFile("previous_score " + this.current_score, path + "\\score\\previous_score.txt");  
  }
  
  void setScore(String file_name, int score){
    String[][] record = fileHelper.readFile(file_name);
    for(int i = 0; i < record.length; i++){
      if(record[i] == null || record[i].length == 0) break;
      for(int j = 0; j < record[i].length - 1; j++){
        if(record[i][j + 1] == null) break;
        if(isNumeric(record[i][j + 1]) && record[i][j].equalsIgnoreCase("highest_score"))
          this.highest_score = Math.max(Integer.parseInt(record[i][j + 1]), score);
        else if(isNumeric(record[i][j + 1]) && record[i][j].equalsIgnoreCase("previous_score")){
          this.previous_score = Integer.parseInt(record[i][j + 1]);
          this.current_score = score;
        }
      }
    }
  }
  
  void getLeaderBoard(){
    String [][] record = fileHelper.readFile(path + "\\score\\leaderboard.txt");
    if(record != null){
      for(int i = 0; i < record.length; i++){
        StringBuilder strBuilder = new StringBuilder();
        if(i == 10) break;
        for(int j = 0; j < record[i].length; j++){
          if(record[i][j] == null) break;
          if(!isNumeric(record[i][j])){
            strBuilder.append(record[i][j]);  
          }
          if(isNumeric(record[i][j])){
            leaderboard.put(strBuilder.toString(), Integer.parseInt(record[i][j]));  
          }
        }
      }
    }
    leaderboard = sortMap(leaderboard);
  }
  
  void recordLeaderBoard(String user, int score){
    if(!leaderboard.containsKey(user)){
      leaderboard.put(user, score);
    }
    else {
      leaderboard.put(user, Math.max(leaderboard.get(user), score));
    }
    leaderboard = sortMap(leaderboard);
    
    try{
      FileWriter lbFile = new FileWriter(path + "\\score\\leaderboard.txt");
      for(Map.Entry<String, Integer> entry : leaderboard.entrySet()){
        lbFile.write(entry.getKey() + " " + entry.getValue());
        lbFile.write(System.getProperty("line.separator"));
      }
      lbFile.close();
    }
    catch(IOException e){
      System.out.println(e);    
    }
  }
  
  HashMap<String, Integer> sortMap(Map<String, Integer> map){
      LinkedHashMap<String, Integer> sortedMap = new LinkedHashMap<String, Integer>();
      ArrayList<Integer> list = new ArrayList<Integer>();
      for (Map.Entry<String, Integer> entry : map.entrySet()) {
         list.add(entry.getValue());
      }
      
      Collections.sort(list, Collections.reverseOrder());
      
      for (int score : list) {
         for (Map.Entry<String, Integer> entry : map.entrySet()) {
            if (entry.getValue() == score) {
               sortedMap.put(entry.getKey(), score);
            }
         }
      }
      return sortedMap;
  }
    
  boolean isNumeric(final String str){
    if(str == null || str.length() == 0) return false;
    
    for(char s : str.toCharArray()){
      if(!Character.isDigit(s)) return false;  
    }
    return true;
  }
}
