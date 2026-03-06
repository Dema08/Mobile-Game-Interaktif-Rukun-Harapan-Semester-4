import 'package:audioplayers/audioplayers.dart';

class MusicService {
  static final _musicPlayer = AudioPlayer();
  static final _sfxPlayer = AudioPlayer();

  static Future<void> playSoalMusic() async {
    await _musicPlayer.setReleaseMode(ReleaseMode.loop);
    await _musicPlayer.setVolume(1.0);
    await _musicPlayer.play(AssetSource('audio/opening_meme.mp3'));
  }

  static Future<void> playRingtoneOnce() async {
    await _sfxPlayer.setReleaseMode(ReleaseMode.stop);
    await _musicPlayer.setVolume(2.0);
    await _sfxPlayer.play(AssetSource('audio/soal_selesai.mp3'));
  }

  static Future<void> playSelesaiMusic() async {
    await _musicPlayer.stop();
    await _musicPlayer.setReleaseMode(ReleaseMode.loop);
    await _musicPlayer.play(AssetSource('audio/victory.mp3'));
  }

  static void stopMusicOnly() {
    _musicPlayer.stop();
  }

  static void stopSfxOnly() {
    _sfxPlayer.stop();
  }

  static void stopAll() {
    _musicPlayer.stop();
    _sfxPlayer.stop();
  }
}
