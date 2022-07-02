char str = '1';	// string de leitura da porta usb

unsigned long timeS01 = 0; // variavel de armazenamento de tempo de inicicializacao do programa
unsigned long timeStartS01 = 0; // variavel de armazenamento de tempo de inicicializacao da contagem de interrupçoes
unsigned long timeEndS01 = 0; // variavel de armazenamento de tempo de finalização da contagem de interrupçoes
unsigned volatile int contTimeS01 = 0;// numero de interrupcoes capituradas pelo sensor IR

unsigned long timeS02 = 0; // variavel de armazenamento de tempo de inicicializacao do programa
unsigned long timeStartS02 = 0; // variavel de armazenamento de tempo de inicicializacao da contagem de interrupçoes
unsigned long timeEndS02 = 0; // variavel de armazenamento de tempo de finalização da contagem de interrupçoes
unsigned int contTimeS02 = 0;// numero de interrupcoes capituradas pelo sensor IR
unsigned int contVoltasDisco = 0;// variavel de armazenamento de numero de voltas do disco 

volatile float velocDisco = 0;
volatile float velocPrecessao = 0;

volatile long x = 30000; //contador para função de tempo para motor brushless

void setup() {
	Serial.begin(9600);	// opens serial port, sets data rate to 9600 bps
         
         pinMode(4, OUTPUT);
         pinMode(5, OUTPUT);   
         pinMode(6, OUTPUT);
         pinMode(7, OUTPUT);
         pinMode(8, OUTPUT);
         pinMode(9, OUTPUT);
         pinMode(10, OUTPUT);
         pinMode(11, OUTPUT);
         pinMode(12, INPUT);
         pinMode(13, OUTPUT);
         
         digitalWrite(13, LOW);
         
         attachInterrupt(0,addContTimeS01, RISING);
         attachInterrupt(1,addContTimeS02, RISING);
         
}

// contador de interrupcoes IR(velocidade presseção)

void addContTimeS01() {  //contTimeS01 += 1;
                         timeEndS01 = millis();      //capitura tempo em milisegundos de inicializacao		        
                         timeS01 = timeEndS01 - timeStartS01;
                       //if(contTimeS01 >= 1) {
                           if(timeS01 > 500 && timeS01 < 4000){   // calculo de erro das interrupções
                           //contTimeS01 += 1;
                           //velocPrecessao = velocPrecessao + timeS01;
                           
                                   velocPrecessao = ((1000 * 6.28)/timeS01);
                                 
                                  Serial.println(velocPrecessao);
                           
                           /* if(contTimeS01 == 3)
                             {
                                  float media = velocPrecessao/3;
                                  velocPrecessao = ((1000 * 6.28)/media);
                                  contTimeS01 = 0;
                                  Serial.println(velocPrecessao);
                            
                           }*/
                           
                           } //contTimeS01 = 0;
                             timeStartS01 = millis();
                       //}
                       
                     
                   }




// contador de interrupcoes IR(velocidade angular do disco)
void addContTimeS02() {  //contTimeS02 += 1; 
                          timeEndS02 = millis();      //capitura tempo em milisegundos de inicializacao		        
                          timeS02 = timeEndS02 - timeStartS02;
                        
                  // if(contTimeS02 >= 1) {
    
                        if(timeS02 >= 12){ // calculo de erro das interrupções
                             velocDisco = ((1000/timeS02) * 6.28);
                             contVoltasDisco++;
                             
                                if(contVoltasDisco >= 100){
                                    contVoltasDisco = 0;
                                    
                                    //Serial.print("Velocidade do disco em rad/s: ");
                                    Serial.println(velocDisco);
                                    //Serial.println(contTimeS02);
                                   }
                             }
                             
                             //contTimeS02 = 0;
                             timeStartS02 = millis();
                             
                         // } 
                     
                       
                     
                   }
                   
                   

