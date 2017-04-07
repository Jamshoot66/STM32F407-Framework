with Interfaces; use Interfaces;

package STM32F407.Types is

   type Word is new Unsigned_32;
   type Half_Word is new Unsigned_16;
   type Byte is new Unsigned_8;

   type pWord is access all Word;
   type pHalf_Word is access all Half_Word;
   type pByte is access all Byte;

   type Bit_1 is mod 2**1 with Size => 1;
   type Bit_2 is mod 2**2 with Size => 2;
   type Bit_3 is mod 2**3 with Size => 3;
   type Bit_4 is mod 2**4 with Size => 4;
   type Bit_5 is mod 2**5 with Size => 5;
   type Bit_6 is mod 2**6 with Size => 6;
   type Bit_7 is mod 2**7 with Size => 7;

   type Bit_32x1 is array (0..31) of Bit_1 with Pack, Size => 32;
   type Bit_16x2 is array (0..15) of Bit_2 with Pack, Size => 32;
   type Bit_8x4  is array (0..7) of Bit_4 with Pack, Size => 32;



   --  AFL constants
   AF_USART1    : constant Bit_4 := 7;

   --  Reset constants
   GPIOA_Reset       : constant Word := 16#A800_0000#;
   GPIOB_Reset       : constant Word := 16#0000_0280#;
   GPIO_Others_Reset : constant Word := 16#0000_0000#;

end STM32F407.Types;
