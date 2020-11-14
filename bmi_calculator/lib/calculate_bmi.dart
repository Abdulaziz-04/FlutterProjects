import 'dart:math';

class CalculateResult {
  CalculateResult(this.height, this.weight);
  final int height;
  final int weight;
  double _bmi;
  String calculate() {
    _bmi = weight / pow(height / 100, 2);
    return _bmi.toStringAsFixed(1);
  }

  String getResult() {
    if (_bmi >= 25) {
      return 'OVERWEIGHT';
    } else if (_bmi >= 18.5) {
      return 'NORMAL';
    } else {
      return 'UNDERWEIGHT';
    }
  }

  String getAdvice() {
    if (_bmi >= 25) {
      return 'You have a higher than normal\nbody-weight,\nTry to exercise more!';
    } else if (_bmi >= 18.5) {
      return 'You have a normal body-weight,\nGood Job!';
    } else {
      return 'You have lower than normal body-weight,\nYou can eat a bit more!';
    }
  }
}
