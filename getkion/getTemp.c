#include <stdio.h>
#include <unistd.h>
#include <wiringPi.h>
#include <wiringPiI2C.h>

#define HDC1000_ADDRESS             0x40
#define HDC1000_RDY_PIN             4

#define HDC1000_TEMPERATURE_POINTER     0x00
#define HDC1000_HUMIDITY_POINTER        0x01
#define HDC1000_CONFIGURATION_POINTER       0x02
#define HDC1000_SERIAL_ID1_POINTER      0xfb
#define HDC1000_SERIAL_ID2_POINTER      0xfc
#define HDC1000_SERIAL_ID3_POINTER      0xfd
#define HDC1000_MANUFACTURER_ID_POINTER     0xfe
#define HDC1000_DEVICE_ID_POINTER       0xff

#define HDC1000_CONFIGURE_MSB           0x10
#define HDC1000_CONFIGURE_LSB           0x00

int main(void) {

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
        return 1;
    } 

    // 温度・湿度の値を同時取得
    get_value[0] = HDC1000_TEMPERATURE_POINTER;
    ret = write(fd, get_value, 1);
    if (ret < 0) {
        printf("error: get value\n");
        return 1;
    }

    // 変換待ち
    while(digitalRead(HDC1000_RDY_PIN) == 1) {
        ;
    }

    // 値取得
    ret = read(fd, result, 4);
    if (ret < 0) {
        printf("error: read value\n");
        return 1;
    }

    tData = result[0] << 8;
    tData |= result[1];
	float kion = ((tData / 65536.0 * 165.0) - 40.0);

    hData = result[2] << 8;
    hData |= result[3];

    printf("気温：%.1f度 ", kion);
    printf("湿度：%.1f％です。\n", (hData / 65536.0 * 100));
	if(kion > 28.0){
		printf("あつい");
	}
	else if(kion > 18.0) {
		printf("かいてき\n");
	}
	else if(kion <= 15.0) {
		printf("さむい\n");
	}

    return 0;
}
