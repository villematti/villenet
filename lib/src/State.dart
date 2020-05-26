abstract class State {
  void setCode(List<dynamic> nywCode);
}

class StateImpl implements State {
  int programCunter = 0;
  List<num> stack = [];
  List<dynamic> code = [];

  void setCode(List<dynamic> newCode) {
    this.code = newCode;
  }
}
