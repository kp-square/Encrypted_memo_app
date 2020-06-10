class Utils{
///This class implements the utility functions

  ///this function takes an integer list as argument and return the string of integers
  ///separated by commas.
  static String keyToString(List<int> key){
    return key.map((i)=>i.toString()).join(',');
  }

  ///this function takes string of integers separated by commas as argument and returns
  ///list of integers.
  static List<int> stringToKey(String str){
    List<int> key=[];
    var foo = str.split(',');
    for(var x in foo){
      key.add(int.parse(x));
    }
    return key;
  }

}