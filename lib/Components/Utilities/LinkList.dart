import 'dart:collection';
import 'dart:math';


class MyEntry extends LinkedListEntry<MyEntry> {
  final String key;
  final String value;

  MyEntry(this.key, this.value);

  @override
  String toString() {
    return '"$key":"$value"';
  }
}

class LinkListParams extends LinkedList<MyEntry>{
  int randomType = 0;

  List index({int otpRandomInt = -1}) {
    Random random = Random();
    randomType = random.nextInt(2);

    var text = "";
    var charAt = "";

    var doWhile = true;
    var node = first;
    while (doWhile){
        var generate = useIndexgenerator(node.key,node.value);
        text += generate[1];
        charAt += generate[0];
      if (node.next != null) {
        node = node.next!;
      }else{
        doWhile = false;
      }
    }
    
    // insert ONLY otpRandomInt if not -1, means having Session/ already loggedin
    return ['"index":"$text${otpRandomInt != -1 ? otpRandomInt : ''}$randomType"',charAt];
  }

  List useIndexgenerator(String key, String value){
    Random random = Random();
    int randomNumber = random.nextInt((value.length > 9) ? 9 : value.length);
    var chartAt = "";

    if (randomType == 0) {
      chartAt = value[randomNumber];

    }else{
      var newVal = value.split('').reversed.join();
      chartAt = newVal[randomNumber];
    }
  
    print("Parameter ==> $key: $value");
    return [chartAt, "$randomNumber"];
  }

  // TO PARAMS
  String toParams(){
    var toParams = "";
    var doWhile = true;
    var node = first;

    while (doWhile){
      if (node.next != null) {
        toParams += '$node,';
        node = node.next!;
      }else{
        toParams += '$node';
        doWhile = false;
      }
    }

    return toParams;
  }
}