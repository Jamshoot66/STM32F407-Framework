with System;

with STM32F407.Types; use STM32F407.Types;
with STM32F407.Offsets; use STM32F407.Offsets;

package STM32F407.GPIO is

      --constansts
   Low          : constant Bit_1 := 0;
   High         : constant Bit_1 := 1;

   Pin0         : constant Half_Word := 2#0000_0000_0000_0001#;
   Pin1         : constant Half_Word := 2#0000_0000_0000_0010#;
   Pin2         : constant Half_Word := 2#0000_0000_0000_0100#;
   Pin3         : constant Half_Word := 2#0000_0000_0000_1000#;
   Pin4         : constant Half_Word := 2#0000_0000_0001_0000#;
   Pin5         : constant Half_Word := 2#0000_0000_0010_0000#;
   Pin6         : constant Half_Word := 2#0000_0000_0100_0000#;
   Pin7         : constant Half_Word := 2#0000_0000_1000_0000#;
   Pin8         : constant Half_Word := 2#0000_0001_0000_0000#;
   Pin9         : constant Half_Word := 2#0000_0010_0000_0000#;
   Pin10        : constant Half_Word := 2#0000_0100_0000_0000#;
   Pin11        : constant Half_Word := 2#0000_1000_0000_0000#;
   Pin12        : constant Half_Word := 2#0001_0000_0000_0000#;
   Pin13        : constant Half_Word := 2#0010_0000_0000_0000#;
   Pin14        : constant Half_Word := 2#0100_0000_0000_0000#;
   Pin15        : constant Half_Word := 2#1000_0000_0000_0000#;

   --  MODER constants
   GPIO_Mode_IN      : constant Bit_2 := 0;
   GPIO_Mode_OUT     : constant Bit_2 := 1;
   GPIO_Mode_AF      : constant Bit_2 := 2;
   GPIO_Mode_AN      : constant Bit_2 := 3;

   --  OTYPER constants
   GPIO_Type_PP      : constant Bit_1 := 0; -- Push/pull
   GPIO_Type_OD      : constant Bit_1 := 1; -- Open drain

   --  OSPEEDR constants
   GPIO_Speed_2MHz   : constant Bit_2 := 0; -- Low speed
   GPIO_Speed_25MHz  : constant Bit_2 := 1; -- Medium speed
   GPIO_Speed_50MHz  : constant Bit_2 := 2; -- Fast speed
   GPIO_Speed_100MHz : constant Bit_2 := 3; -- High speed on 30pF, 80MHz on 15

   --  PUPDR constants
   GPIO_No_Pull      : constant Bit_2 := 0;
   GPIO_Pull_Up      : constant Bit_2 := 1;
   GPIO_Pull_Down    : constant Bit_2 := 2;

   type rGPIO_Register is record
      MODER   : Bit_16x2;   --  mode register
      OTYPER  : Bit_32x1;   --  output type register
      OSPEEDR : Bit_16x2;   --  output speed register
      PUPDR   : Bit_16x2;   --  pull-up/pull-down register
      IDR     : Word;       --  input data register
      ODR     : Word;       --  output data register
      BSRR    : Word;       --  bit set/reset register
      LCKR    : Word;       --  configuration lock register
      AFRL    : Bit_8x4;    --  alternate function low register
      AFRH    : Bit_8x4;    --  alternate function high register
   end record with Volatile;

   -- pointer to rGPIO_Register
   type pRegister is access all rGPIO_Register;

   for rGPIO_Register use record
      MODER   at 0  range 0 .. 31;
      OTYPER  at 4  range 0 .. 31;
      OSPEEDR at 8  range 0 .. 31;
      PUPDR   at 12 range 0 .. 31;
      IDR     at 16 range 0 .. 31;
      ODR     at 20 range 0 .. 31;
      BSRR    at 24 range 0 .. 31;
      LCKR    at 28 range 0 .. 31;
      AFRL    at 32 range 0 .. 31;
      AFRH    at 36 range 0 .. 31;
   end record;

   GPIOA : aliased STM32F407.GPIO.rGPIO_Register with
     Volatile,
     Address => System'To_Address(GPIOA_Base);

   GPIOB : aliased STM32F407.GPIO.rGPIO_Register with
     Volatile,
     Address => System'To_Address(GPIOB_Base);

   GPIOC : aliased STM32F407.GPIO.rGPIO_Register with
     Volatile,
     Address => System'To_Address(GPIOC_Base);

   GPIOD : aliased STM32F407.GPIO.rGPIO_Register with
     Volatile,
     Address => System'To_Address(GPIOD_Base);

   GPIOE : aliased STM32F407.GPIO.rGPIO_Register with
     Volatile,
     Address => System'To_Address(GPIOE_Base);

   type rGPIO_Pin is record
      Port : pRegister;
      Pin_Number  : Half_Word;
   end record;

end STM32F407.GPIO;
