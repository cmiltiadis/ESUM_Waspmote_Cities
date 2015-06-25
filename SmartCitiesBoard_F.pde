
// Put your libraries here (#include ...)
#include <WaspSensorCities.h>

// CONSTANTS
#define FRAME_DELAY_TIME 1000 //delay time between readings (milliseconds)
//SENSORS
bool readAudio= true; 
bool readLuminosity = true; 
bool readDust= true;

//parse token
char frameToken ='$'; 



void setup() {
  // Turn on the USB and print a start message
  USB.ON();
  USB.println(F("ESUM_Smart_Cities_Board"));

  getBatteryReading(); 
  delay(100);

  // Turn on the sensor board
  SensorCities.ON();
  // Turn on the RTC
  RTC.ON();
  
  //print sensor setup
  printSensorSetup(); 

  /*
   * Initialize sensors from the beginning
   * Otherwise the have to be switched on and off on each frame
   * which makes everything slower
   */

  if (readLuminosity){
    // Turn on the sensor and wait for stabilization and response time
    SensorCities.setSensorMode(SENS_ON, SENS_CITIES_LDR);
  }
  if (readAudio){
    SensorCities.setSensorMode(SENS_ON, SENS_CITIES_AUDIO);
  }
  if (readDust){
     SensorCities.setSensorMode(SENS_ON, SENS_CITIES_DUST); 
  }
}

void loop() {
  
  /*
   *  GET SENSOR READINGS
   */
   
  float luminosityVal=0; 
  if(readLuminosity){
    // Read the LDR sensor 
    luminosityVal = SensorCities.readValue(SENS_CITIES_LDR);

  }

  float audioVal=0; 
  if (readAudio){
   // Read the audio sensor 
    audioVal = SensorCities.readValue(SENS_CITIES_AUDIO);
  }
  
  float dustVal =0; 
  if (readDust){
    // Read the Dust sensor 
  dustVal = SensorCities.readValue(SENS_CITIES_DUST);
  }

  /*
   * OUTPUT READINGS
   */
  USB.print(frameToken);  //the token is used to get the first value of each frame
  
  if (readAudio){
    USB.print(F("Sound pressure: "));
    USB.print(audioVal);
    USB.println(F(" dBA"));
  }
  if (readLuminosity){
    //USB.print(token); 
    USB.print(F("Luminosity: "));
    USB.print(luminosityVal);
    USB.println(F(" %"));
  }
  
  if (readDust){
     USB.print(F("Dust: "));
    USB.print(dustVal);
    USB.println(F(" mg/m3"));
  }

  //do a delay for the sensors to power down
  delay(FRAME_DELAY_TIME);
}











