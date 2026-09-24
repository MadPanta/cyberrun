import 'dart:async';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';

enum MissionStatus { briefing, active, success, failed }

class MissionController extends GetxController {
  final RxInt secondsLeft = 30.obs;
  final Rx<MissionStatus> status = MissionStatus.briefing.obs;

  final RxString email = ''.obs;
  final RxString password = ''.obs;
  final RxString confirmPassword = ''.obs;

  final RxBool showPassword = false.obs;
  final RxBool showConfirmPassword = false.obs;

  final AudioPlayer _player = AudioPlayer();

  Timer? _timer;

  /*
  |--------------------------------------------------------------------------
  | Mission
  |--------------------------------------------------------------------------
  */

  void beginMission() {
    secondsLeft.value = 30;
    status.value = MissionStatus.active;

    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsLeft.value <= 1) {
        timer.cancel();
        secondsLeft.value = 0;
        _player.stop();

        status.value = MissionStatus.failed;
      } else {
        secondsLeft.value--;

        if (secondsLeft.value == 14) {
          _player.stop();

          _player.play(AssetSource("sounds/beep.mp3"));
        }
      }
    });
  }

  void restartMission() {
    _player.stop();
    _timer?.cancel();

    secondsLeft.value = 30;

    email.value = '';
    password.value = '';
    confirmPassword.value = '';

    showPassword.value = false;
    showConfirmPassword.value = false;

    status.value = MissionStatus.briefing;
  }

  /*
  |--------------------------------------------------------------------------
  | Submit
  |--------------------------------------------------------------------------
  */

  void submitTerminalAccess() {
    if (!isValidEmail) {
      Get.snackbar(
        'Invalid Email',
        'Please enter a valid email address.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (!isStrongPassword) {
      Get.snackbar(
        'Weak Password',
        'Your password does not meet the security requirements.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (!passwordsMatch) {
      Get.snackbar(
        'Passwords Do Not Match',
        'Please confirm your password.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    _timer?.cancel();

    _player.stop();

    status.value = MissionStatus.success;
  }

  /*
  |--------------------------------------------------------------------------
  | Validation
  |--------------------------------------------------------------------------
  */

  bool get isValidEmail {
    return email.value.trim().contains('@') && email.value.trim().contains('.');
  }

  bool get hasUppercase => password.value.contains(RegExp(r'[A-Z]'));

  bool get hasLowercase => password.value.contains(RegExp(r'[a-z]'));

  bool get hasNumber => password.value.contains(RegExp(r'[0-9]'));

  bool get hasSymbol =>
      password.value.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));

  bool get hasEightCharacters => password.value.length >= 8;

  bool get passwordsMatch =>
      password.value.isNotEmpty && password.value == confirmPassword.value;

  bool get isStrongPassword =>
      hasUppercase &&
      hasLowercase &&
      hasNumber &&
      hasSymbol &&
      hasEightCharacters;

  bool get canSecureTerminal {
    return isValidEmail && isStrongPassword && passwordsMatch;
  }

  /*
  |--------------------------------------------------------------------------
  | Password Strength
  |--------------------------------------------------------------------------
  */

  double get passwordStrength {
    int score = 0;

    if (hasUppercase) score++;
    if (hasLowercase) score++;
    if (hasNumber) score++;
    if (hasSymbol) score++;
    if (hasEightCharacters) score++;

    return score / 5;
  }

  String get strengthLabel {
    final strength = passwordStrength;

    if (strength == 0) {
      return "Waiting";
    }

    if (strength < 0.40) {
      return "Weak";
    }

    if (strength < 0.80) {
      return "Medium";
    }

    return "Strong";
  }

  /*
  |--------------------------------------------------------------------------
  | Password Visibility
  |--------------------------------------------------------------------------
  */

  void togglePassword() {
    showPassword.value = !showPassword.value;
  }

  void toggleConfirmPassword() {
    showConfirmPassword.value = !showConfirmPassword.value;
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
