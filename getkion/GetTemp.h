
#include <cstdio>
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

class GetTemp
{
private:
  float temperature;
  float humidity;
public:
  GetTemp();
  bool execute();
  float getTemperature(){return temperature;}
  float getHumidity(){return humidity;}
};
