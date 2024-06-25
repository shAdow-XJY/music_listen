import '../static/book_list_data.dart';
import 'music_model.dart';

class MusicManager {
  // 私有构造函数
  MusicManager._privateConstructor();

  // 单例实例
  static final MusicManager instance = MusicManager._privateConstructor();

  // 书籍列表
  final List<MusicModel> musicList = musicListData;
}
