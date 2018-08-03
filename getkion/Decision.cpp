#include <cstdio>
#include "GetTemp.h"

/**
 * エアコンON/OFF判定
 * @return 0：つけない
 *         1：暖房をつける
 *         2：冷房をつける（未実装）
 */
int main() {
  GetTemp getTemp;
  if(!getTemp.execute()) {
    printf("取得に失敗しました\n");
    return 0;
  }
  if(getTemp.getTemperature() < 16.) {
    printf("%.1f度です。\n暖房おん！\n",getTemp.getTemperature());
    return 1;
  }
  //  else if(getTemp.getTemperature() > 30.) {
  //   printf("冷房おん！");
  // }
  printf("%.1f度だからエアコンはつけないよ\n",getTemp.getTemperature());
  return 0;
}
