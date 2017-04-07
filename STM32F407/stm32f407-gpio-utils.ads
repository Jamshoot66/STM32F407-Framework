package STM32F407.GPIO.Utils is

   procedure Set_Pin(fGPIO : in out rGPIO_Register;
                     PinNumber : Half_Word; HighLow : Bit_1);

   procedure Set_Pin(fGPIO_Pin : in out rGPIO_Pin; HighLow : Bit_1);

   function Is_Set(fGPIO : in rGPIO_Register;
                   PinNumber : Half_Word) return Boolean;

   procedure Init_as_Digital_Output(fGPIO_Pin : in out rGPIO_Pin);

end STM32F407.GPIO.Utils;