// girar motor em sentido horario
void motor_passo1(int t){
       
       digitalWrite(8, HIGH);
       digitalWrite(9, HIGH);
       digitalWrite(10, LOW);
       digitalWrite(11, LOW);
       
       delay(t);
       
       digitalWrite(8, LOW);
       digitalWrite(9, HIGH);
       digitalWrite(10, HIGH);
       digitalWrite(11, LOW);
       
       delay(t);
       
       digitalWrite(8, LOW);
       digitalWrite(9, LOW);
       digitalWrite(10, HIGH);
       digitalWrite(11, HIGH);
              
       delay(t);
       
       digitalWrite(8, HIGH);
       digitalWrite(9, LOW);
       digitalWrite(10, LOW);
       digitalWrite(11, HIGH);
              
       delay(t);
      
       }  




// girar motor em sentido anti-horario
void motor_passo2(int t){
       
       digitalWrite(8, HIGH);
       digitalWrite(9, LOW);
       digitalWrite(10, LOW);
       digitalWrite(11, HIGH);
              
       delay(t);
       
       digitalWrite(8, LOW);
       digitalWrite(9, LOW);
       digitalWrite(10, HIGH);
       digitalWrite(11, HIGH);
              
       delay(t);
       
       digitalWrite(8, LOW);
       digitalWrite(9, HIGH);
       digitalWrite(10, HIGH);
       digitalWrite(11, LOW);
       
       delay(t);
      
       digitalWrite(8, HIGH);
       digitalWrite(9, HIGH);
       digitalWrite(10, LOW);
       digitalWrite(11, LOW);
       
       delay(t); 
      
       digitalWrite(8, HIGH);
       digitalWrite(9, LOW);
       digitalWrite(10, LOW);
       digitalWrite(11, HIGH);
              
       delay(t);
      
       }  
       
       void motor_passo3(int t){
       
       digitalWrite(8, LOW);
       digitalWrite(9, LOW);
       digitalWrite(10, LOW);
       digitalWrite(11, LOW);
              
       delay(t);
       
       
       
       
       }  
       
       void motor_passo4(int t){
       
       digitalWrite(8, HIGH);
       digitalWrite(9, LOW);
       digitalWrite(10, LOW);
       digitalWrite(11, LOW);
       
       
       delay(t);
       
       digitalWrite(8, HIGH);
       digitalWrite(9, HIGH);
       digitalWrite(10, LOW);
       digitalWrite(11, LOW);
       
       delay(t);
       
       digitalWrite(8, LOW);
       digitalWrite(9, HIGH);
       digitalWrite(10, LOW);
       digitalWrite(11, LOW);
              
       delay(t);
       
       digitalWrite(8, LOW);
       digitalWrite(9, HIGH);
       digitalWrite(10, HIGH);
       digitalWrite(11, LOW);
              
       delay(t);
      
       digitalWrite(8, LOW);
       digitalWrite(9, LOW);
       digitalWrite(10, HIGH);
       digitalWrite(11, LOW);
       
       
       delay(t);
       
       digitalWrite(8, LOW);
       digitalWrite(9, LOW);
       digitalWrite(10, HIGH);
       digitalWrite(11, HIGH);
       
       delay(t);
       
       digitalWrite(8, LOW);
       digitalWrite(9, LOW);
       digitalWrite(10, LOW);
       digitalWrite(11, HIGH);
              
       delay(t);
       
       digitalWrite(8, HIGH);
       digitalWrite(9, LOW);
       digitalWrite(10, LOW);
       digitalWrite(11, HIGH);
              
       delay(t);
       }  



void motor_brushless(int t){
       
       digitalWrite(5, LOW);
       digitalWrite(6, HIGH);
       digitalWrite(7, LOW);
       
              
       delay(t);
       
       digitalWrite(5, LOW);
       digitalWrite(6, HIGH);
       digitalWrite(7, HIGH);
              
       delay(t);
       
       digitalWrite(5, LOW);
       digitalWrite(6, LOW);
       digitalWrite(7, HIGH);
       
       delay(t);
      
       digitalWrite(5, HIGH);
       digitalWrite(6, LOW);
       digitalWrite(7, HIGH);
       
       delay(t); 
      
       digitalWrite(5, HIGH);
       digitalWrite(6, LOW);
       digitalWrite(7, LOW);
              
       delay(t);
      
       digitalWrite(5, HIGH);
       digitalWrite(6, HIGH);
       digitalWrite(7, LOW);
              
       delay(t);
       }  
       
       
 //aciona motor brushless dc

