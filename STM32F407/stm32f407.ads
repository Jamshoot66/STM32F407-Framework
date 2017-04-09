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

package STM32F407 is

   Peripheral_Base : constant := 16#4000_0000#;

   APB1_Peripheral_Base : constant := Peripheral_Base;
   APB2_Peripheral_Base : constant := Peripheral_Base + 16#0001_0000#;
   AHB1_Peripheral_Base : constant := Peripheral_Base + 16#0002_0000#;
   AHB2_Peripheral_Base : constant := Peripheral_Base + 16#1000_0000#;

   GPIOA_Base           : constant := AHB1_Peripheral_Base + 16#0000#;
   GPIOB_Base           : constant := AHB1_Peripheral_Base + 16#0400#;
   GPIOC_Base           : constant := AHB1_Peripheral_Base + 16#0800#;
   GPIOD_Base           : constant := AHB1_Peripheral_Base + 16#0C00#;
   GPIOE_Base           : constant := AHB1_Peripheral_Base + 16#1000#;

   FLASH_Base           : constant := AHB1_Peripheral_Base + 16#3C00#;
   RCC_Base             : constant := AHB1_Peripheral_Base + 16#3800#;

   PWR_Base             : constant := APB1_Peripheral_Base + 16#7000#;

   USART1_Base          : constant := APB2_Peripheral_Base + 16#1000#;
   SYSCFG_Base          : constant := APB2_Peripheral_Base + 16#3800#;
   EXTI_Base            : constant := APB2_Peripheral_Base + 16#3C00#;

   SPI1_Base 		: constant := 16#4001_3000#;
   SPI_CR1_Offset      	: constant := 16#00#;
   SPI_CR2_Offset      	: constant := 16#04#;
   SPI_SR_Offset      	: constant := 16#08#;
   SPI_DR_Offset      	: constant := 16#0C#;
   SPI_CRCPR_Offset   	: constant := 16#10#;
   SPI_RXCRCR_Offset   	: constant := 16#14#;
   SPI_TXCRCR_Offset    : constant := 16#18#;
   SPI_I2SCFGR_Offset   : constant := 16#1C#;
   SPI_I2SPR_Offset     : constant := 16#20#;



   DAC_Base             : constant := 16#4000_7400#;
   DAC_SWTRIGR_Base     : constant := DAC_Base + 16#04#;
   DAC_DHR12R1_Base     : constant := DAC_Base + 16#08#;
   DAC_DOR1_Base        : constant := DAC_Base + 16#2C#;

end STM32F407;
