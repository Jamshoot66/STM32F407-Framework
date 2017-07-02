------------------------------------------------------------------------------
--                              STM32F407 Framework                         --
--                 Written by Sergey "Jamshoot" Gorshkov. 2017.             --
--                           Default encoding is UTF-8.                     --
--                                                                          --
-- You can redistribute it and/or modify it under terms of the GNU General  --
-- Public License as published  by the Free Software  Foundation;  either   --
-- version 3,  or (at your option) any later version.                       --
--                                                                          --
-- You should have received a copy of the GNU General Public License and    --
-- a copy of the GCC Runtime Library Exception along with this program.     --
-- If not, see <http://www.gnu.org/licenses/>.                              --
------------------------------------------------------------------------------


package STM32F407.GPIO.Utils is

   ----------------------------------------------------------------------------
   -- Вспомогательный тип для упрощенного использования конкретного вывода   --
   -- GPIO.                                                                  --
   -- Использование:                                                         --
   -- declare                                                                --
   --   LED1 : rGPIO_Pin := rGPIO_Pin'(Port       => GPIOA'Access,           --
   --                                  Pin_Number => Pin1);                  --
   --   ...                                                                  --
   -- begin                                                                  --
   --     --включение тактирования GPIO                                      --
   --   STM32F407.GPIO.Utils.RCC_Clock_Enable(LED1.Port);                    --
   --     --быстрая настройка вывода как цифрового                           --
   --   STM32F407.GPIO.Utils.Init_as_Digital_Output( LED1 );                 --
   --     --выставление "высокого" состояния вывода                          --
   --   STM32F407.GPIO.Utils.Set_Pin( LED1, High );                          --
   ----------------------------------------------------------------------------
   type rGPIO_Pin is record
      Port : aliased pGPIO_Register;
      Pin_Number  : tPin;
   end record;

   ----------------------------------------------------------------------------
   -- Вспомогательная процедура установки высокого/низкого состояния вывода  --
   -- GPIO.                                                                  --
   -- Использование:                                                         --
   -- STM32F407.GPIO.Utils.Set_Pin( LED1, High );                            --
   ----------------------------------------------------------------------------
   procedure Set_Pin(fGPIO_Pin : in out rGPIO_Pin; HighLow : Bit_1);

   ----------------------------------------------------------------------------
   -- Вспомогательная функция, возвращающая true, если вывод находится в     --
   -- высоком состоянии                                                      --
   -- Использование:                                                         --
   -- LED1_Setted := STM32F407.GPIO.Utils.Is_Set( LED1 );                    --
   ----------------------------------------------------------------------------
   function Is_Set(fGPIO_Pin : in out rGPIO_Pin) return Boolean;


   ----------------------------------------------------------------------------
   -- Вспомогательная процедура изменения с высокого на низкого состояния    --
   -- вывода и наоборот                                                      --
   -- GPIO.                                                                  --
   -- Использование:                                                         --
   -- STM32F407.GPIO.Utils.Toggle_Pin( LED1 );                               --
   ----------------------------------------------------------------------------
   procedure Toggle_Pin(fGPIO_Pin : in out rGPIO_Pin);

   ----------------------------------------------------------------------------
   -- Вспомогательная процедура настройки вывода как цифрового               --
   --                                                                        --
   -- Использование:                                                         --
   --   STM32F407.GPIO.Utils.Init_as_Digital_Output( LED1 );                 --
   --                                                                        --
   -- Параметры вывода:                                                      --
   -- MODER   - GPIO_Mode_OUT;                                               --
   -- OTYPER  - GPIO_Type_PP;                                                --
   -- OSPEEDR - GPIO_Speed_100MHz;                                           --
   -- PUPDR   - GPIO_No_Pull;                                                --
   --                                                                        --
   -- Примечание. Перед использованием, необходимо включить тактирование     --
   -- порта GPIO (регистр RCC):                                              --
   --   STM32F407.GPIO.Utils.RCC_Clock_Enable(LED1.Port);                    --
   ----------------------------------------------------------------------------
   procedure Init_as_Digital_Output(fGPIO_Pin : in out rGPIO_Pin);

   ----------------------------------------------------------------------------
   -- Вспомогательная процедура настройки вывода как цифрового входа         --
   --                                                                        --
   -- Использование:                                                         --
   --   STM32F407.GPIO.Utils.Init_as_Digital_Input( LED1 );                  --
   --                                                                        --
   -- Параметры вывода:                                                      --
   -- MODER   - GPIO_Mode_IN;                                                --
   -- PUPDR   - GPIO_No_Pull;                                                --
   --                                                                        --
   -- Примечание. Перед использованием, необходимо включить тактирование     --
   -- порта GPIO (регистр RCC):                                              --
   --   STM32F407.GPIO.Utils.RCC_Clock_Enable(LED1.Port);                    --
   ----------------------------------------------------------------------------
   procedure Init_as_Digital_Input(fGPIO_Pin : in out rGPIO_Pin);


   ----------------------------------------------------------------------------
   -- Вспомогательная процедура включения тактирования GPIO                  --
   --                                                                        --
   -- Использование:                                                         --
   --   STM32F407.GPIO.Utils.RCC_Clock_Enable(LED1.Port);                    --
   ----------------------------------------------------------------------------
   procedure RCC_Clock_Enable( Port : aliased STM32F407.GPIO.pGPIO_Register );

end STM32F407.GPIO.Utils;
