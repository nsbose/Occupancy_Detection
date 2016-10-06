/*
Collects sensor data for a School of Public Health Project for monitoring
indoor environmental conditions and occupancy

Emily Lam, Multimedia Communications Lab, Boston University
*/

#include "Adafruit_BMP280.h"
#include "Adafruit_TCS34725.h"
#include "Adafruit_HTU21DF.h"
#include "ThingSpeak.h"
#include "functions.h"
#include "definitions.h"

// ThingSpeak Client
TCPClient ThingSpeakClient;
unsigned long myChannelNumber = 143904;
const char * myWriteAPIKey = "VAPEP7OWHFBR93UJ";

// Setup Loop
void setup() {

  Serial.begin(9600);

  // Temperature/Humidity/Pressure setup
  InitializeBMP280();

  // Color sensor setup
  InitializeTCS34725();

  // Humidity sensor setup
  InitializeHTU21DF();

  // ThingSpeak Client Setup
  ThingSpeak.begin(ThingSpeakClient);

}

void loop(void)
{

  ThingSpeak.setField(CH_TEMP, bmp.readTemperature());
  ThingSpeak.setField(CH_PRES, bmp.readPressure());
  //ThingSpeak.setField(CH_HUMD, bmp.readHumidity());

  uint16_t r, g, b, c;
  tcs.setInterrupt(true);  // turn off LED
  SampleTCS34725(&r, &g, &b, &c);
  ThingSpeak.setField(CH_COLR, tcs.calculateColorTemperature(r, g, b));
  ThingSpeak.setField(CH_LUX,  tcs.calculateLux(r, g, b));

  ThingSpeak.setField(CH_HUM2, htu.readHumidity());
  ThingSpeak.setField(CH_TEM2, htu.readTemperature());

  ThingSpeak.writeFields(myChannelNumber, myWriteAPIKey);

  // System.sleep(SLEEP_MODE_DEEP,20);

  //delay(20000);
}
