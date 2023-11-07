import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:audioplayers/audioplayers.dart' as a;
import 'package:audioplayers/audioplayers.dart';
import 'package:dailyremember/domain/core/model/local_storage/speaking_model.dart';
import 'package:dailyremember/presentation/speaking/widget/player_bar.dart';
import 'package:dailyremember/presentation/speaking/widget/save_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable_panel/controllers/slide_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../../infrastructure/theme/typography.dart';
import '../widget/add_target.dart';
import '../widget/menu_record.dart';

class SpeakingController extends GetxController {
  final SlideController slideController = SlideController(
      usePreActionController: true, usePostActionController: true);

  TextEditingController targetController = TextEditingController();
  RecorderController recordController = RecorderController();
  PlayerController playerController = PlayerController();

  a.AudioPlayer audioPlayer = a.AudioPlayer();
  late Box<SpeakingModel> box;
  var speakingData = <SpeakingModel>[].obs;
  final storage = GetStorage();

  var isOpenFloating = false.obs;
  var seconds = 0.obs;
  var minutes = 0.obs;
  var isRunning = false.obs;
  var isStop = false.obs;
  var isPlaying = <bool>[].obs;
  var isSave = false.obs;
  var playingDuration = 0.0.obs;
  var maxDuration = 0.0.obs;

  TextEditingController titleController = TextEditingController();
  var recordingsAudio = <Map<String, dynamic>>[].obs;
  String? currentRecordingPath;
  Uint8List? audioData;

// Load data speaking from local storage

  Future<void> loadSpeakingData() async {
    var box = await Hive.openBox<SpeakingModel>('speakings');
    final sepaking = box.values.toList().cast<SpeakingModel>();
    speakingData.assignAll(sepaking);
  }

// Open menu record
  Future<void> openMenuRecord(int index) async {
    isSave.value = false;
    isStop.value = false;
    final hasPermission = await recordController.checkPermission();
    if (hasPermission) {
      startRecording();
      startTimer();
      Get.bottomSheet(const MenuRecord()).whenComplete(() {
        log("---------Stop Recording---------");
        recordController.stop();
        resetTimer();
      });
    }
  }

  // Start counter time

  void startTimer() {
    if (!isRunning.value) {
      isRunning.value = true;
      Duration duration = 1.seconds;
      Timer.periodic(duration, (Timer timer) {
        if (isRunning.value) {
          if (seconds.value < 59) {
            seconds.value++;
          } else {
            seconds.value = 0;
            minutes.value++;
          }
        } else {
          timer.cancel();
        }
      });
    }
  }

// Stop counter time
  void stopTimer() {
    isRunning.value = false;
  }

// Reset time
  void resetTimer() {
    isRunning.value = false;
    seconds.value = 0;
    minutes.value = 0;
  }

  void onSaveRecord() {
    Get.back();
  }

  void onDeleteRecord() {
    Get.back();
  }

  // ----------

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

  openSaveDialog() {
    onResumeStopRecord();
    Get.defaultDialog(
        radius: 8,
        title: "Save Recording?",
        titleStyle: titleBold,
        content: SaveDialog(
          onPressed: () => saveRecording(),
        )).whenComplete(() {
      if (isSave.value == false) {
        onResumeStopRecord();
      }
    });
  }

  Future<void> saveRecording() async {
    isSave.value = true;
    if (currentRecordingPath != null) {
      recordController.stop();
      var box = await Hive.openBox<SpeakingModel>('speakings');
      String convidence = "";
      var speakingModel = SpeakingModel(
          titleController.text,
          currentRecordingPath ?? '',
          '${minutes.value.toString().padLeft(2, '0')}:${seconds.value.toString().padLeft(2, '0')}',
          "",
          convidence,
          DateTime.timestamp().toString());
      box.add(speakingModel);
      // ignore: avoid_print
      print("Rekaman disimpan.");
      // Bersihkan nilai saat ini
      titleController.clear();
      currentRecordingPath = null;
      isPlaying.clear();
      isPlaying.value =
          List.generate(box.values.length, (index) => false).toList();
      loadSpeakingData();
      Get.back();
      Get.back();
    } else {
      // ignore: avoid_print
      print("Tidak ada rekaman yang tersedia untuk disimpan.");
    }
  }

