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
import '../../../components/app_snackbar.dart';
import '../../../components/waiting_progress.dart';
import '../../../domain/core/interfaces/transcribe_repository.dart';
import '../../../domain/core/model/local_storage/speaking_model.dart';
import '../../../infrastructure/dal/repository/transcribe_repository_impl.dart';
import '../../../infrastructure/theme/typography.dart';
import '../widget/save_dialog.dart';

enum SpeakingTimerStatus { initial, loading, waiting, success, failed }

class SpeakingTimerController extends GetxController {
  final TranscribeRepository _transcribeRepository;
  SpeakingTimerController(this._transcribeRepository);

  var speakingTimeStatus = Rx<SpeakingTimerStatus>(SpeakingTimerStatus.initial);

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
      String fileName = 'speaking-${box.values.length + 1}.wav';
      currentRecordingPath = '${appDocDirectory.path}/$fileName';
      await recordController.record(
          path: currentRecordingPath, bitRate: 256000);
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
      Get.back();
      WaitingProgress.init(title: 'Saving record processed');
      final idTranscribe = await _transcribeRepository.transcribeAudio(
          currentRecordingPath ?? '', titleController.text);
      if (idTranscribe != null) {
        await addToLocalStorage(idTranscribe);
        // Bersihkan nilai saat ini
        titleController.clear();
        currentRecordingPath = null;
        Get.back();
        AppSnackbar.success(message: "Success save recording!");
      } else {
        Get.back();
        AppSnackbar.error(message: "Failed save recording!");
      }
    } else {
      Get.back();
      // ignore: avoid_print
      print("Tidak ada rekaman yang tersedia untuk disimpan.");
    }
  }

  Future<void> addToLocalStorage(String id) async {
    var box = await Hive.openBox<SpeakingModel>('speakings');
    var speakingModel = SpeakingModel(
        titleController.text,
        currentRecordingPath ?? '',
        saveDurationSpeaking.value,
        id,
        "",
        DateTime.timestamp().toString());
    box.add(speakingModel);
    // ignore: avoid_print
    print("Rekaman disimpan.");
  }

  refreshDataSpeaking() {
    final speakingController =
        Get.put(SpeakingController(TranscribeRepositoryImpl()));
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
