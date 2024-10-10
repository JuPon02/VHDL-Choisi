library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity timer is
   generic(
      G_MAX_TIMER_BITS : integer := 4;    -- 
      G_COUNT_RESTART  : boolean := false
   );
   port(
      clk        : in  std_logic;
      reset_n    : in  std_logic;
      
      start      : in  std_logic;
      init_delay : in  std_logic_vector(G_MAX_TIMER_BITS-1 downto 0);
      count_on   : in  std_logic;
      
      count_val  : out std_logic_vector(G_MAX_TIMER_BITS-1 downto 0);
      done       : out std_logic
   );
end timer;
   
architecture rtl of timer is
   signal count_cur : unsigned(G_MAX_TIMER_BITS-1 downto 0);
   signal count_nxt : unsigned(G_MAX_TIMER_BITS-1 downto 0);
   signal count     : unsigned(G_MAX_TIMER_BITS-1 downto 0);
   signal done_l    : std_logic;
begin
   g_restart_allowed: if G_COUNT_RESTART generate
      count <= unsigned(init_delay) when (start='1') else 
               count_cur;
   end generate g_restart_allowed;
   
   g_restart_forbidden: if not G_COUNT_RESTART generate
      -- Wait end of count before it's possible to restart the timer
	   -- When reset_n is active LOW counter is at 0 and done_l is 1 => count is set at 
	   -- initial value during the reset
      count <= unsigned(init_delay) when ((start='1') and (done_l='1')) else 
               count_cur;
   end generate g_restart_forbidden;
   
   count_nxt <= count-1 when count_on='1' else
                count;
   count_val <= std_logic_vector(count);
   
   done_l    <= '1' when count_cur=0 else '0';
   done      <= done_l;
   
   p_count : process(clk)
   begin
      if (rising_edge(clk)) then
         if (reset_n='0') then
            count_cur <= (others=>'0');
         elsif(((done_l='0') and (count_on='1')) or (start='1')) then
            count_cur <= count_nxt;
         end if;
      end if;         
   end process p_count;
   
end architecture rtl;