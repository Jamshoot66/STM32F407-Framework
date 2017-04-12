------------------------------------------------------------------------------
--                              STM32F407 Framework                         --
--                 Written by Sergey "Jamshoot" Gorshkov. 2017.             --
--                                                                          --
-- You can redistribute it and/or modify it under terms of the GNU General  --
-- Public License as published  by the Free Software  Foundation;  either   --
-- version 3,  or (at your option) any later version.                       --
--                                                                          --
-- You should have received a copy of the GNU General Public License and    --
-- a copy of the GCC Runtime Library Exception along with this program.     --
-- If not, see <http://www.gnu.org/licenses/>.                              --
------------------------------------------------------------------------------

with System; use System;

package body STM32F407.GPIO.Utils is


   procedure Set_Pin(fGPIO_Pin : in out rGPIO_Pin; HighLow : Bit_1) is

   begin

      if (HighLow = High) then
         fGPIO_Pin.Port.BSRR := fGPIO_Pin.Port.BSRR or tPin'Enum_Rep(fGPIO_Pin.Pin_Number);
      end if;

      if (HighLow = Low) then
         fGPIO_Pin.Port.BSRR := fGPIO_Pin.Port.BSRR or
           Shift_Left( Value  => tPin'Enum_Rep(fGPIO_Pin.Pin_Number),
                       Amount => 16);
      end if;

   exception
      when others => null;
   end Set_Pin;

   function Is_Set(fGPIO_Pin : in out rGPIO_Pin) return Boolean is
   begin

      if ( ((fGPIO_Pin.Port.IDR) And tPin'Enum_Rep(fGPIO_Pin.Pin_Number)) > 0 ) then
         return True;
      else
         return False;
      end if;

   exception

      when Constraint_Error =>
         --GPIO_Pin variable is not initialized propery
         --TODO Make an exception handler
         return False;


   end Is_Set;

   procedure Init_as_Digital_Output(fGPIO_Pin : in out rGPIO_Pin) is
   begin

      fGPIO_Pin.Port.MODER( tPin'Pos(fGPIO_Pin.Pin_Number) ) :=
        GPIO_Mode'Enum_Rep(GPIO_Moder_OUT);

      fGPIO_Pin.Port.OTYPER( tPin'Pos(fGPIO_Pin.Pin_Number) ) :=
        GPIO_OTYPE'Enum_Rep(GPIO_Type_PP);

      fGPIO_Pin.Port.OSPEEDR( tPin'Pos(fGPIO_Pin.Pin_Number) ) := GPIO_Speed_100MHz;
      fGPIO_Pin.Port.PUPDR( tPin'Pos(fGPIO_Pin.Pin_Number) ) := GPIO_No_Pull;

   exception
      when Constraint_Error =>
         --GPIO_Pin variable is not initialized propery
         --TODO Make an exception handler
         null;
   end;

   procedure Init_as_Digital_Input(fGPIO_Pin : in out rGPIO_Pin) is
   begin

      fGPIO_Pin.Port.MODER( tPin'Pos(fGPIO_Pin.Pin_Number) ) := GPIO_Mode_IN;
      fGPIO_Pin.Port.PUPDR( tPin'Pos(fGPIO_Pin.Pin_Number) ) := GPIO_No_Pull;

   exception
      when Constraint_Error =>
         --GPIO_Pin variable is not initialized propery
         --TODO Make an exception handler
         null;
   end;

   procedure RCC_Clock_Enable( Port : aliased STM32F407.GPIO.pGPIO_Register ) is
      Port_Const : Word := 0;

   begin

      if ( (Port.all'Address) = System'To_Address(GPIOA_Base) ) then
         Port_Const := Word(GPIOA_RCC_AHB1ENR_Enable);
      end if;

      if ( (Port.all'Address) = System'To_Address(GPIOB_Base) ) then
         Port_Const := Word(GPIOB_RCC_AHB1ENR_Enable);
      end if;

      if ( (Port.all'Address) = System'To_Address(GPIOC_Base) ) then
         Port_Const := Word(GPIOC_RCC_AHB1ENR_Enable);
      end if;

      if ( (Port.all'Address) = System'To_Address(GPIOD_Base) ) then
         Port_Const := Word(GPIOD_RCC_AHB1ENR_Enable);
      end if;

      if ( (Port.all'Address) = System'To_Address(GPIOE_Base) ) then
         Port_Const := Word(GPIOE_RCC_AHB1ENR_Enable);
      end if;

      RCC_Register.AHB1ENR := RCC_Register.AHB1ENR or Port_Const;

   exception
      when Constraint_Error =>
         --GPIO_Pin variable is not initialized propery
         --TODO Make an exception handler
         null;

   end;

end STM32F407.GPIO.Utils;
