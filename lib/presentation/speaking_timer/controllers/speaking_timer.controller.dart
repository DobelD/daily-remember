import 'dart:async';
import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:dailyremember/presentation/speaking/controllers/speaking.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import '../../../domain/core/model/local_storage/speaking_model.dart';
import '../../../infrastructure/theme/typography.dart';
import '../widget/save_dialog.dart';

class SpeakingTimerController extends GetxController {
  TextEditingController titleController = TextEditingController();
  final CountDownController countDownController = CountDownController();
  RecorderController recordController = RecorderController();
  late Box<SpeakingModel> box;
  String? currentRecordingPath;
  var isRunning = false.obs;
  var isFinish = false.obs;
  var isReset = false.obs;
  var selectedMinutes = 0.obs;
  var selectedSeconds = 0.obs;
  var maxDuration = 0.obs;
  var saveDurationSpeaking = "".obs;

  void setTime(int minutes, int seconds) {
    selectedMinutes.value = minutes;
    selectedSeconds.value = seconds;
    var toDurationMinutes = minutes.minutes.inMilliseconds;
    var toDurationSeconds = seconds.seconds.inMilliseconds;
    maxDuration.value = toDurationMinutes + toDurationSeconds;
    saveDurationSpeaking.value =
        '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  Future<void> showTimerPicker() async {
    final pickedTime = await showTimePicker(
      context: Get.context!,
      initialTime:
          TimeOfDay(hour: selectedMinutes.value, minute: selectedSeconds.value),
    );

    if (pickedTime != null) {
      setTime(pickedTime.hour, pickedTime.minute);
    }
  }

  void startRecordSpeakingTimer() {
    if (isReset.value == false) {
      startCountdownTimer();
    } else {
      isReset.value = false;
      isRunning.value = false;
      isFinish.value = false;
      saveDurationSpeaking.value = "";
      currentRecordingPath = null;
      selectedMinutes.value = 0;
      selectedSeconds.value = 0;
    }
  }

  Future<void> startRecording() async {
    final hasPermission = await recordController.checkPermission();
    if (hasPermission) {
      Directory appDocDirectory = await getApplicationDocumentsDirectory();
      String fileName = 'speaking-${box.values.length + 1}.aac';
      currentRecordingPath = '${appDocDirectory.path}/$fileName';
      await recordController.record(
          path: currentRecordingPath,
          androidEncoder: AndroidEncoder.aac,
          bitRate: 256000);
      // Bit Rate Sedang : 128000
      // Bit Rate Tinggi : 256000

      bool isRecording = recordController.isRecording;
      if (isRecording) {
        // ignore: avoid_print
        print("Merekam");
      }
    } else {
      // ignore: avoid_print
      print("Tidak dapat merekam, periksa izin mikrofon.");
    }
  }

  void startCountdownTimer() {
    if (selectedMinutes.value != 0 || selectedSeconds.value != 0) {
      if (!isRunning.value &&
          (selectedMinutes.value > 0 || selectedSeconds.value > 0)) {
        isRunning.value = true;
        startRecording();
        Duration duration = 1.seconds;
        Timer.periodic(duration, (Timer timer) {
          if (isRunning.value) {
            if (selectedSeconds.value > 0) {
              selectedSeconds.value--;
            } else {
              if (selectedMinutes.value > 0) {
                selectedMinutes.value--;
                selectedSeconds.value = 59;
              } else {
                isRunning.value = false;
                isFinish.value = true;
                timer.cancel();
                openDialogFinish();
              }
            }
          } else {
            timer.cancel();
          }
        });
      }
    } else {
      Get.showSnackbar(GetSnackBar(
        margin: const EdgeInsets.all(16),
        borderRadius: 8.r,
        backgroundColor: Colors.red,
        message: "Set timer to start speaking",
        duration: 1.seconds,
      ));
    }
  }

  void openDialogFinish() {
    recordController.stop();
    Get.defaultDialog(
        radius: 8,
        title: "Save Recording?",
        titleStyle: titleBold,
        content: SaveDialog(
          onPressed: () => saveRecording(),
        )).whenComplete(() {
      isReset.value = true;
    });
  }

  Future<void> saveRecording() async {
    if (currentRecordingPath != null) {
      recordController.stop();
      var box = await Hive.openBox<SpeakingModel>('speakings');
      var speakingModel = SpeakingModel(
          titleController.text,
          currentRecordingPath ?? '',
          saveDurationSpeaking.value,
          "",
          "",
          DateTime.timestamp().toString());
      box.add(speakingModel);
      // ignore: avoid_print
      print("Rekaman disimpan.");
      // Bersihkan nilai saat ini
      titleController.clear();
      currentRecordingPath = null;
      Get.back();
    } else {
      // ignore: avoid_print
      print("Tidak ada rekaman yang tersedia untuk disimpan.");
    }
  }

  refreshDataSpeaking() {
    final speakingController = Get.put(SpeakingController());
    speakingController.loadSpeakingData();
  }

  @override
  void onInit() {
    box = Hive.box<SpeakingModel>('speakings');
    super.onInit();
  }

  @override
  void onClose() {
    isReset.value = false;
    isRunning.value = false;
    isFinish.value = false;
    saveDurationSpeaking.value = "";
    currentRecordingPath = null;
    selectedMinutes.value = 0;
    selectedSeconds.value = 0;
    recordController.stop();
    refreshDataSpeaking();
    super.onClose();
  }
}
