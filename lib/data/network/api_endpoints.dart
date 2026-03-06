class ApiEndpoints {
  static const baseUrl = 'backofficegame.timuye.com';
  static const prefix = '/api';

  static const login = '$prefix/login/mobile';
  static const logout = '$prefix/logout';
  static const getProfile = '$prefix/profile';
  static const getkelas = '$prefix/kelas';
  static const getsiswabykelasid = '$prefix/getkelasbyidsiswa';
  static const getujian = '$prefix/ujian';
  static const getsoalujian = '$prefix/ujian/soal';
  static const getperingkat = '$prefix/peringkat';
  static const getdashboard = '$prefix/dashboard';
  static const submitjawaban = '$prefix/jawaban-siswa';
  static const getprogresreport = '$prefix/progress-report';
}
