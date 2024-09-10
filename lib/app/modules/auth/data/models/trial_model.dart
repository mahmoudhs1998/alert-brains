class TrialModel {
  late bool quickMath;
  late bool speedyNumbers;
  late bool focusGame;
  late bool powerMemo;

  TrialModel(
      this.quickMath, this.speedyNumbers, this.focusGame, this.powerMemo);

  factory TrialModel.fromJson(Map<String, dynamic> data) {
    return TrialModel(data['quickMath'], data['speedyNumbers'],
        data['focusGame'], data['powerMemo']);
  }

  toMap() {
    return {
      'quickMath': quickMath,
      'speedyNumbers': speedyNumbers,
      'focusGame': focusGame,
      'powerMemo': powerMemo,
    };
  }
}
