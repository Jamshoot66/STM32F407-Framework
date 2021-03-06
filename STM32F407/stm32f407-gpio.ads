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

with System;

with STM32F407.Types; use STM32F407.Types;
with STM32F407.RCC; use STM32F407.RCC;


------------------------------------------------------------------------------
--                              STM32F407.GPIO                              --
-- Базовый интерфейс универсального порта ввода/ввывода (GPIO).             --
-- Для настройки/использования конкретных выводов прользоваться переменными --
-- GPIOA (*B, C, D, E)
------------------------------------------------------------------------------
package STM32F407.GPIO is

   ----------------------------
   -- Базовые константы GPIO --
   ----------------------------

   Low          : constant Bit_1 := 0;
   High         : constant Bit_1 := 1;


   -- Тип tPin используется для указания конкретного пина ввода/вывода
   -- Использование:
   -- а) tPin'Enum_Rep( PinXX ) для получение константы для чтения/установки бита
   --    в регистры BSRR, IDR;
   --    Пример:
   --    fGPIO_Pin.Port.BSRR := fGPIO_Pin.Port.BSRR or
   --                           tPin'Enum_Rep(fGPIO_Pin.Pin_Number);
   -- б) tPin'Pos ( PinXX ) при использовании типа в качестве индекса
   --    для типа rGPIO_Register
   --    Пример:
   --    fGPIO_Pin.Port.MODER( tPin'Pos(fGPIO_Pin.Pin_Number) ) := ...
   type tPin is (Pin0,
                 Pin1,
                 Pin2,
                 Pin3,
                 Pin4,
                 Pin5,
                 Pin6,
                 Pin7,
                 Pin8,
                 Pin9,
                 Pin10,
                 Pin11,
                 Pin12,
                 Pin13,
                 Pin14,
                 Pin15);

   for tPin use (Pin0  => 2#0000_0000_0000_0001#,
                 Pin1  => 2#0000_0000_0000_0010#,
                 Pin2  => 2#0000_0000_0000_0100#,
                 Pin3  => 2#0000_0000_0000_1000#,
                 Pin4  => 2#0000_0000_0001_0000#,
                 Pin5  => 2#0000_0000_0010_0000#,
                 Pin6  => 2#0000_0000_0100_0000#,
                 Pin7  => 2#0000_0000_1000_0000#,
                 Pin8  => 2#0000_0001_0000_0000#,
                 Pin9  => 2#0000_0010_0000_0000#,
                 Pin10 => 2#0000_0100_0000_0000#,
                 Pin11 => 2#0000_1000_0000_0000#,
                 Pin12 => 2#0001_0000_0000_0000#,
                 Pin13 => 2#0010_0000_0000_0000#,
                 Pin14 => 2#0100_0000_0000_0000#,
                 Pin15 => 2#1000_0000_0000_0000#);

   -- Константы MODER (Mode register)
   type GPIO_Mode is (GPIO_Mode_IN,
                      GPIO_Mode_OUT,
                      GPIO_Mode_AF,
                      GPIO_Mode_AN);

   for GPIO_Mode use (GPIO_Mode_IN   => 2#00#,
                      GPIO_Mode_OUT  => 2#01#,
                      GPIO_Mode_AF   => 2#10#,
                      GPIO_Mode_AN   => 2#11#);

   -- Константы OTYPER (Output type register)
   type GPIO_Type is (GPIO_Type_Push_Pull,
                      GPIO_Type_Open_Drain);

   for GPIO_Type use (GPIO_Type_Push_Pull  => 2#0#,
                      GPIO_Type_Open_Drain => 2#1#);

   -- Константы OSPEEDR
   type GPIO_Speed is (GPIO_Speed_2MHz,
                       GPIO_Speed_25MHz,
                       GPIO_Speed_50MHz,
                       GPIO_Speed_100MHz);

   for GPIO_Speed use (GPIO_Speed_2MHz   => 2#00#,
                       GPIO_Speed_25MHz  => 2#01#,
                       GPIO_Speed_50MHz  => 2#10#,
                       GPIO_Speed_100MHz => 2#11#);

   -- Константы PUPDR
   type GPIO_Pullup_Pulldown is (GPIO_No_Pull,
                                 GPIO_Pull_Up,
                                 GPIO_Pull_Down);

   for GPIO_Pullup_Pulldown use (GPIO_No_Pull   => 2#00#,
                                 GPIO_Pull_Up   => 2#01#,
                                 GPIO_Pull_Down => 2#11#);

   ----------------------------------------------------------------------------
   -- Основной регистр GPIO.                                                 --
   -- Содержит все настройки портов ввода/вывода                             --
   -- Для Stm32f407 используйте предопределенные переменные данного типа     --
   -- GPIOA (B, C, D, E)                                                     --
   ----------------------------------------------------------------------------
   type rGPIO_Register is record
      MODER   : Bit_16x2;   --  mode register
      OTYPER  : Bit_32x1;   --  output type register
      OSPEEDR : Bit_16x2;   --  output speed register
      PUPDR   : Bit_16x2;   --  pull-up/pull-down register
      IDR     : Word;       --  input data register
      ODR     : Word;       --  output data register
      BSRR    : Word;       --  bit set/reset register
      LCKR    : Word;       --  configuration lock register
      AFRL    : Bit_8x4;    --  alternate function low register
      AFRH    : Bit_8x4;    --  alternate function high register
   end record with Volatile;

   -- ссылка на rGPIO_Register
   type pGPIO_Register is access all rGPIO_Register;


   for rGPIO_Register use record
      MODER   at 0  range 0 .. 31;
      OTYPER  at 4  range 0 .. 31;
      OSPEEDR at 8  range 0 .. 31;
      PUPDR   at 12 range 0 .. 31;
      IDR     at 16 range 0 .. 31;
      ODR     at 20 range 0 .. 31;
      BSRR    at 24 range 0 .. 31;
      LCKR    at 28 range 0 .. 31;
      AFRL    at 32 range 0 .. 31;
      AFRH    at 36 range 0 .. 31;
   end record;

   GPIOA : aliased STM32F407.GPIO.rGPIO_Register with
     Volatile,
     Address => System'To_Address(GPIOA_Base);

   GPIOB : aliased STM32F407.GPIO.rGPIO_Register with
     Volatile,
     Address => System'To_Address(GPIOB_Base);

   GPIOC : aliased STM32F407.GPIO.rGPIO_Register with
     Volatile,
     Address => System'To_Address(GPIOC_Base);

   GPIOD : aliased STM32F407.GPIO.rGPIO_Register with
     Volatile,
     Address => System'To_Address(GPIOD_Base);

   GPIOE : aliased STM32F407.GPIO.rGPIO_Register with
     Volatile,
     Address => System'To_Address(GPIOE_Base);




   -- constants for a RCC register
   GPIOA_RCC_AHB1ENR_Enable : constant Byte := 2#0000_0001#;
   GPIOB_RCC_AHB1ENR_Enable : constant Byte := 2#0000_0010#;
   GPIOC_RCC_AHB1ENR_Enable : constant Byte := 2#0000_0100#;
   GPIOD_RCC_AHB1ENR_Enable : constant Byte := 2#0000_1000#;
   GPIOE_RCC_AHB1ENR_Enable : constant Byte := 2#0001_0000#;

end STM32F407.GPIO;
