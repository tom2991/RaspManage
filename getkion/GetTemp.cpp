#include "GetTemp.h"

GetTemp::GetTemp() {
  temperature = 0.;
  humidity = 0.;
}

bool GetTemp::execute() {
  int fd;
  int ret;

  int tData; // 温度
  int hData; // 湿度

  unsigned char result[4];
  unsigned char set_value[3];
  unsigned char get_value[1];

  // RDYピン準備
  wiringPiSetupGpio();
  pinMode(HDC1000_RDY_PIN, INPUT);

  // I2C準備
  fd = wiringPiI2CSetup(HDC1000_ADDRESS);

  // センサー設定値
  set_value[0] = HDC1000_CONFIGURATION_POINTER;
  set_value[1] = HDC1000_CONFIGURE_MSB;
  set_value[2] = HDC1000_CONFIGURE_LSB;

  // センサー設定
  ret = write(fd, set_value, 3);
  if (ret < 0) {
      printf("error: set configuration value\n");
      return false;
  }

  // 温度・湿度の値を同時取得
  get_value[0] = HDC1000_TEMPERATURE_POINTER;
  ret = write(fd, get_value, 1);
  if (ret < 0) {
      printf("error: get value\n");
      return false;
  }

  // 変換待ち
  while(digitalRead(HDC1000_RDY_PIN) == 1) {
      ;
  }

  // 値取得
  ret = read(fd, result, 4);
  if (ret < 0) {
      printf("error: read value\n");
      return false;
  }

  tData = result[0] << 8;
  tData |= result[1];
  temperature = ((tData / 65536.0 * 165.0) - 40.0);

  hData = result[2] << 8;
  hData |= result[3];
  humidity = hData / 65536.0 * 100;
  return true;
}
