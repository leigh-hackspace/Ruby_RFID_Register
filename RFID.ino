#include <MFRC522.h>

/**
 * ----------------------------------------------------------------------------
 * Based on an MFRC522 library example; see https://github.com/miguelbalboa/rfid
 *- ----------------------------------------------------------------------------
 */
#include <SPI.h>
#include <MFRC522.h>

#define RST_PIN         5
#define SS_PIN          10
int LEDRed = 3;
int LEDGreen =4;
int Speaker = 7;

MFRC522 mfrc522(SS_PIN, RST_PIN);   // Create MFRC522 instance.

MFRC522::MIFARE_Key key;

/**
 * Initialize.
 */
void setup() {
    Serial.begin(9600);  // Initialize serial communications with the PC
    while (!Serial);    // Do nothing if no serial port is opened (added for Arduinos based on ATMEGA32U4)
    SPI.begin();    // Init SPI bus
    mfrc522.PCD_Init(); // Init MFRC522 card

    // Prepare the key (used both as key A and as key B)
    for (byte i = 0; i < 6; i++) {
        key.keyByte[i] = 0xFF;
    }
}

/**
 * Main loop.
 */
void loop() {
    // Look for new cards
    if ( ! mfrc522.PICC_IsNewCardPresent())
        return;

    // Select one of the cards
    if ( ! mfrc522.PICC_ReadCardSerial())
        return;
    // Show some details of the PICC (that is: the tag/card)
    Serial.print(F("{\"CardUID\":\""));
    dump_byte_array(mfrc522.uid.uidByte, mfrc522.uid.size);
    Serial.println("\"}");
    analogWrite(LEDRed,1000);
	analogWrite(Speaker,500);
    delay(500);
    analogWrite(LEDRed,0);
	analogwrute(Speaker,0);
    // Check for compatibility
        return;
    // Halt PICC
    mfrc522.PICC_HaltA();
    // Stop encryption on PCD
    mfrc522.PCD_StopCrypto1();
	delay(3000);
}

/**
 * Helper routine to dump a byte array as hex values to Serial.
 */
void dump_byte_array(byte *buffer, byte bufferSize) {
    if (bufferSize >4){
      for (byte i = 3; i< bufferSize; i++) {
        Serial.print(buffer[i] < 0x10 ? "0" : "");
        Serial.print(buffer[i], HEX);
        }
      }
    else{
      for (byte i = 0; i < bufferSize; i++) {
        Serial.print(buffer[i] < 0x10 ? "0" : "");
        Serial.print(buffer[i], HEX);
      }
    }
}

