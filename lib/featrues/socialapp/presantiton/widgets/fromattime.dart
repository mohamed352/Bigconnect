String getTimeDifferenceFromNow(DateTime dateTime) {
  Duration difference = DateTime.now().difference(dateTime);
  if (difference.inSeconds < 5) {
    return "Just now";
  } else if (difference.inMinutes < 1) {
    return "${difference.inSeconds}s ";
  } else if (difference.inHours < 1) {
    return "${difference.inMinutes}m ";
  } else if (difference.inHours < 24) {
    return "${difference.inHours}h ";
  } else {
    return "${difference.inDays}d ";
  }
}