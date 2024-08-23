class StringTools{
  static String firstUpperOfString(String str){
    if(str.isEmpty){
      return "";
    }else{
      return str[0].toUpperCase()+str.substring(1);
    }
    
  }
}

