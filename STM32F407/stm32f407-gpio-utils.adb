package body STM32F407.GPIO.Utils is

   procedure Set_Pin(fGPIO : in out rGPIO_Register;
                     PinNumber : Half_Word; HighLow : Bit_1) is
      Converted_PinNumber : constant Word := Word(PinNumber);
   begin
      if (HighLow = High) then
         fGPIO.BSRR := fGPIO.BSRR or Converted_PinNumber;
      end if;

      if (HighLow = Low) then
         fGPIO.BSRR := fGPIO.BSRR or
           Shift_Left( Value  => Converted_PinNumber,
                       Amount => 16);
      end if;
   end;

   procedure Set_Pin(fGPIO_Pin : in out rGPIO_Pin; HighLow : Bit_1) is
      Converted_PinNumber : constant Word := Word(fGPIO_Pin.Pin_Number);
   begin
      if (HighLow = High) then
         fGPIO_Pin.Port.BSRR := fGPIO_Pin.Port.BSRR or Converted_PinNumber;
      end if;

      if (HighLow = Low) then
         fGPIO_Pin.Port.BSRR := fGPIO_Pin.Port.BSRR or
           Shift_Left( Value  => Converted_PinNumber,
                       Amount => 16);
      end if;

   exception
         when others => null;
   end Set_Pin;

   function Is_Set(fGPIO : in rGPIO_Register;
                   PinNumber : Half_Word) return Boolean is
   begin

      if ( ((fGPIO.IDR) And Word(PinNumber)) > 0 ) then
         return True;
      else
         return False;
      end if;

   end Is_Set;

   procedure Init_as_Digital_Output(fGPIO_Pin : in out rGPIO_Pin) is
   begin
      fGPIO_Pin.Port.MODER( Integer(fGPIO_Pin.Pin_Number) ) := GPIO_Mode_OUT;
      fGPIO_Pin.Port.OSPEEDR( Integer(fGPIO_Pin.Pin_Number) ) :=  GPIO_Speed_100MHz;
      --fGPIO_Pin.Port.PUPDR( fGPIO_Pin.Pin_Number ) = GPIO_Pull_Down;
      --null;
   exception
         when others => null;
   end;

end STM32F407.GPIO.Utils;
