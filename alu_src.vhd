library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alu is
    Port (
            opA, opB, opCode : in std_logic_vector(3 downto 0);
            output : out std_logic_vector(3 downto 0);
            mode : in std_logic; -- '0' = unsigned | '1' = signed
            less_than, great_than, equal : out std_logic;
             
            --   N - negative
            --   Z - zero
            --   C - carry
            --   V - overflow
            
            N : out std_logic;
            Z : out std_logic;
            C : out std_logic;
            V : out std_logic
    );
end alu;

architecture arch of alu is
    -- making custom type
    
    type opcode_t is (add_t, sub_t, mult_t, div_t, and_t, or_t, xor_t, not_t, comp_t);
    signal op : opcode_t;
    signal a_u, b_u : unsigned(3 downto 0);
    signal a_s, b_s : signed(3 downto 0);
    signal tmp_out : std_logic_vector(4 downto 0); -- one bit longer to detect overflow
begin
    -- mapping the enum
    op <= opcode_t'val( to_integer(unsigned(opCode)) );

    -- mapping internal operands
    a_u <= unsigned(opA); b_u <= unsigned(opB);
    a_s <= signed(opA); b_s <= signed(opB);

    result_proc : process (op, a_u, a_s, b_u, b_s, mode)
    begin

        -- defaults first
        tmp_out <= (others => '0');

        case op is
            when add_t =>
                if mode = '0' then
                    -- append '0' bit to capture carry for C flag
                    tmp_out <= std_logic_vector(('0' & a_u) + ('0' & b_u));
                else
                    tmp_out <= std_logic_vector(resize(a_s, 5) + resize(b_s, 5));
                end if;
            when sub_t => 
                if mode = '0' then 
                    -- unsigned sub, prepend '1' to operand A to av cary bit default to '1'
                    tmp_out <= std_logic_vector(('0' & a_u) - ('0' & b_u));
                else
                    tmp_out <= std_logic_vector(resize(a_s, 5) - resize(b_s, 5));
                end if;
            when others => null;
        end case;
    end process result_proc;

    -- split the process between flag and result because it looks better 

    flag_proc : process (op, a_u, a_s, b_u, b_s, mode, tmp_out)
    begin

        N <= '0'; Z <= '0'; C <= '0'; V <= '0';

        case op is
            when add_t =>
                -- zero flag check for both are same
                if tmp_out = "00000" then
                        Z <= '1';
                    else Z <= '0'; end if;
                if mode = '0' then -- unsigned add
                    -- carry check
                    C <= not tmp_out(4);   
                else -- signed add
                    -- overflow and negative check
                    N <= tmp_out(3);
                    V <= not((a_s(3) xor b_s(3)) and (tmp_out(3) xor a_s(3)));
                end if;

            when sub_t => 
                -- zero check the same for both so outside of mode checks
                if tmp_out(3 downto 0) = "0000" then 
                        Z <= '1';
                    else Z <= '0'; end if;
                if mode = '0' then 
                    -- unsigned sub, carry
                    C <= not tmp_out(tmp_out'high);
                else -- signed sub, neg, over, resp.
                    N <= tmp_out(3);
                    V <= ((a_s(3) xor b_s(3)) and (tmp_out(3) xor a_s(3)));
                end if;
            
            when mult_t => 
            null;
            when others => null;
        end case;
    end process flag_proc;

    output <= tmp_out(3 downto 0);
    
end arch;