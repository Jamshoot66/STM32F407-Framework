With STM32F407.Registers; Use STM32F407.Registers;

package body STM32F407.SPI is

   procedure Transmit_8bit(fMessage : Byte) is
      --Current_cycle : Natural := 0;
      --Dummy         : Byte;
   begin

      while SPI1_SR.BSY = 1 loop
         null;
      end loop;

      while (SPI1_SR.TXE = 0) loop
         null;
      end loop;


         SPI1_DR.LSB := fMessage;

   end;

   function Recieve_8bit return Byte is

      temp : Byte := 0;

   begin

      Transmit_8bit(0);

      while (SPI1_SR.RXNE = 0) loop
         Null;
      end loop;

      temp := SPI1_DR.LSB;

      while SPI1_SR.BSY = 1 loop
         null;
      end loop;

         return temp;

   end;


end STM32F407.SPI;
