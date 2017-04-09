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
--with STM32F407.Offsets; use STM32F407.Offsets;

--with System;


package STM32F407.DAC is

   --DAC control register. 14.5.1 (p. 442) STM32407VG ref. manual
   type tDAC_CR is record

      EN1       : Bit_1;
      BOFF1     : Bit_1;
      TEN1      : Bit_1;
      TSEL1     : Bit_3;
      WAVE1     : Bit_2;
      MAMP1     : Bit_4;
      DMAEN1    : Bit_1;
      DMAUDRIE1 : Bit_1;
      Reserved1 : Bit_2;

      EN2       : Bit_1;
      BOFF2     : Bit_1;
      TEN2      : Bit_1;
      TSEL2     : Bit_3;
      WAVE2     : Bit_2;
      MAMP2     : Bit_4;
      DMAEN2    : Bit_1;
      DMAUDRIE2 : Bit_1;
      Reserved2 : Bit_2;

   end record;

   for tDAC_CR use record

      EN1          at 0 range 0..0;
      BOFF1        at 0 range 1..1;
      TEN1         at 0 range 2..2;
      TSEL1        at 0 range 3..5;
      WAVE1        at 0 range 6..7;
      MAMP1        at 0 range 8..11;
      DMAEN1       at 0 range 12..12;
      DMAUDRIE1    at 0 range 13..13;
      Reserved1    at 0 range 14..15;

      EN2          at 2 range 0..0;
      BOFF2        at 2 range 1..1;
      TEN2         at 2 range 2..2;
      TSEL2        at 2 range 3..5;
      WAVE2        at 2 range 6..7;
      MAMP2        at 2 range 8..11;
      DMAEN2       at 2 range 12..12;
      DMAUDRIE2    at 2 range 13..13;
      Reserved2    at 2 range 14..15;

   end record;



   --DAC control register. 14.5.2 (p. 445) STM32407VG ref. manual
   type tDAC_SWTRIGR is record

      SWTRIG1   : Bit_1;
      SWTRIG2   : Bit_1;
      Reserved : Bit_4; --reserved bits 2..32
      --Reserved2 : Byte;
      --Reserved3 : Half_Word;

   end record;

   for tDAC_SWTRIGR use record

      SWTRIG1    at 0 range 0..0;
      SWTRIG2    at 0 range 1..1;
      Reserved   at 0 range 2..31;

   end record;

   type tDAC_DHR8RD is record

      DACC1DHR : Byte;
      DACC2DHR : Byte;
      Reserved : Half_Word;

   end record;

--   for tDAC_DHR8RD use record
--
--      DACC1DHR at 0 range 0..7;
--      DACC2DHR at 8 range 0..7;
--   end record;




   --cSW : Word with
   --  Volatile,
   --  Address => System'To_Address(DAC_SWTRIGR_Base);

   --DAC data holding registers



end STM32F407.DAC;
