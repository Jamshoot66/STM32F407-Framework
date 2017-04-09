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

package STM32F407.SPI is

   Tx_timeout_cycles  : constant Natural := 1000;
   Rx_timeout_cycles  : constant Natural := 1000;

   Cpha_Rising   : constant  Bit_1 := 0;
   Cpha_Falling  : constant  Bit_1 := 1;

   Cpol_Low      : constant  Bit_1 := 0;
   Cpol_High     : constant  Bit_1 := 1;

   Mstr_Slave    : constant  Bit_1 := 0;
   Mstr_Master   : constant  Bit_1 := 1;

   Br_2      : constant  Bit_3 := 2#000#;
   Br_4      : constant  Bit_3 := 2#001#;
   Br_8      : constant  Bit_3 := 2#010#;
   Br_16     : constant  Bit_3 := 2#011#;
   Br_32     : constant  Bit_3 := 2#100#;
   Br_64     : constant  Bit_3 := 2#101#;
   Br_128    : constant  Bit_3 := 2#110#;
   Br_256    : constant  Bit_3 := 2#111#;

   Spe_Disable   : constant  Bit_1 := 0;
   Spe_Enable    : constant  Bit_1 := 1;

   Lsb_First_MSB : constant  Bit_1 := 0;
   Lsb_First_LSB : constant  Bit_1 := 1;

   Ssi_Reset     : constant  Bit_1 := 0;
   Ssi_Set       : constant  Bit_1 := 1;

   Ssm_Disabled  : constant  Bit_1 := 0;
   Ssm_Enabled   : constant  Bit_1 := 1;

   Rx_Only_Full_Duplex      : constant  Bit_1 := 0;
   Rx_Only_Output_disabled  : constant  Bit_1 := 1;

   Dff_8bit        : constant  Bit_1 := 0;
   Dff_16bit        : constant  Bit_1 := 1;

   Crc_Next_Data_Phase  : constant Bit_1 := 0;
   Crc_Next_Transfer    : constant Bit_1 := 1;

   Crc_En_Disable   : constant  Bit_1 := 0;
   Crc_En_Enable    : constant  Bit_1 := 1;

   Bidi_Oe_Rx       : constant  Bit_1 := 0;
   Bidi_Oe_Tx       : constant  Bit_1 := 1;

   Bidi_Mode_2_Line : constant  Bit_1 := 0;
   Bidi_Mode_1_Line : constant  Bit_1 := 1;


   type rSPI_CR1 is record

      CPHA      : Bit_1;
      -- Clock phase
      -- Cpha_Rising The first clock transition is the
      --   first data capture edge
      -- Cpha_Falling The second clock transition is the
      --   first data capture edge

      CPOL      : Bit_1;
      -- Clock polarity
      -- Cpol_Low for low is idle
      -- Cpol_High for high is idle

      MSTR      : Bit_1;
      -- Master selection
      -- Mstr_Slave for SPI as slave conf.
      -- Mstr_Master for SPI as slave conf.

      BR        : Bit_3;
      -- Baud rate prescaler
      -- Br_2   for Fpcl/2
      -- Br_4   for Fpcl/4
      -- Br_8   for Fpcl/8
      -- Br_16  for Fpcl/16
      -- Br_32  for Fpcl/32
      -- Br_64  for Fpcl/64
      -- Br_128 for Fpcl/128
      -- Br_256 for Fpcl/256


      SPE       : Bit_1;
      -- SPI enable bit
      -- Spe_Disable for disable SPI
      -- Spe_Enable for enable SPI

      LSB_FIRST : Bit_1;
      -- Frame format
      -- MSB transmitter first
      -- LSB transmitter first


      SSI       : Bit_1;
      -- Internal slave select
      -- ??? nevedomaya huina


      SSM       : Bit_1;
      -- Software slave management
      -- Ssm_Disabled
      -- Ssm_Enabled

      RX_ONLY   : Bit_1;
      -- Receive only
      -- Rx_Only_Full_Duplex Rx and Tx
      -- Rx_Only_Output_disabled Rx only

      DFF       : Bit_1;
      -- Data frame format
      -- Dff_8bit transfer 8 bit data
      -- Dff_16bit transfer 16 bit data

      CRC_NEXT  : Bit_1;
      -- Crc transfer
      -- Crc_Next_Data_Phase
      -- Crc_Next_Transfer

      CRC_EN    : Bit_1;
      -- Hardware CRC calc. enable
      -- Cnc_en_Disable
      -- Crc_En_Enable

      BIDI_OE   : Bit_1;
      -- Output enable in bidirect. mode
      -- Bidi_Oe_Rx receive only
      -- Bidi_Oe_Tx transmit only

      BIDI_MODE : Bit_1;
      -- Bidirectional mode enable
      -- Bidi_Mode_2_Line for 2 line unidirect.
      -- Bidi_Mode_1_Line for 1 line bidirect.

   end record with Volatile_Full_Access, Size => 16;

   for rSPI_CR1 use record

      CPHA      at 0  range 0 .. 0;
      CPOL      at 0  range 1 .. 1;
      MSTR      at 0  range 2 .. 2;
      BR        at 0  range 3 .. 5;
      SPE       at 0  range 6 .. 6;
      LSB_FIRST at 0  range 7 .. 7;
      SSI       at 0  range 8 .. 8;
      SSM       at 0  range 9 .. 9;
      RX_ONLY   at 0  range 10 .. 10;
      DFF       at 0  range 11 .. 11;
      CRC_NEXT  at 0  range 12 .. 12;
      CRC_EN    at 0  range 13 .. 13;
      BIDI_OE   at 0  range 14 .. 14;
      BIDI_MODE at 0  range 15 .. 15;

   end record;

   TXEIE_disable     : constant  Bit_1 := 0;
   TXEIE_enable      : constant  Bit_1 := 1;

   RXNEIE_disable    : constant  Bit_1 := 0;
   RXNEIE_enable     : constant  Bit_1 := 1;

   ERRIE_disable     : constant  Bit_1 := 0;
   ERRIE_enable      : constant  Bit_1 := 1;

   FRF_Motorola      : constant  Bit_1 := 0;
   FRF_Ti            : constant  Bit_1 := 1;

   SSOE_disable      : constant  Bit_1 := 0;
   SSOE_enable       : constant  Bit_1 := 1;

   TXDMAEN_disable   : constant  Bit_1 := 0;
   TXDMAEN_enable    : constant  Bit_1 := 1;

   RXDMAEN_disable   : constant  Bit_1 := 0;
   RXDMAEN_enable    : constant  Bit_1 := 1;

   type rSPI_CR2 is record

      TXEIE     : Bit_1;
      -- Tx buffer empty interrupt enable

      RXNEIE    : Bit_1;
      -- RX buffer not empty interrupt enable

      ERRIE     : Bit_1;
      -- Error interrupt enable

      FRF       : Bit_1;
      -- Frame format Motorola(0) / TI(1)

      Reserved  : Bit_1;
      -- Reserved. Forced to 0 by hardware

      SSOE      : Bit_1;
      -- SS output is disabled(0) in master
      -- mode and the cell can work in
      -- multimaster configuration

      TXDMAEN   : Bit_1;
      -- When this bit is set,
      -- the DMA request is made whenever the TXE flag is set.

      RXDMAEN   : Bit_1;
      -- When this bit is set,
      -- the DMA request is made whenever the RXNE flag is set

   end record with Volatile_Full_Access, Size => 16;

   for rSPI_CR2 use record

      TXEIE     at 0  range 7 .. 7;
      RXNEIE    at 0  range 6 .. 6;
      ERRIE     at 0  range 5 .. 5;
      FRF       at 0  range 4 .. 4;
      Reserved  at 0  range 3 .. 3;
      SSOE      at 0  range 2 .. 2;
      TXDMAEN   at 0  range 1 .. 1;
      RXDMAEN   at 0  range 0 .. 0;

   end record;

   type rSPI_SR is record

      FRE     : Bit_1;
      --Frame format error
      --
      --0: No frame format error
      --1: A frame formaterror occurred
      --This flag is set by hardware and cleared by software
      --when the SPIx_SR register is read.
      --Note: This flag is used when the SPI operates in TI
      --slave mode or I2S slave mode (refer to Section 28.3.10).

      BSY     : Bit_1;
      --Busy flag
      --
      --0: SPI (or I2S) not busy
      --1: SPI (or I2S) is busy in communication or Tx buffer
      --is not empty
      --This flag is set and cleared by hardware.
      --Note: BSY flag must be used with caution:
      --refer to Section 28.3.7: Status flags and
      --Section 28.3.8: Disabling the SPI.

      OVR     : Bit_1;
      --Overrun flag
      --
      --0: No overrun occurred
      --1: Overrun occurred
      --This flag is set by hardware and reset by
      --a software sequence. Refer to Section 28.4.8 on
      --page 899 for the software sequence.

      MODF    : Bit_1;
      --Mode fault
      --
      --0: No mode fault occurred
      --1: Mode fault occurred
      --This flag is set by hardware and reset by
      --a software sequence. Refer to Section 28.3.10 on
      --page 881for the software sequence.
      --Note: This bit is not used in I2S mode

      CRCERR  : Bit_1;
      --CRC error flag
      --
      --0: CRC value received matches the SPI_RXCRCR value
      --1: CRC value received does not match the SPI_RXCRCR
      --value
      --This flag is set by hardware and cleared by
      --software writing 0.
      --Note: This bit is not used in I2S mode.

      UDR     : Bit_1;
      --Underrun flag
      --
      --0: No underrun occurred
      --1: Underrun occurred
      --This flag is set by hardware and reset by
      --a software sequence. Refer to Section 28.4.8 on
      --page 899 for the software sequence.
      --Note: This bit is not used in SPI mode.

      CHSIDE  : Bit_1;
      --Channel side
      --
      --0: Channel Left has to be transmitted or
      --has been received
      --1: Channel Right has to be transmitted or
      --has been received
      --Note: This bit is not used for SPI mode and
      --is meaningless in PCM mode.

      TXE     : Bit_1;
      --Transmit buffer empty
      --
      --0: Tx buffer not empty
      --1: Tx buffer empty

      RXNE    : Bit_1;
      --Receive buffer not empty
      --
      --0: Rx buffer empty
      --1: Rx buffer not empty

   end record with Volatile_Full_Access, Size => 16;

   for rSPI_SR use record

      FRE       at 0  range 8 .. 8;
      BSY       at 0  range 7 .. 7;
      OVR       at 0  range 6 .. 6;
      MODF      at 0  range 5 .. 5;
      CRCERR    at 0  range 4 .. 4;
      UDR       at 0  range 3 .. 3;
      CHSIDE    at 0  range 2 .. 2;
      TXE       at 0  range 1 .. 1;
      RXNE      at 0  range 0 .. 0;

   end record;

   type rSPI_DR is record

      LSB : Byte;
      MSB : Byte;

   end record with Volatile_Full_Access, Size => 16;

   for rSPI_DR use record

      LSB at 0  range 0 .. 7;
      MSB at 0  range 8 .. 15;

   end record;

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

   procedure Transmit_8bit(fMessage : Byte);
   function Recieve_8bit return Byte;

end STM32F407.SPI;
