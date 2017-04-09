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

with System;
with STM32F407.Types; use STM32F407.Types;


package STM32F407.RCC is

   type rRCC_Register is record
      CR          : Word;  --  RCC clock control register at 16#00#
      PLLCFGR     : Word;  --  RCC PLL configuration register at 16#04#
      CFGR        : Word;  --  RCC clock configuration register at 16#08#
      CIR         : Word;  --  RCC clock interrupt register at 16#0C#
      AHB1RSTR    : Word;  --  RCC AHB1 peripheral reset register at 16#10#
      AHB2RSTR    : Word;  --  RCC AHB2 peripheral reset register at 16#14#
      AHB3RSTR    : Word;  --  RCC AHB3 peripheral reset register at 16#18#
      Reserved_0  : Word;  --  Reserved at 16#1C#
      APB1RSTR    : Word;  --  RCC APB1 peripheral reset register at 16#20#
      APB2RSTR    : Word;  --  RCC APB2 peripheral reset register at 16#24#
      Reserved_1  : Word;  --  Reserved at 16#28#
      Reserved_2  : Word;  --  Reserved at 16#2c#
      AHB1ENR     : Word;  --  RCC AHB1 peripheral clock register at 16#30#
      AHB2ENR     : Word;  --  RCC AHB2 peripheral clock register at 16#34#
      AHB3ENR     : Word;  --  RCC AHB3 peripheral clock register at 16#38#
      Reserved_3  : Word;  --  Reserved at 16#0C#
      APB1ENR     : Word;  --  RCC APB1 peripheral clock enable at 16#40#
      APB2ENR     : Word;  --  RCC APB2 peripheral clock enable at 16#44#
      Reserved_4  : Word;  --  Reserved at 16#48#
      Reserved_5  : Word;  --  Reserved at 16#4c#
      AHB1LPENR   : Word;  --  RCC AHB1 periph. low power clk en. at 16#50#
      AHB2LPENR   : Word;  --  RCC AHB2 periph. low power clk en. at 16#54#
      AHB3LPENR   : Word;  --  RCC AHB3 periph. low power clk en. at 16#58#
      Reserved_6  : Word;  --  Reserved, 16#5C#
      APB1LPENR   : Word;  --  RCC APB1 periph. low power clk en. at 16#60#
      APB2LPENR   : Word;  --  RCC APB2 periph. low power clk en. at 16#64#
      Reserved_7  : Word;  --  Reserved at 16#68#
      Reserved_8  : Word;  --  Reserved at 16#6C#
      BDCR        : Word;  --  RCC Backup domain control register at 16#70#
      CSR         : Word;  --  RCC clock control/status register at 16#74#
      Reserved_9  : Word;  --  Reserved at 16#78#
      Reserved_10 : Word;  --  Reserved at 16#7C#
      SSCGR       : Word;  --  RCC spread spectrum clk gen. reg. at 16#80#
      PLLI2SCFGR  : Word;  --  RCC PLLI2S configuration register at 16#84#
   end record;

   for rRCC_Register use record
      CR          at 0   range 0 .. 31;
      PLLCFGR     at 4   range 0 .. 31;
      CFGR        at 8   range 0 .. 31;
      CIR         at 12  range 0 .. 31;
      AHB1RSTR    at 16  range 0 .. 31;
      AHB2RSTR    at 20  range 0 .. 31;
      AHB3RSTR    at 24  range 0 .. 31;
      Reserved_0  at 28  range 0 .. 31;
      APB1RSTR    at 32  range 0 .. 31;
      APB2RSTR    at 36  range 0 .. 31;
      Reserved_1  at 40  range 0 .. 31;
      Reserved_2  at 44  range 0 .. 31;
      AHB1ENR     at 48  range 0 .. 31;
      AHB2ENR     at 52  range 0 .. 31;
      AHB3ENR     at 56  range 0 .. 31;
      Reserved_3  at 60  range 0 .. 31;
      APB1ENR     at 64  range 0 .. 31;
      APB2ENR     at 68  range 0 .. 31;
      Reserved_4  at 72  range 0 .. 31;
      Reserved_5  at 76  range 0 .. 31;
      AHB1LPENR   at 80  range 0 .. 31;
      AHB2LPENR   at 84  range 0 .. 31;
      AHB3LPENR   at 88  range 0 .. 31;
      Reserved_6  at 92  range 0 .. 31;
      APB1LPENR   at 96  range 0 .. 31;
      APB2LPENR   at 100 range 0 .. 31;
      Reserved_7  at 104 range 0 .. 31;
      Reserved_8  at 108 range 0 .. 31;
      BDCR        at 112 range 0 .. 31;
      CSR         at 116 range 0 .. 31;
      Reserved_9  at 120 range 0 .. 31;
      Reserved_10 at 124 range 0 .. 31;
      SSCGR       at 128 range 0 .. 31;
      PLLI2SCFGR  at 132 range 0 .. 31;
   end record;

   RCC_Register : STM32F407.RCC.rRCC_Register with
     Volatile,
     Address => System'To_Address(RCC_Base);

end STM32F407.RCC;

