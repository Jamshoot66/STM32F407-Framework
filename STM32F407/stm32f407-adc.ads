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

with STM32F407.types; use STM32F407.types;

package STM32F407.ADC is

   ADC1_Offset : constant Word := 16#00#;
   ADC2_Offset : constant Word := 16#100#;
   ADC3_Offset : constant Word := 16#200#;
   ADCCommon_Offset : constant Word := 16#300#;

   --ADC Status register
   type rADC_SR is record

      --AWD:Analog watchdog flag
      --This bit is set by hardware when the converted voltage crosses
      --the values programmed in the ADC_LTR and ADC_HTR
      --registers. It is cleared by software.
      --0: No analog watchdog event occurred
      --1: Analog watchdog event occurred
      AWD     : Bit_1;

      --EOC:Regular channel end of conversion
      --This bit is set by hardware at the end of the conversion of a
      --regular group of channels. It is cleared by software
      --or by reading the ADC_DR register.
      --0: Conversion not complete (EOCS=0), or sequence
      --of conversions not complete (EOCS=1)
      --1: Conversion complete (EOCS=0), or sequence of conversions
      --complete (EOCS=1)
      EOC     : Bit_1;

      --JEOC:Injected channel end of conversion
      --This bit is set by hardware at the end of the conversion of all
      --injected channels in the group. It is cleared by software.
      --0: Conversion is not complete
      --1: Conversion complete
      JEOC    : Bit_1;

      --JSTRT:Injected channel start flag
      --This bit is set by hardware when injected group conversion
      --starts. It is cleared by software.
      --0: No injected group conversion started
      --1: Injected group conversion has started
      JSTRT   : Bit_1;

      --STRT:Regular channel start flag
      --This bit is set by hardware when regular channel conversion
      --starts. It is cleared by software.
      --0: No regular channel conversion started
      --1: Regular channel conversion has started
      STRT    : Bit_1;

      --Overrun
      --This bit is set by hardware when data are lost (either in single
      --mode or in dual/triple mode). It is cleared by software.
      --Overrun detection is enabled only when DMA = 1 or EOCS = 1.
      --0: No overrun occurred
      --1: Overrun has occurred
      OVR     : Bit_1;
   end record with Volatile_Full_Access, Size => 32;

   for rADC_SR use record

      AWD      at 0  range 0 .. 0;
      EOC      at 0  range 1 .. 1;
      JEOC     at 0  range 2 .. 2;
      JSTRT    at 0  range 3 .. 3;
      STRT     at 0  range 4 .. 4;
      OVR      at 0  range 5 .. 5;

      -- bits 6..31 reserved
   end record;

   ADC_SR_Offset : constant Word := 16#00#;

   -- ADC control register 1
   type rADC_CR1 is record

     --AWDCH[4:0]:Analog watchdog channel select bits
     --These bits are set and cleared by software. They select
     --the input channel to be guarded by the analog watchdog.
     --Note: 00000: ADC analog input Channel0
     --00001: ADC analog input Channel1
     --...
     --01111: ADC analog input Channel15
     --10000: ADC analog input Channel16
     --10001: ADC analog input Channel17
     --10010: ADC analog input Channel18
      AWDCH       : Bit_5;

      --EOCIE: Interrupt enable for EOC
      --This bit is set and cleared by software to enable/disable
      --the end of conversion interrupt.
      --0: EOC interrupt disabled
      --1: EOC interrupt enabled. An interrupt is generated when
      --the EOC bit is set.
      EOCIE       : Bit_1;

      --AWDIE: Analog watchdog interrupt enable
      --This bit is set and cleared by software to enable/disable
      --the analog watchdog interrupt.
      --0: Analog watchdog interrupt disabled
      --1: Analog watchdog interrupt enabled
      AWDIE       : Bit_1;

      --JEOCIE:Interrupt enable for injected channels
      --This bit is set and cleared by software to enable/disable
      --the end of conversion interrupt for injected channels.
      --0: JEOC interrupt disabled
      --1: JEOC interrupt enabled. An interrupt is generated
      --when the JEOC bit is set.
      JEOCIE      : Bit_1;

      --SCAN:Scan mode
      --This bit is set and cleared by software to enable/disable
      --the Scan mode. In Scan mode, the inputs selected through
      --the ADC_SQRx orADC_JSQRx registers are converted.
      --0: Scan mode disabled
      --1: Scan mode enabled
      --Note: An EOC interrupt is generated if the EOCIE bit is set:
      -- - At the end of each regular group sequence if the EOCS bit is
      --   cleared to 0
      -- - At the end of each regular channel conversion if the EOCS
      --   bit is set to 1
      --Note: A JEOC interrupt is generated only on the end of
      --conversion of the last channel if the JEOCIE bit is set.
      SCAN        : Bit_1;

      --AWDSGL:Enable the watchdog on a single channel in scan mode
      --This bit is set and cleared by software to enable/disable the analog
      --watchdog on the channel identified by the AWDCH[4:0] bits.
      --0: Analog watchdog enabled on all channels
      --1: Analog watchdog enabled on a single channel
      AWDSGL      : Bit_1;

      --JAUTO:Automatic injected group conversion
      --This bit is set and cleared by software to enable/disable
      --automatic injected group conversion after regular group
      --conversion.
      --0: Automatic injected group conversion disabled
      --1: Automatic injected group conversion enabled
      JAUTO       : Bit_1;

      --DISCEN:Discontinuous mode on regular channels
      --This bit is set and cleared by software to enable/disable
      --Discontinuous mode on regular channels.
      --0: Discontinuous mode on regular channels disabled
      --1: Discontinuous mode on regular channels enabled
      DISCEN      : Bit_1;

      --JDISCEN:Discontinuous mode on injected channels
      --This bit is set and cleared by software to enable/disable
      --discontinuous mode on the injected channels of a group.
      --0: Discontinuous mode on injected channels disabled
      --1: Discontinuous mode on injected channels enabled
      JDISCEN     : Bit_1;

      --DISCNUM[2:0]:Discontinuous mode channel count
      --These bits are written by software to define the number
      --of regular channels to be converted in discontinuous mode,
      --after receiving an external trigger.
      --000: 1 channel
      --001: 2 channels
      --...
      --111: 8 channels
      DISCNUM     : Bit_3;

      --Don't touch me
      RESERVED_1  : Bit_6;

      --JAWDEN:Analog watchdog enable on injected channels
      --This bit is set and cleared by software.
      --0: Analog watchdog disabled on injected channels
      --1: Analog watchdog enabled on injected channels
      JAWDEN      : Bit_1;

      --AWDEN:Analog watchdog enable on regular channels
      --This bit is set and cleared by software.
      --0: Analog watchdog disabled on regular channels
      --1: Analog watchdog enabled on regular channels
      AWDEN       : Bit_1;

      --These bits are written by software to select the resolution
      --of the conversion.
      --00: 12-bit (15 ADCCLK cycles)
      --01: 10-bit (13 ADCCLK cycles)
      --10: 8-bit (11 ADCCLK cycles)
      --11: 6-bit (9 ADCCLK cycles)
      RES         : Bit_2;

      --OVRIE: Overrun interrupt enable
      --This bit is set and cleared by software to enable/disable
      --the Overrun interrupt.
      --0: Overrun interrupt disabled
      --1: Overrun interrupt enabled. An interrupt is
      --generated when the OVR bit is set.
      OVRIE       : Bit_1;

      --Don't touch me
      RESERVED_2  : Bit_5;

   end record with Volatile_Full_Access, Size => 32;

   for rADC_CR1 use record

      AWDCH       at 0  range 0 .. 4;
      EOCIE       at 0  range 5 .. 5;
      AWDIE       at 0  range 6 .. 6;
      JEOCIE      at 0  range 7 .. 7;
      SCAN        at 0  range 8 .. 8;
      AWDSGL      at 0  range 9 .. 9;
      JAUTO       at 0  range 10 .. 10;
      DISCEN      at 0  range 11 .. 11;
      JDISCEN     at 0  range 12 .. 12;
      DISCNUM     at 0  range 13 .. 15;
      RESERVED_1  at 0  range 16 .. 21;
      JAWDEN      at 0  range 22 .. 22;
      AWDEN       at 0  range 23 .. 23;
      RES         at 0  range 24 .. 25;
      OVRIE       at 0  range 26 .. 26;
      RESERVED_2  at 0  range 27 .. 31;

   end record;

   ADC_CR1_Offset       : Word := 16#04#;

   --ADC control register 2
   type rADC_CR2 is record

      --ADON:A/D Converter ON / OFF
      --This bit is set and cleared by software.
      --0: Disable ADC conversion and go to power down mode
      --1: Enable ADC
      ADON        : Bit_1;

      --CONT:Continuous conversion
      --This bit is set and cleared by software. If it isset, conversion
      --takes place continuously until it is cleared.
      --0: Single conversion mode
      --1: Continuous conversion mode
      CONT        : Bit_1;
      RESERVED_1  : Bit_6;

      --DMA:Direct memory access mode (for single ADC mode)
      --This bit is set and cleared by software. Refer to the DMA
      --controller chapter for more details.
      --0: DMA mode disabled
      --1: DMA mode enabled
      DMA         : Bit_1;

      --DDS:DMA disable selection (for single ADC mode)
      --This bit is set and cleared by software.
      --0: No new DMA request is issued after the lasttransfer
      --(as configured in the DMA controller)
      --1: DMA requests are issued as long as data are converted
      --and DMA=1
      DDS         : Bit_1;

      --EOCS:End of conversion selection
      --This bit is set and cleared by software.
      --0: The EOC bit is set at the end of each sequence of
      --regular conversions. Overrun detection is enabled only if DMA=1.
      --1: The EOC bit is set at the end of each regular conversion.
      --Overrun detection is enabled.
      EOCS        : Bit_1;

      --ALIGN:Data alignment
      --This bit is set and cleared by software.
      --Refer to Figure 48and Figure 49.
      --0: Right alignment
      --1: Left alignment
      ALIGN       : Bit_1;
      RESERVED_2  : Bit_4;

      --JEXTSEL[3:0]:External event select for injected group
      --These bits select the external event used to trigger the
      --start of conversion of an injected group.
      --0000: Timer 1 CC4 event
      --0001: Timer 1 TRGO event
      --0010: Timer 2 CC1 event
      --0011: Timer 2 TRGO event
      --0100: Timer 3 CC2 event
      --0101: Timer 3 CC4 event
      --0110: Timer 4 CC1 event
      --0111: Timer 4 CC2 event
      --1000: Timer 4 CC3 event
      --1001: Timer 4 TRGO event
      --1010: Timer 5 CC4 event
      --1011: Timer 5 TRGO event
      --1100: Timer 8 CC2 event
      --1101: Timer 8 CC3 event
      --1110: Timer 8 CC4 event
      --1111: EXTI line15
      JEXTSEL     : Bit_4;

      --JEXTEN:External trigger enable for injected channels
      --These bits are set and cleared by software to select the external trigger polarity and enable
      --the trigger of an injected group.
      --00: Trigger detection disabled
      --01: Trigger detection on the rising edge
      --10: Trigger detection on the falling edge
      --11: Trigger detection on both the rising and falling edges
      JEXTEN      : Bit_2;

      --JSWSTART:Start conversion of injected channels
      --This bit is set by software and cleared byhardware as soon
      --as the conversion starts.
      --0: Reset state
      --1: Starts conversion of injected channels
      --Note: This bit can be set only when ADON = 1 otherwise
      --no conversion is launched.
      JSWSTART    : Bit_1;
      RESERVED_3  : Bit_1;

      --EXTSEL[3:0]:External event select for regular group
      --These bits select the external event used to trigger
      --the start of conversion of a regular group:
      --0000: Timer 1 CC1 event
      --0001: Timer 1 CC2 event
      --0010: Timer 1 CC3 event
      --0011: Timer 2 CC2 event
      --0100: Timer 2 CC3 event
      --0101: Timer 2 CC4 event
      --0110: Timer 2 TRGO event
      --0111: Timer 3 CC1 event
      --1000: Timer 3 TRGO event
      --1001: Timer 4 CC4 event
      --1010: Timer 5 CC1 event
      --1011: Timer 5 CC2 event
      --1100: Timer 5 CC3 event
      --1101: Timer 8 CC1 event
      --1110: Timer 8 TRGO event
      --1111: EXTI line11
      EXTSEL      : Bit_4;

      --EXTEN:External trigger enable for regular channels
      --These bits are set and cleared by software to select the
      --external trigger polarity and enable the trigger of
      --a regular group.
      --00: Trigger detection disabled
      --01: Trigger detection on the rising edge
      --10: Trigger detection on the falling edge
      --11: Trigger detection on both the rising and falling edges
      EXTEN       : Bit_2;

      --Start conversion of regular channels
      --This bit is set by software to start conversion and cleared
      --by hardware as soon as the conversion starts.
      --0: Reset state
      --1: Starts conversion of regular channels
      --Note: This bit can be set only when ADON = 1 otherwise
      --no conversion is launched.
      SWSTART     : Bit_1;
      RESERVED_4  : Bit_1;

   end record with Volatile_Full_Access, Size => 32;

   for rADC_CR2 use record

      ADON        at 0  range 0 .. 0;
      CONT        at 0  range 1 .. 1;
      RESERVED_1  at 0  range 2 .. 7;
      DMA         at 0  range 8 .. 8;
      DDS         at 0  range 9 .. 9;
      EOCS        at 0  range 10 .. 10;
      ALIGN       at 0  range 11 .. 11;
      RESERVED_2  at 0  range 12 .. 15;
      JEXTSEL     at 0  range 16 .. 19;
      JEXTEN      at 0  range 20 .. 21;
      JSWSTART    at 0  range 22 .. 22;
      RESERVED_3  at 0  range 23 .. 23;
      EXTSEL      at 0  range 24 .. 27;
      EXTEN       at 0  range 28 .. 29;
      SWSTART     at 0  range 30 .. 30;
      RESERVED_4  at 0  range 31 .. 31;

   end record;

   ADC_CR2_Offset       : Word := 16#08#;

   type rADC_SMPR1 is record

      --SMPx[2:0]: Channel x sampling time selection
      --These bits are written by software to select the sampling
      --time individually for each channel.
      --During sampling cycles, the channel selection bits must
      --remain unchanged.
      --000: 3 cycles
      --001: 15 cycles
      --010: 28 cycles
      --011: 56 cycles
      --100: 84 cycles
      --101: 112 cycles
      --110: 144 cycles
      --111: 480 cycles
      SMP10         : Bit_3;

      --SMPx[2:0]: Channel x sampling time selection
      --These bits are written by software to select the sampling
      --time individually for each channel.
      --During sampling cycles, the channel selection bits must
      --remain unchanged.
      --000: 3 cycles
      --001: 15 cycles
      --010: 28 cycles
      --011: 56 cycles
      --100: 84 cycles
      --101: 112 cycles
      --110: 144 cycles
      --111: 480 cycles
      SMP11         : Bit_3;

      --SMPx[2:0]: Channel x sampling time selection
      --These bits are written by software to select the sampling
      --time individually for each channel.
      --During sampling cycles, the channel selection bits must
      --remain unchanged.
      --000: 3 cycles
      --001: 15 cycles
      --010: 28 cycles
      --011: 56 cycles
      --100: 84 cycles
      --101: 112 cycles
      --110: 144 cycles
      --111: 480 cycles
      SMP12         : Bit_3;

      --SMPx[2:0]: Channel x sampling time selection
      --These bits are written by software to select the sampling
      --time individually for each channel.
      --During sampling cycles, the channel selection bits must
      --remain unchanged.
      --000: 3 cycles
      --001: 15 cycles
      --010: 28 cycles
      --011: 56 cycles
      --100: 84 cycles
      --101: 112 cycles
      --110: 144 cycles
      --111: 480 cycles
      SMP13         : Bit_3;

      --SMPx[2:0]: Channel x sampling time selection
      --These bits are written by software to select the sampling
      --time individually for each channel.
      --During sampling cycles, the channel selection bits must
      --remain unchanged.
      --000: 3 cycles
      --001: 15 cycles
      --010: 28 cycles
      --011: 56 cycles
      --100: 84 cycles
      --101: 112 cycles
      --110: 144 cycles
      --111: 480 cycles
      SMP14         : Bit_3;

      --SMPx[2:0]: Channel x sampling time selection
      --These bits are written by software to select the sampling
      --time individually for each channel.
      --During sampling cycles, the channel selection bits must
      --remain unchanged.
      --000: 3 cycles
      --001: 15 cycles
      --010: 28 cycles
      --011: 56 cycles
      --100: 84 cycles
      --101: 112 cycles
      --110: 144 cycles
      --111: 480 cycles
      SMP15         : Bit_3;

      --SMPx[2:0]: Channel x sampling time selection
      --These bits are written by software to select the sampling
      --time individually for each channel.
      --During sampling cycles, the channel selection bits must
      --remain unchanged.
      --000: 3 cycles
      --001: 15 cycles
      --010: 28 cycles
      --011: 56 cycles
      --100: 84 cycles
      --101: 112 cycles
      --110: 144 cycles
      --111: 480 cycles
      SMP16         : Bit_3;

      --SMPx[2:0]: Channel x sampling time selection
      --These bits are written by software to select the sampling
      --time individually for each channel.
      --During sampling cycles, the channel selection bits must
      --remain unchanged.
      --000: 3 cycles
      --001: 15 cycles
      --010: 28 cycles
      --011: 56 cycles
      --100: 84 cycles
      --101: 112 cycles
      --110: 144 cycles
      --111: 480 cycles
      SMP17         : Bit_3;

      --SMPx[2:0]: Channel x sampling time selection
      --These bits are written by software to select the sampling
      --time individually for each channel.
      --During sampling cycles, the channel selection bits must
      --remain unchanged.
      --000: 3 cycles
      --001: 15 cycles
      --010: 28 cycles
      --011: 56 cycles
      --100: 84 cycles
      --101: 112 cycles
      --110: 144 cycles
      --111: 480 cycles
      SMP18         : Bit_3;

      RESERVED      : Bit_5;
   end record with Volatile_Full_Access, Size => 32;

   for rADC_SMPR1 use record

      SMP10         at 0  range 0 .. 2;
      SMP11         at 0  range 3 .. 5;
      SMP12         at 0  range 6 .. 8;
      SMP13         at 0  range 9 .. 11;
      SMP14         at 0  range 12 .. 14;
      SMP15         at 0  range 15 .. 17;
      SMP16         at 0  range 18 .. 20;
      SMP17         at 0  range 21 .. 23;
      SMP18         at 0  range 24 .. 26;
      RESERVED      at 0  range 27 .. 31;

   end record;

   ADC_SMPR1_Offset     : Word := 16#0C#;

   type rADC_SMPR2 is record

      --SMPx[2:0]: Channel x sampling time selection
      --These bits are written by software to select the sampling
      --time individually for each channel.
      --During sampling cycles, the channel selection bits must
      --remain unchanged.
      --000: 3 cycles
      --001: 15 cycles
      --010: 28 cycles
      --011: 56 cycles
      --100: 84 cycles
      --101: 112 cycles
      --110: 144 cycles
      --111: 480 cycles
      SMP0         : Bit_3;

      --SMPx[2:0]: Channel x sampling time selection
      --These bits are written by software to select the sampling
      --time individually for each channel.
      --During sampling cycles, the channel selection bits must
      --remain unchanged.
      --000: 3 cycles
      --001: 15 cycles
      --010: 28 cycles
      --011: 56 cycles
      --100: 84 cycles
      --101: 112 cycles
      --110: 144 cycles
      --111: 480 cycles
      SMP1         : Bit_3;

      --SMPx[2:0]: Channel x sampling time selection
      --These bits are written by software to select the sampling
      --time individually for each channel.
      --During sampling cycles, the channel selection bits must
      --remain unchanged.
      --000: 3 cycles
      --001: 15 cycles
      --010: 28 cycles
      --011: 56 cycles
      --100: 84 cycles
      --101: 112 cycles
      --110: 144 cycles
      --111: 480 cycles
      SMP2         : Bit_3;

      --SMPx[2:0]: Channel x sampling time selection
      --These bits are written by software to select the sampling
      --time individually for each channel.
      --During sampling cycles, the channel selection bits must
      --remain unchanged.
      --000: 3 cycles
      --001: 15 cycles
      --010: 28 cycles
      --011: 56 cycles
      --100: 84 cycles
      --101: 112 cycles
      --110: 144 cycles
      --111: 480 cycles
      SMP3         : Bit_3;

      --SMPx[2:0]: Channel x sampling time selection
      --These bits are written by software to select the sampling
      --time individually for each channel.
      --During sampling cycles, the channel selection bits must
      --remain unchanged.
      --000: 3 cycles
      --001: 15 cycles
      --010: 28 cycles
      --011: 56 cycles
      --100: 84 cycles
      --101: 112 cycles
      --110: 144 cycles
      --111: 480 cycles
      SMP4         : Bit_3;

      --SMPx[2:0]: Channel x sampling time selection
      --These bits are written by software to select the sampling
      --time individually for each channel.
      --During sampling cycles, the channel selection bits must
      --remain unchanged.
      --000: 3 cycles
      --001: 15 cycles
      --010: 28 cycles
      --011: 56 cycles
      --100: 84 cycles
      --101: 112 cycles
      --110: 144 cycles
      --111: 480 cycles
      SMP5         : Bit_3;

      --SMPx[2:0]: Channel x sampling time selection
      --These bits are written by software to select the sampling
      --time individually for each channel.
      --During sampling cycles, the channel selection bits must
      --remain unchanged.
      --000: 3 cycles
      --001: 15 cycles
      --010: 28 cycles
      --011: 56 cycles
      --100: 84 cycles
      --101: 112 cycles
      --110: 144 cycles
      --111: 480 cycles
      SMP6         : Bit_3;

      --SMPx[2:0]: Channel x sampling time selection
      --These bits are written by software to select the sampling
      --time individually for each channel.
      --During sampling cycles, the channel selection bits must
      --remain unchanged.
      --000: 3 cycles
      --001: 15 cycles
      --010: 28 cycles
      --011: 56 cycles
      --100: 84 cycles
      --101: 112 cycles
      --110: 144 cycles
      --111: 480 cycles
      SMP7         : Bit_3;

      --SMPx[2:0]: Channel x sampling time selection
      --These bits are written by software to select the sampling
      --time individually for each channel.
      --During sampling cycles, the channel selection bits must
      --remain unchanged.
      --000: 3 cycles
      --001: 15 cycles
      --010: 28 cycles
      --011: 56 cycles
      --100: 84 cycles
      --101: 112 cycles
      --110: 144 cycles
      --111: 480 cycles
      SMP8         : Bit_3;

      --SMPx[2:0]: Channel x sampling time selection
      --These bits are written by software to select the sampling
      --time individually for each channel.
      --During sampling cycles, the channel selection bits must
      --remain unchanged.
      --000: 3 cycles
      --001: 15 cycles
      --010: 28 cycles
      --011: 56 cycles
      --100: 84 cycles
      --101: 112 cycles
      --110: 144 cycles
      --111: 480 cycles
      SMP9         : Bit_3;
      RESERVED     : Bit_2;

   end record with Volatile_Full_Access, Size => 32;

   for rADC_SMPR2 use record

      SMP0         at 0  range 0 .. 2;
      SMP1         at 0  range 3 .. 5;
      SMP2         at 0  range 6 .. 8;
      SMP3         at 0  range 9 .. 11;
      SMP4         at 0  range 12 .. 14;
      SMP5         at 0  range 15 .. 17;
      SMP6         at 0  range 18 .. 20;
      SMP7         at 0  range 21 .. 23;
      SMP8         at 0  range 24 .. 26;
      SMP9         at 0  range 27 .. 29;
      RESERVED     at 0  range 30 .. 31;

   end record;
   ADC_SMPR2_Offset     : Word := 16#10#;


   JOFR1            : Half_Word;
   JOFR1_Offset     : Word := 16#14#;

   JOFR2            : Half_Word;
   JOFR2_Offset     : Word := 16#18#;

   JOFR3            : Half_Word;
   JOFR3_Offset     : Word := 16#1C#;

   JOFR4            : Half_Word;
   JOFR4_Offset     : Word := 16#20#;




end STM32F407.ADC;
