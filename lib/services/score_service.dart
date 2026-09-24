import 'package:shared_preferences/shared_preferences.dart';

class ScoreService {
  static const String _scoreKey = 'total_score';
  static const String _levelKey = 'completed_levels';

  Future<int> getScore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_scoreKey) ?? 0;
  }

  Future<int> getCompletedLevels() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_levelKey) ?? 0;
  }

  Future<void> addScore(int points) async {
    final prefs = await SharedPreferences.getInstance();
    final currentScore = prefs.getInt(_scoreKey) ?? 0;
    await prefs.setInt(_scoreKey, currentScore + points);
  }

  Future<void> completeLevel() async {
    final prefs = await SharedPreferences.getInstance();
    final completed = prefs.getInt(_levelKey) ?? 0;
    await prefs.setInt(_levelKey, completed + 1);
  }

  Future<void> resetScores() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_scoreKey);
    await prefs.remove(_levelKey);
  }
}
