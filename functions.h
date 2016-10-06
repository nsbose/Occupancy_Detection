#include "Adafruit_BMP280.h"
#include "Adafruit_TCS34725.h"
#include "Adafruit_HTU21DF.h"
#include "ThingSpeak.h"
#include "definitions.h"


// BMP180 Temperature, Pressure, Altitude
extern Adafruit_BMP280 bmp;
void InitializeBMP280();

// TCS34725 Color Sensor
extern Adafruit_TCS34725 tcs;
void InitializeTCS34725();
void SampleTCS34725(uint16_t *r, uint16_t *g, uint16_t *b, uint16_t *c);

// HTU21DF Humidity Sensor
extern Adafruit_HTU21DF htu;
void InitializeHTU21DF();
