#include <cstdio>
#include "GetTemp.h"

int main() {
  GetTemp getTemp;
  if(!getTemp.execute()) {
    printf("取得に失敗しました。\n");
    return 0;
  }
  printf("気温：%.1f度 ", getTemp.getTemperature());
  printf("湿度：%.1f％です。\n", getTemp.getHumidity());
  if(getTemp.getTemperature() > 28.0){
    printf("あつい");
  }
  else if(getTemp.getTemperature() > 18.0) {
    printf("かいてき\n");
  }
  else if(getTemp.getTemperature() <= 15.0) {
    printf("さむい\n");
  }
}