void brushless(long x)
       {

       digitalWrite(6, HIGH);
       digitalWrite(7, LOW);
       digitalWrite(8, LOW);
       digitalWrite(9, LOW);
       digitalWrite(10, LOW);
       digitalWrite(11, HIGH);
       
       delayMicroseconds(x);
       
       digitalWrite(6, HIGH);
       digitalWrite(7, LOW);
       digitalWrite(8, LOW);
       digitalWrite(9, HIGH);
       digitalWrite(10, LOW);
       digitalWrite(11, LOW);
       
       delayMicroseconds(x);
       
       digitalWrite(6, LOW);
       digitalWrite(7, LOW);
       digitalWrite(8, LOW);
       digitalWrite(9, HIGH);
       digitalWrite(10, HIGH);
       digitalWrite(11, LOW);
       
       delayMicroseconds(x);
       
       digitalWrite(6, LOW);
       digitalWrite(7, HIGH);
       digitalWrite(8, LOW);
       digitalWrite(9, LOW);
       digitalWrite(10, HIGH);
       digitalWrite(11, LOW);
       
       delayMicroseconds(x);
       
       digitalWrite(6, LOW);
       digitalWrite(7, HIGH);
       digitalWrite(8, HIGH);
       digitalWrite(9, LOW);
       digitalWrite(10, LOW);
       digitalWrite(11, LOW);

       delayMicroseconds(x);
       
       digitalWrite(6, LOW);
       digitalWrite(7, LOW);
       digitalWrite(8, HIGH);
       digitalWrite(9, LOW);
       digitalWrite(10, LOW);
       digitalWrite(11, HIGH);
       
       delayMicroseconds(x);
       
       } 

   void piscaLed(){
     
   digitalWrite(13, HIGH);
   delay(30);
   digitalWrite(13, LOW);
   delay(30);
   
 }


 void iniciarExperimento(){  // liga o motor do giroscopio e espera atingir uma velocidade minima
  
       digitalWrite(4, HIGH);   // aciona motor
  
       //while(velocDisco < 300){}  // espera disco atingir alta velocidade
       //delay(3000);
 
 } 
 
  void desligarMotorGiro(){  
  
       digitalWrite(4, LOW);   // desliga motor
  
      
 } 

 void inclinarArco(){
 
      //attachInterrupt(1);  // desativa interrupção
     
      int temp = 0;
      
      while (temp < 85){
            motor_passo4(10);
            temp++;
      }
      str='3';
       motor_passo3(50);
       
       temp = 0;
       while (temp < 35){
            motor_passo4(10);
            temp++;
      }
      delay(10000);
      motor_passo3(50);
      
      delay(2000);
      desligarMotorGiro();
 }




void loop() {

  ///*
 
  
        
        
  
                          
                          
                           
	// send data only when you receive data:
	if (Serial.available() > 0) {
		
		str = Serial.read();  // read the incoming byte:
                   
                     if((str != '0')){                
		       // say what you got:
                        //Serial.print("I received: ");
                        //Serial.println(str);
                        
                       
                               
                        
                     }  

         }
         
                               if(str=='b') motor_brushless(50);
                               
                               if(str=='d') motor_passo1(10);
                               
                               if(str=='e') motor_passo2(10);

                               if(str=='r') motor_passo3(50);
                               
                               if(str=='w') motor_passo4(10);
                               
                               if(str=='M') inclinarArco();
                               
                               if(str=='I') iniciarExperimento();
                               
                               if(str == 'D') desligarMotorGiro(); 
     // */   
     /*
       
     
         if (x > 6000){

                brushless(x);
                x = x - 50;
         }
     

         else if (x > 2000 && x <= 6000){

                brushless(x);
                x = x - 5;
         }

         else if (x > 600 && x <= 2000){

                brushless(x);
                x = x - 3;
         }

         else if (x > 500 && x <= 600){

                brushless(x);
                x = x - 1;
         }

         else

              brushless(x);
      */  

}

 
