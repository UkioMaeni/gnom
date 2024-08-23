
extension on  String{
  String firstUpper(){
    if(isEmpty){
      return "";
    }else{
      return this[0].toUpperCase()+substring(1);
    }
  }
}

gefd()=>"dsd".firstUpper();