  openPlayingBar(String path, int index) {
    resetTimer();
    Get.bottomSheet(const PlayerBar()).whenComplete(() {
      stopPlayingAudio();
    });
    playAudio(path, index);
  }

  Future<void> playAudio(String path, int index) async {
    isPlaying[index] = true;
    if (isPlaying[index] == false) {
      await audioPlayer.stop();
    } else {
      DeviceFileSource source = DeviceFileSource(path);
      await audioPlayer.play(source);
      final duration = await audioPlayer.getDuration(); // Dapatkan durasi audio
      maxDuration.value = duration?.inMilliseconds.toDouble() ?? 0;
      int audioDurationSeconds =
          (maxDuration.value / 1000).floor(); // Konversi ke detik
      int audioDurationMinutes = (audioDurationSeconds / 60).floor();
      minutes.value = audioDurationMinutes;
      seconds.value = audioDurationSeconds % 60;
      startCountdownTimer();
      audioPlayer.onPositionChanged.listen((event) {
        playingDuration.value = event.inMilliseconds.toDouble();
      });
      audioPlayer.onPlayerComplete.listen((event) {
        log("Selesai------");
        playingDuration.value = maxDuration.value;
        isPlaying[index] = false;
        isStop.value = false;
        Get.back();
      });
    }
  }

  stopPlayingAudio() {
    isStop.value = false;
    audioPlayer.stop();
    isPlaying.clear();
    isPlaying.value =
        List.generate(box.values.length, (index) => false).toList();
    Get.back();
  }

  pauseResumeAudio() {
    isStop.value = !isStop.value;
    if (isRunning.value) {
      stopTimer();
      audioPlayer.pause();
    } else {
      audioPlayer.resume();
      startCountdownTimer();
    }
  }

  void startCountdownTimer() {
    if (!isRunning.value && minutes.value > 0 || seconds.value > 0) {
      isRunning.value = true;
      Duration duration = 1.seconds;
      Timer.periodic(duration, (Timer timer) {
        if (isRunning.value) {
          if (seconds.value > 0) {
            seconds.value--;
          } else {
            if (minutes.value > 0) {
              minutes.value--;
              seconds.value = 59;
            } else {
              isRunning.value = false; // Timer selesai
              timer.cancel();
            }
          }
        } else {
          timer.cancel();
        }
      });
    }
  }

  void openDialogTarget() {
    final target = storage.read('speaking-target');
    targetController = TextEditingController(text: target);
    Get.defaultDialog(
        title: "Buat target speaking harian!",
        titleStyle: titleBold,
        radius: 8,
        content: AddTarget(
          onPressed: () {
            storage.write('speaking-target', targetController.text);
            Get.back();
          },
        )).whenComplete(() {
      targetController.clear();
    });
  }

  void deleteSpeaking(int index, String audioPath) {
    Get.defaultDialog(
        title: "Delete Speaking",
        titleStyle: titleBold,
        middleText: "Apakah anda yakin menghapus rekaman speaking?",
        middleTextStyle: subTitleNormal,
        titlePadding: const EdgeInsets.only(top: 12),
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        radius: 8.r,
        actions: [
          TextButton(
              onPressed: () => Get.back(),
              child: Text(
                'No',
                style: hintSubTitleBold,
              )),
          TextButton(
              onPressed: () => deleteAction(index, audioPath),
              child: Text(
                'Yes',
                style: subTitleBold,
              ))
        ]);
  }

  void deleteAction(int index, String audioPath) {
    if (index >= 0 && index < box.length) {
      box.deleteAt(index);
      File(audioPath).delete();
      loadSpeakingData();
      Get.back();
    }
  }

  @override
  void onInit() {
    box = Hive.box<SpeakingModel>('speakings');
    isPlaying.value =
        List.generate(box.values.length, (index) => false).toList();
    loadSpeakingData();
    super.onInit();
  }

  @override
  void onClose() {
    slideController.dispose();
    super.onClose();
  }

  void onResumeStopRecord() {
    isStop.value = !isStop.value;
    if (isRunning.value) {
      stopTimer();
      recordController.pause();
    } else {
      startRecording();
      startTimer();
    }
  }
}
