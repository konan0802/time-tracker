const NoTask = '[No current task]';
const MtgTime = 'MTGタスク';
const BreakTime = '休憩時間';
const OtherTime = 'その他(工数見積・サポート)';

const fexedTasks = [
  NoTask,
  MtgTime,
  '開発部 全般タスク',
  OtherTime,
  '全社タスク(開発関係以外)',
  BreakTime
];

String MyTask = '1178401050518173';

String Main = '1201164375807533';
String Spot = '1201073557779280';
String Review = '1201405932474075';

List<String> AsanaSectionList = [
  Main,
  Spot,
  Review,
];

Map<String, String> SectionIDs = {
  'Main': '1201164375807533',
  'Spot': '1201073557779280',
  'Review': '1201405932474075',
};
