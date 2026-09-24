import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameController extends GetxController {
  final RxInt xp = 0.obs;

  final RxInt currentMission = 1.obs;

  final RxInt securityShield = 100.obs;

  final RxString rank = "Cyber Recruit".obs;

  Future<void> loadGame() async {
    final prefs = await SharedPreferences.getInstance();

    xp.value = prefs.getInt("xp") ?? 0;

    currentMission.value = prefs.getInt("mission") ?? 1;

    securityShield.value = prefs.getInt("shield") ?? 100;

    updateRank();
  }

  Future<void> saveGame() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt("xp", xp.value);

    await prefs.setInt("mission", currentMission.value);

    await prefs.setInt("shield", securityShield.value);
  }

  Future<void> completeMission(int xpEarned) async {
    xp.value += xpEarned;

    currentMission.value++;

    updateRank();

    await saveGame();
  }

  bool isMissionCompleted(int missionNumber) {
    return currentMission.value > missionNumber;
  }

  bool isMissionUnlocked(int missionNumber) {
    return currentMission.value >= missionNumber;
  }

  void updateRank() {
    if (xp.value >= 2500) {
      rank.value = "Cyber Guardian";
    } else if (xp.value >= 1500) {
      rank.value = "Cyber Defender";
    } else if (xp.value >= 700) {
      rank.value = "Cyber Analyst";
    } else {
      rank.value = "Cyber Recruit";
    }
  }

  Future<void> finishOperationHook() async {
    if (currentMission.value < 3) {
      xp.value += 150;

      securityShield.value += 10;

      if (securityShield.value > 100) {
        securityShield.value = 100;
      }

      currentMission.value = 3;

      updateRank();

      await saveGame();
    }
  }

  @override
  void onInit() {
    loadGame();
    super.onInit();
  }
}
