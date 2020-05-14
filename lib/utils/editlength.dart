int min(int a, int b) {
  if (a < b)
    return a;
  else
    return b;
}

int max(int a, int b) {
  if (a > b)
    return a;
  else
    return b;
}

List<List<int>> dd_list(int n, int m) {
  List<List<int>> dp = List();
  for (int i = 0; i < n; i++) {
    List<int> tmp = List();
    for (int j = 0; j < m; j++) {
      tmp.add(0);
    }
    dp.add(tmp);
  }
  return dp;
}

int longest_common_sequence(String a, String b) {
  int la = a.length;
  int lb = b.length;
  List<List<int>> dp = dd_list(la + 1, lb + 1);
  for (int i = 0; i <= la; i++) {
    dp[i][0] = 0;
  }
  for (int j = 0; j <= lb; j++) {
    dp[0][j] = 0;
  }
  for (int i = 1; i <= la; i++) {
    for (int j = 1; j <= lb; j++) {
      if (a.codeUnitAt(i - 1) == b.codeUnitAt(j - 1)) {
        dp[i][j] = dp[i - 1][j - 1]+1;
      } else {
        dp[i][j] = max(dp[i - 1][j], dp[i][j - 1]);
      }
    }
  }
  return dp[la][lb];
}

int edit_length(String a, String b) {
//  print("edit lenth" + a + " " + b);
//  print(a.codeUnits);
//  print(b.codeUnits);
  int la = a.length;
  int lb = b.length;
  List<List<int>> dp = dd_list(la + 1, lb + 1);
  for (int i = 0; i <= la; i++) {
    dp[i][0] = i;
//    print(a.codeUnitAt(i));
  }
  for (int j = 0; j <= lb; j++) {
    dp[0][j] = j;
//    print(b.codeUnitAt(j));
  }
  for (int i = 1; i <= la; i++) {
    for (int j = 1; j <= lb; j++) {
//       print("ok" + a.codeUnitAt(i-1).toString() + " " + b.codeUnitAt(j-1).toString());
      if (a.codeUnitAt(i - 1) == b.codeUnitAt(j - 1)) {
        dp[i][j] = dp[i - 1][j - 1];
      } else {
        dp[i][j] = min(min(dp[i - 1][j], dp[i][j - 1]), dp[i - 1][j - 1]) + 1;
      }
    }
  }

//  print("edit lenth" + a + " " + b + " " + dp[la][lb].toString());
//  print(dp);
  return dp[la][lb];
}
