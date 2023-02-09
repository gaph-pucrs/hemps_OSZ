library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.standards.all;
use work.seek_pkg.all;

package snip_pkg is
    
    constant TAM_WORD   : integer := TAM_FLIT*2;
    subtype regword is std_logic_vector(TAM_WORD-1 downto 0);

    constant FIXED_HEADER_SIZE      : integer := 2;
    constant XY_HEADER_SIZE         : integer := 4;
    constant DYNAMIC_HEADER_SIZE    : integer := 22;

    constant TABLE_SIZE             : integer := 4;
    constant MAX_FLITS_PER_PKT      : integer := 255;

    constant FIFO_SIZE              : integer := 32;

    constant APPID_SIZE             : integer := 16;
    constant KEYPERIPH_SIZE         : integer := APPID_SIZE;
    constant MAX_PATH_FLITS         : integer := 6;

    subtype regN_appID      is std_logic_vector(APPID_SIZE-1 downto 0);
    subtype regN_keyPeriph  is std_logic_vector(KEYPERIPH_SIZE-1 downto 0);
    subtype regN_keyParam   is std_logic_vector((TAM_FLIT/2)-1 downto 0);
    type    regN_path       is array(MAX_PATH_FLITS-1 downto 0) of regflit;
    subtype intN_pathSize   is integer range 0 to MAX_PATH_FLITS;
    subtype intN_pathIndex  is integer range 0 to MAX_PATH_FLITS-1;

    -------------------
    -- LFSR SETTINGS --
    -------------------

    constant lfsr_degree        : integer := 16;
    constant lfsr_polynomial    : std_logic_vector(lfsr_degree-1 downto 0) := x"D008"; -- x^16 + x^15 + x^13 + x^4 + 1

    subtype regN_lfsr is std_logic_vector(lfsr_degree-1 downto 0);
    ---------------------------------------
    -- MESSAGE DELIVERY SERVICE SETTINGS --
    ---------------------------------------

    constant DEFAULT_WORDS_PER_DELIVERY         : integer := 10;
    constant MAX_WORDS_PER_DELIVERY             : integer := 64;

    --------------------------------
    -- SERVICES AND FLIT POSITION --
    --------------------------------

    constant IO_INIT_SERVICE                    : regword := x"00000305";
    constant IO_CONFIG_SERVICE                  : regword := x"00000300";
    constant IO_RENEW_KEYS                      : regword := x"00000330";
    constant IO_REQUEST_SERVICE                 : regword := x"00000015";
    constant IO_DELIVERY_SERVICE                : regword := x"00000025";
    constant IO_ACK_SERVICE                     : regword := x"00000026";

    constant PACKET_SIZE_FLIT_HI                : integer := 0;
    constant F1_FLIT                            : integer := 2;
    constant F2_FLIT                            : integer := 3;
    constant SERVICE_FLIT_HI                    : integer := 4;
    constant PACKET_SOURCE_FLIT                 : integer := 9;
    constant DELIVERY_SIZE_FLIT                 : integer := 15;
    constant END_OF_HEADER_FLIT                 : integer := 21;

    -- constant SERVICE_FLIT_HI_TX                 : integer := 2;

    --  Service                 F1          F2
    --  IO_INIT                 zero        k0
    --  IO_CONFIG               zero        appId xor k0
    --  IO_REQ/DELIVERY/ACK     k1 xor k2   appId xor k2

    ----------------------------------------------
    -- APPLICATION TABLE PRIMARY INTERFACE (RW) --
    ----------------------------------------------

    type AppTablePrimaryInput is record

        -- control:

        request         : std_logic;
        crypto          : std_logic;
        newLine         : std_logic;
        tag             : regN_appID;
        tagAux          : regN_appID;
        clearSlot       : std_logic;

        -- data:

        appId_w         : regN_appID;
        appId_wen       : std_logic;

        key1_w          : regN_keyPeriph;
        key1_wen        : std_logic;

        key2_w          : regN_keyPeriph;
        key2_wen        : std_logic;

        pathSize_w      : intN_pathSize;
        pathSize_wen    : std_logic;

        pathFlit_w      : regflit;
        pathFlit_wen    : std_logic;
        pathFlit_idx    : intN_pathIndex;

    end record;

    type AppTablePrimaryOutput is record

        -- control:

        ready           : std_logic;
        fail            : std_logic;
        full            : std_logic;

        -- data:

        appId           : regN_appID;
        key1            : regN_keyPeriph;
        key2            : regN_keyPeriph;
        pathSize        : intN_pathSize;
        pathFlit        : regflit;
    
    end record;
    
    ------------------------------------------------
    -- APPLICATION TABLE SECONDARY INTERFACE (RO) --
    ------------------------------------------------

    type AppTableSecondaryInput is record

        -- control:
        
        tag             : regN_appID;
        
        -- data:
        
        pathFlit_idx    : intN_pathIndex;

    end record;

    type AppTableSecondaryOutput is record

        -- control:

        ready           : std_logic;

        -- data:

        appId           : regN_appID;
        key1            : regN_keyPeriph;
        key2            : regN_keyPeriph;
        pathSize        : intN_pathSize;
        pathFlit        : regflit;

    end record;

    --------------------------------
    -- RESPONSE REQUEST INTERFACE --
    --------------------------------

    type TransmissionModeType is (THROUGH_HERMES, THROUGH_BRNOC);

    type ResponseParametersType is record
        txMode          : TransmissionModeType;
        appId           : regN_appID;
        hermesService   : regword;
        brnocService    : seek_bitN_service;
        source          : regflit;
        target          : regflit;
    end record;

    type TransmissionStatusType is record
        busy            : std_logic;
        accepted        : std_logic;
        rejected        : std_logic;
    end record;

    ---------------------------
    -- FIFO BUFFER INTERFACE --
    ---------------------------

    type BufferStatusType is record
        empty           : std_logic;
        full            : std_logic;
        err             : std_logic;
    end record;
    
end package;
