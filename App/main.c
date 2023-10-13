#include "stdio.h"
#include "stm32_hal_init.h"
#include "stm32f4xx_hal.h"
#include "rtthread.h"

#define LCTStatus_ERROR_LED         GPIOE, GPIO_PIN_2
#define LCTStatus_RUNNING_LED       GPIOE, GPIO_PIN_3

int main(void)
{
    GPIO_InitTypeDef GPIO_InitStruct = {0};

    __HAL_RCC_GPIOE_CLK_ENABLE();

    GPIO_InitStruct.Pin = GPIO_PIN_2|GPIO_PIN_3;
    GPIO_InitStruct.Mode = GPIO_MODE_OUTPUT_PP;
    GPIO_InitStruct.Pull = GPIO_NOPULL;
    GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_LOW;
    HAL_GPIO_Init(GPIOE, &GPIO_InitStruct);

    while(1)
    {
        rt_thread_mdelay(500);
        HAL_GPIO_WritePin(LCTStatus_RUNNING_LED, GPIO_PIN_SET);
        rt_thread_mdelay(500);
        HAL_GPIO_WritePin(LCTStatus_RUNNING_LED, GPIO_PIN_RESET);
    }

    return 0;
}

