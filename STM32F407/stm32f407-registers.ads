with STM32F407.RCC;
with STM32F407.Offsets; use STM32F407.Offsets;
with STM32F407.Types; use STM32F407.Types;
with STM32F407.GPIO;
with STM32F407.DAC;
with STM32F407.SPI;

with System;

package STM32F407.Registers is
   
   RCC_Register : STM32F407.RCC.rRCC_Register with
     Volatile,
     Address => System'To_Address(RCC_Base);

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

