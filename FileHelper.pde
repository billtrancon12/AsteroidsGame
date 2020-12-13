import java.io.File;  // Import the File class
import java.io.FileNotFoundException;  // Import this class to handle errors
import java.util.Scanner; // Import the Scanner class to read text files
import java.io.IOException;
import java.io.FileWriter;

class FileHelper{  
  String path;
  
  FileHelper(String path){
    this.path = path;  
  }
  
  void createFile(String file_name){
    try{
      File newFile = new File(path + "\\" + file_name);
      newFile.createNewFile();
    }
    catch(IOException e){
      System.out.println(e);  
    }
  }
  
  void createFile(String file_name, String dir){
    try{
      File newDir = new File(path + "\\" + dir);
      newDir.mkdir();
      
      File newFile = new File(newDir.getPath() + "\\" + file_name);
      newFile.createNewFile();
    }
    catch(IOException e){
      System.out.println(e);
    }
  }
  
  boolean exist(String file_name){
    File file = new File(file_name);
    if(file.exists()) return true;
    else return false;
  }
  
  void writeFile(String data, String file_name){
    try{
      FileWriter fileWriter = new FileWriter(file_name);
      fileWriter.write(data);
      fileWriter.close();
    }
    catch(IOException e){
      System.out.println(e);  
    }
  }
  
  String[][] readFile(String file_name){
    String[][] record = new String[1000][10000];
    try{
      File fileReader = new File(file_name);
      Scanner scanReader = new Scanner(fileReader);
      int line = 1;
      while(scanReader.hasNext()){
        String data = scanReader.nextLine();
        String[] info = data.split(" ");
        record[line - 1] = info;
        line++;
      }
      scanReader.close();
    }
    catch(FileNotFoundException e){
      System.out.println(e);  
    }
    return record;
  }
}
