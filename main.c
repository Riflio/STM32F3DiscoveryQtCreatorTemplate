#include "stm32f30x_conf.h"


#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
GPIO_InitTypeDef gpio; //-- храним настройки портов
 
//-- реализуем функцию задержки
void delay(long ms)
{
    for(long i=0; i<ms; i++) __NOP();
}
  
//-- настраиваем порты
void initAll()
{
    RCC_AHBPeriphClockCmd(RCC_AHBPeriph_GPIOE, ENABLE);
  
    gpio.GPIO_Mode = GPIO_Mode_OUT;
    gpio.GPIO_Pin = GPIO_Pin_8 | GPIO_Pin_9 | GPIO_Pin_10 | GPIO_Pin_11 | GPIO_Pin_12 | GPIO_Pin_13 | GPIO_Pin_14 | GPIO_Pin_15 ;
    GPIO_Init(GPIOE, &gpio);
}
 
int main()
{
    initAll();
    int pins[8] = {GPIO_Pin_8, GPIO_Pin_9, GPIO_Pin_10, GPIO_Pin_11, GPIO_Pin_12, GPIO_Pin_13, GPIO_Pin_14, GPIO_Pin_15 };
         
    int i = 0;
    while(1){   
         
        if (i>=8) {
            i=0;
            GPIO_ResetBits(GPIOE, pins[7]);
        }
         
        if (i>0) {
            GPIO_ResetBits(GPIOE, pins[i-1]);
        }
         
        GPIO_SetBits(GPIOE, pins[i]);
        delay(910000);
         
        i++;        
         
    }
}

