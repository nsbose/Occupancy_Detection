/*
Wiring and functions for the sensors
*/

#include "functions.h"

/*
    BMP280 Temperature, Pressure, Altitude

    Connections:
    ------------
    SCK -> D1
    SDA -> D0
    VCC -> 3.3V
    GND -> GND

    I2C Address:
    ------------
    Default -> 0x77
*/

Adafruit_BMP280 bmp;

void InitializeBMP280(){
	if (!bmp.begin()) {
    Serial.println("Could not find BMP280 sensor, check wiring!");
    while (1);
	}
}

/*
    TCS34725 Color Sensor

    Connections:
    ------------
    SCK -> D1
    SDA -> D0
    VCC -> 3.3V
    GND -> GND

    I2C Address:
    ------------
    Default -> 0x29
*/

Adafruit_TCS34725 tcs = Adafruit_TCS34725(TCS34725_INTEGRATIONTIME_700MS, TCS34725_GAIN_1X);

void InitializeTCS34725(){
  if (!tcs.begin()) {
    Serial.println("Could not find TCS34725 sensor, check wiring!");
    while (1);
    }
}

void SampleTCS34725(uint16_t *r,  uint16_t *g, uint16_t *b, uint16_t *c){
  delay(60);  // takes 50ms to read
  tcs.getRawData(r, g, b, c);
}

/*
    HTU21DF Humidity Sensor

    Connections:
    ------------
    SCK -> D1
    SDA -> D0
    VCC -> 3.3V
    GND -> GND

    I2C Address:
    ------------
    Default -> 0x40
*/

Adafruit_HTU21DF htu;

void InitializeHTU21DF(){
	if (!htu.begin()) {
    Serial.println("Could not find HTU21DF sensor, check wiring!");
    while (1);
	}
}
