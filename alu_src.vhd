library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu is
    Port (
            opA, opB, opCode : in std_logic_vector(3 downto 0);
            output : out std_logic_vector(3 downto 0);
            mode : in std_logic;
            less_than, great_than, equal : out std_logic;
            /* 
               N - negative
               Z - zero
               C - carry
               V - overflow
            */
            Z : out std_logic;
            C : out std_logic;
            V : out std_logic;
            N : out std_logic
    );
end alu;

architecture arch of alu is
    -- making custom type
    type opcode_t is (add_t, sub_t, and_t, or_t, xor_t, not_t, comp_t);
    signal op : opcode_t;
    signal tmp_out : unsigned(4 downto 0);
begin
    with op select
        
    with 


            

            