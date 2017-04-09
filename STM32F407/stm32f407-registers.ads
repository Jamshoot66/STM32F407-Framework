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

with STM32F407.Types; use STM32F407.Types;
with STM32F407.DAC;
with STM32F407.SPI;

with System;

package STM32F407.Registers is
   
   

   DAC_CR : STM32F407.DAC.tDAC_CR with
     Volatile,
     Address => System'To_Address(DAC_Base);

   DAC_SWTRIGR : STM32F407.DAC.tDAC_SWTRIGR with
     Volatile,
     Address => System'To_Address(DAC_SWTRIGR_Base);

   DAC_DHR12R1 : Word with
     Volatile,
     Address => System'To_Address(DAC_DHR12R1_Base);

   DAC_DOR1 : Word with
     Volatile,
     Address => System'To_Address(DAC_DOR1_Base);

   SPI1_CR1 : SPI.rSPI_CR1 with
     Volatile,
     Address => System'To_Address(SPI1_Base + SPI_CR1_Offset);

   SPI1_CR2 : SPI.rSPI_CR2 with
     Volatile,
     Address => System'To_Address(SPI1_Base + SPI_CR2_Offset);

   SPI1_SR : SPI.rSPI_SR with
     Volatile,
     Address => System'To_Address(SPI1_Base + SPI_SR_Offset);

   SPI1_DR : SPI.rSPI_DR with
     Volatile,
     Address => System'To_Address(SPI1_Base + SPI_DR_Offset);

end STM32F407.Registers;

