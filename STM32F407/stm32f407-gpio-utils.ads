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

package STM32F407.GPIO.Utils is


   --Set or reset pin.
   procedure Set_Pin(fGPIO_Pin : in out rGPIO_Pin; HighLow : Bit_1);

   -- Returns TRUE is pin is High, and FALSE if it is not
   function Is_Set(fGPIO_Pin : in out rGPIO_Pin) return Boolean;


   --Simple init port/pin as a digital output
   --Params:
   -- MODER   is GPIO_Mode_OUT;
   -- OTYPER  is GPIO_Type_PP;
   -- OSPEEDR is GPIO_Speed_100MHz;
   -- PUPDR   is GPIO_No_Pull;
   procedure Init_as_Digital_Output(fGPIO_Pin : in out rGPIO_Pin);

   --Set enable bit to RCC register
   --@Port is a pointer to GPIOA (B, C etc.) from *.GPIO package
   procedure RCC_Clock_Enable( Port : aliased STM32F407.GPIO.pGPIO_Register );

end STM32F407.GPIO.Utils;
