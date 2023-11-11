import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:audioplayers/audioplayers.dart' as a;
import 'package:audioplayers/audioplayers.dart';
import 'package:dailyremember/components/app_snackbar.dart';
import 'package:dailyremember/components/waiting_progress.dart';
import 'package:dailyremember/domain/core/interfaces/transcribe_repository.dart';
import 'package:dailyremember/domain/core/model/params/speaking_param.dart';
import 'package:dailyremember/presentation/speaking/widget/player_bar.dart';
import 'package:dailyremember/presentation/speaking/widget/save_dialog.dart';
import 'package:dailyremember/presentation/speaking/widget/transcribe_audio_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable_panel/controllers/slide_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import '../../../domain/core/interfaces/speaking_repository.dart';
import '../../../domain/core/model/speaking_model.dart';
import '../../../infrastructure/theme/typography.dart';
import '../widget/add_target.dart';
import '../widget/menu_record.dart';

enum SpeakingStatus { initial, loading, waiting, success, failed }

class SpeakingController extends GetxController {
  final SpeakingRepository _speakingRepository;
  final TranscribeRepository _transcribeRepository;
  SpeakingController(this._transcribeRepository, this._speakingRepository);
  final SlideController slideController = SlideController(
      usePreActionController: true, usePostActionController: true);

  var speakingStatus = Rx<SpeakingStatus>(SpeakingStatus.initial);

  TextEditingController targetController = TextEditingController();
  RecorderController recordController = RecorderController();
  PlayerController playerController = PlayerController();

  a.AudioPlayer audioPlayer = a.AudioPlayer();
  // late Box<SpeakingModel> box;
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

  // Get Data

  Future<void> getData() async {
    speakingStatus(SpeakingStatus.loading);
    final data = await _speakingRepository.getSpeaking();
    if (data != null) {
      speakingData.assignAll(data);
      speakingStatus(SpeakingStatus.success);
      isPlaying.clear();
      isPlaying.value = List.generate(data.length, (index) => false).toList();
    } else {
      speakingStatus(SpeakingStatus.failed);
    }
  }

// Load data speaking from local storage

  // Future<void> loadSpeakingData() async {
  //   var box = await Hive.openBox<SpeakingModel>('speakings');
  //   final sepaking = box.values.toList().cast<SpeakingModel>();
  //   speakingData.assignAll(sepaking);
  // }

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
      String fileName = 'speaking-${speakingData.length + 1}.wav';
      currentRecordingPath = appDocDirectory.path;
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
      Get.back();
      WaitingProgress.init(title: 'Saving record processed');
      var param = SpeakingParam(
        title: titleController.text,
        audioPath: currentRecordingPath,
        duration:
            '${minutes.value.toString().padLeft(2, '0')}:${seconds.value.toString().padLeft(2, '0')}',
      );

      final res = await _speakingRepository.createdSpeaking(param);
      if (res != null) {
        // Bersihkan nilai saat ini
        titleController.clear();
        currentRecordingPath = null;
        getData();
        Get.back();
        Get.back();
        AppSnackbar.success(message: "Success save recording!");
      } else {
        Get.back();
        Get.back();
        AppSnackbar.error(message: "Failed save recording!");
      }
    } else {
      // ignore: avoid_print
      print("Tidak ada rekaman yang tersedia untuk disimpan.");
    }
  }

  // Future<bool?> createdSpeaking() async {

  //   if (res != null) {
  //     print("Berhasil");
  //     return true;
  //   }
  //   return null;
  // }

  // Future<void> addToLocalStorage(String id) async {
  //   var box = await Hive.openBox<SpeakingModel>('speakings');
  //   var speakingModel = SpeakingModel(
  //       titleController.text,
  //       currentRecordingPath ?? '',
  //       '${minutes.value.toString().padLeft(2, '0')}:${seconds.value.toString().padLeft(2, '0')}',
  //       id,
  //       "",
  //       DateTime.timestamp().toString());
  //   box.add(speakingModel);
  //   // ignore: avoid_print
  //   print("Rekaman disimpan.");
  // }

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
        List.generate(speakingData.length, (index) => false).toList();
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

  void deleteSpeaking(int id, String audioPath, String idTranscribe) {
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
              onPressed: () => deleteAction(id, audioPath, idTranscribe),
              child: Text(
                'Yes',
                style: subTitleBold,
              ))
        ]);
  }

  void deleteAction(int id, String audioPath, String idTranscribe) async {
    Get.back();
    WaitingProgress.init(title: "Delete Speaking");
    final res = await _speakingRepository.deleteSpeaking(id, idTranscribe);
    if (res != null) {
      await Future.delayed(2.seconds, () {
        File(audioPath).delete();
        getData();
        Get.back();
        AppSnackbar.success(message: "Speaking deleted!");
      });
    } else {
      AppSnackbar.error(message: "Failed delete speaking!");
    }
  }

  Future<void> openTranscribe(
      int id, String idTranscript, String? transcribe, int index) async {
    if (transcribe == null) {
      Get.defaultDialog(
          title: "Transcribe Audio",
          titleStyle: titleBold,
          middleText: "Audio not transcribe, trancribe now?",
          middleTextStyle: subTitleNormal,
          titlePadding: const EdgeInsets.only(top: 12),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          radius: 8.r,
          actions: [
            TextButton(
                onPressed: () => Get.back(),
                child: Text(
                  'No',
                  style: hintSubTitleBold,
                )),
            TextButton(
                onPressed: () =>
                    addTranscribeToSpeaking(id, idTranscript, index),
                child: Text(
                  'Yes',
                  style: subTitleBold,
                ))
          ]);
    } else {
      openBottomSheetTranscribe(transcribe);
    }
  }

  Future<void> addTranscribeToSpeaking(
      int id, String idTranscribe, int index) async {
    Get.back();
    speakingStatus(SpeakingStatus.waiting);
    if (speakingStatus.value == SpeakingStatus.waiting) {
      WaitingProgress.init(title: 'Trancribe processed');
    }
    final res =
        await _speakingRepository.addTranscribeToSpeaking(id, idTranscribe);
    if (res == true) {
      await getData();
      await Future.delayed(1.seconds, () {
        speakingStatus(SpeakingStatus.success);
        Get.back();
        openBottomSheetTranscribe(speakingData[index].transcript ?? '');
      });
    } else {
      Get.back();
      AppSnackbar.error(
          message: "Try again later, the transcription is being generated!");
    }
  }

  void openBottomSheetTranscribe(String transcribe) async {
    Get.bottomSheet(TranscribeAudioWidget(transcribe: transcribe),
        enterBottomSheetDuration: 400.milliseconds,
        exitBottomSheetDuration: 400.milliseconds);
  }

  @override
  void onInit() {
    // box = Hive.box<SpeakingModel>('speakings');
    getData();
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
