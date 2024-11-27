
import 'package:shared_preferences/shared_preferences.dart';

class PolicyRepo{
    
    Future<String> get policyIsCompleted async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? policy= prefs.getString("policy");
    return policy==null?"no":policy;
  }
  Future<void> savePolicy(String policy)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("policy", policy);
  }
}

final  policyRepo=PolicyRepo();