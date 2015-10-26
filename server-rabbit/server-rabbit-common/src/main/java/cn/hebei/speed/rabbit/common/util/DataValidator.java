package cn.hebei.speed.rabbit.common.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class DataValidator {
    
  
    public static boolean isNumeric(String str){  
          Pattern pattern = Pattern.compile("^(-?\\d+)(\\.\\d+)?$");  
          Matcher isNum = pattern.matcher(str);  
          if( !isNum.matches() ){  
                return false;  
          }  
          return true;  
    }  
      
   
    public static boolean isEmail(String str){  
        if(isEmpty(str))  
            return false;  
        return str.matches("^[\\w-]+(\\.[\\w-]+)*@[\\w-]+(\\.[\\w-]+)+$");  
    }  
      
   
    public static boolean isMobile(String str){  
        if(isEmpty(str))  
            return false;  
        return str.matches("^(13|14|15|18)\\d{9}$");  
    }  
      
   
    public static boolean isNumber(String str) {  
        try{  
            Integer.parseInt(str);  
            return true;  
        }catch(Exception ex){  
            return false;  
        }  
    }  
      
  
    public static boolean isNotEmpty(String str){  
        if(str == null || "".equals(str))  
            return false;  
        return true;  
    }  
      
   
    public static boolean isNotEmptyIgnoreBlank(String str){  
        if(str == null || "".equals(str) || "".equals(str.trim()))  
            return false;  
        return true;  
    }  
      
  
    public static boolean isEmpty(String str){  
    	
        if(str == null || "".equals(str))  
            return true;  
        return false;  
    }  
   
      
   
    public static boolean isEmptyIgnoreBlank(String str){  
        if(str == null || "".equals(str) || "".equals(str.trim()))  
            return true;  
        return false;  
    }  
      
   
    private DataValidator(){}  
}
