library timestampformat;

class Language {
  static String justNow = "just now";
  static String yesterday = "yesterday";
  static String today = "today";
  static String year = "year";
  static String month = "month";
  static String day = "day";
  static String hour = "hrs";
  static String minute = "mins";
}

class TimestampFormat {
  String formatMonth(month) {
    String name = "";
    switch (month) {
      case 1:
        name = "Jan";
        break;
      case 2:
        name = "Feb";
        break;
      case 3:
        name = "Mar";
        break;
      case 4:
        name = "Apr";
        break;
      case 5:
        name = "May";
        break;
      case 6:
        name = "Jun";
        break;
      case 7:
        name = "Jul";
        break;
      case 8:
        name = "Aug";
        break;
      case 9:
        name = "Sep";
        break;
      case 10:
        name = "Oct";
        break;
      case 11:
        name = "Nov";
        break;
      case 12:
        name = "Dec";
        break;
      default:
    }
    return name;
  }

  String zeroFormat(num) {
    return (num.toString().length == 1 ? '0' : '') + num.toString();
  }

  String parseTime(int timestamp) {
    var curTimestamp = int.parse((DateTime.now().millisecondsSinceEpoch / 1000)
        .floor()
        .toString()); // current timestamp

    if (timestamp.toString().length == 13) {
      timestamp = (timestamp / 1000).floor();
    }

    var timestampDiff = curTimestamp - timestamp; // differ time

    DateTime curDate = DateTime.fromMillisecondsSinceEpoch(
      int.parse((curTimestamp * 1000).toString()),
    ); // now datetime

    DateTime targetDate = DateTime.fromMillisecondsSinceEpoch(
        timestamp * 1000); // target DateTime
    int Y = targetDate.year;
    int m = targetDate.month;
    int d = targetDate.day;
    int H = targetDate.hour;
    int i = targetDate.minute;
    int s = targetDate.second;

    if (timestampDiff < 60) {
      // Less than one minute
      return Language.justNow;
    } else if (timestampDiff < 3600) {
      // Less than one hour
      return (timestampDiff / 60).floor().toString() +
          " " +
          Language.minute +
          " ago";
    } else if (curDate.year == Y && curDate.month == m && curDate.day == d) {
      /// Same Day
      return Language.today + " " + zeroFormat(H) + ':' + zeroFormat(i);
    } else {
      var newDate =
          DateTime.fromMillisecondsSinceEpoch((curTimestamp - 86400) * 1000);

      if (newDate.year == Y && newDate.month == m && newDate.day == d) {
        // yesterday
        return Language.yesterday + " " + zeroFormat(H) + ':' + zeroFormat(i);
      } else if (curDate.year == Y) {
        /// Same year
        return formatMonth(m) + " " + zeroFormat(d);
      } else {
        /// other years
        return formatMonth(m) + " " + zeroFormat(d) + ", " + Y.toString();
      }
    }
  }
}
