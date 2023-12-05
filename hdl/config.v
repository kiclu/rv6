// Instruction cache structure
`define imem_struct_set_assoc
// `define imem_struct_full_assoc
// `define imem_struct_direct

// Instruction cache line size in bits
`define imem_line 128
`define imem_offs_len $clog2(`imem_line/8)

// Set associative L1i cache parameter configuration
`ifdef imem_struct_set_assoc
    // Set count
    `define imem_sets 2
    `define imem_set_len $clog2(`imem_sets)

    // Ways per set
    `define imem_ways 2
    `define imem_way_len $clog2(`imem_ways)

    `define imem_tag_len (64 - `imem_set_len - `imem_offs_len)
`endif

// Data cache structure
`define dmem_struct_set_assoc
// `define dmem_struct_full_assoc
// `define dmem_struct_direct

// Data cache line size in bits
`define dmem_line 128
`define dmem_offs_len $clog2(`dmem_line/8)

// Set associative L1d cache parameter configuration
`ifdef dmem_struct_set_assoc
    // Set count
    `define dmem_sets 2
    `define dmem_set_len $clog2(`dmem_sets)

    // Ways per set
    `define dmem_ways 2
    `define dmem_way_len $clog2(`dmem_ways)

    `define dmem_tag_len (64 - `dmem_set_len - `dmem_offs_len)
`endif

// Hart cache structure
`define hmem_struct_set_assoc
// `define hmem_struct_full_assoc
// `define hmem_struct_direct

// Hart cache line size in bits
`define hmem_line 256
`define hmem_offs_len $clog2(`hmem_line/8)

// Set associative L2 cache parameter configuration
`ifdef hmem_struct_set_assoc
    // Set count
    `define hmem_sets 2
    `define hmem_set_len $clog2(`hmem_sets)

    // Ways per set
    `define hmem_ways 2
    `define hmem_way_len $clog2(`hmem_ways)

    `define hmem_tag_len (64 - `hmem_set_len - `hmem_offs_len)
`endif
